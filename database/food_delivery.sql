-- ============================================
-- FOOD DELIVERY DATABASE - COMPLETE DUMP
-- ============================================
-- Tạo database
CREATE DATABASE IF NOT EXISTS food_delivery;
USE food_delivery;

-- ============================================
-- 1. TABLE: user - Người dùng
-- ============================================
CREATE TABLE `user` (
  `user_id` INT AUTO_INCREMENT PRIMARY KEY,
  `full_name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert sample users
INSERT INTO `user` (`full_name`, `email`, `password`) VALUES
('Nguyễn Văn A', 'nguyenvana@gmail.com', 'password123'),
('Trần Thị B', 'tranthib@gmail.com', 'password123'),
('Lê Văn C', 'levanc@gmail.com', 'password123'),
('Phạm Thị D', 'phamthid@gmail.com', 'password123'),
('Hoàng Văn E', 'hoangvane@gmail.com', 'password123'),
('Vũ Thị F', 'vuthif@gmail.com', 'password123'),
('Đặng Văn G', 'dangvang@gmail.com', 'password123'),
('Bùi Thị H', 'buithih@gmail.com', 'password123'),
('Dương Văn I', 'duongvani@gmail.com', 'password123'),
('Mai Thị K', 'maithik@gmail.com', 'password123'),
('Trương Văn L', 'truongvanl@gmail.com', 'password123'),
('Phan Thị M', 'phanthim@gmail.com', 'password123'),
('Lý Văn N', 'lyvann@gmail.com', 'password123'),
('Võ Thị O', 'vothio@gmail.com', 'password123'),
('Hồ Văn P', 'hovanp@gmail.com', 'password123'),
('Đinh Thị Q', 'dinhthiq@gmail.com', 'password123'),
('Ngô Văn R', 'ngovanr@gmail.com', 'password123'),
('Tô Thị S', 'tothis@gmail.com', 'password123'),
('Đỗ Văn T', 'dovant@gmail.com', 'password123'),
('Cao Thị U', 'caothiu@gmail.com', 'password123');

-- ============================================
-- 2. TABLE: restaurant - Nhà hàng
-- ============================================
CREATE TABLE `restaurant` (
  `res_id` INT AUTO_INCREMENT PRIMARY KEY,
  `res_name` VARCHAR(255) NOT NULL,
  `image` VARCHAR(500),
  `desc` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert sample restaurants
INSERT INTO `restaurant` (`res_name`, `image`, `desc`) VALUES
('Nhà hàng Hương Việt', 'huongviet.jpg', 'Món ăn truyền thống Việt Nam'),
('Pizza Paradise', 'pizza.jpg', 'Pizza Ý chính gốc'),
('Sushi Master', 'sushi.jpg', 'Sushi & Sashimi tươi ngon'),
('Phở Hà Nội', 'pho.jpg', 'Phở bò Hà Nội truyền thống'),
('BBQ House', 'bbq.jpg', 'Nướng Hàn Quốc'),
('Vegetarian Heaven', 'vege.jpg', 'Món chay cao cấp'),
('Burger King Express', 'burger.jpg', 'Burger & Fast food'),
('Dimsum Palace', 'dimsum.jpg', 'Dimsum & Món Hoa'),
('Thai Spice', 'thai.jpg', 'Ẩm thực Thái Lan'),
('Seafood Ocean', 'seafood.jpg', 'Hải sản tươi sống');

-- ============================================
-- 3. TABLE: food_type - Loại món ăn
-- ============================================
CREATE TABLE `food_type` (
  `type_id` INT AUTO_INCREMENT PRIMARY KEY,
  `type_name` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert sample food types
INSERT INTO `food_type` (`type_name`) VALUES
('Món chính'),
('Khai vị'),
('Tráng miệng'),
('Đồ uống'),
('Món ăn nhanh');

-- ============================================
-- 4. TABLE: food - Món ăn
-- ============================================
CREATE TABLE `food` (
  `food_id` INT AUTO_INCREMENT PRIMARY KEY,
  `food_name` VARCHAR(255) NOT NULL,
  `image` VARCHAR(500),
  `price` DECIMAL(10,2) NOT NULL,
  `desc` TEXT,
  `type_id` INT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`type_id`) REFERENCES `food_type`(`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert sample foods
INSERT INTO `food` (`food_name`, `image`, `price`, `desc`, `type_id`) VALUES
('Phở bò', 'pho_bo.jpg', 45000, 'Phở bò Hà Nội truyền thống', 1),
('Bún chả', 'bun_cha.jpg', 40000, 'Bún chả Hà Nội', 1),
('Cơm tấm', 'com_tam.jpg', 35000, 'Cơm tấm sườn bì chả', 1),
('Pizza hải sản', 'pizza_haisan.jpg', 150000, 'Pizza với hải sản tươi', 1),
('Sushi combo', 'sushi_combo.jpg', 200000, '20 miếng sushi tổng hợp', 1),
('Gỏi cuốn', 'goi_cuon.jpg', 30000, 'Gỏi cuốn tôm thịt', 2),
('Chả giò', 'cha_gio.jpg', 35000, 'Chả giò chiên giòn', 2),
('Salad trộn', 'salad.jpg', 40000, 'Salad rau củ tươi', 2),
('Kem vani', 'kem.jpg', 20000, 'Kem vani mát lạnh', 3),
('Chè ba màu', 'che.jpg', 25000, 'Chè ba màu truyền thống', 3),
('Bánh flan', 'flan.jpg', 15000, 'Bánh flan caramen', 3),
('Trà sữa', 'tra_sua.jpg', 30000, 'Trà sữa trân châu', 4),
('Cà phê sữa đá', 'ca_phe.jpg', 25000, 'Cà phê sữa đá Việt Nam', 4),
('Nước cam', 'nuoc_cam.jpg', 20000, 'Nước cam vắt tươi', 4),
('Hamburger', 'hamburger.jpg', 50000, 'Hamburger bò phô mai', 5),
('Gà rán', 'ga_ran.jpg', 60000, '3 miếng gà rán giòn', 5),
('Khoai tây chiên', 'khoai_tay.jpg', 25000, 'Khoai tây chiên giòn', 5),
('Mì Ý sốt bò bằm', 'mi_y.jpg', 70000, 'Mì Ý spaghetti sốt bò bằm', 1),
('Lẩu Thái', 'lau_thai.jpg', 250000, 'Lẩu Thái chua cay', 1),
('Cơm chiên Dương Châu', 'com_chien.jpg', 45000, 'Cơm chiên Dương Châu đặc biệt', 1),
('Bánh mì thịt', 'banh_mi.jpg', 20000, 'Bánh mì thịt pate', 5),
('Nem rán', 'nem_ran.jpg', 40000, 'Nem rán miền Bắc', 2),
('Súp hải sản', 'sup_haisan.jpg', 50000, 'Súp hải sản đặc biệt', 2),
('Yaourt', 'yaourt.jpg', 15000, 'Yaourt sữa chua', 3),
('Sinh tố bơ', 'sinh_to_bo.jpg', 35000, 'Sinh tố bơ sữa', 4),
('Nước dừa', 'nuoc_dua.jpg', 20000, 'Nước dừa tươi', 4),
('Bò bít tết', 'bo_bit_tet.jpg', 120000, 'Bò bít tết Úc', 1),
('Cá hồi nướng', 'ca_hoi.jpg', 180000, 'Cá hồi nướng sốt teriyaki', 1),
('Tôm hùm nướng', 'tom_hum.jpg', 500000, 'Tôm hùm nướng phô mai', 1),
('Lẩu hải sản', 'lau_haisan.jpg', 300000, 'Lẩu hải sản cao cấp', 1);

-- ============================================
-- 5. TABLE: sub_food - Món phụ
-- ============================================
CREATE TABLE `sub_food` (
  `sub_id` INT AUTO_INCREMENT PRIMARY KEY,
  `sub_name` VARCHAR(255) NOT NULL,
  `sub_price` DECIMAL(10,2) NOT NULL,
  `food_id` INT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`food_id`) REFERENCES `food`(`food_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert sample sub_foods
INSERT INTO `sub_food` (`sub_name`, `sub_price`, `food_id`) VALUES
('Thêm thịt bò', 20000, 1),
('Thêm tàu hủ ky', 15000, 1),
('Thêm trứng', 10000, 3),
('Thêm phô mai', 15000, 4),
('Thêm hải sản', 30000, 4),
('Thêm wasabi', 5000, 5),
('Thêm gừng', 5000, 5),
('Thêm xúc xích', 10000, 15),
('Thêm rau củ', 10000, 15),
('Thêm topping trân châu', 10000, 12),
('Thêm topping thạch', 8000, 12),
('Thêm đá', 0, 13),
('Size lớn', 10000, 14),
('Thêm sốt mayo', 5000, 16),
('Thêm sốt cay', 5000, 16),
('Thêm tôm', 25000, 20),
('Thêm xúc xích Đức', 20000, 18),
('Thêm nấm', 15000, 27),
('Thêm bơ', 10000, 25),
('Thêm đường', 5000, 24);

-- ============================================
-- 6. TABLE: order - Đơn hàng
-- ============================================
CREATE TABLE `order` (
  `order_id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL,
  `food_id` INT NOT NULL,
  `amount` INT NOT NULL,
  `code` VARCHAR(50) NOT NULL UNIQUE,
  `arr_sub_id` JSON,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`),
  FOREIGN KEY (`food_id`) REFERENCES `food`(`food_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert sample orders
INSERT INTO `order` (`user_id`, `food_id`, `amount`, `code`, `arr_sub_id`) VALUES
(1, 1, 2, 'ORD001', '[1,2]'),
(2, 4, 1, 'ORD002', '[4,5]'),
(3, 5, 1, 'ORD003', '[6,7]'),
(4, 3, 3, 'ORD004', '[3]'),
(5, 15, 2, 'ORD005', '[8,9]'),
(1, 12, 1, 'ORD006', '[10,11]'),
(2, 1, 1, 'ORD007', '[1]'),
(6, 20, 2, 'ORD008', '[16]'),
(7, 18, 1, 'ORD009', '[17]'),
(8, 27, 1, 'ORD010', '[18]'),
(9, 4, 2, 'ORD011', '[4]'),
(10, 5, 1, 'ORD012', NULL),
(11, 15, 3, 'ORD013', '[8]'),
(12, 1, 2, 'ORD014', '[1,2]'),
(13, 3, 1, 'ORD015', '[3]'),
(14, 12, 2, 'ORD016', '[10]'),
(15, 20, 1, 'ORD017', NULL),
(1, 4, 1, 'ORD018', '[4,5]'),
(2, 18, 2, 'ORD019', '[17]'),
(3, 1, 1, 'ORD020', '[1]'),
(4, 5, 1, 'ORD021', '[6,7]'),
(5, 15, 1, 'ORD022', '[8,9]'),
(6, 3, 2, 'ORD023', '[3]'),
(7, 12, 1, 'ORD024', '[10,11]'),
(8, 4, 1, 'ORD025', NULL),
(9, 1, 3, 'ORD026', '[1,2]'),
(10, 20, 1, 'ORD027', '[16]'),
(11, 18, 2, 'ORD028', '[17]'),
(12, 5, 1, 'ORD029', '[6]'),
(13, 15, 1, 'ORD030', NULL),
(14, 1, 2, 'ORD031', '[1]'),
(15, 3, 1, 'ORD032', '[3]'),
(16, 12, 1, 'ORD033', '[10]'),
(17, 4, 2, 'ORD034', '[4,5]'),
(18, 20, 1, 'ORD035', NULL),
(19, 18, 1, 'ORD036', '[17]'),
(20, 5, 1, 'ORD037', '[6,7]'),
(1, 15, 2, 'ORD038', '[8]'),
(2, 1, 1, 'ORD039', '[1,2]'),
(3, 3, 2, 'ORD040', '[3]'),
(4, 12, 1, 'ORD041', '[10,11]'),
(5, 4, 1, 'ORD042', NULL),
(6, 20, 2, 'ORD043', '[16]'),
(7, 18, 1, 'ORD044', '[17]'),
(8, 5, 1, 'ORD045', '[6]'),
(9, 15, 2, 'ORD046', '[8,9]'),
(10, 1, 1, 'ORD047', '[1]'),
(11, 3, 1, 'ORD048', '[3]'),
(12, 12, 2, 'ORD049', '[10]'),
(13, 4, 1, 'ORD050', '[4,5]');

-- ============================================
-- 7. TABLE: like_res - Like nhà hàng
-- ============================================
CREATE TABLE `like_res` (
  `like_id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL,
  `res_id` INT NOT NULL,
  `date_like` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`),
  FOREIGN KEY (`res_id`) REFERENCES `restaurant`(`res_id`),
  UNIQUE KEY `unique_user_restaurant` (`user_id`, `res_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert sample likes
INSERT INTO `like_res` (`user_id`, `res_id`, `date_like`) VALUES
(1, 1, '2024-12-01 10:30:00'),
(1, 2, '2024-12-02 11:00:00'),
(1, 3, '2024-12-03 09:15:00'),
(1, 4, '2024-12-04 14:20:00'),
(1, 5, '2024-12-05 16:45:00'),
(2, 1, '2024-12-01 12:00:00'),
(2, 2, '2024-12-02 13:30:00'),
(2, 3, '2024-12-03 15:00:00'),
(2, 4, '2024-12-04 10:00:00'),
(3, 1, '2024-12-01 09:00:00'),
(3, 2, '2024-12-02 10:30:00'),
(3, 5, '2024-12-05 11:00:00'),
(3, 6, '2024-12-06 14:00:00'),
(4, 1, '2024-12-01 08:30:00'),
(4, 3, '2024-12-03 09:00:00'),
(4, 4, '2024-12-04 10:30:00'),
(5, 2, '2024-12-02 11:30:00'),
(5, 3, '2024-12-03 12:00:00'),
(5, 5, '2024-12-05 13:30:00'),
(6, 1, '2024-12-01 14:00:00'),
(6, 2, '2024-12-02 15:30:00'),
(7, 1, '2024-12-01 16:00:00'),
(7, 3, '2024-12-03 17:00:00'),
(8, 2, '2024-12-02 09:30:00'),
(8, 4, '2024-12-04 10:00:00'),
(9, 1, '2024-12-01 11:00:00'),
(9, 5, '2024-12-05 12:00:00'),
(10, 2, '2024-12-02 13:00:00'),
(10, 3, '2024-12-03 14:00:00'),
(11, 1, '2024-12-01 15:00:00'),
(12, 2, '2024-12-02 16:00:00'),
(13, 3, '2024-12-03 17:00:00'),
(14, 4, '2024-12-04 09:00:00'),
(15, 5, '2024-12-05 10:00:00'),
(16, 1, '2024-12-01 11:30:00'),
(17, 2, '2024-12-02 12:30:00'),
(18, 3, '2024-12-03 13:30:00'),
(19, 4, '2024-12-04 14:30:00'),
(20, 5, '2024-12-05 15:30:00'),
(1, 6, '2024-12-06 16:00:00'),
(2, 7, '2024-12-07 17:00:00'),
(3, 8, '2024-12-08 09:00:00'),
(4, 9, '2024-12-09 10:00:00'),
(5, 10, '2024-12-10 11:00:00'),
(6, 3, '2024-12-03 12:00:00'),
(7, 4, '2024-12-04 13:00:00'),
(8, 5, '2024-12-05 14:00:00'),
(9, 6, '2024-12-06 15:00:00'),
(10, 7, '2024-12-07 16:00:00'),
(11, 8, '2024-12-08 17:00:00'),
(12, 9, '2024-12-09 09:30:00'),
(13, 10, '2024-12-10 10:30:00'),
(14, 1, '2024-12-01 11:45:00'),
(15, 2, '2024-12-02 12:45:00'),
(16, 3, '2024-12-03 13:45:00'),
(17, 4, '2024-12-04 14:45:00'),
(18, 5, '2024-12-05 15:45:00'),
(19, 6, '2024-12-06 16:45:00'),
(20, 7, '2024-12-07 17:45:00'),
(1, 8, '2024-12-08 09:15:00'),
(2, 9, '2024-12-09 10:15:00'),
(3, 10, '2024-12-10 11:15:00'),
(4, 5, '2024-12-05 12:15:00'),
(5, 6, '2024-12-06 13:15:00'),
(6, 7, '2024-12-07 14:15:00'),
(7, 8, '2024-12-08 15:15:00'),
(8, 9, '2024-12-09 16:15:00'),
(9, 10, '2024-12-10 17:15:00'),
(10, 1, '2024-12-01 09:45:00'),
(11, 2, '2024-12-02 10:45:00'),
(12, 3, '2024-12-03 11:45:00'),
(13, 4, '2024-12-04 12:45:00'),
(14, 5, '2024-12-05 13:45:00'),
(15, 6, '2024-12-06 14:45:00'),
(16, 7, '2024-12-07 15:45:00'),
(17, 8, '2024-12-08 16:45:00'),
(18, 9, '2024-12-09 17:45:00'),
(19, 10, '2024-12-10 09:20:00'),
(20, 1, '2024-12-01 10:20:00');

-- ============================================
-- 8. TABLE: rate_res - Đánh giá nhà hàng
-- ============================================
CREATE TABLE `rate_res` (
  `rate_id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL,
  `res_id` INT NOT NULL,
  `amount` INT NOT NULL CHECK (`amount` >= 1 AND `amount` <= 5),
  `date_rate` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`),
  FOREIGN KEY (`res_id`) REFERENCES `restaurant`(`res_id`),
  UNIQUE KEY `unique_user_restaurant_rate` (`user_id`, `res_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert sample ratings
INSERT INTO `rate_res` (`user_id`, `res_id`, `amount`, `date_rate`) VALUES
(1, 1, 5, '2024-12-01 18:00:00'),
(2, 1, 4, '2024-12-01 18:30:00'),
(3, 1, 5, '2024-12-01 19:00:00'),
(4, 1, 4, '2024-12-01 19:30:00'),
(5, 2, 5, '2024-12-02 18:00:00'),
(6, 2, 4, '2024-12-02 18:30:00'),
(7, 2, 5, '2024-12-02 19:00:00'),
(8, 2, 3, '2024-12-02 19:30:00'),
(9, 3, 4, '2024-12-03 18:00:00'),
(10, 3, 5, '2024-12-03 18:30:00'),
(11, 3, 4, '2024-12-03 19:00:00'),
(12, 4, 5, '2024-12-04 18:00:00'),
(13, 4, 4, '2024-12-04 18:30:00'),
(14, 5, 5, '2024-12-05 18:00:00'),
(15, 5, 4, '2024-12-05 18:30:00'),
(16, 6, 4, '2024-12-06 18:00:00'),
(17, 6, 5, '2024-12-06 18:30:00'),
(18, 7, 3, '2024-12-07 18:00:00'),
(19, 7, 4, '2024-12-07 18:30:00'),
(20, 8, 5, '2024-12-08 18:00:00'),
(1, 2, 4, '2024-12-02 19:30:00'),
(2, 3, 5, '2024-12-03 19:30:00'),
(3, 4, 4, '2024-12-04 19:30:00'),
(4, 5, 5, '2024-12-05 19:30:00'),
(5, 6, 4, '2024-12-06 19:30:00'),
(6, 7, 3, '2024-12-07 19:30:00'),
(7, 8, 4, '2024-12-08 19:30:00'),
(8, 9, 5, '2024-12-09 18:00:00'),
(9, 9, 4, '2024-12-09 18:30:00'),
(10, 10, 5, '2024-12-10 18:00:00'),
(11, 10, 4, '2024-12-10 18:30:00'),
(1, 3, 5, '2024-12-03 20:00:00'),
(2, 4, 4, '2024-12-04 20:00:00'),
(3, 5, 5, '2024-12-05 20:00:00'),
(4, 6, 4, '2024-12-06 20:00:00'),
(5, 7, 3, '2024-12-07 20:00:00'),
(6, 8, 4, '2024-12-08 20:00:00'),
(7, 9, 5, '2024-12-09 20:00:00'),
(8, 10, 4, '2024-12-10 20:00:00'),
(9, 1, 5, '2024-12-01 20:00:00');

-- ============================================
-- INDEXES for better performance
-- ============================================
CREATE INDEX idx_order_user ON `order`(`user_id`);
CREATE INDEX idx_order_food ON `order`(`food_id`);
CREATE INDEX idx_like_user ON `like_res`(`user_id`);
CREATE INDEX idx_like_res ON `like_res`(`res_id`);
CREATE INDEX idx_rate_user ON `rate_res`(`user_id`);
CREATE INDEX idx_rate_res ON `rate_res`(`res_id`);