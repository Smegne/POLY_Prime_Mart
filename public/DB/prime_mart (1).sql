-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 01, 2025 at 02:53 AM
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
  `status` varchar(50) NOT NULL
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
  `set_in` enum('latest','bestselling') DEFAULT 'latest',
  `show_in` enum('home page','shop page') DEFAULT 'shop page'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `title`, `price`, `discount`, `stock`, `description`, `category`, `image_url`, `set_in`, `show_in`) VALUES
(1, 'SkyBlue Wireless Earbuds', 499.00, 10.00, '0', 'Experience crystal-clear sound with these sleek wireless earbuds, perfect for music lovers on the go.', 'electronics', 'https://images.unsplash.com/photo-1590658268037-6bf121711a34', 'latest', 'shop page'),
(2, 'Cozy Knit Sweater', 3450.00, 15.00, '0', 'Stay warm and stylish in this soft, beige knit sweater, ideal for chilly evenings.', 'clothing', 'https://images.unsplash.com/photo-1600004897555-34a86a0c8613', 'latest', 'shop page'),
(3, 'Modern Ceramic Table Lamp', 62.00, 5.00, '0', 'Illuminate your space with this minimalist ceramic lamp, adding a touch of elegance to any room.', 'home decor', 'https://images.unsplash.com/photo-1594643439870-277b13ec-40e1-4c43-b48b-831f290222e9', 'latest', 'shop page'),
(4, 'AdventurePro Hiking Backpack', 79.99, 20.00, '0', 'Tackle the trails with this durable, water-resistant backpack, featuring multiple compartments for all your gear.', 'outdoor', 'https://images.unsplash.com/photo-1551632811-561732d1e306', 'latest', 'shop page'),
(5, 'Stainless Steel Water Bottle', 24.95, 0.00, '0', 'Keep your drinks hot or cold for hours with this eco-friendly, stainless steel water bottle.', 'outdoor', 'https://images.unsplash.com/photo-1602143407151-7111542de6e8', 'latest', 'shop page'),
(6, 'Retro Vinyl Record Player', 89.00, 10.00, '0', 'Spin your favorite records on this vintage-style record player with built-in speakers.', 'electronics', 'https://images.unsplash.com/photo-1519227357039-8a72f1f9f4d0', 'latest', 'shop page'),
(7, 'Floral Print Summer Dress', 42.00, 25.00, '0', 'Feel the breeze in this vibrant floral dress, perfect for picnics or casual outings.', 'clothing', 'https://images.unsplash.com/photo-1584273361231-7e423321d306', 'latest', 'shop page'),
(8, 'Wooden Wall Art Set', 55.00, 0.00, '0', 'Transform your walls with this set of three rustic wooden art pieces, showcasing nature-inspired designs.', 'home decor', 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c', 'latest', 'shop page'),
(9, 'Compact Camping Lantern', 1999.00, 5.00, '0', 'Light up your campsite with this portable, solar-powered lantern, built for outdoor adventures.', 'outdoor', 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c', 'latest', 'shop page'),
(10, 'Smart LED Desk Light', 37.50, 15.00, '0', 'Brighten your workspace with this adjustable LED desk light, featuring touch controls and USB charging.', 'electronics', 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c', 'latest', 'shop page'),
(11, 'Velvet Throw Pillow', 29.00, 10.00, '0', 'Add a pop of luxury to your sofa with this plush velvet throw pillow in deep emerald green.', 'home decor', 'https://images.unsplash.com/photo-1605721911519-3d9495257a27', 'latest', 'shop page'),
(12, 'Denim Utility Jacket', 64.99, 20.00, '0', 'Elevate your wardrobe with this versatile denim jacket, featuring multiple pockets for a rugged look.', 'clothing', 'https://images.unsplash.com/photo-1602293589930-45aad59ba7b2', 'latest', 'shop page'),
(13, 'ssmegn', 2300.00, 67.00, '0', '', '', 'https://images.unsplash.com/photo-1512729343400-4fcf83a18f72?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fHBjfGVufDB8fDB8fHww', 'latest', 'shop page'),
(14, 'a woman holding shopping bags', 987.00, 45.00, '0', 'A back view of a woman holding shopping bags in front of a store window stock photo', 'clothing', 'https://media.istockphoto.com/id/2155795543/photo/a-back-view-of-a-woman-holding-shopping-bags-in-front-of-a-store-window.jpg?s=2048x2048&w=is&k=20&c=WIkI5826AKsZ0Q7Ggc-KB5AiWzAGLcjdyEoNIgOZkyM=', 'latest', 'shop page'),
(15, 'A man models a stylish ', 45.00, 999.99, '34', 'A man models a stylish pair of clear-framed eyeglasses, enhancing his sophisticated', 'clothing', 'https://images.unsplash.com/photo-1717724162644-75f624f413ca?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'bestselling', 'home page');

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
  `status` varchar(50) DEFAULT 'Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `status`) VALUES
(1, 'primemart1', 'smegndestew2@gmail.com', '$2b$10$ZL.EeVlxaxzDdY5vJCJdq.fQcFQMIeQ5FqRO9HSFG9nLSfJBXHtb2', 'Active'),
(2, 'smegndestew53@gmail.com', 'smegndestew53@gmail.com', '$2b$10$D.RXyNVJ1WkmtU0OZiwlE.2Om0kfAjiaETjnhnRe1rbYv5LiKs7H2', 'Active'),
(3, 'smegndestew5@gmail.com', 'smegndestew5@gmail.com', '$2b$10$5RuLQCxV.BJoHdOqh5tFHuCO9mw1svubz/PejCgHcjKJ2GnxOS7tq', 'Active'),
(4, 'smegndestew@gmail.com', 'smegndestew@gmail.com', '$2b$10$UELDDOAap8lpG.Tyrctow.MQ6Zi.1c25HyFoLyA3jSh5VsZlX3t42', 'Active'),
(7, '234', 'smegndeste@gmail.com', '$2b$10$HMRVeb4NgNSDs2bl/rcOJ.qtiRHFQTtyX2HDiJru.5L5KHI5MLLsa', 'Active'),
(9, 'smegn@gmail.com', 'smegn@gmail.com', '$2b$10$QbB7RJWP1Dxo.ZwrRJJda./nu6Ctx04.7u5k.giwGgLM14SvpZVRe', 'Active'),
(10, 'sme@gmail.com', 'sme@gmail.com', '$2b$10$Cmdm81JsWu/lrnta.pRGFeRG7sowrh81tFWiMDrNX5wp3VaoP6IKq', 'Active'),
(11, 'megn@gmail.com', 'megn@gmail.com', '$2b$10$8QHFuyaJH/y23Ka2IectuuXp212LLrgqD7ukRY3u9eE7goq9ekfBi', 'Active'),
(12, 'maza', 'maz@gmail.com', '$2b$10$9SYjxMgdvBqssp2ERkeFRuo5sts8m5TJvf4lOFCMH/kxIo7k1vdTi', 'Active'),
(13, 'bdu1404215', 'smegndestew533@gmail.com', '$2b$10$zRPlVBWiiNq3B8UNxZtGO.VIw7yKHkBoVzPbrw1DbVVUGq7gafD.a', 'Active'),
(14, 'kiru', 'kiru@gmail.com', '$2b$10$pBQr2g7h1DUqQwUraJRjjO/71Se6igRmoKmAGStRIKW.dTxRh.X5S', 'Active');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
