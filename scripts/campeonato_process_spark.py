from pyspark.sql import SparkSession
import traceback

spark = SparkSession.builder \
    .master("local[*]") \
    .appName("airflow_app") \
    .config('spark.executor.memory', '6g') \
    .config('spark.driver.memory', '6g') \
    .config("spark.driver.maxResultSize", "1048MB") \
    .config("spark.port.maxRetries", "100") \
    .getOrCreate()

sc = spark.sparkContext


read_path = 'campeonato_brasileiro_dataset/'
files = ['campeonato-brasileiro-cartoes.csv',
        'campeonato-brasileiro-estatisticas-full.csv',
        'campeonato-brasileiro-full.csv',
        'campeonato-brasileiro-gols.csv']
write_path = 'raw/'

for file in files:
    try:
        df = spark.read.format("csv") \
            .options(header='true', delimiter=',', inferSchema='true') \
            .load(read_path+file)
    except Exception:
        print(traceback.format_exc())
    
    table_name = file.split(".csv")[0].replace("-", "_")
    
    df.write.mode('overwrite') \
        .format('parquet') \
        .option("parquet.compress", "snappy") \
        .save(write_path+table_name+'/')