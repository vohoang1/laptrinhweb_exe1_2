USE `bke_center`;

-- 1. Liệt kê các hóa đơn của khách hàng, thông tin hiển thị gồm: mã user, tên user, mã hóa đơn
SELECT u.user_id, u.user_name, o.order_id
FROM users u 
JOIN orders o ON u.user_id = o.user_id;

-- 2. Liệt kê số lượng các hóa đơn của khách hàng: mã user, tên user, số đơn hàng
SELECT u.user_id, u.user_name, COUNT(o.order_id) as so_don_hang
FROM users u 
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.user_name;

-- 3. Liệt kê thông tin hóa đơn: mã đơn hàng, số sản phẩm
SELECT o.order_id, COUNT(od.product_id) as so_san_pham
FROM orders o 
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.order_id;

-- 4. Liệt kê thông tin mua hàng của người dùng: mã user, tên user, mã đơn hàng, tên sản phẩm.
SELECT u.user_id, u.user_name, o.order_id, p.product_name
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
ORDER BY o.order_id, u.user_id;

-- 5. Liệt kê 7 người dùng có số lượng đơn hàng nhiều nhất
SELECT u.user_id, u.user_name, COUNT(o.order_id) as so_don_hang
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.user_name
ORDER BY so_don_hang DESC
LIMIT 7;

-- 6. Liệt kê 7 người dùng mua sản phẩm có tên: Samsung hoặc Apple
SELECT u.user_id, u.user_name, o.order_id, p.product_name
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE p.product_name LIKE '%Samsung%' OR p.product_name LIKE '%Apple%'
ORDER BY u.user_id, o.order_id
LIMIT 7;

-- 7. Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng
SELECT u.user_id, u.user_name, o.order_id, SUM(p.product_price) as tong_tien
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY u.user_id, u.user_name, o.order_id
ORDER BY u.user_id;

-- 8. Mỗi user chỉ chọn ra 1 đơn hàng có giá tiền lớn nhất.
SELECT u.user_id, u.user_name, res.order_id, res.tong_tien
FROM users u
JOIN (
    -- Bước 1: Tính tiền cho từng đơn hàng
    SELECT o.user_id, o.order_id, SUM(p.product_price) as tong_tien
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY o.user_id, o.order_id
) res ON u.user_id = res.user_id
WHERE res.tong_tien = (
    -- Bước 2: Tìm giá tiền lớn nhất của user đó
    SELECT MAX(sub_res.tong_tien)
    FROM (
        SELECT o2.user_id, SUM(p2.product_price) as tong_tien
        FROM orders o2
        JOIN order_details od2 ON o2.order_id = od2.order_id
        JOIN products p2 ON od2.product_id = p2.product_id
        GROUP BY o2.user_id, o2.order_id
    ) sub_res
    WHERE sub_res.user_id = u.user_id
);

-- 9. Mỗi user chỉ chọn ra 1 đơn hàng có giá tiền nhỏ nhất.
SELECT u.user_id, u.user_name, res.order_id, res.tong_tien, res.so_san_pham
FROM users u
JOIN (
    -- Bước 1: Tính tiền và số lượng cho từng đơn hàng
    SELECT o.user_id, o.order_id, SUM(p.product_price) as tong_tien, COUNT(od.product_id) as so_san_pham
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY o.user_id, o.order_id
) res ON u.user_id = res.user_id
WHERE res.tong_tien = (
    -- Bước 2: Tìm giá tiền nhỏ nhất của user đó
    SELECT MIN(sub_res.tong_tien)
    FROM (
        SELECT o2.user_id, SUM(p2.product_price) as tong_tien
        FROM orders o2
        JOIN order_details od2 ON o2.order_id = od2.order_id
        JOIN products p2 ON od2.product_id = p2.product_id
        GROUP BY o2.user_id, o2.order_id
    ) sub_res
    WHERE sub_res.user_id = u.user_id
);

-- 10. Mỗi user chỉ chọn ra 1 đơn hàng có số sản phẩm là nhiều nhất.
SELECT u.user_id, u.user_name, res.order_id, res.tong_tien, res.so_san_pham
FROM users u
JOIN (
    -- Bước 1: Tính tiền và số lượng cho từng đơn hàng
    SELECT o.user_id, o.order_id, SUM(p.product_price) as tong_tien, COUNT(od.product_id) as so_san_pham
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY o.user_id, o.order_id
) res ON u.user_id = res.user_id
WHERE res.so_san_pham = (
    -- Bước 2: Tìm số lượng sản phẩm lớn nhất của user đó
    SELECT MAX(sub_res.so_san_pham)
    FROM (
        SELECT o2.user_id, COUNT(od2.product_id) as so_san_pham
        FROM orders o2
        JOIN order_details od2 ON o2.order_id = od2.order_id
        GROUP BY o2.user_id, o2.order_id
    ) sub_res
    WHERE sub_res.user_id = u.user_id
);
