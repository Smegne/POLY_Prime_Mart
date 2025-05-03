-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 03, 2025 at 03:40 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `prime_mart`
--

-- --------------------------------------------------------

--
-- Table structure for table `banners`
--

CREATE TABLE `banners` (
  `id` int(11) NOT NULL,
  `message` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `customer` varchar(255) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `status` enum('pending','processing','shipped','delivered','cancelled','paid') DEFAULT 'pending',
  `transaction_id` varchar(255) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT 'chapa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `customer`, `total`, `status`, `transaction_id`, `payment_method`) VALUES
(1, 'smegn', 1500.00, '', 'TXN123456789', 'Chapa');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `discount` decimal(5,2) DEFAULT 0.00,
  `stock` varchar(20) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `set_in` enum('latest','bestselling','feature') DEFAULT 'latest',
  `show_in` enum('home page','shop page') DEFAULT 'shop page'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `title`, `price`, `discount`, `stock`, `description`, `category`, `image_url`, `set_in`, `show_in`) VALUES
(4, 'AdventurePro Hiking Backpack', 79.99, 20.00, '0', 'Tackle the trails with this durable, water-resistant backpack, featuring multiple compartments for all your gear.', 'outdoor', 'https://images.unsplash.com/photo-1551632811-561732d1e306', 'latest', 'shop page'),
(5, 'Stainless Steel Water Bottle', 24.95, 0.00, '0', 'Keep your drinks hot or cold for hours with this eco-friendly, stainless steel water bottle.', 'outdoor', 'https://images.unsplash.com/photo-1602143407151-7111542de6e8', 'latest', 'shop page'),
(8, 'Wooden Wall Art Set', 55.00, 0.00, '0', 'Transform your walls with this set of three rustic wooden art pieces, showcasing nature-inspired designs.', 'home decor', 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c', 'latest', 'shop page'),
(9, 'Compact Camping Lantern', 1999.00, 5.00, '0', 'Light up your campsite with this portable, solar-powered lantern, built for outdoor adventures.', 'outdoor', 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c', 'latest', 'shop page'),
(10, 'Smart LED Desk Light', 37.50, 15.00, '0', 'Brighten your workspace with this adjustable LED desk light, featuring touch controls and USB charging.', 'electronics', 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c', 'latest', 'shop page'),
(13, 'ssmegn', 2300.00, 67.00, '0', '', '', 'https://images.unsplash.com/photo-1512729343400-4fcf83a18f72?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fHBjfGVufDB8fDB8fHww', 'latest', 'shop page'),
(14, 'a woman holding shopping bags', 987.00, 45.00, '0', 'A back view of a woman holding shopping bags in front of a store window stock photo', 'clothing', 'https://media.istockphoto.com/id/2155795543/photo/a-back-view-of-a-woman-holding-shopping-bags-in-front-of-a-store-window.jpg?s=2048x2048&w=is&k=20&c=WIkI5826AKsZ0Q7Ggc-KB5AiWzAGLcjdyEoNIgOZkyM=', 'latest', 'shop page'),
(15, 'A man models a stylish ', 45.00, 999.99, '34', 'A man models a stylish pair of clear-framed eyeglasses, enhancing his sophisticated', 'clothing', 'https://images.unsplash.com/photo-1717724162644-75f624f413ca?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'bestselling', 'home page'),
(17, 'Photo by Mahdi Bafande', 9000.00, 18.00, '24', 'Photo by Mahdi Bafand', 'clothing', 'https://images.unsplash.com/photo-1621335829175-95f437384d7c?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'latest', 'home page'),
(18, 'fashion hat', 450.00, 11.00, '34', 'fashion hat', 'clothing', 'https://plus.unsplash.com/premium_photo-1683121266311-04c92a01f5e6?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'bestselling', 'home page'),
(39, 'Young man consults with girlfriend while selecting a shirt', 6500.00, 6.00, '23', 'Young man consults with girlfriend while selecting a shirt', 'electronics', 'https://plus.unsplash.com/premium_photo-1683120693594-3bcd84aa7220?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'latest', 'home page'),
(40, 'Professional dressmaker fixing beautiful dress decoration ', 5900.00, 10.00, '56', 'Professional dressmaker fixing beautiful dress decoration element while happy customer standing still', 'electronics', 'https://plus.unsplash.com/premium_photo-1683121807753-43d2f6b07f00?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'latest', 'home page'),
(41, 'a young boy in a black jacket and khaki pants', 1234.00, 0.00, '67', 'a young boy in a black jacket and khaki pants', 'clothing', 'https://plus.unsplash.com/premium_photo-1707816501019-430eb73eb624?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'latest', 'home page'),
(42, 'a woman in a gray suit and white sneakers', 3456.00, 999.99, '54', 'a woman in a gray suit and white sneakers', 'clothing', 'https://plus.unsplash.com/premium_photo-1707816501019-8f24a3c9bac4?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'latest', 'home page'),
(43, 'A group of young girls standing next to each other', 6894.00, 3.00, '35', 'A group of young girls standing next to each other', 'clothing', 'https://plus.unsplash.com/premium_photo-1706382233597-284bdd2aa549?q=80&w=869&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'latest', 'home page'),
(44, 'a woman riding a skateboard down a street', 97765.00, 6.00, '65', 'a woman riding a skateboard down a street', 'clothing', 'https://plus.unsplash.com/premium_photo-1705974281509-117a3d8988cb?q=80&w=871&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'latest', 'home page'),
(45, 'woman in orange and white hoodie', 5657.00, 5.00, '556', 'woman in orange and white hoodie', 'clothing', 'https://images.unsplash.com/photo-1587038255943-390cadaefffe?q=80&w=464&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'latest', 'home page'),
(46, 'a stack of sweaters sitting on top of a wooden table', 8900.00, 21.00, '5', 'a stack of sweaters sitting on top of a wooden table', 'clothing', 'https://plus.unsplash.com/premium_photo-1673458070040-d126ffddafe3?q=80&w=455&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'latest', 'home page'),
(47, 'a woman with white hair is holding a coffee cup', 5466.00, 4.00, '34', 'a woman with white hair is holding a coffee cup', 'clothing', 'https://plus.unsplash.com/premium_photo-1698952256460-b7780e853f63?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'latest', 'home page'),
(48, 'woman in black and brown leopard print coat standing near white wall', 5678.00, 6.00, '5', 'woman in black and brown leopard print coat standing near white wall', 'outdoor', 'https://images.unsplash.com/photo-1608836389743-ce6a98ebcc87?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'latest', 'home page'),
(49, 'woman in pink and white floral spaghetti strap dress', 3456.00, 3.00, '3', 'woman in pink and white floral spaghetti strap dress walking on gray concrete bridge during daytime\n', 'electronics', 'https://images.unsplash.com/photo-1615805698573-38d5d4f06981?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'latest', 'home page'),
(50, 'girl in blue and red zip up jacket and black pants standing on gray concrete floor', 8976.00, 54.00, '4', 'girl in blue and red zip up jacket and black pants standing on gray concrete floor', 'clothing', 'https://images.unsplash.com/photo-1592851324684-f2c6d7604c8d?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'latest', 'home page'),
(51, 'man in black leather jacke', 6788.00, 7.00, '77', 'man in black leather jacket and black pants standing on sidewalk during daytime', 'clothing', 'https://images.unsplash.com/photo-1589837015063-1b6c5ff9f467?q=80&w=464&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'latest', 'home page'),
(52, 'Fashionable young woman wearing a blue coat and sunglasses strikes', 4567.00, 12.00, '56', 'Fashionable young woman wearing a blue coat and sunglasses strikes a pose on a vibrant yellow background, exuding confidence and style', 'clothing', 'https://media.istockphoto.com/id/2206037487/photo/stylish-woman-posing-in-blue-coat-dark-sunglasses-against-bright-yellow-backdrop-radiating.jpg?s=612x612&w=is&k=20&c=U640YeCga8r39vg-ARLYsiy0ODulphqDoLfL5ZBOEus=', 'latest', 'home page');

-- --------------------------------------------------------

--
-- Table structure for table `promotions`
--

CREATE TABLE `promotions` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `discount` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `role` varchar(100) NOT NULL,
  `permissions` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

CREATE TABLE `support_tickets` (
  `id` int(11) NOT NULL,
  `customer` varchar(255) NOT NULL,
  `issue` text NOT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` varchar(50) DEFAULT 'Active',
  `role` enum('user','admin') NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `status`, `role`) VALUES
(1, 'primemart1', 'smegndestew2@gmail.com', '$2b$10$ZL.EeVlxaxzDdY5vJCJdq.fQcFQMIeQ5FqRO9HSFG9nLSfJBXHtb2', 'Active', 'user'),
(2, 'smegndestew53@gmail.com', 'smegndestew53@gmail.com', '$2b$10$D.RXyNVJ1WkmtU0OZiwlE.2Om0kfAjiaETjnhnRe1rbYv5LiKs7H2', 'Active', 'admin'),
(3, 'smegndestew5@gmail.com', 'smegndestew5@gmail.com', '$2b$10$5RuLQCxV.BJoHdOqh5tFHuCO9mw1svubz/PejCgHcjKJ2GnxOS7tq', 'Active', 'user'),
(4, 'smegndestew@gmail.com', 'smegndestew@gmail.com', '$2b$10$UELDDOAap8lpG.Tyrctow.MQ6Zi.1c25HyFoLyA3jSh5VsZlX3t42', 'Active', 'user'),
(7, '234', 'smegndeste@gmail.com', '$2b$10$HMRVeb4NgNSDs2bl/rcOJ.qtiRHFQTtyX2HDiJru.5L5KHI5MLLsa', 'Active', 'user'),
(9, 'smegn@gmail.com', 'smegn@gmail.com', '$2b$10$QbB7RJWP1Dxo.ZwrRJJda./nu6Ctx04.7u5k.giwGgLM14SvpZVRe', 'Active', 'user'),
(10, 'sme@gmail.com', 'sme@gmail.com', '$2b$10$Cmdm81JsWu/lrnta.pRGFeRG7sowrh81tFWiMDrNX5wp3VaoP6IKq', 'Active', 'user'),
(11, 'megn@gmail.com', 'megn@gmail.com', '$2b$10$8QHFuyaJH/y23Ka2IectuuXp212LLrgqD7ukRY3u9eE7goq9ekfBi', 'Active', 'user'),
(12, 'maza', 'maz@gmail.com', '$2b$10$9SYjxMgdvBqssp2ERkeFRuo5sts8m5TJvf4lOFCMH/kxIo7k1vdTi', 'Active', 'user'),
(13, 'bdu1404215', 'smegndestew533@gmail.com', '$2b$10$zRPlVBWiiNq3B8UNxZtGO.VIw7yKHkBoVzPbrw1DbVVUGq7gafD.a', 'Active', 'user'),
(14, 'kiru', 'kiru@gmail.com', '$2b$10$pBQr2g7h1DUqQwUraJRjjO/71Se6igRmoKmAGStRIKW.dTxRh.X5S', 'Active', 'user'),
(15, 'taju', 'taju@gmail.com', '$2b$10$BKcukYQIsmRq/ZIzoKlDIul7fOvyQBUqekEI8hzh32hc4OBRwVAES', 'Active', 'user'),
(16, 'taj@gmail.com', 'taj@gmail.com', '$2b$10$UTxjxc9NYanWoirFqUuLaO/MwJxU1SCW9qbwzaFcTiPYLHO0wmC46', 'Active', 'user');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `banners`
--
ALTER TABLE `banners`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `promotions`
--
ALTER TABLE `promotions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `banners`
--
ALTER TABLE `banners`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `promotions`
--
ALTER TABLE `promotions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_tickets`
--
ALTER TABLE `support_tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
