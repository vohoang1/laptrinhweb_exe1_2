-- ============================================================================
-- SQL SCHEMA - Quản lý người dùng BKE
-- ============================================================================
CREATE DATABASE IF NOT EXISTS `bke_center` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `bke_center`;

CREATE TABLE `users` (
    `user_id` INT(11) NOT NULL AUTO_INCREMENT,
    `user_name` VARCHAR(25) NOT NULL,
    `user_email` VARCHAR(55) NOT NULL,
    `user_pass` VARCHAR(255) NOT NULL,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `products` (
    `product_id` INT(11) NOT NULL AUTO_INCREMENT,
    `product_name` VARCHAR(255) NOT NULL,
    `product_price` DOUBLE NOT NULL,
    `product_description` TEXT NOT NULL,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `orders` (
    `order_id` INT(11) NOT NULL AUTO_INCREMENT,
    `user_id` INT(11) NOT NULL,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`order_id`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `order_details` (
    `order_detail_id` INT(11) NOT NULL AUTO_INCREMENT,
    `order_id` INT(11) NOT NULL,
    `product_id` INT(11) NOT NULL,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`order_detail_id`),
    FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
    FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Thêm dữ liệu mẫu
INSERT INTO `users` (`user_name`, `user_email`, `user_pass`) VALUES 
('Minh Anh', 'minhanh@gmail.com', '123456'),
('Mai Linh', 'mailinh@yahoo.com', '123456'),
('Hoàng Minh', 'hoangminh@gmail.com', '123456'),
('Lan Nhi', 'lannhi@hotmail.com', '123456');

INSERT INTO `products` (`product_name`, `product_price`, `product_description`) VALUES 
('Samsung Galaxy S23', 20000000, 'Flagship Samsung'),
('iPhone 14 Pro', 25000000, 'Flagship Apple');
