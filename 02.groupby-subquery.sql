## GROUP BY ##
#: 그룹화해 각 값들의 평균값, 개수 등을 구할 때 사용
-- classicmodels, customers 테이블을 이용해 국가, 도시별 고객 수 구하기
select country, city, count(customernumber) n_customers
from classicmodels.customers
group by country, city;

/* 자주 사용하는 3가지 집계 함수
	avg(): 평균 
	count(): 개수 구하기
    sum(): 합하기
*/
-- 집계함수에 case when 구문 사용: 필요한 조건만 집계가능
/* select sum(case when 국가 = '한국' then 1 else 0 end) 
korea_cnt from table; */
-- classicmodels.customers 테이블을 이용해 usa 거주자의 수를 계산하고, 그 비중을 구하세요.
select sum(CASE WHEN country = 'USA' then 1 else 0 end) n_usa,
sum(case when country = 'USA' then 1 else 0 end)/count(*) usa_portion
from classicmodels.customers;

## JOIN ##
#: 여러가지 테이블로 나뉜 정보 테이블 결합 함수
# 1) LEFT JOIN(LEFT OUTER JOIN): 특정 테이블 정보 기준으로 타 테이블 결합
-- classicmodels.customers, classicmodels.orders 테이블을 결합하고 ORDERNUMBER와 COUNTRY를 출력 (LEFT JOIN)
select A.ordernumber, B.country
from classicmodels.orders A left join classicmodels.customers B
on A.customernumber = B.customernumber;
-- classicmodels.customers, classicmodels.orders 테이블을 이용해 USA 거주자의 주문번호, 국가 출력
select a.ordernumber, b.country
from classicmodels.orders a left join classicmodels.customers b
on a.customerNumber = b.customerNumber
where b.country = 'USA';

# 2) INNER JOIN : 2가지 테이블에 공통으로 존재하는 정보만 출력
/* select *
from table_a inner join table_b
on table_a.column 1 = table_b.column 2 */
-- classicmodels.customers, classicmodels.orders 테이블을 이용해 USA 거주자의 주문번호, 국가를 출력
select a.ordernumber, b.country
from classicmodels.orders a inner join classicmodels.customers b
on a.customerNumber = b.customerNumber
where b.country = 'USA';

# 3) FULL JOIN: 모두 출력
/*	select *
	from table_A 
    full join table_B
	on table_A.column 1 = table_B.column 2 */

## CASE WHEN ## : 조건에 따른 값을 다르게 출력하고 싶은 경우 사용
-- 조건 1을 만족하는 경우 결과 1을 출력하게 되고, 조건 2를 만족하는 경우 결과 2를 출력하게 되고,
-- 조건 1,조건 2를 모두 만족하지않는 경우 결과 3을 출력하게 된다.
/*	select case when 조건 1 then 결과 1
	when 조건 2 then 결과 2 else 결과 3 end
    from 데이터베이스.테이블 명; */
    
-- classicmodels.customers의 country 칼럼을 이용해 북미(Canada, USA), 비북미를 출력하는 칼럼 생성
select country, case when country in ('USA', 'Canada') then 'north america' else 'others' end as region
from classicmodels.customers;

-- classicmodels.customers의 country 칼럼을 이용해 북미, 비북미를 출력하는 칼럼을 생성하고 북미, 비북미 거주 고객의 수 계산
select case when country in ('USA', 'Canada') then 'north america' else 'others' end as region, count(customerNumber) n_customers
from classicmodels.customers
group by case when country in('USA','Canada') then 'north america' else 'others' end; 

## RANK, DENSE_RANK, ROW_NUMBER ## : 데이터에 순위 매기는데 사용되는 함수
# 동점인 경우 같은 등수로 계산
/*	RANK: 동점인 경우의 데이터 세트를 고려해 등수 매김
	DENSE_RANK: 동점의 등수 바로 다음 수로 순위 매김 */
# ROW_NUMBER: 동점인 경우도 서로 다른 동수로 계산

-- classicmodels.products 테이블에서 buyprice 칼럼으로 순위를 매기기(오름차순)
select buyprice,
row_number() over(order by buyprice) rownumber,
rank() over(order by buyprice) rnk,
dense_rank() over(order by buyprice) denserank
from classicmodels.products;
-- classicmodels.products 테이블의 productline별로 순위를 매기기 (buyprice 칼럼기준, 오름차순)
select buyprice,
row_number() over(partition by productline order by buyprice) rownumber,
rank() over(partition by productline order by buyprice) rnk,
dense_rank() over(partition by productline order by buyprice) denserank
from classicmodels.products;

## SUBQUERY ##
# in 연산자 이후 () 내의 쿼리를 쿼리 안의 쿼리라는 의미
# in 연산자 뿐만 아니라 from, join에서도 사용 가능  
-- classicmodels.customers와 classicmodels.orders를 이용해 USA 거주자의 주문 번호 출력
select ordernumber
from classicmodels.orders
where customerNumber in (select customerNumber 
from classicmodels.customers where country = 'USA');