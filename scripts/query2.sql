SELECT sum(visitante_placar) / count(id) 
FROM "a3_challenge"."campeonato_brasileiro_full" 
where visitante = 'Cruzeiro'
and vencedor = 'Cruzeiro'
limit 10;