1-joins

task-1
select c.customer_name, c.city,o.order_date from customer c join orders o on c.customer_id = o.customer_id
where o.order_date >= '2023-01-01';

task-2

SELECT p.product_name,p.category,c.city,p.price AS total_price FROM customer c JOIN orders o ON c.customer_id = o.customer_id
JOIN 
order_items oi ON o.order_id = oi.order_id
JOIN 
 product p ON oi.product_id = p.product_id
WHERE c.city = 'Mumbai';

task-3

SELECT
    c.customer_name,
    o.order_date,
    SUM(oi.total_price) AS total_price
FROM
    customer c
JOIN
    orders o ON c.customer_id = o.customer_id
JOIN
    order_items oi ON o.order_id = oi.order_id
WHERE
    o.payment_mode= 'Credit Card'
GROUP BY
    c.customer_name,
    o.order_date,
    o.order_id
ORDER BY
    o.order_date;

	task-->4

select p.product_name,p.category,oi.quantity * p.price as total_price from product p
join
 order_items oi on p.product_id = oi.product_id
join
 orders o on oi.order_id = o.order_id
where o.order_date between '2023-01-01' and '2023-06-30';	

task-->5

select c.customer_name ,sum(oi.quantity) as total_products_ordered from customer c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
group by c.customer_name
order by total_products_ordered desc;

2-DISTINCTs

task-->1

select distinct city from customer;

task-->2

select distinct supplier_name from product;

task-->3

select distinct payment_mode from orders;

task-->4

select distinct p.category from order_items oi join product p on oi.product_id=p.product_id ;

task-->5

SELECT DISTINCT p.supplier_city FROM product p ;

3-ORDER_DESC

task-->1
select * from customer order by customer_name ASC;

task-->2
select * from orders orderby order_amount DESC;

task-->3
SELECT * FROM product ORDER BY price ASC, category DESC;

task-->4
SELECT order_id, customer_id, order_date FROM orders ORDER BY order_date DESC;

task-->5
SELECT c.city, COUNT(*) AS total_orders FROM orders o JOIN customer c ON o.customer_id = c.customer_id
GROUP BY c.city ORDER BY c.city ASC;

4-LIMITs & OFFSETs

task-->1
select * from customer order by customer_id limit 10;

task-->2
select * from product order by price desc limit 5;
task-->3
select * from orders order by customer_id offset 10 limit 10;
task-->4
select order_id,order_date,customer_id from orders where order_date>='2023-01-01'order by order_date limit 10;
task-->5
select distinct delivery_city from orders order  by delivery_city offset 10 limit 10;

5-AGGREGATE FUNCTIONSs
TASK-->1
select count(*) as total_orders from orders;
task-->2
select sum(order_amount) as total_revenue from orders where payment_mode = 'UPI';
task-->3
select avg(price) as average_price from product;
task-->4
select max(order_amount),min(order_amount) from orders where extract(year from order_date) = 2023;
task-->5
select product_id, sum(quantity) as quantity from order_items group  by product_id;

6-SET OPERATIONS

task-->1
SELECT customer_id FROM orders WHERE EXTRACT(YEAR FROM order_date) = 2022
INTERSECT
SELECT customer_id FROM orders WHERE EXTRACT(YEAR FROM order_date) = 2023;
task-->2
SELECT DISTINCT supplier_city FROM product
EXCEPT
SELECT DISTINCT city FROM customer;
task-->3
SELECT DISTINCT supplier_city AS city FROM product
UNION
SELECT DISTINCT city FROM customer;
task-->4
SELECT DISTINCT product_name FROM product
INTERSECT
SELECT DISTINCT p.product_name FROM orders o JOIN order_items oi ON o.order_id = oi.order_id
JOIN product p ON oi.product_id = p.product_id
WHERE EXTRACT(YEAR FROM o.order_date) = 2023;

7.SUBQUERIES

task-->1
select customer_name from customer where customer_id in (select customer_id from orders o join order_items oi
on o.order_id=oi.order_id group by customer_id having sum (oi.total_price)>(select avg(oi.total_price)from order_items oi))

task-->2
select product_name from product where product_id in(select product_id from order_items oi group by product_id having
count(distinct order_id)>1)

task-->3
select product_name from product where product_id in(
select product_id from order_items where order_id in(
select order_id from orders where customer_id in(
select customer_id from customer where city= 'Pune')))

task-->4
select * from orders where order_id in(
select order_id from orders order by order_amount desc 
limit 3 )

task-->5
select customer_name from customer where customer_id in(
select customer_id from orders where order_id in(
select order_id from order_items where product_id in (
select product_id from product where price>30000)))

