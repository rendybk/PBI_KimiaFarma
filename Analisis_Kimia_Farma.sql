-- 5 Cabang dengan Rating Teratas
WITH avg_transaction_rating AS (
    SELECT 
        ft.branch_id, 
        AVG(ft.rating) AS avg_trans_rating
    FROM 
        `rakamin-kf-analytics-439102.kimia_farma.kf_final_transaction` ft
    GROUP BY 
        ft.branch_id
)
SELECT 
    kc.branch_name, 
    kc.kota, 
    kc.provinsi, 
    kc.rating AS branch_rating, 
    atr.avg_trans_rating AS transaction_rating
FROM 
    `rakamin-kf-analytics-439102.kimia_farma.kf_kantor_cabang` kc
JOIN 
    avg_transaction_rating atr ON kc.branch_id = atr.branch_id
ORDER BY 
    kc.rating DESC, 
    atr.avg_trans_rating ASC
LIMIT 5;

-- 10 Profinsi dengan total transaksi tertinggi
select 
kc.provinsi,
sum(ft.price) as total_transaksi
from
	`rakamin-kf-analytics-439102.kimia_farma.kf_final_transaction` ft
join
	`rakamin-kf-analytics-439102.kimia_farma.kf_kantor_cabang` kc on ft.branch_id = kc.branch_id
group by
	kc.provinsi
order by
	total_transaksi desc
limit 10;

-- 5 branch dengan rating tertinggi tetapi rating transaksi terendah
WITH avg_transaction_rating AS (
    SELECT 
        ft.branch_id, 
        AVG(ft.rating) AS avg_trans_rating
    FROM 
        `rakamin-kf-analytics-439102.kimia_farma.kf_final_transaction` ft
    GROUP BY 
        ft.branch_id
)
SELECT 
    kc.branch_name, 
    kc.kota, 
    kc.provinsi, 
    kc.rating AS branch_rating, 
    atr.avg_trans_rating AS transaction_rating
FROM 
    `rakamin-kf-analytics-439102.kimia_farma.kf_kantor_cabang` kc
JOIN 
    avg_transaction_rating atr ON kc.branch_id = atr.branch_id
ORDER BY 
    kc.rating DESC, 
    atr.avg_trans_rating ASC
LIMIT 5;

-- Persentase penjualan tiap produk
SELECT
kp.product_name,
SUM(ft.nett_sales),
(SUM(ft.nett_sales) /(SELECT(SUM(nett_sales)) FROM `rakamin-kf-analytics-439102.kimia_farma.kf_final_transaction`)) * 100 AS persentase_profit
FROM
`rakamin-kf-analytics-439102.kimia_farma.kf_final_transaction` ft
JOIN
`rakamin-kf-analytics-439102.kimia_farma.kf_product` kp ON ft.product_id = kp.product_id
GROUP BY kp.product_name
ORDER BY persentase_profit DESC

-- Top 5 cabang dengan penjualan terbanyak

SELECT
kc.branch_name,
kc.kota,
kc.provinsi,
SUM(ft.nett_sales) AS total_pendapatan
FROM
`rakamin-kf-analytics-439102.kimia_farma.kf_final_transaction` ft
JOIN
`rakamin-kf-analytics-439102.kimia_farma.kf_kantor_cabang` kc ON ft.branch_id = kc.branch_id
GROUP BY kc.branch_name,kc.kota,kc.provinsi 
ORDER BY total_pendapatan DESC
LIMIT 5;