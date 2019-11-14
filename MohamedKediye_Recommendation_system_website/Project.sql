-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 22, 2019 at 03:54 PM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Project`
--

-- --------------------------------------------------------

--
-- Table structure for table `userMusic`
--

CREATE TABLE `userMusic` (
  `id` int(11) NOT NULL,
  `userID` int(10) NOT NULL,
  `SongName` varchar(100) NOT NULL,
  `Genre` varchar(100) NOT NULL,
  `SongRating` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userMusic`
--

INSERT INTO `userMusic` (`id`, `userID`, `SongName`, `Genre`, `SongRating`) VALUES
(1, 1, 'new shapes', 'pop', '4'),
(2, 6, 'Hello', 'Soul', '5'),
(3, 4, 'Hello', 'Soul', '4'),
(4, 6, 'new shapes', 'pop', '4'),
(5, 1, 'Starstruck', 'rap', '5'),
(6, 6, 'Starstruck', 'rap', '5'),
(7, 4, 'business', 'raggae', '4'),
(8, 6, 'Throne', 'reggae', '2'),
(9, 6, 'ricc forever', 'rap', '4'),
(10, 1, 'business', 'reggae', '2'),
(11, 4, 'new shapes', 'pop', '2'),
(12, 4, 'looking too closely', 'alternative', '5'),
(13, 1, 'looking too closely', 'alternative', '4'),
(14, 1, 'new shapes', 'pop', '4');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `ID` int(11) NOT NULL,
  `username` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`ID`, `username`) VALUES
(1, 'Kediye'),
(4, 'kaleem'),
(6, 'adam');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `userMusic`
--
ALTER TABLE `userMusic`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `userMusic`
--
ALTER TABLE `userMusic`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
