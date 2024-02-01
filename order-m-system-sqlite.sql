-- 1. Write a query to Display the product details (product_class_code, product_id, product_desc, product_price,) as per the following criteria and sort them in descending order of category: a. If the category is 2050, increase the price by 2000 b. If the category is 2051, increase the price by 500 c. If the category is 2052, increase the price by 600. Hint: Use case statement. no permanent change in table required. (60 ROWS) [NOTE: PRODUCT TABLE]
select product_class_code,product_id,product_desc,
    case  
        when product_class_code = 2050 then product_price + 2000
        when product_class_code = 2051 then product_price + 500
        when product_class_code = 2052 then product_price + 600
        else product_price
    end
from PRODUCT order by product_class_code desc;

-- 2. Write a query to display (product_class_desc, product_id, product_desc, product_quantity_avail ) and Show inventory status of products as below as per their available quantity: a. For Electronics and Computer categories, if available quantity is <= 10, show 'Low stock', 11 <= qty <= 30, show 'In stock', >= 31, show 'Enough stock' b. For Stationery and Clothes categories, if qty <= 20, show 'Low stock', 21 <= qty <= 80, show 'In stock', >= 81, show 'Enough stock' c. Rest of the categories, if qty <= 15 – 'Low Stock', 16 <= qty <= 50 – 'In Stock', >= 51 – 'Enough stock' For all categories, if available quantity is 0, show 'Out of stock'. Hint: Use case statement. (60 ROWS) [NOTE: TABLES TO BE USED – product, product_class]
select pc.product_class_desc,p.product_id,p.product_desc,p.product_quantity_avail,
    case
        when pc.product_class_desc in('Electronics', 'Computer') then
            case 
				when p.product_quantity_avail = 0 then 'Out of stock'
                when p.product_quantity_avail <= 10 and p.product_quantity_avail>0 then 'Low stock'
                when p.product_quantity_avail between 11 and 30 then 'In stock'
                else 'Enough stock'
            end
        when pc.product_class_desc in ('Stationery', 'Clothes') then
            case 
                when p.product_quantity_avail = 0 then 'Out of stock'
				when p.product_quantity_avail <= 20 and p.product_quantity_avail>0 then 'Low stock'
                when p.product_quantity_avail between 21 and 80 then 'In stock'
                else 'Enough stock'
            end
        else
            case 
				when p.product_quantity_avail = 0 then 'Out of stock'
                when p.product_quantity_avail <= 15 and p.product_quantity_avail>0 then 'Low stock'
                when p.product_quantity_avail between 16 and 50 then 'In stock'
                else 'Enough stock'
            end
    end as inventoryStatus
from product p join product_class pc on p.product_class_code = pc.product_class_code;

-- 3. Write a query to Show the count of cities in all countries other than USA & MALAYSIA, with more than 1 city, in the descending order of CITIES. (2 rows) [NOTE: ADDRESS TABLE, Do not use Distinct]
select country,count(city) from address where country not in('USA', 'MALAYSIA') group by country having count(city) > 1 order by count(city) desc;

-- 4. Write a query to display the customer_id,customer full name ,city,pincode,and order details (order id, product class desc, product desc, subtotal(product_quantity * product_price)) for orders shipped to cities whose pin codes do not have any 0s in them. Sort the output on customer name and subtotal. (52 ROWS) [NOTE: TABLE TO BE USED - online_customer, address, order_header, order_items, product, product_class]
select oc.customer_id,oc.customer_fname || ' ' || oc.customer_lname as customer_full_name,a.city,a.pincode,oh.order_id,pc.product_class_desc,p.product_desc,
oi.product_quantity * p.product_price as subTotal
from online_customer oc
join address a on oc.address_id = a.address_id
join order_header oh on oc.customer_id = oh.customer_id
join order_items oi on oh.order_id = oi.order_id
join product p on oi.product_id = p.product_id
join product_class pc on p.product_class_code = pc.product_class_code
where a.pincode not like '%0%' and oh.order_status = 'Shipped' order by customer_full_name, subTotal;


-- 5. Write a Query to display product id,product description,totalquantity(sum(product quantity) for an item which has been bought maximum no. of times (Quantity Wise) along with product id 201. (USE SUB-QUERY) (1 ROW) [NOTE: ORDER_ITEMS TABLE, PRODUCT TABLE]
select p.product_id,p.product_desc,sum(oi.product_quantity) as totalQuantity 
from product p
join order_items oi on p.product_id = oi.product_id where oi.order_id in (select order_id from order_items where product_id = 201)and p.product_id != 201 
group by p.product_id, p.product_desc order by totalQuantity desc limit 1;

-- 6. Write a query to display the customer_id,customer name, email and order details (order id, product desc,product qty, subtotal(product_quantity * product_price)) for all customers even if they have not ordered any item.(225 ROWS) [NOTE: TABLE TO BE USED - online_customer, order_header, order_items, product] 
select c.customer_id,c.customer_fname || ' ' || c.customer_lname as customerFullName,c.customer_email,o.order_id,p.product_desc,oi.product_quantity,oi.product_quantity * p.product_price as subTotal
from online_customer c
left join order_header o on c.customer_id = o.customer_id
left join order_items oi on o.order_id = oi.order_id
left join product p on oi.product_id = p.product_id;
