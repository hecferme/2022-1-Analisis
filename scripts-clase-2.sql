select 'hola mundo'
select 'hola mundo' as HolaMundo
select 'hola mundo'as [Hola Mundoñá¢]
select upper ('hola mundo'),lower ('HOLA MUNDO')
select CHARINDEX('a', 'hola mundoa', 5)
select len ('hola mundo'), REPLACE('hola mundo', 'do', 'cartaguito campeón')
select left ('hola mundo',6), right('hola mundo',3), SUBSTRING('hola mundo',3,5)
select REVERSE('hola mundo')
-------------------------
-- números
/* inicio
de
comentario
*/
select 10 + cast (20 as real) * 15 / 17, POWER(2, 10), log(57, 2)
--- bits
-- 1 1001
-- 0 1001
----------- AND
--     1001

select 25 & 9
select 19 | 57
select ~45
-- bit encendido
select 70997  & power (2, 8)  -- = 0 -->bit apagado; > 0 --> bit encendido 
-- 10001010101010101
-- 00000000001000000
------------------------------------------------------------
--fechas
declare @miFecha as datetime = '2020-05-12 18:29:46.806'
--select @miFecha, year(@miFecha), MONTH(@miFecha), datepart(week, @miFecha)
--select datepart(quarter, @miFecha),DATEPART(millisecond, @miFecha)
declare @miFecha2 as DATETIME = '2018-11-24 06:51:38.937'
--select DATEDIFF(second, @miFecha, @miFecha2)
select DATEADD(millisecond, 738412378, @miFecha2)
------------------------
-- case
-- select
-- tarea moral:
-- instale sql server developer edition localmente y restaure la bd adventureworksLT
-- el sql server DEBE incluir analysis services en modo MULTIDIMENSIONAL (NOOOO - PIVOT)



