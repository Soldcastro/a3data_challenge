CREATE EXTERNAL TABLE `campeonato_brasileiro_estatisticas_full`(
  `partida_id` int, 
  `rodada` int, 
  `clube` string, 
  `chutes` int, 
  `chutes_no_alvo` int, 
  `posse_de_bola` string, 
  `passes` int, 
  `precisao_passes` string, 
  `faltas` int, 
  `cartao_amarelo` int, 
  `cartao_vermelho` int, 
  `impedimentos` int, 
  `escanteios` int)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat'
LOCATION
  's3://soldcastro-dados/raw/campeonato_brasileiro_estatisticas_full/'