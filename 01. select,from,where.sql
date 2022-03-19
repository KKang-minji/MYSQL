## SELECT ##
# 1) 칼럼 조회
-- classicmodels.customers의 customerNumber를 조회
SELECT customerNumber 
FROM classicmodels.customers;

# 2) 집계함수
-- classicmodels.payment의 amount의 총합과 checknumber 개수를 구하시오
SELECT SUM(amount),
COUNT(checknumber)
FROM classicmodels.payments;

# 3) *(모든 결과 조회): 모든 칼럼 출력
# 여러개 칼럼 출력: ,를 추가하여 실행
-- classicmodels.products의 productName, productLine을 조회
SELECT productname, productline
FROM classicmodels.products;

# 4) AS: 특정 칼럼의 칼럼 명을 변경해 조회
-- classicmodels.products의  prodictCode의 개수를 구하고, 칼럼 명을 n_products로 변경
select count(productcode) as n_products
from classicmodels.products;
-- AS를 사용하지 않아도 변수명 변경 가능
select count(productcode) n_products
from classicmodels.products;

# 5) DISTINCT: 중복 제외하고 데이터 조회
-- classicmodels.orderdetails의 ordernumber의 중복을 제거하고 조회
select distinct ordernumber
from classicmodels.orderdetails;

## FROM ##
/* select 계산식 또는 칼럼 명 
from DB명.sales; */
/* use db명;
select 계산식 또는 칼럼 명 
from sales; */

## WHERE ## 
#: 조건 생성
/* select 상품번호 
from db명.product 
where 판매 국가='미국'; */

# 1) BETWEEN : 특정 칼럼의 값이 시작점~끝점인 데이터만 출력 조건 생성
/* select *
from db명.테이블 명
where 칼럼 between 시작점 and 끝점; */
-- classicmodels.orderdetails의 priceEach가 30에서 50 사이인 데이터 조회
select *
from classicmodels.orderdetails
where priceEach between 30 and 50;

# 2) 대소 관계 표현
/* = : 동일하다
   > : 초과
   >=: 이상
   < : 미만
   <=: 이하
   <>: 같지 않다 */
-- classicmodels.orderdetails의 priceEach가 30 이상인 데이터 조회
select *
from classicmodels.orderdetails
where priceEach >= 30;

# 3) IN: IN 연산자에 입력된 값 중에서 하나라도 일치하는 것이 있으면 리스트에 조회
/* select 칼럼 명
from 테이블 명
where 칼럼 명 IN (값1, 값2); */
-- classicmodels.customers의 country가 USA 또는 Canada인 customernumber를 조회
select customernumber
from classicmodels.customers
where country in('USA','Canada');

# 4) NOT IN: 특정 값을 포함하지 않는 데이터만 출력
-- classicmodels.customers의 country가 USA, Canada가 아닌 customernumber를 조회
select customernumber
from classicmodels.customers
where country not in('USA', 'Canada');

# 5) IS NULL: 결측값(NULL) 데이터를 출력
/* select 칼럼명 또는 계산식
from 테이블 명
where 칼럼 IS NULL; */
-- classicmodels.employees의 reportsTo의 값이 NULL인 employeenumber를 조회
SELECT employeenumber
FROM classicmodels.employees
WHERE reportsTo IS NULL;
# IS NOT NULL: 결측깂(null)이 아닌 것만 출력
/* select 칼럼 명 또는 계산식
from 테이블명
where 칼럼 is not null; */

# 6) LIKE'%TEXT%': 쿼리문 WHERE절에 주로 사용되며 부분적으로 일치하는 칼럼을 찾을때 사용
# _ : 글자숫자를 정해줌(EX 컬럼명 LIKE '홍_동')
# % : 글자숫자를 정해주지않음(EX 컬럼명 LIKE '홍%')
-- classicmodels.customers의 addressline1에 ST가 포함된 addressline1을 출력
select addressline1
from classicmodels.customers
where addressLine1 like'%ST%';

