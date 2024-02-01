-- 	EXERCISE 7 TO 10

-- 7. Write a query to display carton id, (len*width*height) as carton_vol and identify the optimum carton (carton with the least volume whose volume is greater than the total volume of all items (len * width * height * product_quantity)) for a given order whose order id is 10006, Assume all items of an order are packed into one single carton (box). (1 ROW) [NOTE: CARTON TABLE]
select c.carton_id,(c.len*c.width*c.height) as cartonVolume from carton c
where (c.len*c.width*c.height) >
(select sum(c.len*c.width*c.height*oi.product_quantity)from order_items oi join product p ON oi.product_id= p.product_id
where oi.order_id = 10006)
order by (c.len*c.width*c.height) limit 1;


-- 8. Write a query to display details (customer id,customer fullname,order id,product quantity) of customers who bought more than ten (i.e. total order qty) products per shipped order. (11 ROWS) [NOTE: TABLES TO BE USED - online_customer, order_header, order_items,]
select oc.customer_id,concat(oc.customer_fname, ' ', oc.customer_lname) as customerFullName,oh.order_id,oi.product_quantity
from online_customer oc
join order_header oh on oc.customer_id = oh.customer_id
join order_items oi on oh.order_id = oi.order_id
where oh.order_status = 'Shipped'
group by oc.customer_id, oc.customer_fname, oc.customer_lname, oh.order_id, oi.product_quantity having sum(oi.product_quantity) > 10;

-- 9. Write a query to display the order_id, customer id and customer full name of customers along with (product_quantity) as total quantity of products shipped for order ids > 10060. (6 ROWS) [NOTE: TABLES TO BE USED - online_customer, order_header, order_items]
select oh.order_id,oc.customer_id,concat(oc.customer_fname, ' ', oc.customer_lname) as customerFullName,
sum(oi.product_quantity) as total_quantity from online_customer oc
join order_header oh on oc.customer_id = oh.customer_id
join order_items oi on oh.order_id = oi.order_id
where oh.order_id > 10060 group by oh.order_id, oc.customer_id, oc.customer_fname, oc.customer_lname;

-- 10. Write a query to display product class description ,total quantity (sum(product_quantity),Total value (product_quantity * product price) and show which class of products have been shipped highest(Quantity) to countries outside India other than USA? Also show the total value of those items. (1 ROWS)[NOTE:PRODUCT TABLE,ADDRESS TABLE,ONLINE_CUSTOMER TABLE,ORDER_HEADER TABLE,ORDER_ITEMS TABLE,PRODUCT_CLASS TABLE]
select product_class_desc,sum(oi.product_quantity),sum(oi.product_quantity * p.product_price) from product_class pc
join product p on pc.product_class_code = p.product_class_code
join order_items oi on p.product_id = oi.product_id
join order_header oh on oi.order_id = oh.order_id
join online_customer oc on oh.customer_id = oc.customer_id
join address a on oc.address_id = a.address_id
where a.country not in ('india', 'usa') group by product_class_desc order by sum(oi.product_quantity) desc limit 1;
