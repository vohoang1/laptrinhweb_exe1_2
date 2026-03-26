-- ============================================================================
--  DATABASE SCHEMA - QUẢN LÝ NGƯỜI DÙNG VÀ ĐƠN HÀNG
--  Trung tâm điện tử BKE
-- ============================================================================

CREATE DATABASE IF NOT EXISTS `bke_center` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `bke_center`;

CREATE TABLE `users` (
    `user_id`       INT(11)     NOT NULL AUTO_INCREMENT,
    `user_name`     VARCHAR(25) NOT NULL,
    `user_email`    VARCHAR(55) NOT NULL,
    `user_pass`     VARCHAR(255) NOT NULL,
    `updated_at`    DATETIME    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_at`    DATETIME    DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`user_id`),
    UNIQUE KEY `uk_user_email` (`user_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `products` (
    `product_id`          INT(11)     NOT NULL AUTO_INCREMENT,
    `product_name`        VARCHAR(255) NOT NULL,
    `product_price`       DOUBLE       NOT NULL,
    `product_description` TEXT         NOT NULL,
    `updated_at`          DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_at`          DATETIME     DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `orders` (
    `order_id`    INT(11)  NOT NULL AUTO_INCREMENT,
    `user_id`     INT(11)  NOT NULL,
    `updated_at`  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_at`  DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`order_id`),
    KEY `fk_orders_user` (`user_id`),
    CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `order_details` (
    `order_detail_id` INT(11)  NOT NULL AUTO_INCREMENT,
    `order_id`        INT(11)  NOT NULL,
    `product_id`      INT(11)  NOT NULL,
    `updated_at`      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_at`      DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`order_detail_id`),
    KEY `fk_order_details_order` (`order_id`),
    KEY `fk_order_details_product` (`product_id`),
    CONSTRAINT `fk_order_details_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_order_details_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` (`user_name`, `user_email`, `user_pass`) VALUES
    ('Minh Anh', 'minhanh@gmail.com', '123456'),
    ('Mai Linh', 'mailinh@yahoo.com', '123456'),
    ('Hoàng Minh', 'hoangminh@gmail.com', '123456'),
    ('Lan Nhi', 'lannhi@hotmail.com', '123456'),
    ('Minh Hải', 'minhhai@gmail.com', '123456'),
    ('Thanh Mai', 'thanhmai@gmail.com', '123456'),
    ('Văn Minh', 'vanminh@yahoo.com', '123456'),
    ('Thu Hà', 'thuha@gmail.com', '123456'),
    ('Minh Trí', 'minhtri@gmail.com', '123456'),
    ('Ánh Mai', 'anhmai@gmail.com', '123456');

INSERT INTO `products` (`product_name`, `product_price`, `product_description`) VALUES
    ('Samsung Galaxy S23', 20000000, 'Điện thoại Samsung flagship 2023'),
    ('iPhone 14 Pro', 25000000, 'Điện thoại Apple cao cấp'),
    ('Samsung TV 55 inch', 15000000, 'Tivi thông minh Samsung'),
    ('Apple MacBook Air', 30000000, 'Laptop Apple mỏng nhẹ'),
    ('Samsung Laptop', 18000000, 'Laptop Samsung hiệu năng cao'),
    ('Apple iPad Pro', 22000000, 'Máy tính bảng Apple'),
    ('Sony Headphones', 5000000, 'Tai nghe không dây'),
    ('Samsung Watch', 8000000, 'Đồng hồ thông minh Samsung'),
    ('Apple Watch', 10000000, 'Đồng hồ thông minh Apple'),
    ('Samsung Tablet', 12000000, 'Máy tính bảng Samsung');

INSERT INTO `orders` (`user_id`) VALUES
    (1), (1), (1), (2), (2), (3), (3), (3), (3), (4),
    (5), (5), (6), (6), (6), (7), (8), (8), (9), (9), (9), (9), (10);

INSERT INTO `order_details` (`order_id`, `product_id`) VALUES
    (1, 1), (1, 2), (1, 3), (2, 4), (2, 5), (3, 6),
    (4, 1), (4, 2), (4, 3), (4, 4), (5, 5),
    (6, 1), (7, 2), (7, 3), (8, 4), (8, 5), (8, 6), (9, 7), (9, 8),
    (10, 1), (10, 2), (10, 3), (10, 4), (10, 5),
    (11, 6), (11, 7), (12, 8), (12, 9), (12, 10),
    (13, 1), (13, 2), (14, 3), (15, 4), (15, 5), (15, 6), (15, 7),
    (16, 8), (16, 9), (17, 1), (18, 2), (18, 3), (18, 4),
    (19, 5), (20, 6), (20, 7), (21, 8), (22, 9), (22, 10),
    (23, 1), (23, 2), (23, 3);
