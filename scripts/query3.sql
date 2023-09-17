select f.mandante, count(c.cartao) as qtd_vermelho
from "a3_challenge"."campeonato_brasileiro_cartoes" as c
inner join "a3_challenge"."campeonato_brasileiro_full" as f
on c.partida_id = f.id
where c.cartao = 'Vermelho'
group by f.mandante
order by qtd_vermelho desc
limit 10;