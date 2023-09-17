CREATE EXTERNAL TABLE `campeonato_brasileiro_full`(
  `id` int, 
  `rodada` int, 
  `data` timestamp, 
  `hora` timestamp, 
  `dia` string, 
  `mandante` string, 
  `visitante` string, 
  `formacao_mandante` string, 
  `formacao_visitante` string, 
  `tecnico_mandante` string, 
  `tecnico_visitante` string, 
  `vencedor` string, 
  `arena` string, 
  `mandante_placar` int, 
  `visitante_placar` int, 
  `mandante_estado` string, 
  `visitante_estado` string, 
  `estado_vencedor` string)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat'
LOCATION
  's3://soldcastro-dados/raw/campeonato_brasileiro_full/'