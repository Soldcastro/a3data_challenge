with tabela_cartao as (
SELECT *,
(case when (length(minuto) > 2 and substring(minuto,1,1) = '4')
    or (length(minuto) = 2 and cast(substring(minuto,2,1) as int) <=5) then 'Primeiro'
    else 'Segundo'
    end) as "tempo"
FROM "a3_challenge"."campeonato_brasileiro_cartoes"
)
SELECT count(a.partida_id) as qtd_cartoes
FROM tabela_cartao as a
inner join "a3_challenge"."campeonato_brasileiro_full" as b
on a.partida_id = b.id
where a.clube = 'Palmeiras'
and b.visitante = 'Palmeiras'
and a.tempo = 'Segundo'
and a.cartao = 'Amarelo'
group by a.clube
limit 10;