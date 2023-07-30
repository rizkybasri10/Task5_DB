create table shipping_summary (
shipping_date date,
seller_name varchar,
buyer_name varchar,
buyer_address varchar,
buyer_city varchar,
buyer_zipcode int,
kode_resi text
)

WITH data_shipping AS (
    SELECT 
        sh.shipping_date,
        st.seller_name,
        bt.buyer_name,
        bt.address AS buyer_address,
        bt.city AS buyer_city,
        bt.zipcode AS buyer_zipcode,
        CONCAT(sh.shipping_id, '-',
               to_char(sh.purchase_date, 'YYYYMMDD'), '-',
               to_char(sh.shipping_date, 'YYYYMMDD'), '-',
               bt.buyer_id, '-',
               st.seller_id) AS kode_resi

    FROM shipping_table AS sh
    LEFT JOIN seller_table AS st ON sh.seller_id = st.seller_id
    LEFT JOIN buyer_table AS bt ON sh.buyer_id = bt.buyer_id
    WHERE shipping_date BETWEEN '2022-12-01' AND '2022-12-31'
    ORDER BY shipping_date
)


SELECT * FROM data_shipping