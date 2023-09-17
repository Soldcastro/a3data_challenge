import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
import traceback


args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)
sc.setLogLevel("INFO")


read_path = 's3://soldcastro-dados/landing_zone/campeonato_brasileiro_dataset/'
files = ['campeonato-brasileiro-cartoes.csv',
        'campeonato-brasileiro-estatisticas-full.csv',
        'campeonato-brasileiro-full.csv',
        'campeonato-brasileiro-gols.csv']
write_path = 's3://soldcastro-dados/raw/'
dest_db = 'a3challenge'


for file in files:
    try:
        spark_df = spark.read.format("csv") \
            .options(header='true', delimiter=',', inferSchema='true') \
            .load(read_path+file)
    except Exception:
        print(traceback.format_exc())
    
    table_name = file.split(".csv")[0].replace("-", "_")
    
    glue_df = glueContext.create_dynamic_frame.fromDF(spark_df, glue_ctx=glueContext, name='glue_df')

    s3output = glueContext.getSink(
    path=write_path+table_name,
    connection_type="s3",
    updateBehavior="UPDATE_IN_DATABASE",
    partitionKeys=[],
    compression="snappy",
    enableUpdateCatalog=True,
    transformation_ctx="s3output",
    )
    s3output.setCatalogInfo(
    catalogDatabase=dest_db, catalogTableName=table_name
    )
    s3output.setFormat("glueparquet")
    s3output.writeFrame(glue_df)


job.commit()