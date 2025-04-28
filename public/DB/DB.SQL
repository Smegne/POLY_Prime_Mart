-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 29, 2025 at 12:56 AM
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
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`) VALUES
(1, 'primemart1', 'smegndestew2@gmail.com', '$2b$10$ZL.EeVlxaxzDdY5vJCJdq.fQcFQMIeQ5FqRO9HSFG9nLSfJBXHtb2'),
(2, 'smegndestew53@gmail.com', 'smegndestew53@gmail.com', '$2b$10$D.RXyNVJ1WkmtU0OZiwlE.2Om0kfAjiaETjnhnRe1rbYv5LiKs7H2'),
(3, 'smegndestew5@gmail.com', 'smegndestew5@gmail.com', '$2b$10$5RuLQCxV.BJoHdOqh5tFHuCO9mw1svubz/PejCgHcjKJ2GnxOS7tq'),
(4, 'smegndestew@gmail.com', 'smegndestew@gmail.com', '$2b$10$UELDDOAap8lpG.Tyrctow.MQ6Zi.1c25HyFoLyA3jSh5VsZlX3t42'),
(7, '234', 'smegndeste@gmail.com', '$2b$10$HMRVeb4NgNSDs2bl/rcOJ.qtiRHFQTtyX2HDiJru.5L5KHI5MLLsa'),
(9, 'smegn@gmail.com', 'smegn@gmail.com', '$2b$10$QbB7RJWP1Dxo.ZwrRJJda./nu6Ctx04.7u5k.giwGgLM14SvpZVRe'),
(10, 'sme@gmail.com', 'sme@gmail.com', '$2b$10$Cmdm81JsWu/lrnta.pRGFeRG7sowrh81tFWiMDrNX5wp3VaoP6IKq'),
(11, 'megn@gmail.com', 'megn@gmail.com', '$2b$10$8QHFuyaJH/y23Ka2IectuuXp212LLrgqD7ukRY3u9eE7goq9ekfBi'),
(12, 'maza', 'maz@gmail.com', '$2b$10$9SYjxMgdvBqssp2ERkeFRuo5sts8m5TJvf4lOFCMH/kxIo7k1vdTi');

--
-- Indexes for dumped tables
--

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
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
