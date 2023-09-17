CREATE EXTERNAL TABLE `campeonato_brasileiro_gols`(
  `partida_id` int, 
  `rodada` int, 
  `clube` string, 
  `atleta` string, 
  `minuto` string)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat'
LOCATION
  's3://soldcastro-dados/raw/campeonato_brasileiro_gols/'