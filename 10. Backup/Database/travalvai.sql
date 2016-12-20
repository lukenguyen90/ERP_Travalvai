-- phpMyAdmin SQL Dump
-- version 4.4.15.8
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 05, 2016 at 01:32 PM
-- Server version: 5.7.15
-- PHP Version: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `travalvai`
--
CREATE DATABASE IF NOT EXISTS `travalvai` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `travalvai`;

-- --------------------------------------------------------

--
-- Table structure for table `access_level`
--

CREATE TABLE IF NOT EXISTS `access_level` (
  `id_access_level` int(11) NOT NULL,
  `al_name` varchar(255) DEFAULT NULL,
  `al_right` longtext,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `access_level`
--

INSERT INTO `access_level` (`id_access_level`, `al_name`, `al_right`, `created`, `updated`, `id_user_created`, `id_user_updated`) VALUES
(1, 'Factory admin', '[]', '2016-08-15 11:21:32', '2016-09-19 11:30:15', 1, 1),
(2, 'Factory office', '[]', '2016-08-15 11:21:42', '2016-09-19 11:30:33', 1, 1),
(3, 'Factory production', '[]', '2016-09-19 11:30:54', '2016-09-19 11:30:54', 1, 1),
(4, 'Factory design', '[]', '2016-09-19 11:31:27', '2016-09-19 11:31:27', 1, 1),
(5, 'Zone admin', '[]', '2016-09-19 11:31:39', '2016-09-19 11:31:39', 1, 1),
(6, 'Zone office', '[]', '2016-09-19 11:31:46', '2016-09-19 11:31:46', 1, 1),
(7, 'Agent admin', '[]', '2016-09-19 11:32:37', '2016-09-19 11:32:37', 1, 1),
(8, 'Agent sales', '[]', '2016-09-19 11:32:49', '2016-09-19 11:32:49', 1, 1),
(9, 'Customer admin', '[]', '2016-09-19 11:33:07', '2016-09-19 11:33:07', 1, 1),
(10, 'Customer office', '[]', '2016-09-19 11:33:20', '2016-09-19 11:33:20', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `access_page`
--

CREATE TABLE IF NOT EXISTS `access_page` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `idPage` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `agent`
--

CREATE TABLE IF NOT EXISTS `agent` (
  `id_Agent` int(11) NOT NULL,
  `ag_code` varchar(255) DEFAULT NULL,
  `ag_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `ag_commission` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_Zone` int(11) DEFAULT NULL,
  `id_language` int(11) DEFAULT NULL,
  `id_contact` int(11) DEFAULT NULL,
  `id_plz` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `agent`
--

INSERT INTO `agent` (`id_Agent`, `ag_code`, `ag_description`, `ag_commission`, `created`, `updated`, `id_user_created`, `id_user_updated`, `id_Zone`, `id_language`, `id_contact`, `id_plz`) VALUES
(14, 'MKN', 'Mekong ''NTO', 30, '2016-09-19 12:13:32', '2016-09-19 12:13:32', 26, 26, 6, 1, 74, NULL),
(15, 'TI', 'Cat - Tex Invest (directe)', 20, '2016-09-19 12:17:24', '2016-10-13 18:07:57', 27, 38, 5, 2, 75, NULL),
(16, 'BG', 'Burgos - Depordist Ebro (Javi)', 20, '2016-09-19 12:24:12', '2016-09-19 12:36:19', 27, 27, 5, 4, 76, NULL),
(17, 'AST', 'Asturias - Universo Balonmano (Jesús)', 20, '2016-09-19 12:28:13', '2016-10-19 09:04:02', 27, 27, 5, 4, 77, NULL),
(18, 'CNT', 'Cantabria - Glu Sport (Eduardo)', 20, '2016-09-19 12:31:58', '2016-09-20 06:07:09', 27, 1, 5, 4, 78, NULL),
(19, 'CST', 'Castelló - Ruben Domenech', 20, '2016-09-19 12:35:54', '2016-09-19 12:35:54', 27, 27, 5, 2, 79, NULL),
(20, 'IB', 'Balears - Gesesport (Miki)', 20, '2016-09-19 12:39:29', '2016-09-19 12:39:29', 27, 27, 5, 2, 80, NULL),
(21, 'ZG', 'Zaragoza - Equipa ZGZ (Sergio/Roberto)', 20, '2016-09-19 12:41:53', '2016-09-19 12:41:53', 27, 27, 5, 4, 81, NULL),
(22, 'MAD', 'Madrid - Impulse (Alex)', 20, '2016-09-19 12:44:32', '2016-09-19 12:44:32', 27, 27, 5, 4, 82, NULL),
(24, 'TVV', 'Traval Vai (VN)- Sales', 20, '2016-10-07 21:38:22', '2016-10-07 21:38:22', 25, 25, 6, 1, 96, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `agent_price`
--

CREATE TABLE IF NOT EXISTS `agent_price` (
  `id_agent_pl` int(11) NOT NULL,
  `apl_date_i` datetime DEFAULT NULL,
  `apl_date_f` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_Agent` int(11) DEFAULT NULL,
  `id_plz` int(11) DEFAULT NULL,
  `id_product` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `agent_price`
--

INSERT INTO `agent_price` (`id_agent_pl`, `apl_date_i`, `apl_date_f`, `created`, `updated`, `id_user_created`, `id_user_updated`, `id_Agent`, `id_plz`, `id_product`) VALUES
(5, '2016-01-01 00:00:00', '2016-12-31 00:00:00', NULL, '2016-10-12 09:15:04', NULL, 25, 15, 5, NULL),
(6, '2016-01-01 00:00:00', '2016-12-31 00:00:00', NULL, '2016-10-15 20:33:49', NULL, 27, 22, 5, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE IF NOT EXISTS `contact` (
  `id_contact` int(11) NOT NULL,
  `cn_name` varchar(255) DEFAULT NULL,
  `cts_address_1` varchar(255) DEFAULT NULL,
  `cts_address_2` varchar(255) DEFAULT NULL,
  `cts_address_3` varchar(255) DEFAULT NULL,
  `cts_city` varchar(255) DEFAULT NULL,
  `cts_province` varchar(255) DEFAULT NULL,
  `cts_zip_code` varchar(255) DEFAULT NULL,
  `cts_country` varchar(255) DEFAULT NULL,
  `cts_phone` varchar(255) DEFAULT NULL,
  `cts_email` varchar(255) DEFAULT NULL,
  `cts_vat_code` varchar(255) DEFAULT NULL,
  `cts_notes` varchar(255) DEFAULT NULL,
  `cts_type` int(11) DEFAULT NULL,
  `draft` bit(1) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `cts_sh_name` varchar(255) DEFAULT NULL,
  `cts_sh_address_1` varchar(255) DEFAULT NULL,
  `cts_sh_address_2` varchar(255) DEFAULT NULL,
  `cts_sh_address_3` varchar(255) DEFAULT NULL,
  `cts_sh_city` varchar(255) DEFAULT NULL,
  `cts_sh_province` varchar(255) DEFAULT NULL,
  `cts_sh_zip_code` varchar(255) DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`id_contact`, `cn_name`, `cts_address_1`, `cts_address_2`, `cts_address_3`, `cts_city`, `cts_province`, `cts_zip_code`, `cts_country`, `cts_phone`, `cts_email`, `cts_vat_code`, `cts_notes`, `cts_type`, `draft`, `created`, `updated`, `cts_sh_name`, `cts_sh_address_1`, `cts_sh_address_2`, `cts_sh_address_3`, `cts_sh_city`, `cts_sh_province`, `cts_sh_zip_code`, `id_user_created`, `id_user_updated`) VALUES
(4, 'Traval Vai (Vietnam) Co. Ltd.', '1870/3G, An Phu Dong 3, Q.12', '', '', 'Ho Chi Minh City', '', '00000', 'Vietnam', '+84 08371199588', 'info@travalvai.com', '1101000791', '', 1, b'0', NULL, '2016-09-19 11:18:17', '', '', '', '', '', '', '', NULL, 1),
(29, 'Barcelona', 'English', 'English', 'English', 'London', '', '', '', '', '', '7000', '', 3, b'0', '2016-08-01 17:55:38', '2016-08-01 17:55:38', 'BCN', 'English', 'English', 'English', '7000', 'LonDon', '', 2, 2),
(68, 'Tex Invest S.L.', 'Molí de la Torre, 107', '', '', 'Badalona', 'Barcelona', '08915', 'Spain', '93-1247599', 'gemma.score@travalvai.com', '40.555.555', '', 2, b'0', '2016-09-19 11:24:37', '2016-09-19 11:24:37', '', '', '', '', '', '', '', 1, 1),
(69, 'Trval Vai (Vietnam) Co. Ltd', '1870/3G, An Phu Dong 3, Q.12', '', '', 'Ho Chi Minh City', '', '', 'Vietnam', '+84 08371199588', 'info@travalvai.com', '1101000791', '', 2, b'0', '2016-09-19 11:27:36', '2016-09-19 11:27:36', '', '', '', '', '', '', '', 1, 1),
(71, 'Xevi (FA)', '', '', '', '', '', '', '', '', '', '00000', 'Factory administrator', 5, b'0', '2016-09-19 12:01:32', '2016-09-19 12:01:59', '', '', '', '', '', '', '', 1, 1),
(72, 'xevi (VN)', '', '', '', '', '', '', '', '', '', '00000', 'Zone administrator - Vietnam', 5, b'0', '2016-09-19 12:04:27', '2016-09-19 12:04:27', '', '', '', '', '', '', '', 1, 1),
(73, 'xevi SP', '', '', '', '', '', '', '', '', '', '000000', 'Zone administrator - SP', 5, b'0', '2016-09-19 12:06:00', '2016-10-05 17:44:17', '', '', '', '', '', '', '', 1, 25),
(74, 'Mekong ''NTO', '33 Nhat Chieu - Tay Ho', '', '', 'Hanoi', '', '', 'Vietnam', '+84 (0) 1644288866', 'info@mekong-nto.com', '0120120', '', 3, b'0', '2016-09-19 12:13:27', '2016-09-19 12:13:27', '', '', '', '', '', '', '', 26, 26),
(75, 'Tex Invest s.l.', 'Molí de la Torre, 107', '', '', 'Badalona', 'Barcelona', '08915', 'Spain', '+34 93 1247599', 'gemma.score@travalvai.com', '404554545', '', 3, b'0', '2016-09-19 12:17:19', '2016-09-19 12:17:48', '', '', '', '', '', '', '', 27, 27),
(76, 'DEPORDIST EBRO, S.L.', 'Javier Palo', 'C/ Condado de Treviño, nº 73, bajo', '', 'Miranda de Ebro', 'Burgos', '09200', 'Spain', '+34 947 105 050', 'comercial@depordist.com', '000000', 'Representant zona Burgos', 3, b'0', '2016-09-19 12:23:57', '2016-09-19 12:23:57', '', '', '', '', '', '', '', 27, 27),
(77, 'UNIVERSO BALONMANO', 'Av. Pablo Iglesias, nº 43, bajo', '', '', 'Gijón', 'Asturias', '33205', 'Spain', '+34 685553535 / 984049877', 'info@universobalonmano.com', '0000', 'Representant Asturies', 3, b'0', '2016-09-19 12:28:08', '2016-10-19 09:04:00', '', '', '', '', '', '', '', 27, 27),
(78, 'Glu Sport. s.l.', 'Francisco Quevedo, 12', '', '', 'Santander', 'Cantabria', '39001', 'Spain', '+34 600 54 34 66', 'glusportsl@hotmail.com', '0000', 'Eduardo\nDistribuidor Cantabria', 3, b'0', '2016-09-19 12:31:54', '2016-09-19 12:31:54', '', '', '', '', '', '', '', 27, 27),
(79, 'Ruben Domenech', 'Maestro Giner, 17', '', '', 'Castelló', 'Castelló', '12004', 'Spain', '+34 644 35 44 97', 'r.domenech@hotmail.com', '0000', 'Representant Castelló', 3, b'0', '2016-09-19 12:35:37', '2016-09-19 12:35:37', '', '', '', '', '', '', '', 27, 27),
(80, 'GESESPORT s.l.', 'C/Pintor Vives, 5', '', '', 'Es Castell', 'Menorca', '07720', 'Spain', '+34 607 81 88 66', 'info@gesesport.es', '00000', 'Representant Balears', 3, b'0', '2016-09-19 12:39:26', '2016-09-19 12:39:26', '', '', '', '', '', '', '', 27, 27),
(81, 'Equipa Zaragoza', 'C/Brazato, nº 3 Local', '', '', 'Zaragoza', 'Zaragoza', '50012', 'Spain', '', 'info@equipazaragoza.com', '00000', 'Representants Saragossa', 3, b'0', '2016-09-19 12:41:51', '2016-09-19 12:41:51', '', '', '', '', '', '', '', 27, 27),
(82, 'Impulse Promotions Team, s.l.', 'Colmenajero, 1', '', '', 'Villanueva del Pardillo', 'Madrid', '28229', 'Spain', '+34 676 653 385 / 606 062 229', 'anevado@impulsepromotionsteam.com', '0000', 'Alex Nevado y David Serrano', 3, b'0', '2016-09-19 12:44:28', '2016-09-19 12:44:28', '', '', '', '', '', '', '', 27, 27),
(84, 'Cristina', '', '', '', '', '', '', '', '', 'gemma@travalvai.com', '000000', 'Perfil administradora agent  Tex Invest', 5, b'0', '2016-09-20 06:19:07', '2016-10-07 22:03:12', '', '', '', '', '', '', '', 27, 25),
(85, 'AE Minguella', '', '', '', 'Badalona', 'Barcelona', '', '', '', '', '000000', '', 4, b'0', '2016-09-20 06:21:50', '2016-09-20 06:21:50', '', '', '', '', '', '', '', 28, 28),
(86, 'CB Montgat', '', '', '', 'Montgat', 'Barcelona', '', '', '', '', '000000', '', 4, b'0', '2016-09-20 06:22:55', '2016-09-20 06:22:55', '', '', '', '', '', '', '', 28, 28),
(87, 'CB Palafolls', '', '', '', 'Palafolls', 'Barcelona', '', '', '', '', '000000', '', 4, b'0', '2016-09-20 06:23:57', '2016-09-20 06:23:57', '', '', '', '', '', '', '', 28, 28),
(88, 'Minguella (user)', '', '', '', '', '', '', '', '', '', '000000', '', 5, b'0', '2016-09-20 06:29:44', '2016-09-20 06:31:27', '', '', '', '', '', '', '', 28, 28),
(89, 'CB Montgat (user)', '', '', '', '', '', '', '', '', '', '000000', '', 5, b'0', '2016-09-20 06:31:04', '2016-09-20 06:31:04', '', '', '', '', '', '', '', 28, 28),
(90, 'Admin', '', '', '', '', '', '', '', '', '', '', '', 5, b'0', '2016-09-30 15:40:24', '2016-09-30 15:40:24', '', '', '', '', '', '', '', 1, 1),
(91, 'MG Admin', '', '', '', '', '', '', '', '', '', '', '', 5, b'0', '2016-09-30 15:42:13', '2016-09-30 15:42:13', '', '', '', '', '', '', '', 31, 31),
(96, 'Traval Vai (VN) Co. Ltd. (Sales)', '', '', '', '', '', '', '', '', '', '', 'Traval Vai for Sales in VN', 3, b'0', '2016-10-07 21:38:18', '2016-10-07 21:38:18', '', '', '', '', '', '', '', 25, 25),
(97, 'Xevi - TVV admin', '', '', '', '', '', '', '', '', '', '', 'Usuari per Traval Vai Vietnam (Sales)', 5, b'0', '2016-10-07 21:47:25', '2016-10-07 21:47:25', '', '', '', '', '', '', '', 26, 26),
(98, 'Guim Valls', '', '', '', '', '', '', '', '', '', '', 'Usuari Mekong NTO', 5, b'0', '2016-10-07 21:48:53', '2016-10-07 21:48:53', '', '', '', '', '', '', '', 26, 26),
(99, 'SSIS - Saigon South International School', '', '', '', '', '', '', '', '', '', '', '', 4, b'0', '2016-10-07 21:50:03', '2016-10-07 21:50:03', '', '', '', '', '', '', '', 35, 35),
(100, 'UNIS', '', '', '', '', '', '', '', '', '', '', '', 4, b'0', '2016-10-07 21:54:09', '2016-10-07 21:54:09', '', '', '', '', '', '', '', 36, 36),
(101, 'Hanoi Dragons', '', '', '', '', '', '', '', '', '', '', '', 4, b'0', '2016-10-07 21:54:44', '2016-10-07 21:54:44', '', '', '', '', '', '', '', 36, 36),
(102, 'Vina School', '', '', '', '', '', '', '', '', '', '', '', 4, b'0', '2016-10-07 21:55:57', '2016-10-07 21:55:57', '', '', '', '', '', '', '', 35, 35),
(103, 'Ta Lai Adventure', '', '', '', '', '', '', '', '', '', '', '', 4, b'0', '2016-10-07 21:57:27', '2016-10-07 21:57:27', '', '', '', '', '', '', '', 35, 35),
(104, 'Alejandro Nevado', '', '', '', '', '', '', '', '', '', '', '', 5, b'0', '2016-10-07 21:58:51', '2016-10-07 21:58:51', '', '', '', '', '', '', '', 25, 25),
(105, 'Canal Isabel II', '', '', '', 'Madrid', '', '', '', '', '', '', '', 4, b'0', '2016-10-07 21:59:54', '2016-10-07 21:59:54', '', '', '', '', '', '', '', 37, 37),
(106, 'CA Las Rozas', '', '', '', '', '', '', '', '', '', '', '', 4, b'0', '2016-10-07 22:01:25', '2016-10-07 22:01:25', '', '', '', '', '', '', '', 37, 37),
(107, 'Gemma Pérez', '', '', '', '', '', '', '', '', '', '', '', 5, b'0', '2016-10-07 22:05:44', '2016-10-07 22:05:44', '', '', '', '', '', '', '', 25, 25),
(108, 'test customer', '', '', '', '', '', '', '', '', '', '', '', 4, b'0', '2016-10-13 15:47:14', '2016-10-13 15:47:14', '', '', '', '', '', '', '', 38, 38),
(109, 'CF Badalona', '', '', '', '', '', '', '', '', '', '', '', 4, b'0', '2016-10-13 18:01:34', '2016-10-13 18:01:34', '', '', '', '', '', '', '', 25, 25),
(110, 'ASME', '', '', '', '', '', '', '', '', '', '', '', 4, b'0', '2016-10-13 18:02:24', '2016-10-13 18:02:24', '', '', '', '', '', '', '', 38, 38),
(113, 'steven nguyen', '43/78/9 Cong Hoa', '', '', 'Tan Binh', 'Ho Chi Minh City', '700000', 'Vietnam', '0913660066', '', '', '', 5, b'0', '2016-10-16 20:33:40', '2016-10-16 20:33:40', '', '', '', '', '', '', '', 1, 1),
(114, 'Canal Isabel II - user', '', '', '', '', '', '', '', '', '', '', '', 5, b'0', '2016-10-17 23:07:36', '2016-10-17 23:08:52', '', '', '', '', '', '', '', 37, 37),
(115, 'ASME usuari', '', '', '', '', '', '', '', '', '', '', '', 5, b'0', '2016-10-19 09:13:00', '2016-10-19 09:13:00', '', '', '', '', '', '', '', 38, 38),
(116, 'CF Lloreda', '', '', '', '', '', '', '', '', '', '', '', 4, b'0', '2016-10-19 11:36:51', '2016-10-19 11:36:51', '', '', '', '', '', '', '', 27, 27),
(117, 'Hanoi Test', '', '', '', '', '', '', '', '', '', '', 'egfoaeg - s', 4, b'0', '2016-10-22 13:22:22', '2016-10-22 13:22:22', '', '', '', '', '', '', '', 25, 25);

-- --------------------------------------------------------

--
-- Table structure for table `contract`
--

CREATE TABLE IF NOT EXISTS `contract` (
  `id_contract` int(11) NOT NULL,
  `c_date_i` datetime DEFAULT NULL,
  `c_no_of_years` double DEFAULT NULL,
  `c_increase_year` double DEFAULT NULL,
  `id_Customer` int(11) DEFAULT NULL,
  `id_Agent` int(11) DEFAULT NULL,
  `id_Zone` int(11) DEFAULT NULL,
  `c_description` longtext
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contract`
--

INSERT INTO `contract` (`id_contract`, `c_date_i`, `c_no_of_years`, `c_increase_year`, `id_Customer`, `id_Agent`, `id_Zone`, `c_description`) VALUES
(12, '2015-01-01 00:00:00', 3, 5, 10, 15, 5, 'Contracte tri anual'),
(13, '2015-01-01 00:00:00', 1, 0, 12, 15, 5, 'Especial aniversari'),
(14, '2014-01-01 00:00:00', 2, 10, 11, 15, 5, 'Anual campus'),
(15, '2015-01-01 00:00:00', 1, 0, 19, 22, 5, 'Introduccion a Canal');

-- --------------------------------------------------------

--
-- Table structure for table `costing`
--

CREATE TABLE IF NOT EXISTS `costing` (
  `id_cost` int(11) NOT NULL,
  `cost_code` varchar(255) DEFAULT NULL,
  `cost_season` varchar(255) DEFAULT NULL,
  `cost_pl` bit(1) DEFAULT NULL,
  `cost_date` date DEFAULT NULL,
  `cost_update` date DEFAULT NULL,
  `cost_weight` varchar(255) DEFAULT NULL,
  `cost_volume` varchar(255) DEFAULT NULL,
  `cost_variants` int(11) DEFAULT NULL,
  `cost_sketch` varchar(255) DEFAULT NULL,
  `hashid` varchar(32) DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_Factory` int(11) DEFAULT NULL,
  `id_customer` int(11) DEFAULT NULL,
  `id_type_products` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `costing`
--

INSERT INTO `costing` (`id_cost`, `cost_code`, `cost_season`, `cost_pl`, `cost_date`, `cost_update`, `cost_weight`, `cost_volume`, `cost_variants`, `cost_sketch`, `hashid`, `id_user_created`, `id_user_updated`, `id_Factory`, `id_customer`, `id_type_products`) VALUES
(53, 'TBS', '2016', b'1', '2016-10-06', NULL, NULL, NULL, 0, NULL, 'F8954D66B111DB232720B6A2A3E9CAD2', 25, NULL, 1, NULL, 2),
(54, 'TBL', '2016', b'1', '2016-10-06', NULL, NULL, NULL, 0, NULL, '17A20C51250F26D503FB952F45FC0E56', 25, NULL, 1, NULL, 8),
(55, 'TPS', '2016', b'1', '2016-10-06', '2016-10-15', '160.0', '900.0', 0, 'PB0039-Polo Ranglan-Buttons.png', 'F20BC81ED735340605000AA8B931FEFF', 25, 25, 1, NULL, 9),
(56, 'TBXS', '2016', b'1', '2016-10-06', NULL, NULL, NULL, 0, NULL, 'E52B8DC57CECFCD9CAD8DEC8F06FDDD2', 25, NULL, 1, NULL, 14),
(57, 'TBXL', '2016', b'1', '2016-10-06', NULL, NULL, NULL, 0, NULL, '930906EA59615882B20BDC150FF0FD7E', 25, NULL, 1, NULL, 15),
(58, 'PSM', '2016', b'1', '2016-10-06', NULL, NULL, NULL, 0, NULL, 'ACAAB87647DB30C5357B5D16662DAEC8', 25, NULL, 1, NULL, 40),
(59, 'TSS', '2016', b'1', '2016-10-06', NULL, NULL, NULL, 0, NULL, 'FAA182ADD7BB36F8916C4654C7C9F89E', 25, NULL, 2, NULL, 41),
(60, 'ACC', '2016', b'1', '2016-10-06', '2016-10-06', '100.0', '300.0', 0, '0301-Calf compressor.png', '41E708E8BB6383F3F7A5D89A67E1C85C', 25, 25, 1, NULL, 45),
(61, 'TPL', '2016', b'1', '2016-10-06', NULL, NULL, NULL, 0, NULL, 'EA30BF908EAAD1058D5D24C3758FB881', 25, NULL, 1, NULL, 48),
(62, 'TRS', '2016', b'1', '2016-10-06', '2016-10-11', '150.0', '700.0', 0, 'R0245-Shirt ranglan armhole cut-Fit.png', 'B2D9B9F9DD1531D76186E6E48579758B', 25, 25, 1, NULL, 49),
(63, 'CBS', '2016', b'1', '2016-10-06', '2016-10-08', '130.0', '500.0', 0, 'R0133-Tanktop Athletics-Tound Neck-Piping.png', '2A75EDAC6F2F42AD635B70A859290FB6', 25, 25, 1, NULL, 50),
(64, 'CBB', '2016', b'1', '2016-10-06', '2016-10-06', '140.0', '600.0', 0, 'R0040-Basket Shirt-Round Neck.png', 'C2000A540403E0687BE6B66270559E5F', 25, 25, 1, NULL, 51),
(65, 'CTS', '2016', b'1', '2016-10-06', '2016-10-08', '120.0', '400.0', 0, '0172-TankTop Beach Volley Woman.png', '34CF7C63CF2353E913DDD281D8EEE3A6', 25, 25, 1, NULL, 52),
(66, 'PSB', '2016', b'1', '2016-10-06', '2016-10-08', '130.0', '500.0', 0, 'P0027-Pant Basic Play.png', '5ED27F7052B8EA78C7DFDF84A007CF5A', 25, 25, 1, NULL, 53),
(67, 'PSP', '2016', b'1', '2016-10-06', '2016-10-08', '150.0', '650.0', 0, 'P0087-Short_Pockets.png', 'E3F2B496D0B0961E67999C755519D2EE', 25, 25, 1, NULL, 54),
(68, 'E-UNIS-1', '2016', b'0', '2016-10-08', '2016-10-08', '200.0', '1000.0', 0, 'DHN0167-V0039-Unis House tShirt-Tiger-v10.jpg', 'BBA732756CB82C121BF32FB7A813C74A', 25, 25, 1, 15, 15),
(75, 'TSS', '2017', b'1', '2016-10-08', '2016-10-08', NULL, NULL, 0, '', '16D00B07DE5BFAFE2088F3FB868B72EA', 25, NULL, 2, NULL, 41),
(98, 'ZS1', '2016', b'1', '2016-10-12', '2016-10-12', '0.0', '0.0', 0, NULL, '591AEA28971823DE60CAF914690A01D2', 25, 25, 1, NULL, 55);

-- --------------------------------------------------------

--
-- Table structure for table `costing_description`
--

CREATE TABLE IF NOT EXISTS `costing_description` (
  `id_cost_description` int(11) NOT NULL,
  `cd_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_cost` int(11) DEFAULT NULL,
  `id_language` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1097 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `costing_description`
--

INSERT INTO `costing_description` (`id_cost_description`, `cd_description`, `created`, `updated`, `id_user_created`, `id_user_updated`, `id_cost`, `id_language`) VALUES
(641, 'T-Shirt Basic Short Sleeves', '2016-10-06 15:29:30', '2016-10-06 15:29:30', 25, 25, 53, 1),
(642, 'Camiseta Bàsica Màniga Curta', '2016-10-06 15:29:30', '2016-10-06 15:29:30', 25, 25, 53, 2),
(643, 'Camiseta Básica Manga Corta', '2016-10-06 15:29:30', '2016-10-06 15:29:30', 25, 25, 53, 4),
(644, 'T-Shirt Basic Short Sleeves', '2016-10-06 15:29:30', '2016-10-06 15:29:30', 25, 25, 53, 8),
(645, 'T-Shirt Basic Short Sleeves', '2016-10-06 15:29:30', '2016-10-06 15:29:30', 25, 25, 53, 12),
(646, 'T-Shirt Basic Short Sleeves', '2016-10-06 15:29:30', '2016-10-06 15:29:30', 25, 25, 53, 15),
(647, 'T-Shirt Basic Short Sleeves', '2016-10-06 15:29:30', '2016-10-06 15:29:30', 25, 25, 53, 17),
(648, 'T-Shirt Basic Short Sleeves', '2016-10-06 15:29:30', '2016-10-06 15:29:30', 25, 25, 53, 19),
(649, 'T-Shirt Basic Long Sleeves', '2016-10-06 15:29:30', '2016-10-06 15:29:30', 25, 25, 54, 1),
(650, 'Camiseta Bàsica Màniga Llarga', '2016-10-06 15:29:30', '2016-10-06 15:29:30', 25, 25, 54, 2),
(651, 'Camiseta Básica Manga Larga', '2016-10-06 15:29:30', '2016-10-06 15:29:30', 25, 25, 54, 4),
(652, 'T-Shirt Basic Long Sleeves', '2016-10-06 15:29:30', '2016-10-06 15:29:30', 25, 25, 54, 8),
(653, 'T-Shirt Basic Long Sleeves', '2016-10-06 15:29:30', '2016-10-06 15:29:30', 25, 25, 54, 12),
(654, 'T-Shirt Basic Long Sleeves', '2016-10-06 15:29:30', '2016-10-06 15:29:30', 25, 25, 54, 15),
(655, 'T-Shirt Basic Long Sleeves', '2016-10-06 15:29:30', '2016-10-06 15:29:30', 25, 25, 54, 17),
(656, 'T-Shirt Basic Long Sleeves', '2016-10-06 15:29:30', '2016-10-06 15:29:30', 25, 25, 54, 19),
(665, 'T-Shirt Basic Spandex Short Sleeves', '2016-10-06 15:29:31', '2016-10-06 15:29:31', 25, 25, 56, 1),
(666, 'Camiseta Bàsica Spandex Màn. Curta', '2016-10-06 15:29:31', '2016-10-06 15:29:31', 25, 25, 56, 2),
(667, 'Camiseta Básica Spandex Man. Corta', '2016-10-06 15:29:31', '2016-10-06 15:29:31', 25, 25, 56, 4),
(668, 'T-Shirt Basic Spandex Short Sleeves', '2016-10-06 15:29:31', '2016-10-06 15:29:31', 25, 25, 56, 8),
(669, 'T-Shirt Basic Spandex Short Sleeves', '2016-10-06 15:29:31', '2016-10-06 15:29:31', 25, 25, 56, 12),
(670, 'T-Shirt Basic Spandex Short Sleeves', '2016-10-06 15:29:31', '2016-10-06 15:29:31', 25, 25, 56, 15),
(671, 'T-Shirt Basic Spandex Short Sleeves', '2016-10-06 15:29:31', '2016-10-06 15:29:31', 25, 25, 56, 17),
(672, 'T-Shirt Basic Spandex Short Sleeves', '2016-10-06 15:29:31', '2016-10-06 15:29:31', 25, 25, 56, 19),
(673, 'T-Shirt Basic Spandex Long Sleeves', '2016-10-06 15:29:31', '2016-10-06 15:29:31', 25, 25, 57, 1),
(674, 'Camiseta Bàsica Spandex Màn. Llarga', '2016-10-06 15:29:31', '2016-10-06 15:29:31', 25, 25, 57, 2),
(675, 'Camiseta Básica Spandex Man. Larga', '2016-10-06 15:29:31', '2016-10-06 15:29:31', 25, 25, 57, 4),
(676, 'T-Shirt Basic Spandex Long Sleeves', '2016-10-06 15:29:31', '2016-10-06 15:29:31', 25, 25, 57, 8),
(677, 'T-Shirt Basic Spandex Long Sleeves', '2016-10-06 15:29:31', '2016-10-06 15:29:31', 25, 25, 57, 12),
(678, 'T-Shirt Basic Spandex Long Sleeves', '2016-10-06 15:29:31', '2016-10-06 15:29:31', 25, 25, 57, 15),
(679, 'T-Shirt Basic Spandex Long Sleeves', '2016-10-06 15:29:31', '2016-10-06 15:29:31', 25, 25, 57, 17),
(680, 'T-Shirt Basic Spandex Long Sleeves', '2016-10-06 15:29:31', '2016-10-06 15:29:31', 25, 25, 57, 19),
(681, 'Short Pant Basic Match', '2016-10-06 15:29:31', '2016-10-06 15:29:31', 25, 25, 58, 1),
(682, 'Pantaló Curt Joc Bàsic', '2016-10-06 15:29:31', '2016-10-06 15:29:31', 25, 25, 58, 2),
(683, 'Pantalón Corto Juego Básico', '2016-10-06 15:29:31', '2016-10-06 15:29:31', 25, 25, 58, 4),
(684, 'Short Pant Basic Match', '2016-10-06 15:29:32', '2016-10-06 15:29:32', 25, 25, 58, 8),
(685, 'Short Pant Basic Match', '2016-10-06 15:29:32', '2016-10-06 15:29:32', 25, 25, 58, 12),
(686, 'Short Pant Basic Match', '2016-10-06 15:29:32', '2016-10-06 15:29:32', 25, 25, 58, 15),
(687, 'Short Pant Basic Match', '2016-10-06 15:29:32', '2016-10-06 15:29:32', 25, 25, 58, 17),
(688, 'Short Pant Basic Match', '2016-10-06 15:29:32', '2016-10-06 15:29:32', 25, 25, 58, 19),
(689, 'T-Shirt', '2016-10-06 15:29:32', '2016-10-06 15:29:32', 25, 25, 59, 1),
(690, '', '2016-10-06 15:29:32', '2016-10-06 15:29:32', 25, 25, 59, 2),
(691, '', '2016-10-06 15:29:32', '2016-10-06 15:29:32', 25, 25, 59, 4),
(692, 'áo sơ mi', '2016-10-06 15:29:32', '2016-10-06 15:29:32', 25, 25, 59, 8),
(693, '', '2016-10-06 15:29:32', '2016-10-06 15:29:32', 25, 25, 59, 12),
(694, '', '2016-10-06 15:29:32', '2016-10-06 15:29:32', 25, 25, 59, 15),
(695, '', '2016-10-06 15:29:32', '2016-10-06 15:29:32', 25, 25, 59, 17),
(696, '', '2016-10-06 15:29:32', '2016-10-06 15:29:32', 25, 25, 59, 19),
(705, 'Polo Long Sleeve', '2016-10-06 15:29:32', '2016-10-06 15:29:32', 25, 25, 61, 1),
(706, 'Polo Màniga Llarga', '2016-10-06 15:29:32', '2016-10-06 15:29:32', 25, 25, 61, 2),
(707, 'Polo Manga Larga', '2016-10-06 15:29:33', '2016-10-06 15:29:33', 25, 25, 61, 4),
(708, 'Polo Long Sleeve', '2016-10-06 15:29:33', '2016-10-06 15:29:33', 25, 25, 61, 8),
(709, 'Polo Long Sleeve', '2016-10-06 15:29:33', '2016-10-06 15:29:33', 25, 25, 61, 12),
(710, 'Polo Long Sleeve', '2016-10-06 15:29:33', '2016-10-06 15:29:33', 25, 25, 61, 15),
(711, 'Polo Long Sleeve', '2016-10-06 15:29:33', '2016-10-06 15:29:33', 25, 25, 61, 17),
(712, 'Polo Long Sleeve', '2016-10-06 15:29:33', '2016-10-06 15:29:33', 25, 25, 61, 19),
(761, 'Calf Compressors', '2016-10-06 16:19:01', '2016-10-06 16:19:01', 25, 25, 60, 1),
(762, 'Compressors de Pantorrilla', '2016-10-06 16:19:01', '2016-10-06 16:19:01', 25, 25, 60, 2),
(763, 'Compresores de Pantorrilla', '2016-10-06 16:19:01', '2016-10-06 16:19:01', 25, 25, 60, 4),
(764, 'Calf Compressors', '2016-10-06 16:19:01', '2016-10-06 16:19:01', 25, 25, 60, 8),
(765, 'Calf Compressors', '2016-10-06 16:19:01', '2016-10-06 16:19:01', 25, 25, 60, 12),
(766, 'Calf Compressors', '2016-10-06 16:19:01', '2016-10-06 16:19:01', 25, 25, 60, 15),
(767, 'Calf Compressors', '2016-10-06 16:19:01', '2016-10-06 16:19:01', 25, 25, 60, 17),
(768, 'Calf Compressors', '2016-10-06 16:19:01', '2016-10-06 16:19:01', 25, 25, 60, 19),
(769, 'Singlet Basic Big', '2016-10-06 16:24:01', '2016-10-06 16:24:01', 25, 25, 64, 1),
(770, 'Camiseta Tirants Bàsica Gran', '2016-10-06 16:24:01', '2016-10-06 16:24:01', 25, 25, 64, 2),
(771, 'Camiseta Tirantes Básica Grande', '2016-10-06 16:24:01', '2016-10-06 16:24:01', 25, 25, 64, 4),
(772, 'Singlet Basic Big', '2016-10-06 16:24:01', '2016-10-06 16:24:01', 25, 25, 64, 8),
(773, 'Singlet Basic Big', '2016-10-06 16:24:01', '2016-10-06 16:24:01', 25, 25, 64, 12),
(774, 'Singlet Basic Big', '2016-10-06 16:24:01', '2016-10-06 16:24:01', 25, 25, 64, 15),
(775, 'Singlet Basic Big', '2016-10-06 16:24:01', '2016-10-06 16:24:01', 25, 25, 64, 17),
(776, 'Singlet Basic Big', '2016-10-06 16:24:01', '2016-10-06 16:24:01', 25, 25, 64, 19),
(777, 'Short Pant Pockets', '2016-10-08 20:48:02', '2016-10-08 20:48:02', 25, 25, 67, 1),
(778, 'Pantaló Curt Butxaques', '2016-10-08 20:48:02', '2016-10-08 20:48:02', 25, 25, 67, 2),
(779, 'Pantalon Corto Bolsillos', '2016-10-08 20:48:02', '2016-10-08 20:48:02', 25, 25, 67, 4),
(780, 'Short Pant Pockets', '2016-10-08 20:48:02', '2016-10-08 20:48:02', 25, 25, 67, 8),
(781, 'Short Pant Pockets', '2016-10-08 20:48:02', '2016-10-08 20:48:02', 25, 25, 67, 12),
(782, 'Short Pant Pockets', '2016-10-08 20:48:02', '2016-10-08 20:48:02', 25, 25, 67, 15),
(783, 'Short Pant Pockets', '2016-10-08 20:48:02', '2016-10-08 20:48:02', 25, 25, 67, 17),
(784, 'Short Pant Pockets', '2016-10-08 20:48:02', '2016-10-08 20:48:02', 25, 25, 67, 19),
(785, 'Short Pant Basic Big', '2016-10-08 21:11:13', '2016-10-08 21:11:13', 25, 25, 66, 1),
(786, 'Pantaló Curt Bàsic Gran', '2016-10-08 21:11:13', '2016-10-08 21:11:13', 25, 25, 66, 2),
(787, 'Pantalón Corto Básico Grande', '2016-10-08 21:11:13', '2016-10-08 21:11:13', 25, 25, 66, 4),
(788, 'Short Pant Basic Big', '2016-10-08 21:11:13', '2016-10-08 21:11:13', 25, 25, 66, 8),
(789, 'Short Pant Basic Big', '2016-10-08 21:11:13', '2016-10-08 21:11:13', 25, 25, 66, 12),
(790, 'Short Pant Basic Big', '2016-10-08 21:11:13', '2016-10-08 21:11:13', 25, 25, 66, 15),
(791, 'Short Pant Basic Big', '2016-10-08 21:11:13', '2016-10-08 21:11:13', 25, 25, 66, 17),
(792, 'Short Pant Basic Big', '2016-10-08 21:11:13', '2016-10-08 21:11:13', 25, 25, 66, 19),
(809, 'T-Shirt Special spandex', '2016-10-08 21:25:43', '2016-10-08 21:25:43', 25, 25, 68, 1),
(810, '', '2016-10-08 21:25:43', '2016-10-08 21:25:43', 25, 25, 68, 2),
(811, '', '2016-10-08 21:25:43', '2016-10-08 21:25:43', 25, 25, 68, 4),
(812, '', '2016-10-08 21:25:43', '2016-10-08 21:25:43', 25, 25, 68, 8),
(813, '', '2016-10-08 21:25:43', '2016-10-08 21:25:43', 25, 25, 68, 12),
(814, '', '2016-10-08 21:25:43', '2016-10-08 21:25:43', 25, 25, 68, 15),
(815, 'T-Shirt Basic Spandex Long Sleeves', '2016-10-08 21:25:43', '2016-10-08 21:25:43', 25, 25, 68, 17),
(816, 'T-Shirt Basic Spandex Long Sleeves', '2016-10-08 21:25:43', '2016-10-08 21:25:43', 25, 25, 68, 19),
(865, 'T-Shirt', '2016-10-08 21:26:58', '2016-10-08 21:26:58', 25, 25, 75, 1),
(866, '', '2016-10-08 21:26:58', '2016-10-08 21:26:58', 25, 25, 75, 2),
(867, '', '2016-10-08 21:26:58', '2016-10-08 21:26:58', 25, 25, 75, 4),
(868, 'áo sơ mi', '2016-10-08 21:26:58', '2016-10-08 21:26:58', 25, 25, 75, 8),
(869, '', '2016-10-08 21:26:58', '2016-10-08 21:26:58', 25, 25, 75, 12),
(870, '', '2016-10-08 21:26:58', '2016-10-08 21:26:58', 25, 25, 75, 15),
(871, '', '2016-10-08 21:26:58', '2016-10-08 21:26:58', 25, 25, 75, 17),
(872, '', '2016-10-08 21:26:58', '2016-10-08 21:26:58', 25, 25, 75, 19),
(1049, 'Tank Top Short', '2016-10-08 21:36:36', '2016-10-08 21:36:36', 25, 25, 65, 1),
(1050, 'Top Curt', '2016-10-08 21:36:36', '2016-10-08 21:36:36', 25, 25, 65, 2),
(1051, 'Top Corto', '2016-10-08 21:36:36', '2016-10-08 21:36:36', 25, 25, 65, 4),
(1052, 'Tank Top Short', '2016-10-08 21:36:36', '2016-10-08 21:36:36', 25, 25, 65, 8),
(1053, 'Tank Top Short', '2016-10-08 21:36:36', '2016-10-08 21:36:36', 25, 25, 65, 12),
(1054, 'Tank Top Short', '2016-10-08 21:36:36', '2016-10-08 21:36:36', 25, 25, 65, 15),
(1055, 'Tank Top Short', '2016-10-08 21:36:36', '2016-10-08 21:36:36', 25, 25, 65, 17),
(1056, 'Tank Top Short', '2016-10-08 21:36:36', '2016-10-08 21:36:36', 25, 25, 65, 19),
(1057, 'Singlet Basic Small', '2016-10-08 21:58:07', '2016-10-08 21:58:07', 25, 25, 63, 1),
(1058, 'Samarreta Bàsica Petita', '2016-10-08 21:58:07', '2016-10-08 21:58:07', 25, 25, 63, 2),
(1059, 'Camiseta sin mangas Básica Pequeña', '2016-10-08 21:58:07', '2016-10-08 21:58:07', 25, 25, 63, 4),
(1060, 'Singlet Basic Small', '2016-10-08 21:58:07', '2016-10-08 21:58:07', 25, 25, 63, 8),
(1061, 'Singlet Basic Small', '2016-10-08 21:58:07', '2016-10-08 21:58:07', 25, 25, 63, 12),
(1062, 'Singlet Basic Small', '2016-10-08 21:58:07', '2016-10-08 21:58:07', 25, 25, 63, 15),
(1063, 'Singlet Basic Small', '2016-10-08 21:58:07', '2016-10-08 21:58:07', 25, 25, 63, 17),
(1064, 'Singlet Basic Small', '2016-10-08 21:58:07', '2016-10-08 21:58:07', 25, 25, 63, 19),
(1065, 'T-Shirt Pro Short Sleeve', '2016-10-11 21:36:33', '2016-10-11 21:36:33', 25, 25, 62, 1),
(1066, 'Camiseta Pro Màniga Curta', '2016-10-11 21:36:33', '2016-10-11 21:36:33', 25, 25, 62, 2),
(1067, 'Camiseta Pro Manga Corta', '2016-10-11 21:36:33', '2016-10-11 21:36:33', 25, 25, 62, 4),
(1068, 'T-Shirt Pro Short Sleeve', '2016-10-11 21:36:33', '2016-10-11 21:36:33', 25, 25, 62, 8),
(1069, 'T-Shirt Pro Short Sleeve', '2016-10-11 21:36:33', '2016-10-11 21:36:33', 25, 25, 62, 12),
(1070, 'T-Shirt Pro Short Sleeve', '2016-10-11 21:36:33', '2016-10-11 21:36:33', 25, 25, 62, 15),
(1071, 'T-Shirt Pro Short Sleeve', '2016-10-11 21:36:33', '2016-10-11 21:36:33', 25, 25, 62, 17),
(1072, 'T-Shirt Pro Short Sleeve', '2016-10-11 21:36:33', '2016-10-11 21:36:33', 25, 25, 62, 19),
(1081, 'Screen Print Small', '2016-10-12 15:12:32', '2016-10-12 15:12:32', 25, 25, 98, 1),
(1082, 'Impresió Serigrafia Petita', '2016-10-12 15:12:32', '2016-10-12 15:12:32', 25, 25, 98, 2),
(1083, 'Impresión Serigrafía Pequeña', '2016-10-12 15:12:32', '2016-10-12 15:12:32', 25, 25, 98, 4),
(1084, 'Screen Print Small', '2016-10-12 15:12:32', '2016-10-12 15:12:32', 25, 25, 98, 8),
(1085, 'Screen Print Small', '2016-10-12 15:12:32', '2016-10-12 15:12:32', 25, 25, 98, 12),
(1086, 'Screen Print Small', '2016-10-12 15:12:32', '2016-10-12 15:12:32', 25, 25, 98, 15),
(1087, 'Screen Print Small', '2016-10-12 15:12:32', '2016-10-12 15:12:32', 25, 25, 98, 17),
(1088, 'Screen Print Small', '2016-10-12 15:12:32', '2016-10-12 15:12:32', 25, 25, 98, 19),
(1089, 'Polo Short Sleeve', '2016-10-15 19:08:01', '2016-10-15 19:08:01', 25, 25, 55, 1),
(1090, 'Polo Màniga Curta', '2016-10-15 19:08:01', '2016-10-15 19:08:01', 25, 25, 55, 2),
(1091, 'Polo Manga Corta', '2016-10-15 19:08:01', '2016-10-15 19:08:01', 25, 25, 55, 4),
(1092, 'Polo Short Sleeve', '2016-10-15 19:08:01', '2016-10-15 19:08:01', 25, 25, 55, 8),
(1093, 'Polo Short Sleeve', '2016-10-15 19:08:01', '2016-10-15 19:08:01', 25, 25, 55, 12),
(1094, 'Polo Short Sleeve', '2016-10-15 19:08:01', '2016-10-15 19:08:01', 25, 25, 55, 15),
(1095, 'Polo Short Sleeve', '2016-10-15 19:08:01', '2016-10-15 19:08:01', 25, 25, 55, 17),
(1096, 'Polo Short Sleeve', '2016-10-15 19:08:01', '2016-10-15 19:08:01', 25, 25, 55, 19);

-- --------------------------------------------------------

--
-- Table structure for table `costing_versions`
--

CREATE TABLE IF NOT EXISTS `costing_versions` (
  `id_cost_version` int(11) NOT NULL,
  `cv_version` varchar(255) DEFAULT NULL,
  `cv_material_cost` varchar(255) DEFAULT NULL,
  `cv_process_cost` varchar(255) DEFAULT NULL,
  `cv_waste` varchar(255) DEFAULT NULL,
  `cv_structure` varchar(255) DEFAULT NULL,
  `cv_margin` varchar(255) DEFAULT NULL,
  `cv_fty_cost_0` varchar(255) DEFAULT NULL,
  `cv_weight` varchar(255) DEFAULT NULL,
  `cv_volume` varchar(255) DEFAULT NULL,
  `cv_sketch` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_cost` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `costing_versions`
--

INSERT INTO `costing_versions` (`id_cost_version`, `cv_version`, `cv_material_cost`, `cv_process_cost`, `cv_waste`, `cv_structure`, `cv_margin`, `cv_fty_cost_0`, `cv_weight`, `cv_volume`, `cv_sketch`, `created`, `updated`, `id_user_created`, `id_user_updated`, `id_cost`) VALUES
(67, '0.0', NULL, NULL, '0.0', NULL, '0.0', '40000.0', '100.0', '300.0', '', NULL, '2016-10-06 16:20:42', 25, 25, 60),
(68, '1.0', NULL, NULL, '0.0', NULL, '0.0', '60000.0', '100.0', '300.0', '', NULL, '2016-10-06 16:21:53', 25, 25, 60),
(69, '0.0', NULL, NULL, '0.0', NULL, '0.0', '110000.0', '150.0', '650.0', 'P0087-Short_Pockets1.png', NULL, '2016-10-08 20:56:28', 25, 25, 67),
(70, '1.0', NULL, NULL, '0.0', NULL, '0.0', '130000.0', '150.0', '650.0', '', NULL, '2016-10-08 20:55:26', 25, 25, 67),
(71, '0.0', NULL, NULL, '0.0', NULL, '0.0', '50000.0', '130.0', '500.0', '', NULL, '2016-10-08 21:18:39', 25, 25, 66),
(72, '1.0', NULL, NULL, '0.0', NULL, '0.0', '70000.0', '130.0', '500.0', '', NULL, '2016-10-08 21:20:03', 25, 25, 66),
(73, '1.0', NULL, NULL, '0.0', NULL, '0.0', '250000.0', '200.0', '1000.0', '', NULL, '2016-10-08 21:24:23', 25, 25, 68),
(80, '2.0', NULL, NULL, '0.0', NULL, '0.0', '120000.0', '120.0', '400.0', '', NULL, '2016-10-08 21:37:48', 25, 25, 65),
(81, '3.0', NULL, NULL, '0.0', NULL, '0.0', '140000.0', '120.0', '400.0', '', NULL, '2016-10-08 21:38:44', 25, 25, 65),
(82, '0.0', NULL, NULL, '0.0', NULL, '0.0', '75000.0', '140.0', '600.0', '', NULL, '2016-10-08 21:44:10', 25, 25, 64),
(83, '1.0', NULL, NULL, '0.0', NULL, '0.0', '95000.0', '140.0', '600.0', '', NULL, '2016-10-08 21:56:30', 25, 25, 64),
(84, '0.0', NULL, NULL, '0.0', NULL, '0.0', '80000.0', '130.0', '500.0', '', NULL, '2016-10-08 21:59:22', 25, 25, 63),
(85, '1.0', NULL, NULL, '0.0', NULL, '0.0', '95000.0', '130.0', '500.0', '', NULL, '2016-10-08 22:00:52', 25, 25, 63),
(86, '2.0', NULL, NULL, '0.0', NULL, '0.0', '105000.0', '130.0', '500.0', '', NULL, '2016-10-11 21:32:54', 25, 25, 63),
(87, '2.0', NULL, NULL, '0.0', NULL, '0.0', '110000.0', '140.0', '600.0', '', NULL, '2016-10-08 22:37:01', 25, 25, 64),
(88, '3.0', NULL, NULL, '0.0', NULL, '0.0', '130000.0', '140.0', '600.0', '', NULL, '2016-10-08 22:36:49', 25, 25, 64),
(89, '3.0', NULL, NULL, '0.0', NULL, '0.0', '125000.0', '130.0', '500.0', '', NULL, '2016-10-11 21:32:47', 25, 25, 63),
(90, '0.0', NULL, NULL, '0.0', NULL, '0.0', '190000.0', '150.0', '700.0', '', NULL, '2016-10-11 21:37:38', 25, 25, 62),
(91, '1.0', NULL, NULL, '0.0', NULL, '0.0', '210000.0', '150.0', '700.0', '', NULL, '2016-10-11 21:42:18', 25, 25, 62),
(92, '1.0', NULL, NULL, '0.0', NULL, '0.0', '20000.0', '0.0', '0.0', '', NULL, '2016-10-12 15:08:35', 25, 25, 98),
(93, '2.0', NULL, NULL, '0.0', NULL, '0.0', '25000.0', '0.0', '0.0', '', NULL, '2016-10-12 15:10:35', 25, 25, 98),
(94, '3.0', NULL, NULL, '0.0', NULL, '0.0', '30000.0', '0.0', '0.0', '', NULL, '2016-10-12 15:30:34', 25, 25, 98),
(95, '0', NULL, NULL, '0.0', NULL, '0.0', '95000.0', '150.0', '700.0', '', NULL, '2016-10-13 22:01:12', 25, 25, 53),
(96, '1', NULL, NULL, '0.0', NULL, '0.0', '105000.0', '150.0', '700.0', '', NULL, '2016-10-13 22:09:09', 25, 25, 53),
(97, '0', NULL, NULL, '0.0', NULL, '0.0', '130000.0', '160.0', '900.0', '', NULL, '2016-10-15 19:09:16', 25, 25, 55),
(98, '1', NULL, NULL, '0.0', NULL, '0.0', '145000.0', '160.0', '900.0', '', NULL, '2016-10-15 19:10:36', 25, 25, 55),
(101, '2', NULL, NULL, '0.0', NULL, '0.0', '155000.0', '160.0', '900.0', '', NULL, '2016-10-19 08:35:30', 25, 25, 55);

-- --------------------------------------------------------

--
-- Table structure for table `costing_version_description`
--

CREATE TABLE IF NOT EXISTS `costing_version_description` (
  `id_cost_version_desc` int(11) NOT NULL,
  `cvd_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_cost_version` int(11) DEFAULT NULL,
  `id_language` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=443 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `costing_version_description`
--

INSERT INTO `costing_version_description` (`id_cost_version_desc`, `cvd_description`, `created`, `updated`, `id_user_created`, `id_user_updated`, `id_cost_version`, `id_language`) VALUES
(254, 'No customization', '2016-10-06 16:20:42', '2016-10-06 16:20:42', 25, 25, 67, 1),
(255, 'No customization', '2016-10-06 16:20:42', '2016-10-06 16:20:42', 25, 25, 67, 2),
(256, 'No customization', '2016-10-06 16:20:42', '2016-10-06 16:20:42', 25, 25, 67, 4),
(257, 'Full Print', '2016-10-06 16:21:53', '2016-10-06 16:21:53', 25, 25, 68, 1),
(258, 'Full Print', '2016-10-06 16:21:53', '2016-10-06 16:21:53', 25, 25, 68, 2),
(259, 'Full Print', '2016-10-06 16:21:53', '2016-10-06 16:21:53', 25, 25, 68, 4),
(260, 'Full Print', '2016-10-06 16:21:53', '2016-10-06 16:21:53', 25, 25, 68, 8),
(261, 'Full Print', '2016-10-06 16:21:53', '2016-10-06 16:21:53', 25, 25, 68, 12),
(262, 'Full Print', '2016-10-06 16:21:53', '2016-10-06 16:21:53', 25, 25, 68, 15),
(263, 'No customization', '2016-10-08 20:49:34', '2016-10-08 20:49:34', 25, 25, 69, 1),
(264, 'No personalitzat', '2016-10-08 20:49:34', '2016-10-08 20:49:34', 25, 25, 69, 2),
(265, 'No personalizado', '2016-10-08 20:49:34', '2016-10-08 20:49:34', 25, 25, 69, 4),
(266, 'No customization', '2016-10-08 20:49:34', '2016-10-08 20:49:34', 25, 25, 69, 8),
(267, 'No customization', '2016-10-08 20:49:34', '2016-10-08 20:49:34', 25, 25, 69, 12),
(268, 'No customization', '2016-10-08 20:49:34', '2016-10-08 20:49:34', 25, 25, 69, 15),
(269, 'Sides print', '2016-10-08 20:55:26', '2016-10-08 20:55:26', 25, 25, 70, 1),
(270, 'Laterals impresos', '2016-10-08 20:55:26', '2016-10-08 20:55:26', 25, 25, 70, 2),
(271, 'Laterales impresos', '2016-10-08 20:55:26', '2016-10-08 20:55:26', 25, 25, 70, 4),
(272, 'Sides print', '2016-10-08 20:55:26', '2016-10-08 20:55:26', 25, 25, 70, 8),
(273, 'Sides print', '2016-10-08 20:55:26', '2016-10-08 20:55:26', 25, 25, 70, 12),
(274, 'Sides print', '2016-10-08 20:55:26', '2016-10-08 20:55:26', 25, 25, 70, 15),
(275, 'No customization', '2016-10-08 21:18:39', '2016-10-08 21:18:39', 25, 25, 71, 1),
(276, 'No personalitzat', '2016-10-08 21:18:39', '2016-10-08 21:18:39', 25, 25, 71, 2),
(277, 'No personalizado', '2016-10-08 21:18:39', '2016-10-08 21:18:39', 25, 25, 71, 4),
(278, 'No customization', '2016-10-08 21:18:39', '2016-10-08 21:18:39', 25, 25, 71, 8),
(279, 'No customization', '2016-10-08 21:18:39', '2016-10-08 21:18:39', 25, 25, 71, 12),
(280, 'No customization', '2016-10-08 21:18:39', '2016-10-08 21:18:39', 25, 25, 71, 15),
(281, 'One side print / Sides Print', '2016-10-08 21:20:03', '2016-10-08 21:20:03', 25, 25, 72, 1),
(282, 'Imprès 1 camal / Imprès Laterals', '2016-10-08 21:20:03', '2016-10-08 21:20:03', 25, 25, 72, 2),
(283, 'Imprès 1 camal / Imprès Laterals', '2016-10-08 21:20:03', '2016-10-08 21:20:03', 25, 25, 72, 4),
(284, 'One side print / Sides Print', '2016-10-08 21:20:03', '2016-10-08 21:20:03', 25, 25, 72, 8),
(285, 'One side print / Sides Print', '2016-10-08 21:20:03', '2016-10-08 21:20:03', 25, 25, 72, 12),
(286, 'One side print / Sides Print', '2016-10-08 21:20:03', '2016-10-08 21:20:03', 25, 25, 72, 15),
(287, 'Full print', '2016-10-08 21:24:23', '2016-10-08 21:24:23', 25, 25, 73, 1),
(321, 'Full print / 1 side print + number', '2016-10-08 21:37:48', '2016-10-08 21:37:48', 25, 25, 80, 1),
(322, 'Full print  / 1 cara + número', '2016-10-08 21:37:48', '2016-10-08 21:37:48', 25, 25, 80, 2),
(323, 'Full print  / 1 lado + número', '2016-10-08 21:37:48', '2016-10-08 21:37:48', 25, 25, 80, 4),
(324, 'Full print / 1 side print + number', '2016-10-08 21:37:48', '2016-10-08 21:37:48', 25, 25, 80, 8),
(325, 'Full print / 1 side print + number', '2016-10-08 21:37:48', '2016-10-08 21:37:48', 25, 25, 80, 12),
(326, 'Full print / 1 side print + number', '2016-10-08 21:37:48', '2016-10-08 21:37:48', 25, 25, 80, 15),
(327, 'Full Print + number', '2016-10-08 21:38:44', '2016-10-08 21:38:44', 25, 25, 81, 1),
(328, 'Full Print + número', '2016-10-08 21:38:44', '2016-10-08 21:38:44', 25, 25, 81, 2),
(329, 'Full Print + número', '2016-10-08 21:38:44', '2016-10-08 21:38:44', 25, 25, 81, 4),
(330, 'Full Print + number', '2016-10-08 21:38:44', '2016-10-08 21:38:44', 25, 25, 81, 8),
(331, 'Full Print + number', '2016-10-08 21:38:44', '2016-10-08 21:38:44', 25, 25, 81, 12),
(332, 'Full Print + number', '2016-10-08 21:38:44', '2016-10-08 21:38:44', 25, 25, 81, 15),
(333, 'No customization', '2016-10-08 21:44:10', '2016-10-08 21:44:10', 25, 25, 82, 1),
(334, 'No personalitzat', '2016-10-08 21:44:10', '2016-10-08 21:44:10', 25, 25, 82, 2),
(335, 'No personalizado', '2016-10-08 21:44:10', '2016-10-08 21:44:10', 25, 25, 82, 4),
(336, 'No customization', '2016-10-08 21:44:10', '2016-10-08 21:44:10', 25, 25, 82, 8),
(337, 'No customization', '2016-10-08 21:44:10', '2016-10-08 21:44:10', 25, 25, 82, 12),
(338, 'No customization', '2016-10-08 21:44:10', '2016-10-08 21:44:10', 25, 25, 82, 15),
(339, 'One side print', '2016-10-08 21:56:30', '2016-10-08 21:56:30', 25, 25, 83, 1),
(340, 'Imprès a 1 cara', '2016-10-08 21:56:30', '2016-10-08 21:56:30', 25, 25, 83, 2),
(341, 'Imprès a 1 cara', '2016-10-08 21:56:30', '2016-10-08 21:56:30', 25, 25, 83, 4),
(342, 'One side print', '2016-10-08 21:56:30', '2016-10-08 21:56:30', 25, 25, 83, 8),
(343, 'One side print', '2016-10-08 21:56:30', '2016-10-08 21:56:30', 25, 25, 83, 12),
(344, 'One side print', '2016-10-08 21:56:30', '2016-10-08 21:56:30', 25, 25, 83, 15),
(345, 'No customization', '2016-10-08 21:59:22', '2016-10-08 21:59:22', 25, 25, 84, 1),
(346, 'No personalitzat', '2016-10-08 21:59:22', '2016-10-08 21:59:22', 25, 25, 84, 2),
(347, 'No personalizado', '2016-10-08 21:59:22', '2016-10-08 21:59:22', 25, 25, 84, 4),
(348, 'No customization', '2016-10-08 21:59:22', '2016-10-08 21:59:22', 25, 25, 84, 8),
(349, 'No customization', '2016-10-08 21:59:22', '2016-10-08 21:59:22', 25, 25, 84, 12),
(350, 'No customization', '2016-10-08 21:59:22', '2016-10-08 21:59:22', 25, 25, 84, 15),
(351, 'One side print', '2016-10-08 22:00:52', '2016-10-08 22:00:52', 25, 25, 85, 1),
(352, 'Imprès a 1 cara', '2016-10-08 22:00:52', '2016-10-08 22:00:52', 25, 25, 85, 2),
(353, 'Impresión a 1 cara', '2016-10-08 22:00:52', '2016-10-08 22:00:52', 25, 25, 85, 4),
(354, 'One side print', '2016-10-08 22:00:52', '2016-10-08 22:00:52', 25, 25, 85, 8),
(355, 'One side print', '2016-10-08 22:00:52', '2016-10-08 22:00:52', 25, 25, 85, 12),
(356, 'One side print', '2016-10-08 22:00:52', '2016-10-08 22:00:52', 25, 25, 85, 15),
(357, 'Full print / 1 side print + number', '2016-10-08 22:02:34', '2016-10-08 22:02:34', 25, 25, 86, 1),
(358, 'Full print  / 1 cara + número', '2016-10-08 22:02:34', '2016-10-08 22:02:34', 25, 25, 86, 2),
(359, 'Full print  / 1 lado + número', '2016-10-08 22:02:34', '2016-10-08 22:02:34', 25, 25, 86, 4),
(360, 'Full print / 1 side print + number', '2016-10-08 22:02:34', '2016-10-08 22:02:34', 25, 25, 86, 8),
(361, 'Full print / 1 side print + number', '2016-10-08 22:02:34', '2016-10-08 22:02:34', 25, 25, 86, 12),
(362, 'Full print / 1 side print + number', '2016-10-08 22:02:34', '2016-10-08 22:02:34', 25, 25, 86, 15),
(363, 'Full print / 1 side print + number', '2016-10-08 22:18:12', '2016-10-08 22:18:12', 25, 25, 87, 1),
(364, 'Full print  / 1 cara + número', '2016-10-08 22:18:12', '2016-10-08 22:18:12', 25, 25, 87, 2),
(365, 'Full print  / 1 lado + número', '2016-10-08 22:18:12', '2016-10-08 22:18:12', 25, 25, 87, 4),
(366, 'Full print / 1 side print + number', '2016-10-08 22:18:12', '2016-10-08 22:18:12', 25, 25, 87, 8),
(367, 'Full print / 1 side print + number', '2016-10-08 22:18:12', '2016-10-08 22:18:12', 25, 25, 87, 12),
(368, 'Full print / 1 side print + number', '2016-10-08 22:18:12', '2016-10-08 22:18:12', 25, 25, 87, 15),
(369, 'Full Print + number', '2016-10-08 22:36:49', '2016-10-08 22:36:49', 25, 25, 88, 1),
(370, 'Full Print + número', '2016-10-08 22:36:49', '2016-10-08 22:36:49', 25, 25, 88, 2),
(371, 'Full Print + número', '2016-10-08 22:36:49', '2016-10-08 22:36:49', 25, 25, 88, 4),
(372, 'Full Print + number', '2016-10-08 22:36:49', '2016-10-08 22:36:49', 25, 25, 88, 8),
(373, 'Full Print + number', '2016-10-08 22:36:49', '2016-10-08 22:36:49', 25, 25, 88, 12),
(374, 'Full Print + number', '2016-10-08 22:36:49', '2016-10-08 22:36:49', 25, 25, 88, 15),
(375, 'Full print + Number', '2016-10-11 21:32:47', '2016-10-11 21:32:47', 25, 25, 89, 1),
(376, 'Full print + Número', '2016-10-11 21:32:47', '2016-10-11 21:32:47', 25, 25, 89, 2),
(377, 'Full print + Número', '2016-10-11 21:32:47', '2016-10-11 21:32:47', 25, 25, 89, 4),
(378, 'Full print + Number', '2016-10-11 21:32:47', '2016-10-11 21:32:47', 25, 25, 89, 8),
(379, 'Full print + Number', '2016-10-11 21:32:47', '2016-10-11 21:32:47', 25, 25, 89, 12),
(380, 'Full print + Number', '2016-10-11 21:32:47', '2016-10-11 21:32:47', 25, 25, 89, 15),
(381, 'No customization', '2016-10-11 21:37:38', '2016-10-11 21:37:38', 25, 25, 90, 1),
(382, 'No personalitzat', '2016-10-11 21:37:38', '2016-10-11 21:37:38', 25, 25, 90, 2),
(383, 'No personalizado', '2016-10-11 21:37:38', '2016-10-11 21:37:38', 25, 25, 90, 4),
(384, 'No customization', '2016-10-11 21:37:38', '2016-10-11 21:37:38', 25, 25, 90, 8),
(385, 'No customization', '2016-10-11 21:37:38', '2016-10-11 21:37:38', 25, 25, 90, 12),
(386, 'No customization', '2016-10-11 21:37:38', '2016-10-11 21:37:38', 25, 25, 90, 15),
(387, 'Print one side', '2016-10-11 21:42:18', '2016-10-11 21:42:18', 25, 25, 91, 1),
(388, 'Imprès a una cara', '2016-10-11 21:42:18', '2016-10-11 21:42:18', 25, 25, 91, 2),
(389, 'Impresión a 1 cara', '2016-10-11 21:42:18', '2016-10-11 21:42:18', 25, 25, 91, 4),
(390, 'Print one side', '2016-10-11 21:42:18', '2016-10-11 21:42:18', 25, 25, 91, 8),
(391, 'Print one side', '2016-10-11 21:42:18', '2016-10-11 21:42:18', 25, 25, 91, 12),
(392, 'Print one side', '2016-10-11 21:42:18', '2016-10-11 21:42:18', 25, 25, 91, 15),
(393, 'Small 10 x 10 cm', '2016-10-12 15:08:35', '2016-10-12 15:08:35', 25, 25, 92, 1),
(394, 'Petit 10 x 10 cm', '2016-10-12 15:08:35', '2016-10-12 15:08:35', 25, 25, 92, 2),
(395, 'Pequeño 10 x 10 cm', '2016-10-12 15:08:35', '2016-10-12 15:08:35', 25, 25, 92, 4),
(396, 'Small 10 x 10 cm', '2016-10-12 15:08:35', '2016-10-12 15:08:35', 25, 25, 92, 8),
(397, 'Small 10 x 10 cm', '2016-10-12 15:08:35', '2016-10-12 15:08:35', 25, 25, 92, 12),
(398, 'Small 10 x 10 cm', '2016-10-12 15:08:35', '2016-10-12 15:08:35', 25, 25, 92, 15),
(399, 'Medium 15 x 15 cm', '2016-10-12 15:10:35', '2016-10-12 15:10:35', 25, 25, 93, 1),
(400, 'Mitjà 15 x 15 cm', '2016-10-12 15:10:35', '2016-10-12 15:10:35', 25, 25, 93, 2),
(401, 'Mediano 15 x 15 cm', '2016-10-12 15:10:35', '2016-10-12 15:10:35', 25, 25, 93, 4),
(402, 'Medium 15 x 15 cm', '2016-10-12 15:10:35', '2016-10-12 15:10:35', 25, 25, 93, 8),
(403, 'Medium 15 x 15 cm', '2016-10-12 15:10:35', '2016-10-12 15:10:35', 25, 25, 93, 12),
(404, 'Medium 15 x 15 cm', '2016-10-12 15:10:35', '2016-10-12 15:10:35', 25, 25, 93, 15),
(405, 'Large 25 x 25 cm', '2016-10-12 15:30:34', '2016-10-12 15:30:34', 25, 25, 94, 1),
(406, 'Gran 25 x 25 cm', '2016-10-12 15:30:34', '2016-10-12 15:30:34', 25, 25, 94, 2),
(407, 'Grande 25 x 25 cm', '2016-10-12 15:30:34', '2016-10-12 15:30:34', 25, 25, 94, 4),
(408, 'Large 25 x 25 cm', '2016-10-12 15:30:34', '2016-10-12 15:30:34', 25, 25, 94, 8),
(409, 'Large 25 x 25 cm', '2016-10-12 15:30:34', '2016-10-12 15:30:34', 25, 25, 94, 12),
(410, 'Large 25 x 25 cm', '2016-10-12 15:30:34', '2016-10-12 15:30:34', 25, 25, 94, 15),
(411, 'No customization', '2016-10-13 22:01:12', '2016-10-13 22:01:12', 25, 25, 95, 1),
(412, 'No personalitzat', '2016-10-13 22:01:12', '2016-10-13 22:01:12', 25, 25, 95, 2),
(413, 'No personalizado', '2016-10-13 22:01:12', '2016-10-13 22:01:12', 25, 25, 95, 4),
(414, 'No customization', '2016-10-13 22:01:12', '2016-10-13 22:01:12', 25, 25, 95, 8),
(415, 'No customization', '2016-10-13 22:01:12', '2016-10-13 22:01:12', 25, 25, 95, 12),
(416, 'No customization', '2016-10-13 22:01:12', '2016-10-13 22:01:12', 25, 25, 95, 15),
(417, 'One side print', '2016-10-13 22:02:32', '2016-10-13 22:02:32', 25, 25, 96, 1),
(418, 'Impressió a 1 cara', '2016-10-13 22:02:32', '2016-10-13 22:02:32', 25, 25, 96, 2),
(419, 'Impresión a 1 cara', '2016-10-13 22:02:32', '2016-10-13 22:02:32', 25, 25, 96, 4),
(420, 'One side print', '2016-10-13 22:02:32', '2016-10-13 22:02:32', 25, 25, 96, 8),
(421, 'One side print', '2016-10-13 22:02:32', '2016-10-13 22:02:32', 25, 25, 96, 12),
(422, 'One side print', '2016-10-13 22:02:32', '2016-10-13 22:02:32', 25, 25, 96, 15),
(423, 'No customization', '2016-10-15 19:09:16', '2016-10-15 19:09:16', 25, 25, 97, 1),
(424, 'No personalitzat', '2016-10-15 19:09:16', '2016-10-15 19:09:16', 25, 25, 97, 2),
(425, 'No personalizado', '2016-10-15 19:09:16', '2016-10-15 19:09:16', 25, 25, 97, 4),
(426, 'No customization', '2016-10-15 19:09:16', '2016-10-15 19:09:16', 25, 25, 97, 8),
(427, 'No customization', '2016-10-15 19:09:16', '2016-10-15 19:09:16', 25, 25, 97, 12),
(428, 'No customization', '2016-10-15 19:09:16', '2016-10-15 19:09:16', 25, 25, 97, 15),
(429, 'Imprès a 1 cara', '2016-10-15 19:10:36', '2016-10-15 19:10:36', 25, 25, 98, 2),
(430, 'Impresión a 1 cara', '2016-10-15 19:10:36', '2016-10-15 19:10:36', 25, 25, 98, 4),
(431, 'One side print', '2016-10-15 19:10:36', '2016-10-15 19:10:36', 25, 25, 98, 8),
(432, 'One side print', '2016-10-15 19:10:36', '2016-10-15 19:10:36', 25, 25, 98, 12),
(433, 'One side printOne side print', '2016-10-15 19:10:36', '2016-10-15 19:10:36', 25, 25, 98, 15),
(437, '2 sides print / 1 side print + number', '2016-10-19 08:35:30', '2016-10-19 08:35:30', 25, 25, 101, 1),
(438, 'Imprès a 2 cares / 1 cara + número', '2016-10-19 08:35:30', '2016-10-19 08:35:30', 25, 25, 101, 2),
(439, 'Impresión a 2 caras / 1 cara + número', '2016-10-19 08:35:30', '2016-10-19 08:35:30', 25, 25, 101, 4),
(440, '2 sides print / 1 side print + number', '2016-10-19 08:35:30', '2016-10-19 08:35:30', 25, 25, 101, 8),
(441, '2 sides print / 1 side print + number', '2016-10-19 08:35:30', '2016-10-19 08:35:30', 25, 25, 101, 12),
(442, '2 sides print / 1 side print + number', '2016-10-19 08:35:30', '2016-10-19 08:35:30', 25, 25, 101, 15);

-- --------------------------------------------------------

--
-- Table structure for table `currency`
--

CREATE TABLE IF NOT EXISTS `currency` (
  `id_currency` int(11) NOT NULL,
  `curr_code` varchar(255) DEFAULT NULL,
  `curr_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `currency`
--

INSERT INTO `currency` (`id_currency`, `curr_code`, `curr_description`, `created`, `updated`, `id_user_created`, `id_user_updated`) VALUES
(1, 'USD', 'US Dollar', '2016-06-14 16:07:20', NULL, NULL, NULL),
(3, 'VND', 'Vietnam Dong', '2016-06-14 16:07:20', NULL, NULL, NULL),
(6, 'RUB', 'Ruby', '2016-06-14 16:07:20', NULL, NULL, NULL),
(16, 'JPY', 'Yen', '2016-06-14 16:07:20', NULL, NULL, NULL),
(17, 'GBP', 'Pound', '2016-06-14 16:07:20', '2016-10-30 16:25:37', NULL, 1),
(18, 'EUR', 'Euro', '2016-06-14 16:07:20', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `currency_convert`
--

CREATE TABLE IF NOT EXISTS `currency_convert` (
  `id_curr_conv` int(11) NOT NULL,
  `cc_date` date DEFAULT NULL,
  `cc_value` double DEFAULT NULL,
  `id_currency` int(11) DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `currency_convert`
--

INSERT INTO `currency_convert` (`id_curr_conv`, `cc_date`, `cc_value`, `id_currency`, `id_user_created`, `id_user_updated`) VALUES
(1, '2016-08-08', 1, 1, 1, 1),
(2, '2016-08-08', 22260, 3, 1, 1),
(3, '2016-08-08', 0.91, 18, 1, 1),
(4, '2016-08-08', 103.75, 16, 1, 1),
(5, '2016-08-08', 70.86, 6, 1, 1),
(6, '2016-08-08', 0.778, 17, 1, 1),
(7, '2016-08-10', 1, 1, 1, 1),
(8, '2016-08-10', 22270, 3, 1, 1),
(9, '2016-08-10', 0.92, 18, 1, 1),
(10, '2016-08-10', 104, 16, 1, 1),
(11, '2016-08-10', 70.8, 6, 1, 1),
(12, '2016-08-10', 0.78, 17, 1, 1),
(13, '2016-08-12', 1, 1, 1, 1),
(14, '2016-08-12', 22250, 3, 1, 1),
(15, '2016-08-12', 0.9, 18, 1, 1),
(16, '2016-08-12', 114.4, 16, 1, 1),
(17, '2016-08-12', 71, 6, 1, 1),
(18, '2016-08-12', 0.79, 17, 1, 1),
(25, '2016-08-15', 1, 1, 1, 1),
(26, '2016-08-15', 22250, 3, 1, 1),
(27, '2016-08-15', 0.9, 18, 1, 1),
(28, '2016-08-15', 114.4, 16, 1, 1),
(29, '2016-08-15', 71, 6, 1, 1),
(30, '2016-08-15', 0.79, 17, 1, 1),
(31, '2016-08-17', 1, 1, 1, 1),
(32, '2016-08-17', 22250, 3, 1, 1),
(33, '2016-08-17', 0.9, 18, 1, 1),
(34, '2016-08-17', 114.4, 16, 1, 1),
(35, '2016-08-17', 71, 6, 1, 1),
(36, '2016-08-17', 0.79, 17, 1, 1),
(37, '2016-08-18', 1, 1, 1, 1),
(38, '2016-08-18', 22250, 3, 1, 1),
(39, '2016-08-18', 0.9, 18, 1, 1),
(40, '2016-08-18', 114.4, 16, 1, 1),
(41, '2016-08-18', 71, 6, 1, 1),
(42, '2016-08-18', 0.79, 17, 1, 1),
(43, '2016-08-19', 1, 1, 1, 1),
(44, '2016-08-19', 22250, 3, 1, 1),
(45, '2016-08-19', 0.9, 18, 1, 1),
(46, '2016-08-19', 114.4, 16, 1, 1),
(47, '2016-08-19', 71, 6, 1, 1),
(48, '2016-08-19', 0.79, 17, 1, 1),
(49, '2016-08-20', 1, 1, 1, 1),
(50, '2016-08-20', 22250, 3, 1, 1),
(51, '2016-08-20', 0.9, 18, 1, 1),
(52, '2016-08-20', 114.4, 16, 1, 1),
(53, '2016-08-20', 71, 6, 1, 1),
(54, '2016-08-20', 0.79, 17, 1, 1),
(55, '2016-08-21', 1, 1, 1, 1),
(56, '2016-08-21', 22250, 3, 1, 1),
(57, '2016-08-21', 0.9, 18, 1, 1),
(58, '2016-08-21', 114.4, 16, 1, 1),
(59, '2016-08-21', 71, 6, 1, 1),
(60, '2016-08-21', 0.79, 17, 1, 1),
(61, '2016-08-22', 1, 1, 1, 1),
(62, '2016-08-22', 22250, 3, 1, 1),
(63, '2016-08-22', 0.9, 18, 1, 1),
(64, '2016-08-22', 114.4, 16, 1, 1),
(65, '2016-08-22', 71, 6, 1, 1),
(66, '2016-08-22', 0.79, 17, 1, 1),
(67, '2016-08-23', 1, 1, 1, 1),
(68, '2016-08-23', 22250, 3, 1, 1),
(69, '2016-08-23', 0.9, 18, 1, 1),
(70, '2016-08-23', 114.4, 16, 1, 1),
(71, '2016-08-23', 71, 6, 1, 1),
(72, '2016-08-23', 0.79, 17, 1, 1),
(73, '2016-08-24', 1, 1, 1, 1),
(74, '2016-08-24', 22250, 3, 1, 1),
(75, '2016-08-24', 0.9, 18, 1, 1),
(76, '2016-08-24', 114.4, 16, 1, 1),
(77, '2016-08-24', 71, 6, 1, 1),
(78, '2016-08-24', 0.79, 17, 1, 1),
(79, '2016-08-25', 1, 1, 1, 1),
(80, '2016-08-25', 22250, 3, 1, 1),
(81, '2016-08-25', 0.9, 18, 1, 1),
(82, '2016-08-25', 114.4, 16, 1, 1),
(83, '2016-08-25', 71, 6, 1, 1),
(84, '2016-08-25', 0.79, 17, 1, 1),
(91, '2016-10-30', 62.955002, 6, 1, 1),
(92, '2016-10-30', 1, 1, 1, 1),
(93, '2016-10-30', 0.909904, 18, 1, 1),
(94, '2016-10-30', 0.820404, 17, 1, 1),
(95, '2016-10-30', 104.69404, 16, 1, 1),
(96, '2016-10-30', 22320, 3, 1, 1),
(97, '2016-10-31', 0.909899, 18, 1, 1),
(98, '2016-10-31', 0.82292, 17, 1, 1),
(99, '2016-10-31', 104.692001, 16, 1, 1),
(100, '2016-10-31', 62.988701, 6, 1, 1),
(101, '2016-10-31', 1, 1, 1, 1),
(102, '2016-10-31', 22320, 3, 1, 1),
(103, '2016-11-01', 63.393902, 6, 1, 1),
(104, '2016-11-01', 0.911099, 18, 1, 1),
(105, '2016-11-01', 0.81744, 17, 1, 1),
(106, '2016-11-01', 1, 1, 1, 1),
(107, '2016-11-01', 104.850998, 16, 1, 1),
(108, '2016-11-01', 22322, 3, 1, 1),
(109, '2016-11-02', 0.903603, 18, 1, 1),
(110, '2016-11-02', 0.816799, 17, 1, 1),
(111, '2016-11-02', 104.012983, 16, 1, 1),
(112, '2016-11-02', 63.326199, 6, 1, 1),
(113, '2016-11-02', 1, 1, 1, 1),
(114, '2016-11-02', 22321, 3, 1, 1),
(115, '2016-11-03', 0.81336, 17, 1, 1),
(116, '2016-11-03', 103.277007, 16, 1, 1),
(117, '2016-11-03', 0.900802, 18, 1, 1),
(118, '2016-11-03', 63.588799, 6, 1, 1),
(119, '2016-11-03', 1, 1, 1, 1),
(120, '2016-11-03', 22321, 3, 1, 1),
(121, '2016-11-04', 0.899901, 18, 1, 1),
(122, '2016-11-04', 63.669802, 6, 1, 1),
(123, '2016-11-04', 1, 1, 1, 1),
(124, '2016-11-04', 0.80297, 17, 1, 1),
(125, '2016-11-04', 102.970001, 16, 1, 1),
(126, '2016-11-04', 22325, 3, 1, 1),
(127, '2016-11-05', 64.217903, 6, 1, 1),
(128, '2016-11-05', 103.15204, 16, 1, 1),
(129, '2016-11-05', 0.79922, 17, 1, 1),
(130, '2016-11-05', 1, 1, 1, 1),
(131, '2016-11-05', 0.89904, 18, 1, 1),
(132, '2016-11-05', 22325, 3, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `id_Customer` int(11) NOT NULL,
  `cs_code` varchar(255) DEFAULT NULL,
  `cs_name` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_language` int(11) DEFAULT NULL,
  `id_agent` int(11) DEFAULT NULL,
  `id_Zone` int(11) DEFAULT NULL,
  `id_type_customer` int(11) DEFAULT NULL,
  `id_contact` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id_Customer`, `cs_code`, `cs_name`, `created`, `updated`, `id_user_created`, `id_user_updated`, `id_language`, `id_agent`, `id_Zone`, `id_type_customer`, `id_contact`) VALUES
(10, NULL, 'AE Minguella', '2016-09-20 06:21:53', '2016-10-12 18:58:02', 28, 1, 2, 15, 5, 3, 85),
(11, NULL, 'CB Montgat', '2016-09-20 06:22:57', '2016-09-20 06:22:57', 28, 28, 2, 15, 5, 3, 86),
(12, NULL, 'CB Palafolls', '2016-09-20 06:24:28', '2016-09-20 06:24:28', 28, 28, 2, 15, 5, 3, 87),
(14, NULL, 'SSIS - Saigon South International School', '2016-10-07 21:50:07', '2016-10-07 21:50:07', 35, 35, 1, 24, 6, 2, 99),
(15, NULL, 'UNIS', '2016-10-07 21:54:11', '2016-10-07 21:54:11', 36, 36, 1, 14, 6, 2, 100),
(16, NULL, 'Hanoi Dragons', '2016-10-07 21:54:46', '2016-10-07 21:54:46', 36, 36, 1, 14, 6, 3, 101),
(17, NULL, 'Vina School', '2016-10-07 21:56:01', '2016-10-07 21:56:01', 35, 35, 1, 24, 6, 2, 102),
(18, NULL, 'Ta Lai Adventire', '2016-10-07 21:57:29', '2016-10-07 21:57:29', 35, 35, 1, 24, 6, 4, 103),
(19, NULL, 'Canal Isabel II', '2016-10-07 21:59:56', '2016-10-07 21:59:56', 37, 37, 4, 22, 5, 3, 105),
(20, NULL, 'CA Las Rozas', '2016-10-07 22:01:27', '2016-10-07 22:01:27', 37, 37, 4, 22, 5, 3, 106),
(21, NULL, 'CF Badalona', '2016-10-13 18:01:40', '2016-10-13 18:01:40', 25, 25, 2, 15, 5, 3, 109),
(22, NULL, 'ASME', '2016-10-13 18:02:26', '2016-10-13 18:02:26', 38, 38, 2, 15, 5, 3, 110),
(23, NULL, 'Lloreda', '2016-10-19 11:36:59', '2016-10-19 11:36:59', 27, 27, 2, 15, 5, 3, 116),
(24, NULL, 'Hanoi Test', '2016-10-22 13:22:28', '2016-10-22 13:22:28', 25, 25, 1, 14, 6, 2, 117);

-- --------------------------------------------------------

--
-- Table structure for table `factory`
--

CREATE TABLE IF NOT EXISTS `factory` (
  `id_factory` int(11) NOT NULL,
  `fty_code` varchar(255) DEFAULT NULL,
  `fty_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_currency` int(11) DEFAULT NULL,
  `id_language` int(11) DEFAULT NULL,
  `id_contact` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `factory`
--

INSERT INTO `factory` (`id_factory`, `fty_code`, `fty_description`, `created`, `updated`, `id_user_created`, `id_user_updated`, `id_currency`, `id_language`, `id_contact`) VALUES
(1, 'TV', 'Traval Vai (VN)', '2016-08-01 13:06:04', '2016-09-19 11:18:36', NULL, 1, 3, 1, 4),
(2, 'TRAVALVAI', 'TRAVALVAI is the largest company in the world', '2016-08-01 13:06:04', '2016-09-09 09:27:54', NULL, 24, 18, 1, 67);

-- --------------------------------------------------------

--
-- Table structure for table `forwarder`
--

CREATE TABLE IF NOT EXISTS `forwarder` (
  `id_forwarder` int(11) NOT NULL,
  `fw_name` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_contact` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `forwarder`
--

INSERT INTO `forwarder` (`id_forwarder`, `fw_name`, `created`, `updated`, `id_user_created`, `id_user_updated`, `id_contact`) VALUES
(1, 'dfgdfg', '2016-08-01 18:24:33', '2016-08-01 18:24:33', 5, 5, 31),
(2, 'Forwarder 1', '2016-08-01 18:25:07', '2016-08-05 09:58:04', 5, 1, 39),
(3, 'Forwarder 2', '2016-08-01 18:25:25', '2016-08-05 10:02:11', 5, 1, 40);

-- --------------------------------------------------------

--
-- Table structure for table `freight`
--

CREATE TABLE IF NOT EXISTS `freight` (
  `id_freight` int(11) NOT NULL,
  `fr_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `freight`
--

INSERT INTO `freight` (`id_freight`, `fr_description`, `created`, `updated`, `id_user_created`, `id_user_updated`) VALUES
(4, 'Freight 1', '2016-08-01 18:19:02', '2016-08-05 10:56:43', 6, 1),
(5, 'Freight 2', '2016-08-05 10:56:51', '2016-08-05 10:56:51', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `group_materials`
--

CREATE TABLE IF NOT EXISTS `group_materials` (
  `Id_group_mat` int(11) NOT NULL,
  `gm_code` varchar(255) DEFAULT NULL,
  `gm_order` varchar(255) DEFAULT NULL,
  `gm_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `id_Factory` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `group_of_products`
--

CREATE TABLE IF NOT EXISTS `group_of_products` (
  `id_group_products` int(11) NOT NULL,
  `gp_code` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_Factory` int(11) DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `group_of_products`
--

INSERT INTO `group_of_products` (`id_group_products`, `gp_code`, `created`, `updated`, `id_Factory`, `id_user_created`, `id_user_updated`) VALUES
(3, 'TB', '2016-08-01 17:12:35', '2016-09-29 09:37:52', 1, 1, 25),
(5, 'TP', '2016-08-02 11:06:24', '2016-09-20 06:51:27', 1, 1, 28),
(9, 'PS', '2016-08-02 11:07:31', '2016-09-20 08:36:17', 1, 1, 25),
(10, 'PP', '2016-08-02 11:07:44', '2016-09-29 09:12:30', 1, 1, 25),
(11, 'PL', '2016-08-02 11:07:56', '2016-09-20 06:47:20', 1, 1, 28),
(12, 'PX', '2016-08-02 11:08:11', '2016-09-29 09:38:32', 1, 1, 25),
(13, 'SW', '2016-08-02 11:08:21', '2016-09-29 09:39:14', 1, 1, 25),
(14, 'SH', '2016-08-02 11:08:34', '2016-09-29 09:38:58', 1, 1, 25),
(15, 'JK', '2016-08-02 11:08:45', '2016-09-20 06:44:03', 1, 1, 28),
(16, 'JH', '2016-08-02 11:09:08', '2016-09-20 06:43:39', 1, 1, 28),
(17, 'OC', '2016-08-02 11:09:34', '2016-09-29 09:10:33', 1, 1, 25),
(18, 'MS', '2016-08-02 11:09:50', '2016-09-29 09:11:55', 1, 1, 25),
(19, 'AT', '2016-08-02 11:10:05', '2016-09-29 09:01:34', 1, 1, 25),
(20, 'AB', '2016-08-02 11:10:16', '2016-10-04 16:39:32', 1, 1, 1),
(21, 'WS', '2016-08-02 11:10:29', '2016-09-29 09:40:12', 1, 1, 25),
(39, 'TSL', '2016-09-23 13:03:54', '2016-09-23 13:04:09', 2, 24, 24),
(42, 'AF', '2016-09-29 09:01:58', '2016-09-29 09:01:58', 1, 25, 25),
(43, 'AC', '2016-09-29 09:02:27', '2016-10-04 16:39:37', 1, 25, 1),
(44, 'AP', '2016-09-29 09:42:02', '2016-09-29 09:42:02', 1, 25, 25),
(45, 'AK', '2016-09-29 09:42:40', '2016-09-29 09:42:40', 1, 25, 25),
(46, 'AS', '2016-09-29 09:43:23', '2016-09-29 09:43:23', 1, 25, 25),
(47, 'AL', '2016-09-29 09:45:00', '2016-10-04 16:39:49', 1, 25, 1),
(48, 'AH', '2016-09-29 09:45:54', '2016-09-29 09:45:54', 1, 25, 25),
(49, 'TR', '2016-09-29 09:46:56', '2016-09-29 09:46:56', 1, 25, 25),
(50, 'TU', '2016-09-29 09:48:52', '2016-09-29 09:48:52', 1, 25, 25),
(51, 'TV', '2016-09-29 09:49:22', '2016-09-29 09:49:22', 1, 25, 25),
(52, 'CB', '2016-09-29 09:50:52', '2016-09-29 09:50:52', 1, 25, 25),
(53, 'CR', '2016-09-29 09:51:29', '2016-09-29 09:51:29', 1, 25, 25),
(54, 'CV', '2016-09-29 09:52:11', '2016-09-29 09:52:11', 1, 25, 25),
(55, 'CT', '2016-09-29 09:52:44', '2016-09-29 09:52:44', 1, 25, 25),
(56, 'OP', '2016-09-29 09:54:05', '2016-09-29 09:54:05', 1, 25, 25),
(57, 'OW', '2016-09-29 09:54:32', '2016-09-29 09:54:32', 1, 25, 25),
(58, 'OB', '2016-09-29 09:54:55', '2016-09-29 09:54:55', 1, 25, 25),
(59, 'MT', '2016-09-29 09:55:44', '2016-09-29 09:55:44', 1, 25, 25),
(60, 'MP', '2016-09-29 09:56:15', '2016-09-29 09:56:15', 1, 25, 25),
(61, 'BT', '2016-09-29 09:56:52', '2016-09-29 09:56:52', 1, 25, 25),
(62, 'BP', '2016-09-29 09:57:20', '2016-09-29 09:57:20', 1, 25, 25),
(63, 'WL', '2016-09-29 09:58:18', '2016-09-29 09:58:18', 1, 25, 25),
(66, 'Z', '2016-10-12 14:38:22', '2016-10-12 14:38:22', 1, 25, 25);

-- --------------------------------------------------------

--
-- Table structure for table `group_product_language`
--

CREATE TABLE IF NOT EXISTS `group_product_language` (
  `id_group_language` int(11) NOT NULL,
  `description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_group` int(11) DEFAULT NULL,
  `id_language` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=529 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `group_product_language`
--

INSERT INTO `group_product_language` (`id_group_language`, `description`, `created`, `updated`, `id_user_created`, `id_user_updated`, `id_group`, `id_language`) VALUES
(17, 'T-Shirt Basic', '2016-08-01 17:12:35', '2016-09-29 09:37:52', 1, 25, 3, 1),
(18, 'Camiseta Bàsica', '2016-08-01 17:12:35', '2016-09-29 09:37:52', 1, 25, 3, 2),
(19, 'Camiseta Básica', '2016-08-01 17:12:35', '2016-09-29 09:37:52', 1, 25, 3, 4),
(20, 'T-Shirt Basic', '2016-08-01 17:12:35', '2016-09-29 09:37:52', 1, 25, 3, 8),
(21, 'T-Shirt Basic', '2016-08-01 17:12:35', '2016-09-29 09:37:52', 1, 25, 3, 12),
(22, 'T-Shirt Basic', '2016-08-01 17:12:35', '2016-09-29 09:37:52', 1, 25, 3, 15),
(23, 'T-Shirt Basic', '2016-08-01 17:12:35', '2016-09-29 09:37:52', 1, 25, 3, 17),
(24, 'T-Shirt Basic', '2016-08-01 17:12:35', '2016-09-29 09:37:52', 1, 25, 3, 19),
(33, 'Polo', '2016-08-02 11:06:24', '2016-09-20 06:51:27', 1, 28, 5, 1),
(34, 'Polo', '2016-08-02 11:06:24', '2016-09-20 06:51:27', 1, 28, 5, 2),
(35, 'Polo', '2016-08-02 11:06:24', '2016-09-20 06:51:27', 1, 28, 5, 4),
(36, 'Polo', '2016-08-02 11:06:24', '2016-09-20 06:51:27', 1, 28, 5, 8),
(37, 'Polo', '2016-08-02 11:06:24', '2016-09-20 06:51:27', 1, 28, 5, 12),
(38, 'Polo', '2016-08-02 11:06:24', '2016-09-20 06:51:27', 1, 28, 5, 15),
(39, '', '2016-08-02 11:06:24', '2016-09-20 06:51:27', 1, 28, 5, 17),
(40, '', '2016-08-02 11:06:24', '2016-09-20 06:51:27', 1, 28, 5, 19),
(65, 'Pant Short', '2016-08-02 11:07:31', '2016-09-20 08:36:17', 1, 25, 9, 1),
(66, 'Pantaló Curt', '2016-08-02 11:07:31', '2016-09-20 08:36:17', 1, 25, 9, 2),
(67, 'Pantalón Corto', '2016-08-02 11:07:31', '2016-09-20 08:36:17', 1, 25, 9, 4),
(68, 'Pant Short', '2016-08-02 11:07:31', '2016-09-20 08:36:17', 1, 25, 9, 8),
(69, 'Pant Short', '2016-08-02 11:07:31', '2016-09-20 08:36:17', 1, 25, 9, 12),
(70, 'Pant Short', '2016-08-02 11:07:31', '2016-09-20 08:36:17', 1, 25, 9, 15),
(71, '', '2016-08-02 11:07:31', '2016-09-20 08:36:17', 1, 25, 9, 17),
(72, '', '2016-08-02 11:07:31', '2016-09-20 08:36:17', 1, 25, 9, 19),
(73, 'Pant Under Knee', '2016-08-02 11:07:44', '2016-09-29 09:12:30', 1, 25, 10, 1),
(74, 'Pantaló Pirata', '2016-08-02 11:07:44', '2016-09-29 09:12:30', 1, 25, 10, 2),
(75, 'Pantalón Pirata', '2016-08-02 11:07:44', '2016-09-29 09:12:30', 1, 25, 10, 4),
(76, 'Pant Under Knee', '2016-08-02 11:07:44', '2016-09-29 09:12:30', 1, 25, 10, 8),
(77, 'Pant Under Knee', '2016-08-02 11:07:44', '2016-09-29 09:12:30', 1, 25, 10, 12),
(78, 'Pant Under Knee', '2016-08-02 11:07:44', '2016-09-29 09:12:30', 1, 25, 10, 15),
(79, 'Pant Under Knee', '2016-08-02 11:07:44', '2016-09-29 09:12:30', 1, 25, 10, 17),
(80, 'Pant Under Knee', '2016-08-02 11:07:44', '2016-09-29 09:12:30', 1, 25, 10, 19),
(81, 'Pant Long', '2016-08-02 11:07:56', '2016-09-20 06:47:20', 1, 28, 11, 1),
(82, 'Pantaló Llarg', '2016-08-02 11:07:56', '2016-09-20 06:47:20', 1, 28, 11, 2),
(83, 'Pantalón Largo', '2016-08-02 11:07:56', '2016-09-20 06:47:20', 1, 28, 11, 4),
(84, 'Pant Long', '2016-08-02 11:07:56', '2016-09-20 06:47:20', 1, 28, 11, 8),
(85, 'Pant Long', '2016-08-02 11:07:56', '2016-09-20 06:47:20', 1, 28, 11, 12),
(86, 'Pant Long', '2016-08-02 11:07:56', '2016-09-20 06:47:20', 1, 28, 11, 15),
(87, '', '2016-08-02 11:07:56', '2016-09-20 06:47:20', 1, 28, 11, 17),
(88, '', '2016-08-02 11:07:56', '2016-09-20 06:47:20', 1, 28, 11, 19),
(89, 'Pant Spandex', '2016-08-02 11:08:11', '2016-09-29 09:38:32', 1, 25, 12, 1),
(90, 'Pantaló Spandex', '2016-08-02 11:08:11', '2016-09-29 09:38:32', 1, 25, 12, 2),
(91, 'Pantalón Spandex', '2016-08-02 11:08:11', '2016-09-29 09:38:32', 1, 25, 12, 4),
(92, 'Pant Spandex', '2016-08-02 11:08:11', '2016-09-29 09:38:32', 1, 25, 12, 8),
(93, 'Pant Spandex', '2016-08-02 11:08:11', '2016-09-29 09:38:32', 1, 25, 12, 12),
(94, 'Pant Spandex', '2016-08-02 11:08:11', '2016-09-29 09:38:32', 1, 25, 12, 15),
(95, 'Pant Spandex', '2016-08-02 11:08:11', '2016-09-29 09:38:32', 1, 25, 12, 17),
(96, 'Pant Spandex', '2016-08-02 11:08:11', '2016-09-29 09:38:32', 1, 25, 12, 19),
(97, 'Sweater', '2016-08-02 11:08:21', '2016-09-29 09:39:14', 1, 25, 13, 1),
(98, 'Dessuadora', '2016-08-02 11:08:21', '2016-09-29 09:39:14', 1, 25, 13, 2),
(99, 'Sudadera', '2016-08-02 11:08:21', '2016-09-29 09:39:14', 1, 25, 13, 4),
(100, 'Sweater', '2016-08-02 11:08:21', '2016-09-29 09:39:14', 1, 25, 13, 8),
(101, 'Sweater', '2016-08-02 11:08:21', '2016-09-29 09:39:14', 1, 25, 13, 12),
(102, 'Sweater', '2016-08-02 11:08:21', '2016-09-29 09:39:14', 1, 25, 13, 15),
(103, 'Sweater', '2016-08-02 11:08:21', '2016-09-29 09:39:14', 1, 25, 13, 17),
(104, 'Sweater', '2016-08-02 11:08:21', '2016-09-29 09:39:14', 1, 25, 13, 19),
(105, 'Sweater Hoodie', '2016-08-02 11:08:34', '2016-09-29 09:38:58', 1, 25, 14, 1),
(106, 'Dessuadora Caputxa', '2016-08-02 11:08:34', '2016-09-29 09:38:58', 1, 25, 14, 2),
(107, 'Jersey Capucha', '2016-08-02 11:08:34', '2016-09-29 09:38:58', 1, 25, 14, 4),
(108, 'Sweater Hoodie', '2016-08-02 11:08:34', '2016-09-29 09:38:58', 1, 25, 14, 8),
(109, 'Sweater Hoodie', '2016-08-02 11:08:34', '2016-09-29 09:38:58', 1, 25, 14, 12),
(110, 'Sweater Hoodie', '2016-08-02 11:08:34', '2016-09-29 09:38:58', 1, 25, 14, 15),
(111, 'Sweater Hoodie', '2016-08-02 11:08:34', '2016-09-29 09:38:58', 1, 25, 14, 17),
(112, 'Sweater Hoodie', '2016-08-02 11:08:34', '2016-09-29 09:38:58', 1, 25, 14, 19),
(113, 'Jacket', '2016-08-02 11:08:45', '2016-09-20 06:44:03', 1, 28, 15, 1),
(114, 'Jaqueta', '2016-08-02 11:08:45', '2016-09-20 06:44:03', 1, 28, 15, 2),
(115, 'Chaqueta', '2016-08-02 11:08:45', '2016-09-20 06:44:03', 1, 28, 15, 4),
(116, 'Jacket', '2016-08-02 11:08:45', '2016-09-20 06:44:03', 1, 28, 15, 8),
(117, 'Jacket', '2016-08-02 11:08:45', '2016-09-20 06:44:03', 1, 28, 15, 12),
(118, 'Jacket', '2016-08-02 11:08:45', '2016-09-20 06:44:03', 1, 28, 15, 15),
(119, '', '2016-08-02 11:08:45', '2016-09-20 06:44:03', 1, 28, 15, 17),
(120, '', '2016-08-02 11:08:45', '2016-09-20 06:44:03', 1, 28, 15, 19),
(121, 'Jacket Hoodie', '2016-08-02 11:09:08', '2016-09-20 06:43:39', 1, 28, 16, 1),
(122, 'Jaqueta caputxa', '2016-08-02 11:09:08', '2016-09-20 06:43:39', 1, 28, 16, 2),
(123, 'Chaqueta capucha', '2016-08-02 11:09:08', '2016-09-20 06:43:39', 1, 28, 16, 4),
(124, 'Jacket Hoodie', '2016-08-02 11:09:08', '2016-09-20 06:43:39', 1, 28, 16, 8),
(125, 'Jacket Hoodie', '2016-08-02 11:09:08', '2016-09-20 06:43:39', 1, 28, 16, 12),
(126, 'Jacket Hoodie', '2016-08-02 11:09:08', '2016-09-20 06:43:39', 1, 28, 16, 15),
(127, '', '2016-08-02 11:09:08', '2016-09-20 06:43:39', 1, 28, 16, 17),
(128, '', '2016-08-02 11:09:08', '2016-09-20 06:43:39', 1, 28, 16, 19),
(129, 'Coat', '2016-08-02 11:09:34', '2016-09-29 09:10:33', 1, 25, 17, 1),
(130, 'Abric', '2016-08-02 11:09:34', '2016-09-29 09:10:33', 1, 25, 17, 2),
(131, 'Abrigo', '2016-08-02 11:09:34', '2016-09-29 09:10:33', 1, 25, 17, 4),
(132, 'Coat', '2016-08-02 11:09:34', '2016-09-29 09:10:33', 1, 25, 17, 8),
(133, 'Coat', '2016-08-02 11:09:34', '2016-09-29 09:10:33', 1, 25, 17, 12),
(134, 'Coat', '2016-08-02 11:09:34', '2016-09-29 09:10:33', 1, 25, 17, 15),
(135, 'Coat', '2016-08-02 11:09:34', '2016-09-29 09:10:33', 1, 25, 17, 17),
(136, 'Coat', '2016-08-02 11:09:34', '2016-09-29 09:10:33', 1, 25, 17, 19),
(137, 'Skinsuit', '2016-08-02 11:09:50', '2016-09-29 09:11:55', 1, 25, 18, 1),
(138, 'Monos / Vestits arrapats', '2016-08-02 11:09:50', '2016-09-29 09:11:55', 1, 25, 18, 2),
(139, 'Monos / Trajes ceñidos', '2016-08-02 11:09:50', '2016-09-29 09:11:55', 1, 25, 18, 4),
(140, 'Skinsuits', '2016-08-02 11:09:50', '2016-09-29 09:11:55', 1, 25, 18, 8),
(141, 'Skinsuits', '2016-08-02 11:09:50', '2016-09-29 09:11:55', 1, 25, 18, 12),
(142, 'Skinsuits', '2016-08-02 11:09:50', '2016-09-29 09:11:55', 1, 25, 18, 15),
(143, 'Skinsuit', '2016-08-02 11:09:50', '2016-09-29 09:11:55', 1, 25, 18, 17),
(144, 'Skinsuit', '2016-08-02 11:09:50', '2016-09-29 09:11:55', 1, 25, 18, 19),
(145, 'Towel', '2016-08-02 11:10:05', '2016-09-29 09:01:34', 1, 25, 19, 1),
(146, 'Tovallola', '2016-08-02 11:10:05', '2016-09-29 09:01:34', 1, 25, 19, 2),
(147, 'Toalla', '2016-08-02 11:10:05', '2016-09-29 09:01:34', 1, 25, 19, 4),
(148, 'khăn tắm', '2016-08-02 11:10:05', '2016-09-29 09:01:34', 1, 25, 19, 8),
(149, 'Towel', '2016-08-02 11:10:05', '2016-09-29 09:01:34', 1, 25, 19, 12),
(150, 'Towel', '2016-08-02 11:10:05', '2016-09-29 09:01:34', 1, 25, 19, 15),
(151, 'Towel', '2016-08-02 11:10:05', '2016-09-29 09:01:34', 1, 25, 19, 17),
(152, 'Towel', '2016-08-02 11:10:05', '2016-09-29 09:01:34', 1, 25, 19, 19),
(153, 'Bibs', '2016-08-02 11:10:16', '2016-10-04 16:39:32', 1, 1, 20, 1),
(154, 'Peto', '2016-08-02 11:10:16', '2016-10-04 16:39:32', 1, 1, 20, 2),
(155, 'Peto', '2016-08-02 11:10:16', '2016-10-04 16:39:32', 1, 1, 20, 4),
(156, 'Bibs', '2016-08-02 11:10:16', '2016-10-04 16:39:32', 1, 1, 20, 8),
(157, 'Bibs', '2016-08-02 11:10:16', '2016-10-04 16:39:32', 1, 1, 20, 12),
(158, 'Bibs', '2016-08-02 11:10:16', '2016-10-04 16:39:32', 1, 1, 20, 15),
(159, 'Bibs', '2016-08-02 11:10:16', '2016-10-04 16:39:32', 1, 1, 20, 17),
(160, 'Bibs', '2016-08-02 11:10:16', '2016-10-04 16:39:32', 1, 1, 20, 19),
(161, 'Windstopper Sleeveless', '2016-08-02 11:10:29', '2016-09-29 09:40:12', 1, 25, 21, 1),
(162, 'Xaleco Paravents', '2016-08-02 11:10:29', '2016-09-29 09:40:12', 1, 25, 21, 2),
(163, 'Chaleco Paravientos', '2016-08-02 11:10:29', '2016-09-29 09:40:12', 1, 25, 21, 4),
(164, 'Windstopper Sleeveless', '2016-08-02 11:10:29', '2016-09-29 09:40:12', 1, 25, 21, 8),
(165, 'Windstopper Sleeveless', '2016-08-02 11:10:29', '2016-09-29 09:40:12', 1, 25, 21, 12),
(166, 'Windstopper Sleeveless', '2016-08-02 11:10:29', '2016-09-29 09:40:12', 1, 25, 21, 15),
(167, 'Windstopper Sleeveless', '2016-08-02 11:10:29', '2016-09-29 09:40:12', 1, 25, 21, 17),
(168, 'Windstopper Sleeveless', '2016-08-02 11:10:29', '2016-09-29 09:40:12', 1, 25, 21, 19),
(305, 'T-Shirt', '2016-09-23 13:03:54', '2016-09-23 13:04:09', 24, 24, 39, 1),
(306, 'T-Shirt', '2016-09-23 13:03:54', '2016-09-23 13:04:09', 24, 24, 39, 2),
(307, 'T-Shirt', '2016-09-23 13:03:54', '2016-09-23 13:04:09', 24, 24, 39, 4),
(308, 'T-Shirt', '2016-09-23 13:03:54', '2016-09-23 13:04:09', 24, 24, 39, 8),
(309, 'T-Shirt', '2016-09-23 13:03:54', '2016-09-23 13:04:09', 24, 24, 39, 12),
(310, 'T-Shirt', '2016-09-23 13:03:54', '2016-09-23 13:04:09', 24, 24, 39, 15),
(311, 'T-Shirt', '2016-09-23 13:03:54', '2016-09-23 13:04:09', 24, 24, 39, 17),
(312, 'T-Shirt', '2016-09-23 13:03:54', '2016-09-23 13:04:09', 24, 24, 39, 19),
(329, 'Buff', '2016-09-29 09:01:58', '2016-09-29 09:01:58', 25, 25, 42, 1),
(330, 'Buff', '2016-09-29 09:01:58', '2016-09-29 09:01:58', 25, 25, 42, 2),
(331, 'Buff', '2016-09-29 09:01:58', '2016-09-29 09:01:58', 25, 25, 42, 4),
(332, 'Buff', '2016-09-29 09:01:58', '2016-09-29 09:01:58', 25, 25, 42, 8),
(333, 'Buff', '2016-09-29 09:01:58', '2016-09-29 09:01:58', 25, 25, 42, 12),
(334, 'Buff', '2016-09-29 09:01:58', '2016-09-29 09:01:58', 25, 25, 42, 15),
(335, 'Buff', '2016-09-29 09:01:58', '2016-09-29 09:01:58', 25, 25, 42, 17),
(336, 'Buff', '2016-09-29 09:01:58', '2016-09-29 09:01:58', 25, 25, 42, 19),
(337, 'Compressors', '2016-09-29 09:02:27', '2016-10-04 16:39:37', 25, 1, 43, 1),
(338, 'Compressors', '2016-09-29 09:02:27', '2016-10-04 16:39:37', 25, 1, 43, 2),
(339, 'Compresores', '2016-09-29 09:02:27', '2016-10-04 16:39:37', 25, 1, 43, 4),
(340, 'Compressors', '2016-09-29 09:02:27', '2016-10-04 16:39:37', 25, 1, 43, 8),
(341, 'Compressors', '2016-09-29 09:02:27', '2016-10-04 16:39:37', 25, 1, 43, 12),
(342, 'Compressors', '2016-09-29 09:02:27', '2016-10-04 16:39:37', 25, 1, 43, 15),
(343, 'Compressors', '2016-09-29 09:02:27', '2016-10-04 16:39:37', 25, 1, 43, 17),
(344, 'Compressors', '2016-09-29 09:02:27', '2016-10-04 16:39:37', 25, 1, 43, 19),
(345, 'Sun Protector / Warmer', '2016-09-29 09:42:02', '2016-09-29 09:42:02', 25, 25, 44, 1),
(346, 'Protector solar / Escalfador', '2016-09-29 09:42:02', '2016-09-29 09:42:02', 25, 25, 44, 2),
(347, 'Protector solar / Calentadores', '2016-09-29 09:42:02', '2016-09-29 09:42:02', 25, 25, 44, 4),
(348, 'Sun Protector / Warmer', '2016-09-29 09:42:02', '2016-09-29 09:42:02', 25, 25, 44, 8),
(349, 'Sun Protector / Warmer', '2016-09-29 09:42:02', '2016-09-29 09:42:02', 25, 25, 44, 12),
(350, 'Sun Protector / Warmer', '2016-09-29 09:42:02', '2016-09-29 09:42:02', 25, 25, 44, 15),
(351, 'Sun Protector / Warmer', '2016-09-29 09:42:02', '2016-09-29 09:42:02', 25, 25, 44, 17),
(352, 'Sun Protector / Warmer', '2016-09-29 09:42:02', '2016-09-29 09:42:02', 25, 25, 44, 19),
(353, 'Backpack', '2016-09-29 09:42:40', '2016-09-29 09:42:40', 25, 25, 45, 1),
(354, 'Motxilla', '2016-09-29 09:42:40', '2016-09-29 09:42:40', 25, 25, 45, 2),
(355, 'Mochila', '2016-09-29 09:42:40', '2016-09-29 09:42:40', 25, 25, 45, 4),
(356, 'Backpack', '2016-09-29 09:42:40', '2016-09-29 09:42:40', 25, 25, 45, 8),
(357, 'Backpack', '2016-09-29 09:42:40', '2016-09-29 09:42:40', 25, 25, 45, 12),
(358, 'Backpack', '2016-09-29 09:42:40', '2016-09-29 09:42:40', 25, 25, 45, 15),
(359, 'Backpack', '2016-09-29 09:42:40', '2016-09-29 09:42:40', 25, 25, 45, 17),
(360, 'Backpack', '2016-09-29 09:42:40', '2016-09-29 09:42:40', 25, 25, 45, 19),
(361, 'Soft Bag', '2016-09-29 09:43:23', '2016-09-29 09:43:23', 25, 25, 46, 1),
(362, 'Bossa cordons', '2016-09-29 09:43:23', '2016-09-29 09:43:23', 25, 25, 46, 2),
(363, 'Bolsa cordones', '2016-09-29 09:43:23', '2016-09-29 09:43:23', 25, 25, 46, 4),
(364, 'Soft Bag', '2016-09-29 09:43:23', '2016-09-29 09:43:23', 25, 25, 46, 8),
(365, 'Soft Bag', '2016-09-29 09:43:23', '2016-09-29 09:43:23', 25, 25, 46, 12),
(366, 'Soft Bag', '2016-09-29 09:43:23', '2016-09-29 09:43:23', 25, 25, 46, 15),
(367, 'Soft Bag', '2016-09-29 09:43:23', '2016-09-29 09:43:23', 25, 25, 46, 17),
(368, 'Soft Bag', '2016-09-29 09:43:23', '2016-09-29 09:43:23', 25, 25, 46, 19),
(369, 'Blanket', '2016-09-29 09:45:00', '2016-10-04 16:39:49', 25, 1, 47, 1),
(370, 'Manta', '2016-09-29 09:45:00', '2016-10-04 16:39:49', 25, 1, 47, 2),
(371, 'Manta', '2016-09-29 09:45:00', '2016-10-04 16:39:49', 25, 1, 47, 4),
(372, 'Blanket', '2016-09-29 09:45:00', '2016-10-04 16:39:49', 25, 1, 47, 8),
(373, 'Blanket', '2016-09-29 09:45:00', '2016-10-04 16:39:49', 25, 1, 47, 12),
(374, 'Blanket', '2016-09-29 09:45:00', '2016-10-04 16:39:49', 25, 1, 47, 15),
(375, 'Blanket', '2016-09-29 09:45:00', '2016-10-04 16:39:49', 25, 1, 47, 17),
(376, 'Blanket', '2016-09-29 09:45:00', '2016-10-04 16:39:49', 25, 1, 47, 19),
(377, 'Accessories Hockey', '2016-09-29 09:45:54', '2016-09-29 09:45:54', 25, 25, 48, 1),
(378, 'Accessoris Hoquei', '2016-09-29 09:45:54', '2016-09-29 09:45:54', 25, 25, 48, 2),
(379, 'Accesorios Hoquei', '2016-09-29 09:45:54', '2016-09-29 09:45:54', 25, 25, 48, 4),
(380, 'Accessories Hockey', '2016-09-29 09:45:54', '2016-09-29 09:45:54', 25, 25, 48, 8),
(381, 'Accessories Hockey', '2016-09-29 09:45:54', '2016-09-29 09:45:54', 25, 25, 48, 12),
(382, 'Accessories Hockey', '2016-09-29 09:45:54', '2016-09-29 09:45:54', 25, 25, 48, 15),
(383, 'Accessories Hockey', '2016-09-29 09:45:54', '2016-09-29 09:45:54', 25, 25, 48, 17),
(384, 'Accessories Hockey', '2016-09-29 09:45:54', '2016-09-29 09:45:54', 25, 25, 48, 19),
(385, 'T-Shirt Pro', '2016-09-29 09:46:56', '2016-09-29 09:46:56', 25, 25, 49, 1),
(386, 'Camiseta Pro', '2016-09-29 09:46:56', '2016-09-29 09:46:56', 25, 25, 49, 2),
(387, 'Camiseta Pro', '2016-09-29 09:46:56', '2016-09-29 09:46:56', 25, 25, 49, 4),
(388, 'T-Shirt Pro', '2016-09-29 09:46:56', '2016-09-29 09:46:56', 25, 25, 49, 8),
(389, 'T-Shirt Pro', '2016-09-29 09:46:56', '2016-09-29 09:46:56', 25, 25, 49, 12),
(390, 'T-Shirt Pro', '2016-09-29 09:46:56', '2016-09-29 09:46:56', 25, 25, 49, 15),
(391, 'T-Shirt Pro', '2016-09-29 09:46:56', '2016-09-29 09:46:56', 25, 25, 49, 17),
(392, 'T-Shirt Pro', '2016-09-29 09:46:56', '2016-09-29 09:46:56', 25, 25, 49, 19),
(393, 'T-Shirt Ultra', '2016-09-29 09:48:52', '2016-09-29 09:48:52', 25, 25, 50, 1),
(394, 'Camiseta Ultra', '2016-09-29 09:48:52', '2016-09-29 09:48:52', 25, 25, 50, 2),
(395, 'Camiseta Ultra', '2016-09-29 09:48:52', '2016-09-29 09:48:52', 25, 25, 50, 4),
(396, 'T-Shirt Ultra', '2016-09-29 09:48:52', '2016-09-29 09:48:52', 25, 25, 50, 8),
(397, 'T-Shirt Ultra', '2016-09-29 09:48:52', '2016-09-29 09:48:52', 25, 25, 50, 12),
(398, 'T-Shirt Ultra', '2016-09-29 09:48:52', '2016-09-29 09:48:52', 25, 25, 50, 15),
(399, 'T-Shirt Ultra', '2016-09-29 09:48:52', '2016-09-29 09:48:52', 25, 25, 50, 17),
(400, 'T-Shirt Ultra', '2016-09-29 09:48:52', '2016-09-29 09:48:52', 25, 25, 50, 19),
(401, 'T-Shirt Reversible', '2016-09-29 09:49:22', '2016-09-29 09:49:22', 25, 25, 51, 1),
(402, 'Camiseta Reversible', '2016-09-29 09:49:22', '2016-09-29 09:49:22', 25, 25, 51, 2),
(403, 'Camiseta Reversible', '2016-09-29 09:49:22', '2016-09-29 09:49:22', 25, 25, 51, 4),
(404, 'T-Shirt Reversible', '2016-09-29 09:49:22', '2016-09-29 09:49:22', 25, 25, 51, 8),
(405, 'T-Shirt Reversible', '2016-09-29 09:49:22', '2016-09-29 09:49:22', 25, 25, 51, 12),
(406, 'T-Shirt Reversible', '2016-09-29 09:49:22', '2016-09-29 09:49:22', 25, 25, 51, 15),
(407, 'T-Shirt Reversible', '2016-09-29 09:49:22', '2016-09-29 09:49:22', 25, 25, 51, 17),
(408, 'T-Shirt Reversible', '2016-09-29 09:49:22', '2016-09-29 09:49:22', 25, 25, 51, 19),
(409, 'Singlet Basic', '2016-09-29 09:50:52', '2016-09-29 09:50:52', 25, 25, 52, 1),
(410, 'Camiseta Tirants Bàsica', '2016-09-29 09:50:52', '2016-09-29 09:50:52', 25, 25, 52, 2),
(411, 'Camiseta Tirantes Básica', '2016-09-29 09:50:52', '2016-09-29 09:50:52', 25, 25, 52, 4),
(412, 'Singlet Basic', '2016-09-29 09:50:52', '2016-09-29 09:50:52', 25, 25, 52, 8),
(413, 'Singlet Basic', '2016-09-29 09:50:52', '2016-09-29 09:50:52', 25, 25, 52, 12),
(414, 'Singlet Basic', '2016-09-29 09:50:52', '2016-09-29 09:50:52', 25, 25, 52, 15),
(415, 'Singlet Basic', '2016-09-29 09:50:52', '2016-09-29 09:50:52', 25, 25, 52, 17),
(416, 'Singlet Basic', '2016-09-29 09:50:52', '2016-09-29 09:50:52', 25, 25, 52, 19),
(417, 'Singlet Pro', '2016-09-29 09:51:29', '2016-09-29 09:51:29', 25, 25, 53, 1),
(418, 'Camiseta Tirants Pro', '2016-09-29 09:51:29', '2016-09-29 09:51:29', 25, 25, 53, 2),
(419, 'Camiseta Tirantes Pro', '2016-09-29 09:51:29', '2016-09-29 09:51:29', 25, 25, 53, 4),
(420, 'Singlet Pro', '2016-09-29 09:51:29', '2016-09-29 09:51:29', 25, 25, 53, 8),
(421, 'Singlet Pro', '2016-09-29 09:51:29', '2016-09-29 09:51:29', 25, 25, 53, 12),
(422, 'Singlet Pro', '2016-09-29 09:51:29', '2016-09-29 09:51:29', 25, 25, 53, 15),
(423, 'Singlet Pro', '2016-09-29 09:51:29', '2016-09-29 09:51:29', 25, 25, 53, 17),
(424, 'Singlet Pro', '2016-09-29 09:51:29', '2016-09-29 09:51:29', 25, 25, 53, 19),
(425, 'Singlet Reversible', '2016-09-29 09:52:11', '2016-09-29 09:52:11', 25, 25, 54, 1),
(426, 'Camiseta Tirants Reversible', '2016-09-29 09:52:11', '2016-09-29 09:52:11', 25, 25, 54, 2),
(427, 'Camiseta Tirantes Reversible', '2016-09-29 09:52:11', '2016-09-29 09:52:11', 25, 25, 54, 4),
(428, 'Singlet Reversible', '2016-09-29 09:52:11', '2016-09-29 09:52:11', 25, 25, 54, 8),
(429, 'Singlet Reversible', '2016-09-29 09:52:11', '2016-09-29 09:52:11', 25, 25, 54, 12),
(430, 'Singlet Reversible', '2016-09-29 09:52:11', '2016-09-29 09:52:11', 25, 25, 54, 15),
(431, 'Singlet Reversible', '2016-09-29 09:52:11', '2016-09-29 09:52:11', 25, 25, 54, 17),
(432, 'Singlet Reversible', '2016-09-29 09:52:11', '2016-09-29 09:52:11', 25, 25, 54, 19),
(433, 'Tank Top', '2016-09-29 09:52:44', '2016-09-29 09:52:44', 25, 25, 55, 1),
(434, 'Top', '2016-09-29 09:52:44', '2016-09-29 09:52:44', 25, 25, 55, 2),
(435, 'Top', '2016-09-29 09:52:44', '2016-09-29 09:52:44', 25, 25, 55, 4),
(436, 'Tank Top', '2016-09-29 09:52:44', '2016-09-29 09:52:44', 25, 25, 55, 8),
(437, 'Tank Top', '2016-09-29 09:52:44', '2016-09-29 09:52:44', 25, 25, 55, 12),
(438, 'Tank Top', '2016-09-29 09:52:44', '2016-09-29 09:52:44', 25, 25, 55, 15),
(439, 'Tank Top', '2016-09-29 09:52:44', '2016-09-29 09:52:44', 25, 25, 55, 17),
(440, 'Tank Top', '2016-09-29 09:52:44', '2016-09-29 09:52:44', 25, 25, 55, 19),
(441, 'Parka', '2016-09-29 09:54:05', '2016-09-29 09:54:05', 25, 25, 56, 1),
(442, 'Parka', '2016-09-29 09:54:05', '2016-09-29 09:54:05', 25, 25, 56, 2),
(443, 'Parka', '2016-09-29 09:54:05', '2016-09-29 09:54:05', 25, 25, 56, 4),
(444, 'Parka', '2016-09-29 09:54:05', '2016-09-29 09:54:05', 25, 25, 56, 8),
(445, 'Parka', '2016-09-29 09:54:05', '2016-09-29 09:54:05', 25, 25, 56, 12),
(446, 'Parka', '2016-09-29 09:54:05', '2016-09-29 09:54:05', 25, 25, 56, 15),
(447, 'Parka', '2016-09-29 09:54:05', '2016-09-29 09:54:05', 25, 25, 56, 17),
(448, 'Parka', '2016-09-29 09:54:05', '2016-09-29 09:54:05', 25, 25, 56, 19),
(449, 'Waistcoat', '2016-09-29 09:54:32', '2016-09-29 09:54:32', 25, 25, 57, 1),
(450, 'Xaleco', '2016-09-29 09:54:32', '2016-09-29 09:54:32', 25, 25, 57, 2),
(451, 'Chaleco', '2016-09-29 09:54:32', '2016-09-29 09:54:32', 25, 25, 57, 4),
(452, 'Waistcoat', '2016-09-29 09:54:32', '2016-09-29 09:54:32', 25, 25, 57, 8),
(453, 'Waistcoat', '2016-09-29 09:54:32', '2016-09-29 09:54:32', 25, 25, 57, 12),
(454, 'Waistcoat', '2016-09-29 09:54:32', '2016-09-29 09:54:32', 25, 25, 57, 15),
(455, 'Waistcoat', '2016-09-29 09:54:32', '2016-09-29 09:54:32', 25, 25, 57, 17),
(456, 'Waistcoat', '2016-09-29 09:54:32', '2016-09-29 09:54:32', 25, 25, 57, 19),
(457, 'Bathrobe', '2016-09-29 09:54:55', '2016-09-29 09:54:55', 25, 25, 58, 1),
(458, 'Barnús', '2016-09-29 09:54:55', '2016-09-29 09:54:55', 25, 25, 58, 2),
(459, 'Albornoz', '2016-09-29 09:54:55', '2016-09-29 09:54:55', 25, 25, 58, 4),
(460, 'Bathrobe', '2016-09-29 09:54:55', '2016-09-29 09:54:55', 25, 25, 58, 8),
(461, 'Bathrobe', '2016-09-29 09:54:55', '2016-09-29 09:54:55', 25, 25, 58, 12),
(462, 'Bathrobe', '2016-09-29 09:54:55', '2016-09-29 09:54:55', 25, 25, 58, 15),
(463, 'Bathrobe', '2016-09-29 09:54:55', '2016-09-29 09:54:55', 25, 25, 58, 17),
(464, 'Bathrobe', '2016-09-29 09:54:55', '2016-09-29 09:54:55', 25, 25, 58, 19),
(465, 'Triathlon Suits', '2016-09-29 09:55:44', '2016-09-29 09:55:44', 25, 25, 59, 1),
(466, 'Trajos de Triatló', '2016-09-29 09:55:44', '2016-09-29 09:55:44', 25, 25, 59, 2),
(467, 'Trajes de Tiatlón', '2016-09-29 09:55:44', '2016-09-29 09:55:44', 25, 25, 59, 4),
(468, 'Triathlon Suits', '2016-09-29 09:55:44', '2016-09-29 09:55:44', 25, 25, 59, 8),
(469, 'Triathlon Suits', '2016-09-29 09:55:44', '2016-09-29 09:55:44', 25, 25, 59, 12),
(470, 'Triathlon Suits', '2016-09-29 09:55:44', '2016-09-29 09:55:44', 25, 25, 59, 15),
(471, 'Triathlon Suits', '2016-09-29 09:55:44', '2016-09-29 09:55:44', 25, 25, 59, 17),
(472, 'Triathlon Suits', '2016-09-29 09:55:44', '2016-09-29 09:55:44', 25, 25, 59, 19),
(473, 'Swimsuits', '2016-09-29 09:56:15', '2016-09-29 09:56:15', 25, 25, 60, 1),
(474, 'Trajos de Bany', '2016-09-29 09:56:15', '2016-09-29 09:56:15', 25, 25, 60, 2),
(475, 'Trajes de Baño', '2016-09-29 09:56:15', '2016-09-29 09:56:15', 25, 25, 60, 4),
(476, 'Swimsuits', '2016-09-29 09:56:15', '2016-09-29 09:56:15', 25, 25, 60, 8),
(477, 'Swimsuits', '2016-09-29 09:56:15', '2016-09-29 09:56:15', 25, 25, 60, 12),
(478, 'Swimsuits', '2016-09-29 09:56:15', '2016-09-29 09:56:15', 25, 25, 60, 15),
(479, 'Swimsuits', '2016-09-29 09:56:15', '2016-09-29 09:56:15', 25, 25, 60, 17),
(480, 'Swimsuits', '2016-09-29 09:56:15', '2016-09-29 09:56:15', 25, 25, 60, 19),
(481, 'Bike T-Shirts', '2016-09-29 09:56:52', '2016-09-29 09:56:52', 25, 25, 61, 1),
(482, 'Mallots Bicicleta', '2016-09-29 09:56:52', '2016-09-29 09:56:52', 25, 25, 61, 2),
(483, 'Mallots Bicicleta', '2016-09-29 09:56:52', '2016-09-29 09:56:52', 25, 25, 61, 4),
(484, 'Bike T-Shirts', '2016-09-29 09:56:52', '2016-09-29 09:56:52', 25, 25, 61, 8),
(485, 'Bike T-Shirts', '2016-09-29 09:56:52', '2016-09-29 09:56:52', 25, 25, 61, 12),
(486, 'Bike T-Shirts', '2016-09-29 09:56:52', '2016-09-29 09:56:52', 25, 25, 61, 15),
(487, 'Bike T-Shirts', '2016-09-29 09:56:52', '2016-09-29 09:56:52', 25, 25, 61, 17),
(488, 'Bike T-Shirts', '2016-09-29 09:56:52', '2016-09-29 09:56:52', 25, 25, 61, 19),
(489, 'Bike Pants', '2016-09-29 09:57:20', '2016-09-29 09:57:20', 25, 25, 62, 1),
(490, 'Pantalons de Bicicleta', '2016-09-29 09:57:20', '2016-09-29 09:57:20', 25, 25, 62, 2),
(491, 'Pantalones de Bicicleta', '2016-09-29 09:57:20', '2016-09-29 09:57:20', 25, 25, 62, 4),
(492, 'Bike Pants', '2016-09-29 09:57:20', '2016-09-29 09:57:20', 25, 25, 62, 8),
(493, 'Bike Pants', '2016-09-29 09:57:20', '2016-09-29 09:57:20', 25, 25, 62, 12),
(494, 'Bike Pants', '2016-09-29 09:57:20', '2016-09-29 09:57:20', 25, 25, 62, 15),
(495, 'Bike Pants', '2016-09-29 09:57:20', '2016-09-29 09:57:20', 25, 25, 62, 17),
(496, 'Bike Pants', '2016-09-29 09:57:20', '2016-09-29 09:57:20', 25, 25, 62, 19),
(497, 'Windstopper Long Sleeves', '2016-09-29 09:58:18', '2016-09-29 09:58:18', 25, 25, 63, 1),
(498, 'Windstopper Màniga Llarga', '2016-09-29 09:58:18', '2016-09-29 09:58:18', 25, 25, 63, 2),
(499, 'Windstopper Manga Larga', '2016-09-29 09:58:18', '2016-09-29 09:58:18', 25, 25, 63, 4),
(500, 'Windstopper Long Sleeves', '2016-09-29 09:58:18', '2016-09-29 09:58:18', 25, 25, 63, 8),
(501, 'Windstopper Long Sleeves', '2016-09-29 09:58:18', '2016-09-29 09:58:18', 25, 25, 63, 12),
(502, 'Windstopper Long Sleeves', '2016-09-29 09:58:18', '2016-09-29 09:58:18', 25, 25, 63, 15),
(503, 'Windstopper Long Sleeves', '2016-09-29 09:58:18', '2016-09-29 09:58:18', 25, 25, 63, 17),
(504, 'Windstopper Long Sleeves', '2016-09-29 09:58:18', '2016-09-29 09:58:18', 25, 25, 63, 19),
(521, 'Customization', '2016-10-12 14:38:22', '2016-10-12 14:38:22', 25, 25, 66, 1),
(522, 'Personalització', '2016-10-12 14:38:22', '2016-10-12 14:38:22', 25, 25, 66, 2),
(523, 'Personalización', '2016-10-12 14:38:22', '2016-10-12 14:38:22', 25, 25, 66, 4),
(524, 'Customization', '2016-10-12 14:38:22', '2016-10-12 14:38:22', 25, 25, 66, 8),
(525, 'Customization', '2016-10-12 14:38:22', '2016-10-12 14:38:22', 25, 25, 66, 12),
(526, 'Customization', '2016-10-12 14:38:22', '2016-10-12 14:38:22', 25, 25, 66, 15),
(527, 'Customization', '2016-10-12 14:38:22', '2016-10-12 14:38:22', 25, 25, 66, 17),
(528, 'Customization', '2016-10-12 14:38:22', '2016-10-12 14:38:22', 25, 25, 66, 19);

-- --------------------------------------------------------

--
-- Table structure for table `incoterm`
--

CREATE TABLE IF NOT EXISTS `incoterm` (
  `id_incoterm` int(11) NOT NULL,
  `ict_code` varchar(255) DEFAULT NULL,
  `ict_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE IF NOT EXISTS `languages` (
  `id_language` int(11) NOT NULL,
  `lg_code` varchar(255) DEFAULT NULL,
  `lg_name` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id_language`, `lg_code`, `lg_name`, `created`, `updated`, `id_user_created`, `id_user_updated`) VALUES
(1, 'ENG', 'English', '2016-06-14 16:07:20', NULL, NULL, NULL),
(2, 'CAT', 'Català', '2016-06-14 16:07:20', '2016-09-06 11:36:43', NULL, 1),
(4, 'SP', 'Spanish', '2016-06-14 16:07:20', '2016-09-06 11:39:15', NULL, 1),
(8, 'VN', 'Vietnamese', '2016-06-14 16:07:20', '2016-09-06 11:40:22', NULL, 1),
(12, 'FR', 'French', '2016-06-14 16:07:20', '2016-09-06 11:40:36', NULL, 1),
(15, 'GM', 'German', '2016-06-14 16:07:20', '2016-09-06 11:40:49', NULL, 1),
(17, '007', '007', '2016-06-14 16:07:20', '2016-09-06 11:39:43', NULL, 1),
(19, '008', '008', '2016-06-14 16:07:20', '2016-09-06 11:39:55', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `materials`
--

CREATE TABLE IF NOT EXISTS `materials` (
  `Id_mat` int(11) NOT NULL,
  `mat_code` varchar(255) DEFAULT NULL,
  `mat_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `id_unit` varchar(255) DEFAULT NULL,
  `mat_price` varchar(255) DEFAULT NULL,
  `mat_date` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_group_mat` int(11) DEFAULT NULL,
  `id_Factory` int(11) DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `id_order` int(11) NOT NULL,
  `ord_date` datetime DEFAULT NULL,
  `ord_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `ord_units` double DEFAULT NULL,
  `ord_fty_del_date` datetime DEFAULT NULL,
  `ord_fty_delivered` double DEFAULT NULL,
  `ord_fty_value` double DEFAULT NULL,
  `ord_fty_confirm` datetime DEFAULT NULL,
  `ord_zone_del_date` datetime DEFAULT NULL,
  `ord_zone_delivered` double DEFAULT NULL,
  `ord_zone_value` double DEFAULT NULL,
  `ord_zone_confirm` datetime DEFAULT NULL,
  `ord_ag_del_date` datetime DEFAULT NULL,
  `ord_ag_commission` int(11) DEFAULT NULL,
  `ord_discount_1` int(11) DEFAULT NULL,
  `ord_discount_2` int(11) DEFAULT NULL,
  `ord_ag_delivered` double DEFAULT NULL,
  `ord_ag_value` double DEFAULT NULL,
  `ord_ag_value_dsc1` double DEFAULT NULL,
  `ord_ag_value_dsc2` double DEFAULT NULL,
  `id_customer` int(11) DEFAULT NULL,
  `ord_plf` int(11) DEFAULT NULL,
  `ord_plz` int(11) DEFAULT NULL,
  `id_order_type` int(11) DEFAULT NULL,
  `id_order_condition` int(11) DEFAULT NULL,
  `id_payment` int(11) DEFAULT NULL,
  `id_order_status` int(11) DEFAULT NULL,
  `offer` longtext
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id_order`, `ord_date`, `ord_description`, `ord_units`, `ord_fty_del_date`, `ord_fty_delivered`, `ord_fty_value`, `ord_fty_confirm`, `ord_zone_del_date`, `ord_zone_delivered`, `ord_zone_value`, `ord_zone_confirm`, `ord_ag_del_date`, `ord_ag_commission`, `ord_discount_1`, `ord_discount_2`, `ord_ag_delivered`, `ord_ag_value`, `ord_ag_value_dsc1`, `ord_ag_value_dsc2`, `id_customer`, `ord_plf`, `ord_plz`, `id_order_type`, `id_order_condition`, `id_payment`, `id_order_status`, `offer`) VALUES
(1, '2016-10-30 20:38:16', '', NULL, NULL, 0, 0, NULL, NULL, 0, 0, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 10, 13, 5, 1, 1, 1, 1, ''),
(2, '2016-11-01 10:09:42', 'second order', NULL, NULL, 0, 0, NULL, NULL, 0, 0, NULL, NULL, NULL, 10, 10, 0, 0, 0, 0, 10, 13, 5, 1, 1, 1, 3, '');

-- --------------------------------------------------------

--
-- Table structure for table `order_condition`
--

CREATE TABLE IF NOT EXISTS `order_condition` (
  `id_order_condition` int(11) NOT NULL,
  `oc_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `order_condition`
--

INSERT INTO `order_condition` (`id_order_condition`, `oc_description`) VALUES
(1, 'Direct'),
(2, 'Agent'),
(3, 'Dealer');

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE IF NOT EXISTS `order_details` (
  `id_order_det` int(11) NOT NULL,
  `ordd_cg_name` varchar(255) DEFAULT NULL,
  `ordd_line` varchar(255) DEFAULT NULL,
  `ordd_name` varchar(255) DEFAULT NULL,
  `ordd_number` varchar(255) DEFAULT NULL,
  `ordd_qtty` double DEFAULT NULL,
  `ordd_fty_pr` double DEFAULT NULL,
  `ordd_zone_pr` double DEFAULT NULL,
  `ordd_ag_pr` double DEFAULT NULL,
  `ordd_fty_tot` double DEFAULT NULL,
  `ordd_zone_tot` double DEFAULT NULL,
  `ordd_ag_tot` double DEFAULT NULL,
  `ordd_del_fty` double DEFAULT NULL,
  `ordd_del_zone` double DEFAULT NULL,
  `ordd_del_ag` double DEFAULT NULL,
  `id_size_det` int(11) DEFAULT NULL,
  `id_order` int(11) DEFAULT NULL,
  `id_product` int(11) DEFAULT NULL,
  `ordd_rcv_zone` double DEFAULT NULL,
  `ordd_rcv_ag` double DEFAULT NULL,
  `ordd_rcv_cs` double DEFAULT NULL,
  `ordd_rcv_pr` double DEFAULT NULL,
  `ordd_size_custom` bit(1) DEFAULT NULL,
  `ordd_pricelist` longtext
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id_order_det`, `ordd_cg_name`, `ordd_line`, `ordd_name`, `ordd_number`, `ordd_qtty`, `ordd_fty_pr`, `ordd_zone_pr`, `ordd_ag_pr`, `ordd_fty_tot`, `ordd_zone_tot`, `ordd_ag_tot`, `ordd_del_fty`, `ordd_del_zone`, `ordd_del_ag`, `id_size_det`, `id_order`, `id_product`, `ordd_rcv_zone`, `ordd_rcv_ag`, `ordd_rcv_cs`, `ordd_rcv_pr`, `ordd_size_custom`, `ordd_pricelist`) VALUES
(1, '', NULL, 'steven', '18', 12, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 87, 1, 3, NULL, NULL, NULL, NULL, b'1', '{"priceList":{"factory":7.61,"agent":15.81,"zone":12.65},"order":{"factory":8.4,"agent":18.9,"zone":14.7},"hasContract":true,"manual":{"factory":8,"agent":18,"zone":14},"total":{"factory":8.4,"agent":18.9,"zone":14.7},"custom":{"factory":0,"agent":0,"zone":0},"grandTotal":{"factory":0,"agent":0,"zone":0},"isContractExpired":false}'),
(2, 'Junior', NULL, 'xevi', '18', 12, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 87, 2, 3, NULL, NULL, NULL, NULL, b'1', '{"priceList":{"factory":7.61,"agent":15.81,"zone":12.65},"order":{"factory":8.4,"agent":18.9,"zone":14.7},"hasContract":true,"manual":{"factory":8,"agent":18,"zone":14},"total":{"factory":8.4,"agent":18.9,"zone":14.7},"custom":{"factory":0,"agent":0,"zone":0},"grandTotal":{"factory":0,"agent":0,"zone":0},"isContractExpired":false}'),
(3, '', NULL, NULL, NULL, 4, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 91, 2, 3, NULL, NULL, NULL, NULL, b'0', '{"priceList":{"factory":7.61,"agent":15.81,"zone":12.65},"order":{"factory":8.4,"agent":18.9,"zone":14.7},"hasContract":true,"manual":{"factory":8,"agent":18,"zone":14},"total":{"factory":8.4,"agent":18.9,"zone":14.7},"custom":{"factory":0,"agent":0,"zone":0},"grandTotal":{"factory":0,"agent":0,"zone":0},"isContractExpired":false}'),
(4, '', NULL, NULL, NULL, 6, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 92, 2, 3, NULL, NULL, NULL, NULL, b'0', '{"priceList":{"factory":7.61,"agent":15.81,"zone":12.65},"order":{"factory":8.4,"agent":18.9,"zone":14.7},"hasContract":true,"manual":{"factory":8,"agent":18,"zone":14},"total":{"factory":8.4,"agent":18.9,"zone":14.7},"custom":{"factory":0,"agent":0,"zone":0},"grandTotal":{"factory":0,"agent":0,"zone":0},"isContractExpired":false}'),
(5, '', NULL, NULL, NULL, 3, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 93, 2, 3, NULL, NULL, NULL, NULL, b'0', '{"priceList":{"factory":7.61,"agent":15.81,"zone":12.65},"order":{"factory":8.4,"agent":18.9,"zone":14.7},"hasContract":true,"manual":{"factory":8,"agent":18,"zone":14},"total":{"factory":8.4,"agent":18.9,"zone":14.7},"custom":{"factory":0,"agent":0,"zone":0},"grandTotal":{"factory":0,"agent":0,"zone":0},"isContractExpired":false}'),
(6, '', NULL, NULL, NULL, 2, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 92, 2, 15, NULL, NULL, NULL, NULL, b'0', '{"priceList":{"factory":3.44,"agent":7.92,"zone":6.34},"order":{"factory":0,"agent":0,"zone":0},"hasContract":false,"manual":{"factory":0,"agent":0,"zone":0},"total":{"factory":3.44,"agent":7.92,"zone":6.34},"custom":{"factory":0,"agent":0,"zone":0},"grandTotal":{"factory":0,"agent":0,"zone":0},"isContractExpired":""}'),
(7, '', NULL, NULL, NULL, 3, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 95, 2, 15, NULL, NULL, NULL, NULL, b'0', '{"priceList":{"factory":3.44,"agent":7.92,"zone":6.34},"order":{"factory":0,"agent":0,"zone":0},"hasContract":false,"manual":{"factory":0,"agent":0,"zone":0},"total":{"factory":3.44,"agent":7.92,"zone":6.34},"custom":{"factory":0,"agent":0,"zone":0},"grandTotal":{"factory":0,"agent":0,"zone":0},"isContractExpired":""}'),
(8, '', NULL, NULL, NULL, 4, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 98, 2, 15, NULL, NULL, NULL, NULL, b'0', '{"priceList":{"factory":3.44,"agent":7.92,"zone":6.34},"order":{"factory":0,"agent":0,"zone":0},"hasContract":false,"manual":{"factory":0,"agent":0,"zone":0},"total":{"factory":3.44,"agent":7.92,"zone":6.34},"custom":{"factory":0,"agent":0,"zone":0},"grandTotal":{"factory":0,"agent":0,"zone":0},"isContractExpired":""}');

-- --------------------------------------------------------

--
-- Table structure for table `order_status`
--

CREATE TABLE IF NOT EXISTS `order_status` (
  `id_order_status` int(11) NOT NULL,
  `os_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `order_status`
--

INSERT INTO `order_status` (`id_order_status`, `os_description`) VALUES
(1, 'On delivery'),
(2, 'Delivered'),
(3, 'Open');

-- --------------------------------------------------------

--
-- Table structure for table `order_type`
--

CREATE TABLE IF NOT EXISTS `order_type` (
  `id_order_type` int(11) NOT NULL,
  `ot_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `order_type`
--

INSERT INTO `order_type` (`id_order_type`, `ot_description`) VALUES
(1, 'Regular'),
(2, 'Reposition'),
(3, 'Samples');

-- --------------------------------------------------------

--
-- Table structure for table `particular`
--

CREATE TABLE IF NOT EXISTS `particular` (
  `id_particular` int(11) NOT NULL,
  `pt_name` varchar(255) DEFAULT NULL,
  `pt_dni` longtext,
  `pt_password` longtext,
  `pt_mail` longtext,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_customer` int(11) DEFAULT NULL,
  `id_language` int(11) DEFAULT NULL,
  `id_contact` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `patterns`
--

CREATE TABLE IF NOT EXISTS `patterns` (
  `id_pattern` int(11) NOT NULL,
  `pt_code` varchar(255) DEFAULT NULL,
  `pt_date` date DEFAULT NULL,
  `pt_update` date DEFAULT NULL,
  `pt_notes` varchar(255) DEFAULT NULL,
  `pt_Sketch` varchar(255) DEFAULT NULL,
  `pt_Parts` varchar(255) DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_Factory` int(11) DEFAULT NULL,
  `id_group_products` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patterns`
--

INSERT INTO `patterns` (`id_pattern`, `pt_code`, `pt_date`, `pt_update`, `pt_notes`, `pt_Sketch`, `pt_Parts`, `id_user_created`, `id_user_updated`, `id_Factory`, `id_group_products`) VALUES
(7, '0039', '2016-06-10', '2016-10-22', 'T-shirt Ranglan Basic Cut', 'hzhzsg1f4e99atcuiny164pummvnv8.png', 'yn15dc1bxxrezdrlqv6137g4gkww2q.jpeg', 25, 25, 1, 3),
(8, '0027', '2016-06-10', '2016-10-14', 'Basic Match Pant (No master grading)', 's7virpnzinpxqan3bqb3aakm8zfse6.png', 'nuv06a3czvk1xr2dc5crp01dgwnmfd.jpeg', 25, 25, 1, 9),
(9, '0040S', '2016-10-14', '2016-10-15', 'Basket Singlet various collars,(not master grading)', 'hqpikycteykf6h5huxi3di11oai644.png', '3x92zev29gbzoageegnnfvnweokt2t.jpeg', 25, 25, 1, 52),
(10, '0040P', '2016-10-14', '2016-10-15', '(not master grading)', 't6pbvz21krcy6lz2dibhm7h1y04y2g.png', NULL, 25, 25, 1, 9),
(11, '0169J', '2016-10-14', '2016-10-17', '', 'ftc79rslpbxmh9kg021lrz4lxqkfb8.png', 'g90epnro6u66zr3z78o1sxzgmy6qkq.jpeg', 25, 25, 1, 15),
(12, '0138', '2016-10-15', '2016-10-15', '', 'agwmixeqtwcyt9e9a8rydvaoa6a9ga.png', 'nczv11pbqqpugsuzxkcf10nqrurvc7.jpeg', 25, 25, 1, 11),
(15, 'TEST', '2016-10-15', '2016-10-16', '', NULL, NULL, 25, 1, 1, 9);

-- --------------------------------------------------------

--
-- Table structure for table `pattern_description`
--

CREATE TABLE IF NOT EXISTS `pattern_description` (
  `id_pattern_des` int(11) NOT NULL,
  `pd_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_pattern` int(11) DEFAULT NULL,
  `id_language` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=225 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pattern_description`
--

INSERT INTO `pattern_description` (`id_pattern_des`, `pd_description`, `created`, `updated`, `id_user_created`, `id_user_updated`, `id_pattern`, `id_language`) VALUES
(153, 'T-shirt Ranglan Basic Cut', '2016-06-10 00:00:00', '2016-06-10 00:00:00', 25, 25, 7, 1),
(154, 'Camiseta Ranglan Tall bàsic', '2016-06-10 00:00:00', '2016-06-10 00:00:00', 25, 25, 7, 2),
(155, 'Camiseta Ranglan Corte Básico', '2016-06-10 00:00:00', '2016-06-10 00:00:00', 25, 25, 7, 4),
(156, 'T-shirt Ranglan Basic Cut', '2016-06-10 00:00:00', '2016-06-10 00:00:00', 25, 25, 7, 8),
(157, 'T-shirt Ranglan Basic Cut', '2016-06-10 00:00:00', '2016-06-10 00:00:00', 25, 25, 7, 12),
(158, 'T-shirt Ranglan Basic Cut', '2016-06-10 00:00:00', '2016-06-10 00:00:00', 25, 25, 7, 15),
(159, 'T-shirt Ranglan Basic Cut', '2016-06-10 00:00:00', '2016-06-10 00:00:00', 25, 25, 7, 17),
(160, 'T-shirt Ranglan Basic Cut', '2016-06-10 00:00:00', '2016-06-10 00:00:00', 25, 25, 7, 19),
(161, 'Basic Match Pant', '2016-06-10 00:00:00', '2016-10-14 00:00:00', 25, 25, 8, 1),
(162, 'Pantaló de joc bàsic', '2016-06-10 00:00:00', '2016-10-14 00:00:00', 25, 25, 8, 2),
(163, 'Pantalón de Juego básico', '2016-06-10 00:00:00', '2016-10-14 00:00:00', 25, 25, 8, 4),
(164, '', '2016-06-10 00:00:00', '2016-10-14 00:00:00', 25, 25, 8, 8),
(165, '', '2016-06-10 00:00:00', '2016-10-14 00:00:00', 25, 25, 8, 12),
(166, '', '2016-06-10 00:00:00', '2016-10-14 00:00:00', 25, 25, 8, 15),
(167, '', '2016-06-10 00:00:00', '2016-10-14 00:00:00', 25, 25, 8, 17),
(168, '', '2016-06-10 00:00:00', '2016-10-14 00:00:00', 25, 25, 8, 19),
(169, 'Basket Singlet', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 9, 1),
(170, 'Camiseta de Básquet', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 9, 2),
(171, 'Camiseta de Básquet', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 9, 4),
(172, 'Basket Singlet', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 9, 8),
(173, 'Basket Singlet', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 9, 12),
(174, 'Basket Singlet', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 9, 15),
(175, '', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 9, 17),
(176, '', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 9, 19),
(177, 'Basket Pant', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 10, 1),
(178, 'Pantaló de Basquet', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 10, 2),
(179, 'Pantalón de Basquet', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 10, 4),
(180, 'Basket Pant', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 10, 8),
(181, 'Basket Pant', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 10, 12),
(182, 'Basket Pant', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 10, 15),
(183, '', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 10, 17),
(184, '', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 10, 19),
(185, 'Jacket Tracksuit dropped sleeve and cuff', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 11, 1),
(186, 'Jaqueta Xandall Mániga Muntada i baixos afegits', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 11, 2),
(187, 'Chaqueta Chándal Manga Montada y bajos añadidos', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 11, 4),
(188, '', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 11, 8),
(189, '', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 11, 12),
(190, '', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 11, 15),
(191, '', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 11, 17),
(192, '', '2016-10-14 00:00:00', '2016-10-15 00:00:00', 25, 25, 11, 19),
(193, 'Tracksuit pant with side tape and diagonal pockets. Knitted fabric.', '2016-10-15 00:00:00', '2016-10-15 00:00:00', 25, 25, 12, 1),
(194, 'Pantaló xandall amb tapeta lateral i butxaques inclinades. Teixit de punt.', '2016-10-15 00:00:00', '2016-10-15 00:00:00', 25, 25, 12, 2),
(195, 'Pantalón chándal con pieza lateral y bolsillos inclinados. Tejido de punto.', '2016-10-15 00:00:00', '2016-10-15 00:00:00', 25, 25, 12, 4),
(196, 'Tracksuit pant with side tape and diagonal pockets', '2016-10-15 00:00:00', '2016-10-15 00:00:00', 25, 25, 12, 8),
(197, 'Tracksuit pant with side tape and diagonal pockets', '2016-10-15 00:00:00', '2016-10-15 00:00:00', 25, 25, 12, 12),
(198, 'Tracksuit pant with side tape and diagonal pockets', '2016-10-15 00:00:00', '2016-10-15 00:00:00', 25, 25, 12, 15),
(199, '', '2016-10-15 00:00:00', '2016-10-15 00:00:00', 25, 25, 12, 17),
(200, '', '2016-10-15 00:00:00', '2016-10-15 00:00:00', 25, 25, 12, 19),
(217, '', '2016-10-15 00:00:00', '2016-10-15 00:00:00', 25, 25, 15, 1),
(218, '', '2016-10-15 00:00:00', '2016-10-15 00:00:00', 25, 25, 15, 2),
(219, '', '2016-10-15 00:00:00', '2016-10-15 00:00:00', 25, 25, 15, 4),
(220, '', '2016-10-15 00:00:00', '2016-10-15 00:00:00', 25, 25, 15, 8),
(221, '', '2016-10-15 00:00:00', '2016-10-15 00:00:00', 25, 25, 15, 12),
(222, '', '2016-10-15 00:00:00', '2016-10-15 00:00:00', 25, 25, 15, 15),
(223, '', '2016-10-15 00:00:00', '2016-10-15 00:00:00', 25, 25, 15, 17),
(224, '', '2016-10-15 00:00:00', '2016-10-15 00:00:00', 25, 25, 15, 19);

-- --------------------------------------------------------

--
-- Table structure for table `pattern_notes`
--

CREATE TABLE IF NOT EXISTS `pattern_notes` (
  `id_pattern_note` int(11) NOT NULL,
  `pn_note` longtext,
  `pn_date` datetime DEFAULT NULL,
  `id_pattern` int(11) DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pattern_notes`
--

INSERT INTO `pattern_notes` (`id_pattern_note`, `pn_note`, `pn_date`, `id_pattern`, `id_user_created`) VALUES
(37, '<p>R collar modified&nbsp;</p>\n\n<p>test&nbsp;</p>\n\n<p><span style="color:#ff0000;"><strong><span style="font-family:Comic Sans MS,cursive;">today</span></strong></span></p>\n', '2016-10-06 11:12:06', 7, 25),
(38, '<p>Created pattern Z to test</p>\n\n<h1>OK</h1>\n\n<p><span dir="ltr" lang="es">qwe</span></p>\n\n<p>&nbsp;</p>\n', '2016-10-07 23:30:47', 7, 25);

-- --------------------------------------------------------

--
-- Table structure for table `pattern_part`
--

CREATE TABLE IF NOT EXISTS `pattern_part` (
  `id_pattern_part` int(11) NOT NULL,
  `pp_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `pp_code` longtext,
  `id_pattern` int(11) DEFAULT NULL,
  `id_language` int(11) DEFAULT NULL,
  `pp_vn` longtext CHARACTER SET utf8,
  `pp_en` longtext CHARACTER SET utf8
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pattern_part`
--

INSERT INTO `pattern_part` (`id_pattern_part`, `pp_description`, `pp_code`, `id_pattern`, `id_language`, `pp_vn`, `pp_en`) VALUES
(34, NULL, 'A', 7, NULL, '', 'Front 1pc - V neckline'),
(35, NULL, 'B', 7, NULL, '', 'Back 1pc'),
(36, NULL, 'C', 7, NULL, '', 'Sleeve 1pc'),
(37, NULL, 'D', 7, NULL, '', 'Round neckline'),
(38, NULL, 'E', 7, NULL, '', 'Polo neckline'),
(39, NULL, 'F', 7, NULL, '', 'Small V neckline'),
(41, NULL, 'H', 7, NULL, '', 'Round neckline +1.5cm'),
(42, NULL, 'I', 7, NULL, '', 'Curved bottom extension'),
(43, NULL, 'K1', 7, NULL, '', 'Front 2pcs Bottom'),
(44, NULL, 'K2', 7, NULL, '', '(L) Front 2pcs Top - V neckline'),
(45, NULL, 'N1', 7, NULL, '', 'Back 2pcs - Bottom'),
(46, NULL, 'N2', 7, NULL, '', '(O) Back 2pcs - Top'),
(47, NULL, 'M', 7, NULL, '', 'Front 2pcs - Round neckline'),
(48, NULL, 'P', 7, NULL, '', 'Polo collar'),
(49, NULL, 'R', 7, NULL, '', 'High Collar Zipper'),
(50, NULL, 'A', 8, NULL, '', 'Pant 1pc'),
(51, NULL, 'B', 8, NULL, '', 'Front Underlining'),
(52, NULL, 'C', 8, NULL, '', 'Back Underlining'),
(55, NULL, 'G', 7, NULL, '', 'Back Neck'),
(56, NULL, 'A', 9, NULL, '', 'Front 1pc V neckline'),
(57, NULL, 'B', 9, NULL, '', 'Back 1pc'),
(58, NULL, 'C', 9, NULL, '', 'Round neckline'),
(59, NULL, 'D', 9, NULL, '', 'Neck'),
(60, NULL, 'A', 10, NULL, '', 'Pant'),
(61, NULL, 'A', 11, NULL, '', 'Front 1pc'),
(62, NULL, 'B', 11, NULL, '', 'Back 1 pc'),
(63, NULL, 'C', 11, NULL, '', 'Front no shoulder'),
(64, NULL, 'D', 11, NULL, '', 'Back no shoulder'),
(65, NULL, 'E', 11, NULL, '', 'Shoulder'),
(66, NULL, 'F', 11, NULL, '', 'Facing'),
(67, NULL, 'G', 11, NULL, '', 'Pocket'),
(68, NULL, 'H', 11, NULL, '', 'Body Side 1 pc'),
(69, NULL, 'I', 11, NULL, '', 'Collar'),
(70, NULL, 'J', 11, NULL, '', 'Bottom'),
(71, NULL, 'K', 11, NULL, '', 'Sleeve side 1pc'),
(72, NULL, 'L', 11, NULL, '', 'Sleeve center'),
(73, NULL, 'M', 11, NULL, '', 'Cuff'),
(74, NULL, 'N', 11, NULL, '', 'Bottom - Body side 2 pcs'),
(75, NULL, 'O', 11, NULL, '', 'Top - Body side 2 pcs'),
(76, NULL, 'P', 11, NULL, '', 'Bottom - Sleeve side 2 pcs'),
(77, NULL, 'Q', 11, NULL, '', 'Top - Sleeve side 2 pcs'),
(78, NULL, 'A', 12, NULL, '', 'Front 1 pc'),
(79, NULL, 'B', 12, NULL, '', 'Back 1 pc'),
(80, NULL, 'C', 12, NULL, '', 'Side 2 pcs - Top'),
(81, NULL, 'D', 12, NULL, '', 'Side 2 pcs - Bottom'),
(82, NULL, 'E', 12, NULL, '', 'Side 1 pc'),
(83, NULL, 'F', 12, NULL, '', 'Front 2 pcs - Top'),
(84, NULL, 'G', 12, NULL, '', 'Back 2 pcs - Top'),
(85, NULL, 'H', 12, NULL, '', 'Front 2 pcs - Bottom'),
(86, NULL, 'I', 12, NULL, '', 'Back 2 pcs - Bottom'),
(87, NULL, 'J', 12, NULL, '', 'Front 3 pcs - Bottom'),
(88, NULL, 'K', 12, NULL, '', 'Bottom Front, zipper center back'),
(89, NULL, 'L', 12, NULL, '', 'Bottom Back, zipper centre back'),
(91, NULL, 'A', 15, NULL, '', ''),
(92, NULL, 'B-TEST', 15, NULL, '', ''),
(93, NULL, 'C-TEST', 15, NULL, '', ''),
(94, NULL, 'D-TEST', 15, NULL, '', ''),
(95, NULL, 'E-TEST', 15, NULL, '', ''),
(96, NULL, 'F-TEST', 15, NULL, '', ''),
(97, NULL, 'H-TEST', 15, NULL, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `pattern_variantions`
--

CREATE TABLE IF NOT EXISTS `pattern_variantions` (
  `id_pattern_var` int(11) NOT NULL,
  `pv_code` varchar(255) DEFAULT NULL,
  `pv_parts` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `pv_sketch` varchar(255) DEFAULT NULL,
  `id_pattern` int(11) DEFAULT NULL,
  `pv_comment` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `pattern_part` text CHARACTER SET utf8 COLLATE utf8_unicode_ci
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pattern_variantions`
--

INSERT INTO `pattern_variantions` (`id_pattern_var`, `pv_code`, `pv_parts`, `pv_sketch`, `id_pattern`, `pv_comment`, `pattern_part`) VALUES
(21, 'R', NULL, 'p8x85xfc8hxl6nyida72z64uzh13sc.png', 7, 'Basic Round Neck', '{"34":{"quantity": "1","id": 34,"code": "A"},"35":{"quantity": "1","id": 35,"code": "B"},"36": {"quantity": "1","id": 36,"code":"B"},"37":{"quantity": "1","id": 37,"code": "B"}}'),
(22, 'V', NULL, 'ai51w8g9teo06b7rn6q9yo5sg1ct5w.png', 7, 'Basic V Neck', '{"34":{"quantity":"1","id":34,"code":"Asdfsdsdf"},"35":{"quantity":"1","id":35,"code":"Bsdfsdsdf"},"36":{"quantity":"2","id":36,"code":"Csdfsdsdf"}}'),
(23, 'PB', NULL, 'ytl0ecaaw0hq7vftv90wm3in84186b.png', 7, 'Basic Polo', '{"34":{"quantity":"1","id":34,"code":"Asdfsdsdf"},"35":{"quantity":"1","id":35,"code":"Bsdfsdsdf"},"36":{"quantity":"2","id":36,"code":"Csdfsdsdf"},"38":{"quantity":"1","id":38,"code":"Esdfsdsdf"},"48":{"quantity":"1","id":48,"code":"Psdfsdsdf"}}'),
(24, 'P', NULL, 'f83wo4mraul30lfxbk3omx693krva6.png', 8, 'Basic', '{"50":{"quantity":"2","id":50,"code":"Asdfsdsdf"}}'),
(25, 'PU', NULL, 'xgsuf8ql5w4ogaf9whh5fiktqd76bq.png', 8, 'Basic with underwear', '{"50":{"quantity":"2","id":50,"code":"Asdfsdsdf"},"51":{"quantity":"1","id":51,"code":"Bsdfsdsdf"},"52":{"quantity":"1","id":52,"code":"Csdfsdsdf"}}'),
(27, 'V', NULL, 'tiqbkdyr7nf44xbien2vnmhop39sbx.png', 9, '', '{"56":{"quantity":"1","id":56,"code":"Asdfsdsdf"},"57":{"quantity":"1","id":57,"code":"Bsdfsdsdf"},"58":{"quantity":"1","id":58,"code":"Csdfsdsdf"}}'),
(28, 'R', NULL, 'n4iidf44xw2ah5a01id4wkp34f89sh.png', 9, '', '{"56":{"quantity":"1","id":56,"code":"Asdfsdsdf"},"57":{"quantity":"1","id":57,"code":"Bsdfsdsdf"},"58":{"quantity":"1","id":58,"code":"Csdfsdsdf"}}'),
(29, 'VT', NULL, 'c79nzzvqwcgm981dor5437cukhgp2s.png', 9, '', '{"56":{"quantity":"1","id":56,"code":"Asdfsdsdf"},"57":{"quantity":"1","id":57,"code":"Bsdfsdsdf"}}'),
(30, 'P', NULL, '1oph6x735skwsv674q9wd1enzvkzgn.png', 10, '', '{"60":{"quantity":"2","id":60,"code":"Asdfsdsdf"}}'),
(31, 'J', NULL, '0bqt148q7mr32uas833eydka9ytrrr.png', 11, '', '{"61":{"quantity":"2","id":61,"code":"Asdfsdsdf"},"62":{"quantity":"1","id":62,"code":"Bsdfsdsdf"},"66":{"quantity":"2","id":66,"code":"Fsdfsdsdf"},"67":{"quantity":"4","id":67,"code":"Gsdfsdsdf"},"68":{"quantity":"4","id":68,"code":"Hsdfsdsdf"},"69":{"quantity":"2","id":69,"code":"Isdfsdsdf"},"70":{"quantity":"2","id":70,"code":"Jsdfsdsdf"},"71":{"quantity":"4","id":71,"code":"Ksdfsdsdf"},"72":{"quantity":"2","id":72,"code":"Lsdfsdsdf"},"73":{"quantity":"2","id":73,"code":"Msdfsdsdf"}}'),
(32, '3PC', NULL, 'w1l3yishz86e52ri4yazecsy47uxh2.png', 12, '', '{"78":{"quantity":"2","id":78,"code":"A"},"79":{"quantity":"2","id":79,"code":"B"},"82":{"quantity":"2","id":82,"code":"E"}}'),
(33, '3PCZ', NULL, 'lbd801a97h432b4lvz6kif76ft340t.png', 12, '', '{"78":{"quantity":"2","id":78,"code":"Asdfsdsdf"},"79":{"quantity":"2","id":79,"code":"Bsdfsdsdf"},"82":{"quantity":"2","id":82,"code":"Esdfsdsdf"}}'),
(34, '4PC', NULL, NULL, 12, '', '{"78":{"quantity":"2","id":78,"code":"Asdfsdsdf"},"79":{"quantity":"2","id":79,"code":"Bsdfsdsdf"},"80":{"quantity":"2","id":80,"code":"Csdfsdsdf"},"81":{"quantity":"2","id":81,"code":"Dsdfsdsdf"}}'),
(35, '4PCZ', NULL, NULL, 12, '', '{"78":{"quantity":"2","id":78,"code":"Asdfsdsdf"},"79":{"quantity":"2","id":79,"code":"Bsdfsdsdf"},"80":{"quantity":"2","id":80,"code":"Csdfsdsdf"},"81":{"quantity":"2","id":81,"code":"Dsdfsdsdf"}}'),
(37, 'A', NULL, NULL, 15, '', '{"91":{"quantity":"2","id":91,"code":"Asdfsdsdf"},"92":{"quantity":"3","id":92,"code":"B-TESTsdfsdsdf"},"93":{"quantity":"4","id":93,"code":"C-TESTsdfsdsdf"},"94":{"quantity":"5","id":94,"code":"D-TESTsdfsdsdf"},"95":{"quantity":"5","id":95,"code":"E-TESTsdfsdsdf"},"96":{"quantity":"5","id":96,"code":"F-TESTsdfsdsdf"},"97":{"quantity":"5","id":97,"code":"H-TESTsdfsdsdf"}}');

-- --------------------------------------------------------

--
-- Table structure for table `pattern_var_des`
--

CREATE TABLE IF NOT EXISTS `pattern_var_des` (
  `id_pv_des` int(11) NOT NULL,
  `pv_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `id_pattern_var` int(11) DEFAULT NULL,
  `id_language` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=289 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pattern_var_des`
--

INSERT INTO `pattern_var_des` (`id_pv_des`, `pv_description`, `id_pattern_var`, `id_language`) VALUES
(153, 'Basic Round Neck', 21, 1),
(154, 'Bàsic coll Rodó', 21, 2),
(155, 'Básico Cuello redondo', 21, 4),
(156, '', 21, 8),
(157, '', 21, 12),
(158, '', 21, 15),
(159, '', 21, 17),
(160, '', 21, 19),
(161, 'Basic V Neck', 22, 1),
(162, 'Bàsic Coll V', 22, 2),
(163, 'Básico Cuello V', 22, 4),
(164, '', 22, 8),
(165, '', 22, 12),
(166, '', 22, 15),
(167, '', 22, 17),
(168, '', 22, 19),
(169, 'Polo Basic Buttons', 23, 1),
(170, 'Polo Bàsic amb Botons', 23, 2),
(171, 'Polo básico con botones', 23, 4),
(172, 'Polo Basic Buttons', 23, 8),
(173, 'Polo Basic Buttons', 23, 12),
(174, 'Polo Basic Buttons', 23, 15),
(175, '', 23, 17),
(176, '', 23, 19),
(177, 'Basic', 24, 1),
(178, 'Basic', 24, 2),
(179, 'Basico', 24, 4),
(180, '', 24, 8),
(181, '', 24, 12),
(182, '', 24, 15),
(183, '', 24, 17),
(184, '', 24, 19),
(185, 'Basic with underwear', 25, 1),
(186, 'Bàsic amb braguero', 25, 2),
(187, 'Básico con braguero', 25, 4),
(188, '', 25, 8),
(189, '', 25, 12),
(190, '', 25, 15),
(191, '', 25, 17),
(192, '', 25, 19),
(201, 'V neck', 27, 1),
(202, 'Coll V', 27, 2),
(203, 'Cuello V', 27, 4),
(204, 'V neck', 27, 8),
(205, 'V neck', 27, 12),
(206, 'V neck', 27, 15),
(207, '', 27, 17),
(208, '', 27, 19),
(209, 'Round neck', 28, 1),
(210, 'Coll rodó', 28, 2),
(211, 'Cuello redondo', 28, 4),
(212, 'Round neck', 28, 8),
(213, 'Round neck', 28, 12),
(214, 'Round neck', 28, 15),
(215, '', 28, 17),
(216, '', 28, 19),
(217, 'V Tape neck', 29, 1),
(218, 'Coll V amb tapeta', 29, 2),
(219, 'Cuello V con tapeta', 29, 4),
(220, 'Round neck', 29, 8),
(221, 'Round neck', 29, 12),
(222, 'Round neck', 29, 15),
(223, '', 29, 17),
(224, '', 29, 19),
(225, 'Basic 1 piece', 30, 1),
(226, 'Bàsic 1 peça', 30, 2),
(227, 'Básico 1 pieza', 30, 4),
(228, 'Basic 1 piece', 30, 8),
(229, 'Basic 1 piece', 30, 12),
(230, 'Basic 1 piece', 30, 15),
(231, '', 30, 17),
(232, '', 30, 19),
(233, 'Basic, side 1 pc, no shoulder', 31, 1),
(234, 'Bàsica, costats 1 peça, sense espatlla', 31, 2),
(235, 'Básica, laterales 1 pieza, sin hombros', 31, 4),
(236, '', 31, 8),
(237, '', 31, 12),
(238, '', 31, 15),
(239, '', 31, 17),
(240, '', 31, 19),
(241, '3 pieces', 32, 1),
(242, '3 peces', 32, 2),
(243, '3 piezas', 32, 4),
(244, '3 pieces', 32, 8),
(245, '3 pieces', 32, 12),
(246, '3 pieces', 32, 15),
(247, '', 32, 17),
(248, '', 32, 19),
(249, '3 pieces + zippers', 33, 1),
(250, '3 peces + cremalleres', 33, 2),
(251, '3 piezas + cremalleras', 33, 4),
(252, '3 pieces + zippers', 33, 8),
(253, '3 pieces + zippers', 33, 12),
(254, '3 pieces + zippers', 33, 15),
(255, '', 33, 17),
(256, '', 33, 19),
(257, '3 pieces + zippers', 34, 1),
(258, 'Lateral 2 peces', 34, 2),
(259, 'Lateral 2 piezas', 34, 4),
(260, 'Side 2 pieces', 34, 8),
(261, 'Side 2 pieces', 34, 12),
(262, 'Side 2 piecesSide 2 pieces', 34, 15),
(263, '', 34, 17),
(264, '', 34, 19),
(265, 'Side 2 pieces + zipper', 35, 1),
(266, 'Lateral 2 peces + cremallera', 35, 2),
(267, 'Lateral 2 piezas + cremalleras', 35, 4),
(268, 'Side 2 pieces + zipper', 35, 8),
(269, 'Side 2 pieces + zipper', 35, 12),
(270, 'Side 2 pieces + zipper', 35, 15),
(271, '', 35, 17),
(272, '', 35, 19),
(281, '', 37, 1),
(282, '', 37, 2),
(283, '', 37, 4),
(284, '', 37, 8),
(285, '', 37, 12),
(286, '', 37, 15),
(287, '', 37, 17),
(288, '', 37, 19);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE IF NOT EXISTS `payment` (
  `id_payment` int(11) NOT NULL,
  `pay_code` varchar(255) DEFAULT NULL,
  `pay_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `pay_dp` double DEFAULT NULL,
  `pay_delivery` double DEFAULT NULL,
  `pay_30_days` double DEFAULT NULL,
  `pay_60_days` double DEFAULT NULL,
  `pay_other` double DEFAULT NULL,
  `pay_day` double DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`id_payment`, `pay_code`, `pay_description`, `pay_dp`, `pay_delivery`, `pay_30_days`, `pay_60_days`, `pay_other`, `pay_day`) VALUES
(1, 'PAY-1', 'First pay ', 10, 15, 20, 25, 30, 30);

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE IF NOT EXISTS `person` (
  `id_person` int(11) NOT NULL,
  `cts_p_name` varchar(255) DEFAULT NULL,
  `cts_p_position` varchar(255) DEFAULT NULL,
  `cts_p_phone` varchar(255) DEFAULT NULL,
  `cts_p_email` varchar(255) DEFAULT NULL,
  `cts_p_notes` varchar(255) DEFAULT NULL,
  `cts_p_bday` date DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_contact` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prd_cust`
--

CREATE TABLE IF NOT EXISTS `prd_cust` (
  `Id_prd_cust` int(11) NOT NULL,
  `cost_code` varchar(255) DEFAULT NULL,
  `cv_version` varchar(255) DEFAULT NULL,
  `prd_cust_qtty` varchar(255) DEFAULT NULL,
  `id_product` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `price_list_factory`
--

CREATE TABLE IF NOT EXISTS `price_list_factory` (
  `id_plf` int(11) NOT NULL,
  `plf_code` varchar(255) DEFAULT NULL,
  `plf_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `plf_season` varchar(255) DEFAULT NULL,
  `plf_correction` double DEFAULT NULL,
  `plf_Ex_Rate` double DEFAULT NULL,
  `plf_date` date DEFAULT NULL,
  `plf_update` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_language` int(11) DEFAULT NULL,
  `id_Factory` int(11) DEFAULT NULL,
  `id_currency` int(11) DEFAULT NULL,
  `id_Zone` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `price_list_factory`
--

INSERT INTO `price_list_factory` (`id_plf`, `plf_code`, `plf_description`, `plf_season`, `plf_correction`, `plf_Ex_Rate`, `plf_date`, `plf_update`, `id_user_created`, `id_user_updated`, `id_language`, `id_Factory`, `id_currency`, `id_Zone`) VALUES
(13, '2016-SP-1', '2016 Spain v1', '2016', 0, 23000, '2016-10-08', '2016-10-08 22:14:06', 25, 25, 1, 1, 1, 5),
(14, '2017-test', '2017 - test', '2017', 0, 23000, '2016-10-08', NULL, 25, 25, 1, 1, 1, 5),
(15, '2015-test', '2015 - test', '2015', 0, 23000, '2016-10-08', NULL, 25, 25, 1, 1, 1, 5),
(17, '2016 test', '2016 test', '2016', 10, 23000, '2016-10-19', '2016-10-19 08:37:08', 25, 25, 1, 1, 1, 5);

-- --------------------------------------------------------

--
-- Table structure for table `price_list_factory_detail`
--

CREATE TABLE IF NOT EXISTS `price_list_factory_detail` (
  `id_plf_det` int(11) NOT NULL,
  `plfd_fty_cost_0` varchar(255) DEFAULT NULL,
  `plfd_fty_sell_1` double DEFAULT NULL,
  `plfd_fty_sell_2` double DEFAULT NULL,
  `plfd_fty_sell_3` double DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_plf` int(11) DEFAULT NULL,
  `id_cost` int(11) DEFAULT NULL,
  `id_factory` int(11) DEFAULT NULL,
  `id_currency` int(11) DEFAULT NULL,
  `id_cost_version` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `price_list_factory_detail`
--

INSERT INTO `price_list_factory_detail` (`id_plf_det`, `plfd_fty_cost_0`, `plfd_fty_sell_1`, `plfd_fty_sell_2`, `plfd_fty_sell_3`, `created`, `updated`, `id_user_created`, `id_user_updated`, `id_plf`, `id_cost`, `id_factory`, `id_currency`, `id_cost_version`) VALUES
(43, '40000', 40000, 1.7391304347826086, 1.7391304347826086, NULL, NULL, NULL, NULL, 13, 60, 1, 1, 67),
(44, '60000', 60000, 2.608695652173913, 2.608695652173913, NULL, NULL, NULL, NULL, 13, 60, 1, 1, 68),
(45, '120000', 120000, 5.217391304347826, 5.217391304347826, NULL, NULL, NULL, NULL, 13, 65, 1, 1, 80),
(46, '140000', 140000, 6.086956521739131, 6.086956521739131, NULL, NULL, NULL, NULL, 13, 65, 1, 1, 81),
(47, '50000', 50000, 2.1739130434782608, 2.1739130434782608, NULL, NULL, NULL, NULL, 13, 66, 1, 1, 71),
(48, '70000', 70000, 3.0434782608695654, 3.0434782608695654, NULL, NULL, NULL, NULL, 13, 66, 1, 1, 72),
(49, '110000', 110000, 4.782608695652174, 4.782608695652174, NULL, NULL, NULL, NULL, 13, 67, 1, 1, 69),
(50, '130000', 130000, 5.6521739130434785, 5.6521739130434785, NULL, NULL, NULL, NULL, 13, 67, 1, 1, 70),
(51, '75000', 75000, 3.260869565217391, 3.260869565217391, NULL, NULL, NULL, NULL, 13, 64, 1, 1, 82),
(52, '95000', 95000, 4.130434782608695, 4.130434782608695, NULL, NULL, NULL, NULL, 13, 64, 1, 1, 83),
(53, '80000', 80000, 3.4782608695652173, 3.4782608695652173, NULL, NULL, NULL, NULL, 13, 63, 1, 1, 84),
(54, '95000', 95000, 4.130434782608695, 4.130434782608695, NULL, NULL, NULL, NULL, 13, 63, 1, 1, 85),
(55, '105000', 105000, 4.565217391304348, 4.6, NULL, NULL, NULL, NULL, 13, 63, 1, 1, 86),
(56, '75000', 75000, 3.26, 3.3, NULL, NULL, NULL, NULL, 14, 64, 1, 1, 82),
(57, '95000', 95000, 4.13, 4.1, NULL, NULL, NULL, NULL, 14, 64, 1, 1, 83),
(58, '75000', 75000, 3.26, 3.26, NULL, NULL, NULL, NULL, 15, 64, 1, 1, 82),
(59, '95000', 95000, 4.13, 4.13, NULL, NULL, NULL, NULL, 15, 64, 1, 1, 83),
(60, '110000', 110000, 4.782608695652174, 4.782608695652174, NULL, NULL, NULL, NULL, 13, 64, 1, 1, 87),
(61, '110000', 110000, 4.782608695652174, 4.8, NULL, NULL, NULL, NULL, 14, 64, 1, 1, 87),
(62, '110000', 110000, 4.782608695652174, 4.782608695652174, NULL, NULL, NULL, NULL, 15, 64, 1, 1, 87),
(66, '130000', 130000, 5.65, 5.65, NULL, NULL, NULL, NULL, 13, 64, 1, 1, 88),
(67, '130000', 130000, 5.65, 5.65, NULL, NULL, NULL, NULL, 14, 64, 1, 1, 88),
(68, '130000', 130000, 5.65, 5.65, NULL, NULL, NULL, NULL, 15, 64, 1, 1, 88),
(69, '125000', 125000, 5.43, 5.43, NULL, NULL, NULL, NULL, 13, 63, 1, 1, 89),
(70, '190000', 190000, 8.26, 8.26, NULL, NULL, NULL, NULL, 13, 62, 1, 1, 90),
(71, '210000', 210000, 9.13, 9.13, NULL, NULL, NULL, NULL, 13, 62, 1, 1, 91),
(72, '20000', 20000, 0.87, 1, NULL, NULL, NULL, NULL, 13, 98, 1, 1, 92),
(73, '25000', 25000, 1.09, 1.2, NULL, NULL, NULL, NULL, 13, 98, 1, 1, 93),
(74, '30000', 30000, 1.3, 1.3, NULL, NULL, NULL, NULL, 13, 98, 1, 1, 94),
(75, '95000', 95000, 4.13, 4.13, NULL, NULL, NULL, NULL, 13, 53, 1, 1, 95),
(76, '105000', 105000, 4.565217391304348, 4.6, NULL, NULL, NULL, NULL, 13, 53, 1, 1, 96),
(77, '130000', 130000, 5.65, 5.65, NULL, NULL, NULL, NULL, 13, 55, 1, 1, 97),
(78, '145000', 145000, 6.3, 6.3, NULL, NULL, NULL, NULL, 13, 55, 1, 1, 98),
(79, '155000', 155000, 6.74, 6.74, NULL, NULL, NULL, NULL, 13, 55, 1, 1, 101),
(81, '95000', 104500, 4.54, 4.54, NULL, NULL, NULL, NULL, 17, 53, 1, 1, 95),
(82, '105000', 115500, 5.02, 5.02, NULL, NULL, NULL, NULL, 17, 53, 1, 1, 96),
(83, '130000', 143000, 6.22, 6.22, NULL, NULL, NULL, NULL, 17, 55, 1, 1, 97),
(84, '145000', 159500, 6.93, 6.93, NULL, NULL, NULL, NULL, 17, 55, 1, 1, 98),
(85, '155000', 170500, 7.41, 7.41, NULL, NULL, NULL, NULL, 17, 55, 1, 1, 101),
(86, '40000', 44000, 1.9100000000000001, 2, NULL, NULL, NULL, NULL, 17, 60, 1, 1, 67),
(87, '60000', 66000, 2.87, 2.8, NULL, NULL, NULL, NULL, 17, 60, 1, 1, 68),
(88, '190000', 209000, 9.09, 9.09, NULL, NULL, NULL, NULL, 17, 62, 1, 1, 90),
(89, '210000', 231000, 10.04, 10.04, NULL, NULL, NULL, NULL, 17, 62, 1, 1, 91),
(90, '80000', 88000, 3.83, 3.83, NULL, NULL, NULL, NULL, 17, 63, 1, 1, 84),
(91, '95000', 104500, 4.54, 4.54, NULL, NULL, NULL, NULL, 17, 63, 1, 1, 85),
(92, '105000', 115500, 5.02, 5.02, NULL, NULL, NULL, NULL, 17, 63, 1, 1, 86),
(93, '125000', 137500, 5.98, 5.98, NULL, NULL, NULL, NULL, 17, 63, 1, 1, 89),
(94, '75000', 82500, 3.59, 3.59, NULL, NULL, NULL, NULL, 17, 64, 1, 1, 82),
(95, '95000', 104500, 4.54, 4.54, NULL, NULL, NULL, NULL, 17, 64, 1, 1, 83),
(96, '110000', 121000, 5.26, 5.26, NULL, NULL, NULL, NULL, 17, 64, 1, 1, 87),
(97, '130000', 143000, 6.22, 6.22, NULL, NULL, NULL, NULL, 17, 64, 1, 1, 88),
(98, '120000', 132000, 5.74, 5.74, NULL, NULL, NULL, NULL, 17, 65, 1, 1, 80),
(99, '140000', 154000, 6.7, 6.7, NULL, NULL, NULL, NULL, 17, 65, 1, 1, 81),
(100, '50000', 55000, 2.39, 2.39, NULL, NULL, NULL, NULL, 17, 66, 1, 1, 71),
(101, '70000', 77000, 3.35, 3.35, NULL, NULL, NULL, NULL, 17, 66, 1, 1, 72),
(102, '110000', 121000, 5.26, 5.26, NULL, NULL, NULL, NULL, 17, 67, 1, 1, 69),
(103, '130000', 143000, 6.22, 6.22, NULL, NULL, NULL, NULL, 17, 67, 1, 1, 70),
(104, '20000', 22000, 0.96, 0.96, NULL, NULL, NULL, NULL, 17, 98, 1, 1, 92),
(105, '25000', 27500, 1.2, 1.2, NULL, NULL, NULL, NULL, 17, 98, 1, 1, 93),
(106, '30000', 33000, 1.43, 1.43, NULL, NULL, NULL, NULL, 17, 98, 1, 1, 94);

-- --------------------------------------------------------

--
-- Table structure for table `price_list_zone`
--

CREATE TABLE IF NOT EXISTS `price_list_zone` (
  `id_plz` int(11) NOT NULL,
  `plz_code` varchar(255) DEFAULT NULL,
  `plz_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `plz_season` varchar(255) DEFAULT NULL,
  `plz_ex_Rate` double DEFAULT NULL,
  `plz_correction` double DEFAULT NULL,
  `plz_commission` double DEFAULT NULL,
  `plz_freight` double DEFAULT NULL,
  `plz_taxes` double DEFAULT NULL,
  `plz_margin` double DEFAULT NULL,
  `plz_date` date DEFAULT NULL,
  `plz_update` date DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_currency` int(11) DEFAULT NULL,
  `id_language` int(11) DEFAULT NULL,
  `id_plf` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `price_list_zone`
--

INSERT INTO `price_list_zone` (`id_plz`, `plz_code`, `plz_description`, `plz_season`, `plz_ex_Rate`, `plz_correction`, `plz_commission`, `plz_freight`, `plz_taxes`, `plz_margin`, `plz_date`, `plz_update`, `id_user_created`, `id_user_updated`, `id_currency`, `id_language`, `id_plf`) VALUES
(5, '2016-DIST-1', 'Distribuidores 2016', '2016', 1.2, NULL, 20, 5, 21, 25, '2016-10-08', '2016-10-19', 25, 25, 18, 4, 13),
(6, 'TEST 2015 SP', 'Test 2015 Spain', '2015', 1.2, NULL, 20, 7, 21, 25, '2016-10-15', '2016-10-15', 27, 27, 18, 4, 15),
(7, '2016-DIST- ESPECIAL', 'Distribuidores 2016 - especial', '2016', 1.1, NULL, 35, 5, 21, 25, '2016-10-19', '2016-10-19', 25, 25, 18, 4, 13);

-- --------------------------------------------------------

--
-- Table structure for table `price_list_zone_details`
--

CREATE TABLE IF NOT EXISTS `price_list_zone_details` (
  `id_plz_det` int(11) NOT NULL,
  `plzd_Weight` double DEFAULT NULL,
  `plzd_Fty_Sell_4` double DEFAULT NULL,
  `plzd_Freight` double DEFAULT NULL,
  `plzd_Taxes` double DEFAULT NULL,
  `plzd_Margin` double DEFAULT NULL,
  `plzd_Margin_1` double DEFAULT NULL,
  `plzd_Margin_2` double DEFAULT NULL,
  `plzd_Zone_Sell_5` double DEFAULT NULL,
  `plzd_Zone_Sell_6` double DEFAULT NULL,
  `plzd_PVPR_7` double DEFAULT NULL,
  `plzd_PVPR_8` double DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_plz` int(11) DEFAULT NULL,
  `id_plf_det` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `price_list_zone_details`
--

INSERT INTO `price_list_zone_details` (`id_plz_det`, `plzd_Weight`, `plzd_Fty_Sell_4`, `plzd_Freight`, `plzd_Taxes`, `plzd_Margin`, `plzd_Margin_1`, `plzd_Margin_2`, `plzd_Zone_Sell_5`, `plzd_Zone_Sell_6`, `plzd_PVPR_7`, `plzd_PVPR_8`, `created`, `updated`, `id_user_created`, `id_user_updated`, `id_plz`, `id_plf_det`) VALUES
(29, 100, 1.45, 0.5, 0.41, 0.59, 25, 20.05, 2.95, 2.95, 3.69, 3.69, '2016-08-10 00:00:00', '2016-08-10 00:00:00', 25, 25, 5, 43),
(30, 100, 2.17, 0.5, 0.56, 0.81, 25.08, 20, 4.04, 4.04, 5.05, 5.05, '2016-08-10 00:00:00', '2016-08-10 00:00:00', 25, 25, 5, 44),
(31, 120, 4.35, 0.6, 1.04, 1.5, 25.04, 19.98, 7.49, 7.49, 9.36, 9.36, '2016-08-10 00:00:00', '2016-08-10 00:00:00', 25, 25, 5, 45),
(32, 120, 5.07, 0.6, 1.19, 1.72, 25.07, 19.96, 8.58, 8.58, 10.72, 10.72, '2016-08-10 00:00:00', '2016-08-10 00:00:00', 25, 25, 5, 46),
(33, 130, 1.81, 0.65, 0.52, 0.74, 24.83, 20, 3.7199999999999998, 3.7199999999999998, 4.65, 4.65, '2016-08-10 00:00:00', '2016-08-10 00:00:00', 25, 25, 5, 47),
(34, 130, 2.54, 0.65, 0.67, 0.96, 24.87, 20.07, 4.82, 4.82, 6.03, 6.03, '2016-08-10 00:00:00', '2016-08-10 00:00:00', 25, 25, 5, 48),
(35, 150, 3.99, 0.75, 1, 1.44, 25.09, 19.96, 7.18, 7.18, 8.97, 8.97, '2016-08-10 00:00:00', '2016-08-10 00:00:00', 25, 25, 5, 49),
(36, 150, 4.71, 0.75, 1.15, 1.65, 24.96, 19.96, 8.26, 8.26, 10.32, 10.32, '2016-08-10 00:00:00', '2016-08-10 00:00:00', 25, 25, 5, 50),
(37, 140, 2.7199999999999998, 0.7, 0.72, 1.03, 24.88, 19.97, 5.17, 5.17, 6.46, 6.46, '2016-08-10 00:00:00', '2016-08-10 00:00:00', 25, 25, 5, 51),
(38, 140, 3.44, 0.7, 0.87, 1.25, 24.95, 21.75, 6.26, 6.26, 7.83, 8, '2016-08-10 00:00:00', '2016-08-10 00:00:00', 25, 25, 5, 52),
(39, 130, 2.9, 0.65, 0.75, 1.07, 24.88, 19.97, 5.37, 5.37, 6.71, 6.71, '2016-08-10 00:00:00', '2016-08-10 00:00:00', 25, 25, 5, 53),
(40, 130, 3.44, 0.65, 0.86, 1.24, 41.41, 20, 6.19, 7, 8.75, 8.75, '2016-08-10 00:00:00', '2016-08-10 00:00:00', 25, 25, 5, 54),
(41, 130, 3.83, 0.65, 0.94, 1.35, 24.91, 19.98, 6.77, 6.77, 8.46, 8.46, '2016-08-10 00:00:00', '2016-08-10 00:00:00', 25, 25, 5, 55),
(42, 140, 3.99, 0.7, 0.98, 1.42, 25.04, 11.38, 7.09, 7.09, 8.86, 8, '2016-08-10 00:00:00', '2016-08-10 00:00:00', 25, 25, 5, 60),
(43, 140, 4.71, 0.7, 1.1400000000000001, 1.6400000000000001, 22.14, 20, 8.19, 8, 10, 10, '2016-08-10 00:00:00', '2016-08-10 00:00:00', 25, 25, 5, 66),
(44, 130, 4.53, 0.65, 1.09, 1.5699999999999998, 25.04, 20, 7.84, 7.84, 9.8, 9.8, '2016-11-10 00:00:00', '2016-11-10 00:00:00', 25, 25, 5, 69),
(45, 150, 6.88, 0.75, 1.6, 2.31, 25.03, 20.03, 11.54, 11.54, 14.43, 14.43, '2016-11-10 00:00:00', '2016-11-10 00:00:00', 25, 25, 5, 70),
(46, 150, 7.61, 0.75, 1.76, 2.5300000000000002, 25, 19.99, 12.65, 12.65, 15.81, 15.81, '2016-11-10 00:00:00', '2016-11-10 00:00:00', 25, 25, 5, 71),
(47, 0, 0.83, 0, 0.17, 0.25, 25, 19.87, 1.25, 1.25, 1.56, 1.56, '2016-10-12 15:13:18', NULL, 25, NULL, 5, 72),
(48, 0, 1, 0, 0.21, 0.3, 24.79, 20.11, 1.51, 1.51, 1.8900000000000001, 1.8900000000000001, '2016-10-12 15:13:18', NULL, 25, NULL, 5, 73),
(49, 0, 1.08, 0, 0.23, 0.33, 25.19, 20, 1.6400000000000001, 1.6400000000000001, 2.05, 2.05, '2016-12-10 00:00:00', '2016-12-10 00:00:00', 25, 25, 5, 74),
(50, 150, 3.44, 0.75, 0.88, 1.27, 25.05, 19.95, 6.34, 6.34, 7.92, 7.92, '2016-10-13 00:00:00', '2016-10-13 00:00:00', 25, 25, 5, 75),
(51, 150, 3.83, 0.75, 0.96, 1.3900000000000001, 25.09, 19.98, 6.93, 6.93, 8.66, 8.66, '2016-10-13 00:00:00', '2016-10-13 00:00:00', 25, 25, 5, 76),
(52, 160, 4.71, 0.8, 1.16, 1.67, 25.04, 20.04, 8.34, 8.34, 10.43, 10.43, '2016-10-15 00:00:00', '2016-10-15 00:00:00', 25, 25, 5, 77),
(53, 160, 5.25, 0.8, 1.27, 1.83, 25, 20.02, 9.15, 9.15, 11.44, 11.44, '2016-10-15 00:00:00', '2016-10-15 00:00:00', 25, 25, 5, 78),
(54, 140, 2.7199999999999998, 0.98, 0.78, 1.12, 25, 20, 5.6, 5.6, 7, 7, '2016-10-15 00:00:00', '2016-10-15 00:00:00', 27, 27, 6, 58),
(55, 140, 3.44, 0.98, 0.93, 1.34, 25.05, 19.98, 6.6899999999999995, 6.6899999999999995, 8.36, 8.36, '2016-10-15 00:00:00', '2016-10-15 00:00:00', 27, 27, 6, 59),
(56, 140, 3.99, 0.98, 1.04, 1.5, 24.96, 20.02, 7.51, 7.51, 9.39, 9.39, '2016-10-15 00:00:00', '2016-10-15 00:00:00', 27, 27, 6, 62),
(57, 140, 4.71, 0.98, 1.19, 1.72, 25, 20, 8.6, 8.6, 10.75, 10.75, '2016-10-15 00:00:00', '2016-10-15 00:00:00', 27, 27, 6, 68),
(58, 160, 5.62, 0.8, 1.35, 1.94, 24.97, 20.02, 9.71, 9.71, 12.14, 12.14, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 5, 79),
(59, 100, 1.58, 0.5, 0.44, 0.63, 25, 30, 3.15, 3.15, 4.85, 4.5, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 43),
(60, 100, 2.37, 0.5, 0.6, 0.87, 25.07, 30, 4.34, 4.34, 6.68, 6.2, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 44),
(61, 120, 4.74, 0.6, 1.12, 1.6099999999999999, 24.92, 30.01, 8.07, 8.07, 12.42, 11.53, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 45),
(62, 120, 5.53, 0.6, 1.29, 1.85, 24.93, 29.98, 9.27, 9.27, 14.26, 13.24, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 46),
(63, 130, 1.98, 0.65, 0.55, 0.8, 25.16, 30.05, 3.98, 3.98, 6.12, 5.6899999999999995, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 47),
(64, 130, 2.77, 0.65, 0.72, 1.03, 24.88, 30.04, 5.17, 5.17, 7.95, 7.39, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 48),
(65, 150, 4.35, 0.75, 1.07, 1.54, 24.96, 29.97, 7.71, 7.71, 11.86, 11.01, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 49),
(66, 150, 5.14, 0.75, 1.24, 1.78, 24.96, 30.01, 8.91, 8.91, 13.71, 12.73, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 50),
(67, 140, 2.96, 0.7, 0.77, 1.11, 25.06, 29.96, 5.54, 5.54, 8.52, 7.91, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 51),
(68, 140, 3.75, 0.7, 0.93, 1.34, 24.91, 30, 6.72, 6.72, 10.34, 9.6, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 52),
(69, 130, 3.16, 0.65, 0.8, 1.15, 24.95, 30.01, 5.76, 5.76, 8.86, 8.23, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 53),
(70, 130, 3.75, 0.65, 0.92, 1.33, 25, 30, 6.65, 6.65, 10.23, 9.5, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 54),
(71, 130, 4.18, 0.65, 1.01, 1.46, 25, 30.01, 7.3, 7.3, 11.23, 10.43, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 55),
(72, 140, 4.35, 0.7, 1.06, 1.53, 25.04, 29.97, 7.64, 7.64, 11.75, 10.91, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 60),
(73, 140, 5.14, 0.7, 1.23, 1.77, 25.04, 30.01, 8.84, 8.84, 13.6, 12.63, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 66),
(74, 130, 4.9399999999999995, 0.65, 1.17, 1.69, 25, 29.99, 8.45, 8.45, 13, 12.07, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 69),
(75, 150, 7.51, 0.75, 1.73, 2.5, 25.03, 29.99, 12.49, 12.49, 19.22, 17.84, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 70),
(76, 150, 8.3, 0.75, 1.9, 2.74, 25.02, 30.01, 13.69, 13.69, 21.06, 19.56, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 71),
(77, 0, 0.91, 0, 0.19, 0.28, 25.45, 29.95, 1.38, 1.38, 2.12, 1.97, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 72),
(78, 0, 1.09, 0, 0.23, 0.33, 25, 30.08, 1.65, 1.65, 2.54, 2.36, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 73),
(79, 0, 1.18, 0, 0.25, 0.36, 25.17, 30.08, 1.79, 1.79, 2.75, 2.56, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 74),
(80, 150, 3.75, 0.75, 0.94, 1.3599999999999999, 25, 29.97, 6.8, 6.8, 10.46, 9.71, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 75),
(81, 150, 4.18, 0.75, 1.04, 1.49, 24.96, 30.02, 7.46, 7.46, 11.48, 10.66, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 76),
(82, 160, 5.14, 0.8, 1.25, 1.8, 25.03, 29.98, 8.99, 8.99, 13.83, 12.84, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 77),
(83, 160, 5.73, 0.8, 1.37, 1.98, 25.06, 29.98, 9.88, 9.88, 15.2, 14.11, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 78),
(84, 160, 6.13, 0.8, 1.46, 2.1, 25.03, 30.02, 10.49, 10.49, 16.14, 14.99, '2016-10-19 00:00:00', '2016-10-19 00:00:00', 25, 25, 7, 79);

-- --------------------------------------------------------

--
-- Table structure for table `process`
--

CREATE TABLE IF NOT EXISTS `process` (
  `Id_process` int(11) NOT NULL,
  `process_code` varchar(255) DEFAULT NULL,
  `process_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `process_price` varchar(255) DEFAULT NULL,
  `id_unit` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE IF NOT EXISTS `product` (
  `id_product` int(11) NOT NULL,
  `pr_version` int(11) DEFAULT NULL,
  `pr_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `pr_section` varchar(255) DEFAULT NULL,
  `pr_fty_sell_9` double DEFAULT NULL,
  `pr_zone_sell_10` double DEFAULT NULL,
  `pr_PVPR_11` double DEFAULT NULL,
  `pr_Club_12` double DEFAULT NULL,
  `pr_Web_13` double DEFAULT NULL,
  `pr_date` date DEFAULT NULL,
  `pr_date_update` date DEFAULT NULL,
  `pr_web` bit(2) DEFAULT b'0',
  `pr_9_valid` double DEFAULT NULL,
  `pr_10_valid` double DEFAULT NULL,
  `pr_11_valid` double DEFAULT NULL,
  `pr_sketch` varchar(255) DEFAULT NULL,
  `pr_picture` varchar(255) DEFAULT NULL,
  `pr_stock` bit(1) DEFAULT NULL,
  `id_Project` int(11) DEFAULT NULL,
  `id_type_products` int(11) DEFAULT NULL,
  `id_pattern_var` int(11) DEFAULT NULL,
  `id_pr_status` int(11) DEFAULT NULL,
  `id_cost` int(11) DEFAULT NULL,
  `id_cost_version` int(11) DEFAULT NULL,
  `id_Pattern` int(11) DEFAULT NULL,
  `id_size` int(11) DEFAULT NULL,
  `id_contract` int(11) DEFAULT NULL,
  `id_plz_det` int(11) DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_Factory` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id_product`, `pr_version`, `pr_description`, `pr_section`, `pr_fty_sell_9`, `pr_zone_sell_10`, `pr_PVPR_11`, `pr_Club_12`, `pr_Web_13`, `pr_date`, `pr_date_update`, `pr_web`, `pr_9_valid`, `pr_10_valid`, `pr_11_valid`, `pr_sketch`, `pr_picture`, `pr_stock`, `id_Project`, `id_type_products`, `id_pattern_var`, `id_pr_status`, `id_cost`, `id_cost_version`, `id_Pattern`, `id_size`, `id_contract`, `id_plz_det`, `id_user_created`, `id_user_updated`, `id_Factory`) VALUES
(3, 2, 'Camiseta Pere Gol', 'Futsal', 8, 14, 18, 0, 0, '2016-10-07', '2016-10-08', b'01', NULL, NULL, NULL, 'DBC0244-R0089-Pere Gol shirt-v1.jpg', 'DBC0244-R0089-V1.jpg', NULL, 23, 49, 21, 3, 62, 91, 7, 1, 12, 46, 25, 28, NULL),
(5, 6, 'Polo per entrenadors', 'Entrenadors', 8, 12, 17, 0, 0, '2016-10-13', '2016-10-13', b'01', NULL, NULL, NULL, 'DBC0269-PB0020-Polo-Montgat-v1.jpg', 'DBC0269-PB0020-V1 (1).JPG', NULL, 25, 49, 23, 3, 62, 90, 7, 1, 14, 45, 25, 25, NULL),
(6, 5, '', 'Basquet', 0, 0, 10, 0, 0, '2016-10-13', '2016-10-13', b'00', NULL, NULL, NULL, 'DBC0376-R0110-Camiseta Escalfament-Palafolls-V5.jpg', 'DBC0376-R0110-V5 (3).jpg', NULL, 24, 2, 21, 3, 53, 96, 7, 1, NULL, 51, 25, 25, NULL),
(7, 6, 'Coll amb entretela gruixuda', '', 0, 0, 0, 0, 0, '2016-10-15', '2016-10-15', b'00', NULL, NULL, NULL, 'DBC0269-PB0020-Polo-Montgat-v11.jpg', 'DBC0269-PB0020-V1 (1)1.JPG', NULL, 25, 9, 23, 4, 55, 98, 7, 1, NULL, 53, 27, 27, NULL),
(9, 4, '', '', 0, 8, 12, 0, 0, '2016-10-15', '2016-10-15', b'00', NULL, NULL, NULL, 'DBC0339-J0068-Jacket Tracksuit-Canal-v3.jpg', 'DBC0339-J0068-V3 (2).JPG', NULL, 26, 49, 31, 3, 64, 88, 11, 1, 15, 43, 27, 27, NULL),
(13, 4, 'Reversible', 'Entrenadors', 0, 0, 0, 0, 0, '2016-10-19', '2016-10-19', b'00', NULL, NULL, NULL, 'DBC0514-RR0040-Palafolls Reversible - v1.jpg', 'DBC0514-RR0040-V1 (5).jpg', NULL, 24, 9, 28, 3, 55, 101, 9, 1, NULL, 58, 25, 25, NULL),
(14, 6, 'Polo paseo', 'shop', NULL, NULL, NULL, 0, 0, '2016-10-22', NULL, NULL, NULL, NULL, NULL, 'DVN0504-PB0183-DB Schenker woman polo - V4.jpg', NULL, NULL, 25, 9, 23, NULL, 55, 101, 7, 1, NULL, 58, 25, NULL, NULL),
(15, 2, 'test product', 'junior', NULL, NULL, NULL, 0, 0, '2016-01-11', NULL, NULL, NULL, NULL, NULL, '2016-09-08 09_46_26-Shared with me - Google Drive.png', NULL, NULL, 29, 2, 21, NULL, 53, 95, 7, 1, NULL, 50, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_components`
--

CREATE TABLE IF NOT EXISTS `product_components` (
  `Id_pr_comp` int(11) NOT NULL,
  `pc_comp_qtty` varchar(255) DEFAULT NULL,
  `id_product` int(11) DEFAULT NULL,
  `id_mat` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `product_process`
--

CREATE TABLE IF NOT EXISTS `product_process` (
  `Id_pr_process` int(11) NOT NULL,
  `pr_process_qtty` varchar(255) DEFAULT NULL,
  `id_process` int(11) DEFAULT NULL,
  `id_product` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `product_status`
--

CREATE TABLE IF NOT EXISTS `product_status` (
  `id_pr_status` int(11) NOT NULL,
  `pr_stat_desc` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product_status`
--

INSERT INTO `product_status` (`id_pr_status`, `pr_stat_desc`, `created`, `updated`, `id_user_created`, `id_user_updated`) VALUES
(3, 'Approved', NULL, NULL, NULL, NULL),
(4, 'Canceled', NULL, NULL, NULL, NULL),
(5, 'In Design Process', NULL, NULL, NULL, NULL),
(6, 'Out of order', NULL, NULL, NULL, NULL),
(7, 'In production', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `prod_cust`
--

CREATE TABLE IF NOT EXISTS `prod_cust` (
  `id_prd_cust` int(11) NOT NULL,
  `cost_code` varchar(255) DEFAULT NULL,
  `cv_version` varchar(255) DEFAULT NULL,
  `prd_cust_qtty` double DEFAULT NULL,
  `prd_cust_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `id_product` int(11) DEFAULT NULL,
  `id_plz_det` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE IF NOT EXISTS `project` (
  `id_Project` int(11) NOT NULL,
  `id_display` int(11) DEFAULT NULL,
  `pj_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `pj_date` date DEFAULT NULL,
  `pj_act_1` bit(1) DEFAULT NULL,
  `pj_act_2` bit(1) DEFAULT NULL,
  `pj_act_3` bit(1) DEFAULT NULL,
  `pj_act_4` bit(1) DEFAULT NULL,
  `pj_act_5` bit(1) DEFAULT NULL,
  `pj_act_6` bit(1) DEFAULT NULL,
  `pj_act_7` bit(1) DEFAULT NULL,
  `pj_act_8` bit(1) DEFAULT NULL,
  `pj_act_9` bit(1) DEFAULT NULL,
  `pj_act_10` bit(1) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_Factory` int(11) DEFAULT NULL,
  `id_customer` int(11) DEFAULT NULL,
  `id_pj_Status` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`id_Project`, `id_display`, `pj_description`, `pj_date`, `pj_act_1`, `pj_act_2`, `pj_act_3`, `pj_act_4`, `pj_act_5`, `pj_act_6`, `pj_act_7`, `pj_act_8`, `pj_act_9`, `pj_act_10`, `created`, `updated`, `id_user_created`, `id_user_updated`, `id_Factory`, `id_customer`, `id_pj_Status`) VALUES
(23, 1, 'Conjunt futbol Sala', '2016-05-09', b'1', b'1', b'1', b'1', b'1', b'0', b'1', b'0', b'0', b'0', '2016-10-06 11:24:46', '2016-10-22 13:28:59', 25, 25, NULL, 10, 1),
(24, 2, 'Camiseta escalfament', '2016-10-04', b'0', b'0', b'0', b'0', b'1', b'0', b'0', b'0', b'0', b'0', '2016-10-06 11:29:01', '2016-10-15 19:23:39', 25, 28, NULL, 12, 1),
(25, 5, 'Polos passeig', '2016-10-06', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2016-10-07 19:08:19', '2016-10-07 19:08:28', 25, 25, NULL, 11, 3),
(26, 6, 'Cándal de verano', '2016-10-06', b'1', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2016-10-08 00:02:04', '2016-10-08 00:02:04', 27, 27, NULL, 19, 1),
(27, 9, 'Chaleco maratón', '2016-10-07', b'1', b'1', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2016-10-08 00:05:30', '2016-10-08 00:05:30', 27, 27, NULL, 20, 1),
(29, 10, 'Pantalón entreno', '2016-10-13', b'1', b'1', b'1', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2016-10-13 10:05:51', '2016-10-13 10:10:11', 27, 27, NULL, 10, 1),
(30, 11, 'T-shirt basket', '2016-10-22', b'1', b'1', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2016-10-22 13:23:43', '2016-10-22 13:24:52', 25, 25, NULL, 24, 1);

-- --------------------------------------------------------

--
-- Table structure for table `project_comment`
--

CREATE TABLE IF NOT EXISTS `project_comment` (
  `id_pj_comment` int(11) NOT NULL,
  `pj_com_comment` text CHARACTER SET utf8,
  `pj_com_date` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_Project` int(11) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_comment`
--

INSERT INTO `project_comment` (`id_pj_comment`, `pj_com_comment`, `pj_com_date`, `created`, `updated`, `id_user_created`, `id_user_updated`, `id_Project`, `id_user`) VALUES
(10, '<p>Conjunt Futbol Sala</p>\n\n<p>- Pantalons 0027</p>\n\n<p>- Camiseta 0039</p>\n\n<p>- Color verd</p>\n\n<p>- Números al darrera</p>\n\n<p>&nbsp;</p>\n\n<p>Quan estigui fet desarrollar Xandall i dessuadora</p>\n', '2016-10-06 11:26:07', NULL, '2016-10-22 01:30:15', 25, 25, 23, NULL),
(11, 'Disseny al drive', '2016-10-06 11:28:04', NULL, NULL, 25, 25, 23, NULL),
(12, 'Camiseta escalfament - Basat en el disseny de la camiseta de joc<br />\nara els espais son petits<br />\ni es pot fer<span style="background-color:#ff0000;">&nbsp;de&nbsp;</span>&nbsp;<span style="color:#ffd700;">colors</span>', '2016-10-06 11:29:37', NULL, '2016-10-11 04:26:38', 25, 25, 24, NULL),
(13, '<p>ready</p>\n\n<p>to send</p>\n\n<p>to&nbsp;</p>\n\n<p><span style="color:#ff8c00;">customer</span></p>\n\n<p>and&nbsp;</p>\n\n<p>wait&nbsp;</p>\n\n<p>for&nbsp;</p>\n\n<p>order</p>\n\n<p>&nbsp;</p>\n', '2016-10-07 06:52:15', NULL, '2016-10-07 06:56:12', 27, 27, 23, NULL),
(14, '<p>Chaleco molón</p>\n', '2016-10-07 07:06:23', NULL, NULL, 27, 27, 27, NULL),
(15, 'I fins a&nbsp;<br />\n1<br />\n<span style="font-size:10px;">2</span><br />\n<span style="font-size:14px;">3</span><br />\n<span style="font-size:18px;">4</span><br />\n<span style="font-size:22px;">5<br />\nlinees</span>', '2016-10-11 04:27:36', NULL, NULL, 25, 25, 24, NULL),
(16, 'Nou disseny de pantalons d''entrenament', '2016-10-13 10:08:43', NULL, NULL, 27, 27, 29, NULL),
(17, 'Dissenyar polo passeig', '2016-10-15 02:26:58', NULL, NULL, 28, 28, 25, NULL),
(18, 'El client vol el coll negre', '2016-10-15 02:27:11', NULL, NULL, 28, 28, 25, NULL),
(19, 'ñ&lt;siuhfdp&lt;wsd<br />\n<br />\nerg<span style="color:#ff0000;">&nbsp;important</span><br />\n&nbsp;', '2016-10-19 06:52:37', NULL, NULL, 27, 27, 23, NULL),
(20, 'idgf[haer[gdfg<br />\n<span style="color:#ff0000;">imoprtant !!!</span><br />\n&nbsp;', '2016-10-22 01:24:25', NULL, NULL, 25, 25, 30, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `project_status`
--

CREATE TABLE IF NOT EXISTS `project_status` (
  `id_pj_Status` int(11) NOT NULL,
  `pj_stat_desc` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_status`
--

INSERT INTO `project_status` (`id_pj_Status`, `pj_stat_desc`, `created`, `updated`, `id_user_created`, `id_user_updated`) VALUES
(1, 'On Design', '2016-08-01 15:19:18', '2016-10-05 15:07:23', 1, 1),
(2, 'Cancel', '2016-08-01 18:56:13', '2016-08-01 18:56:13', 1, 1),
(3, 'On Production', '2016-08-01 18:56:23', '2016-10-05 15:07:37', 1, 1),
(4, 'Stand by', '2016-10-05 15:09:46', '2016-10-05 15:09:46', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `shipment_type`
--

CREATE TABLE IF NOT EXISTS `shipment_type` (
  `id_shipment_type` int(11) NOT NULL,
  `st_code` varchar(255) DEFAULT NULL,
  `st_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sizes`
--

CREATE TABLE IF NOT EXISTS `sizes` (
  `id_size` int(11) NOT NULL,
  `sz_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `sz_qtty` double DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sizes`
--

INSERT INTO `sizes` (`id_size`, `sz_description`, `sz_qtty`, `created`, `updated`, `id_user_created`, `id_user_updated`) VALUES
(1, '6XS to 6XL', 15, '2016-08-17 16:56:16', '2016-08-17 16:56:16', 1, 1),
(2, 'Unica', 1, '2016-09-13 09:15:00', '2016-09-13 09:15:00', 1, 1),
(4, 'BIB', 5, '2016-10-09 09:02:40', '2016-10-09 09:02:40', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `sizes_details`
--

CREATE TABLE IF NOT EXISTS `sizes_details` (
  `id_size_det` int(11) NOT NULL,
  `id_size` int(11) DEFAULT NULL,
  `szd_position` varchar(255) DEFAULT NULL,
  `szd_size` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sizes_details`
--

INSERT INTO `sizes_details` (`id_size_det`, `id_size`, `szd_position`, `szd_size`) VALUES
(87, 1, '1', '6XS'),
(88, 1, '2', '5XS'),
(89, 1, '3', '4XS'),
(90, 1, '4', '3XS'),
(91, 1, '5', 'XXS'),
(92, 1, '6', 'XS'),
(93, 1, '7', 'S'),
(94, 1, '8', 'M'),
(95, 1, '9', 'L'),
(96, 1, '10', 'XL'),
(97, 1, '11', 'XXL'),
(98, 1, '12', '3XL'),
(99, 1, '13', '4XL'),
(102, 4, '1', 'XS'),
(103, 4, '2', 'S'),
(104, 4, '3', 'M'),
(105, 4, '4', 'L'),
(114, 1, '14', '5XL'),
(115, 1, '15', '6XL'),
(116, 4, '5', 'XL'),
(117, 2, '1', 'UN');

-- --------------------------------------------------------

--
-- Table structure for table `type_of_customers`
--

CREATE TABLE IF NOT EXISTS `type_of_customers` (
  `id_type_Customer` int(11) NOT NULL,
  `tc_code` varchar(255) DEFAULT NULL,
  `tc_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `type_of_customers`
--

INSERT INTO `type_of_customers` (`id_type_Customer`, `tc_code`, `tc_description`, `created`, `updated`, `id_user_created`, `id_user_updated`) VALUES
(1, 'COM', 'Company', '2016-08-01 13:51:55', '2016-08-01 18:15:56', 1, 2),
(2, 'SCH', 'School', '2016-09-19 11:42:49', '2016-09-19 11:42:49', 1, 1),
(3, 'SC', 'Sport Club', '2016-09-19 11:43:13', '2016-09-19 11:43:13', 1, 1),
(4, 'ER', 'Event/Race', '2016-09-19 11:43:55', '2016-09-19 11:43:55', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `type_of_products`
--

CREATE TABLE IF NOT EXISTS `type_of_products` (
  `id_type_products` int(11) NOT NULL,
  `tp_code` varchar(255) DEFAULT NULL,
  `tp_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_Factory` int(11) DEFAULT NULL,
  `id_group_products` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `type_of_products`
--

INSERT INTO `type_of_products` (`id_type_products`, `tp_code`, `tp_description`, `created`, `updated`, `id_user_created`, `id_user_updated`, `id_Factory`, `id_group_products`) VALUES
(2, 'TBS', NULL, '2016-08-01 17:13:57', '2016-09-29 10:11:05', 1, 25, 1, 3),
(8, 'TBL', NULL, '2016-08-02 11:12:23', '2016-10-04 16:39:12', 1, 1, 1, 3),
(9, 'TPS', '', '2016-08-02 11:12:52', '2016-09-29 10:07:27', 1, 25, 1, 5),
(14, 'TBXS', NULL, '2016-08-02 11:17:20', '2016-09-29 10:15:13', 1, 25, 1, 3),
(15, 'TBXL', NULL, '2016-08-02 11:17:34', '2016-09-29 10:14:13', 1, 25, 1, 3),
(40, 'PSM', NULL, '2016-09-21 04:50:45', '2016-10-06 15:23:34', 27, 25, 1, 9),
(41, 'TSS', NULL, '2016-09-23 13:04:52', '2016-09-23 13:04:52', 24, 24, 2, 39),
(45, 'ACC', NULL, '2016-09-29 10:03:04', '2016-10-04 16:38:59', 25, 1, 1, 43),
(48, 'TPL', NULL, '2016-10-06 15:06:48', '2016-10-06 15:06:48', 25, 25, 1, 5),
(49, 'TRS', NULL, '2016-10-06 15:09:52', '2016-10-06 15:09:52', 25, 25, 1, 49),
(50, 'CBS', NULL, '2016-10-06 15:12:36', '2016-10-06 15:12:36', 25, 25, 1, 52),
(51, 'CBB', NULL, '2016-10-06 15:19:41', '2016-10-06 15:19:41', 25, 25, 1, 52),
(52, 'CTS', NULL, '2016-10-06 15:20:35', '2016-10-06 15:20:35', 25, 25, 1, 55),
(53, 'PSB', NULL, '2016-10-06 15:22:37', '2016-10-06 15:22:37', 25, 25, 1, 9),
(54, 'PSP', NULL, '2016-10-06 15:24:31', '2016-10-06 15:24:31', 25, 25, 1, 9),
(55, 'ZS1', NULL, '2016-10-12 14:40:39', '2016-10-12 14:40:39', 25, 25, 1, 66);

-- --------------------------------------------------------

--
-- Table structure for table `type_product_language`
--

CREATE TABLE IF NOT EXISTS `type_product_language` (
  `id_type_language` int(11) NOT NULL,
  `description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_type` int(11) DEFAULT NULL,
  `id_language` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=441 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `type_product_language`
--

INSERT INTO `type_product_language` (`id_type_language`, `description`, `created`, `updated`, `id_user_created`, `id_user_updated`, `id_type`, `id_language`) VALUES
(9, 'T-Shirt Basic Short Sleeves', '2016-08-01 17:13:57', '2016-09-29 10:11:05', 1, 25, 2, 1),
(10, 'Camiseta Bàsica Màniga Curta', '2016-08-01 17:13:57', '2016-09-29 10:11:05', 1, 25, 2, 2),
(11, 'Camiseta Básica Manga Corta', '2016-08-01 17:13:57', '2016-09-29 10:11:05', 1, 25, 2, 4),
(12, 'T-Shirt Basic Short Sleeves', '2016-08-01 17:13:57', '2016-09-29 10:11:05', 1, 25, 2, 8),
(13, 'T-Shirt Basic Short Sleeves', '2016-08-01 17:13:57', '2016-09-29 10:11:05', 1, 25, 2, 12),
(14, 'T-Shirt Basic Short Sleeves', '2016-08-01 17:13:57', '2016-09-29 10:11:05', 1, 25, 2, 15),
(15, 'T-Shirt Basic Short Sleeves', '2016-08-01 17:13:57', '2016-09-29 10:11:05', 1, 25, 2, 17),
(16, 'T-Shirt Basic Short Sleeves', '2016-08-01 17:13:57', '2016-09-29 10:11:05', 1, 25, 2, 19),
(57, 'T-Shirt Basic Long Sleeves', '2016-08-02 11:12:23', '2016-10-04 16:39:12', 1, 1, 8, 1),
(58, 'Camiseta Bàsica Màniga Llarga', '2016-08-02 11:12:23', '2016-10-04 16:39:12', 1, 1, 8, 2),
(59, 'Camiseta Básica Manga Larga', '2016-08-02 11:12:23', '2016-10-04 16:39:12', 1, 1, 8, 4),
(60, 'T-Shirt Basic Long Sleeves', '2016-08-02 11:12:23', '2016-10-04 16:39:12', 1, 1, 8, 8),
(61, 'T-Shirt Basic Long Sleeves', '2016-08-02 11:12:23', '2016-10-04 16:39:12', 1, 1, 8, 12),
(62, 'T-Shirt Basic Long Sleeves', '2016-08-02 11:12:23', '2016-10-04 16:39:12', 1, 1, 8, 15),
(63, 'T-Shirt Basic Long Sleeves', '2016-08-02 11:12:23', '2016-10-04 16:39:12', 1, 1, 8, 17),
(64, 'T-Shirt Basic Long Sleeves', '2016-08-02 11:12:23', '2016-10-04 16:39:12', 1, 1, 8, 19),
(65, 'Polo Short Sleeve', '2016-08-02 11:12:52', '2016-09-29 10:07:27', 1, 25, 9, 1),
(66, 'Polo Màniga Curta', '2016-08-02 11:12:52', '2016-09-29 10:07:27', 1, 25, 9, 2),
(67, 'Polo Manga Corta', '2016-08-02 11:12:52', '2016-09-29 10:07:27', 1, 25, 9, 4),
(68, 'Polo Short Sleeve', '2016-08-02 11:12:52', '2016-09-29 10:07:27', 1, 25, 9, 8),
(69, 'Polo Short Sleeve', '2016-08-02 11:12:52', '2016-09-29 10:07:27', 1, 25, 9, 12),
(70, 'Polo Short Sleeve', '2016-08-02 11:12:52', '2016-09-29 10:07:27', 1, 25, 9, 15),
(71, 'Polo Short Sleeve', '2016-08-02 11:12:52', '2016-09-29 10:07:27', 1, 25, 9, 17),
(72, 'Polo Short Sleeve', '2016-08-02 11:12:52', '2016-09-29 10:07:27', 1, 25, 9, 19),
(105, 'T-Shirt Basic Spandex Short Sleeves', '2016-08-02 11:17:20', '2016-09-29 10:15:13', 1, 25, 14, 1),
(106, 'Camiseta Bàsica Spandex Màn. Curta', '2016-08-02 11:17:20', '2016-09-29 10:15:13', 1, 25, 14, 2),
(107, 'Camiseta Básica Spandex Man. Corta', '2016-08-02 11:17:20', '2016-09-29 10:15:13', 1, 25, 14, 4),
(108, 'T-Shirt Basic Spandex Short Sleeves', '2016-08-02 11:17:20', '2016-09-29 10:15:13', 1, 25, 14, 8),
(109, 'T-Shirt Basic Spandex Short Sleeves', '2016-08-02 11:17:20', '2016-09-29 10:15:13', 1, 25, 14, 12),
(110, 'T-Shirt Basic Spandex Short Sleeves', '2016-08-02 11:17:20', '2016-09-29 10:15:13', 1, 25, 14, 15),
(111, 'T-Shirt Basic Spandex Short Sleeves', '2016-08-02 11:17:20', '2016-09-29 10:15:13', 1, 25, 14, 17),
(112, 'T-Shirt Basic Spandex Short Sleeves', '2016-08-02 11:17:20', '2016-09-29 10:15:13', 1, 25, 14, 19),
(113, 'T-Shirt Basic Spandex Long Sleeves', '2016-08-02 11:17:34', '2016-09-29 10:14:13', 1, 25, 15, 1),
(114, 'Camiseta Bàsica Spandex Màn. Llarga', '2016-08-02 11:17:34', '2016-09-29 10:14:13', 1, 25, 15, 2),
(115, 'Camiseta Básica Spandex Man. Larga', '2016-08-02 11:17:34', '2016-09-29 10:14:13', 1, 25, 15, 4),
(116, 'T-Shirt Basic Spandex Long Sleeves', '2016-08-02 11:17:34', '2016-09-29 10:14:13', 1, 25, 15, 8),
(117, 'T-Shirt Basic Spandex Long Sleeves', '2016-08-02 11:17:34', '2016-09-29 10:14:13', 1, 25, 15, 12),
(118, 'T-Shirt Basic Spandex Long Sleeves', '2016-08-02 11:17:34', '2016-09-29 10:14:13', 1, 25, 15, 15),
(119, 'T-Shirt Basic Spandex Long Sleeves', '2016-08-02 11:17:34', '2016-09-29 10:14:13', 1, 25, 15, 17),
(120, 'T-Shirt Basic Spandex Long Sleeves', '2016-08-02 11:17:34', '2016-09-29 10:14:13', 1, 25, 15, 19),
(313, 'Short Pant Basic Match', '2016-09-21 04:50:45', '2016-10-06 15:23:34', 27, 25, 40, 1),
(314, 'Pantaló Curt Joc Bàsic', '2016-09-21 04:50:45', '2016-10-06 15:23:34', 27, 25, 40, 2),
(315, 'Pantalón Corto Juego Básico', '2016-09-21 04:50:45', '2016-10-06 15:23:34', 27, 25, 40, 4),
(316, 'Short Pant Basic Match', '2016-09-21 04:50:45', '2016-10-06 15:23:34', 27, 25, 40, 8),
(317, 'Short Pant Basic Match', '2016-09-21 04:50:45', '2016-10-06 15:23:34', 27, 25, 40, 12),
(318, 'Short Pant Basic Match', '2016-09-21 04:50:45', '2016-10-06 15:23:34', 27, 25, 40, 15),
(319, 'Short Pant Basic Match', '2016-09-21 04:50:45', '2016-10-06 15:23:34', 27, 25, 40, 17),
(320, 'Short Pant Basic Match', '2016-09-21 04:50:45', '2016-10-06 15:23:34', 27, 25, 40, 19),
(321, 'T-Shirt', '2016-09-23 13:04:52', '2016-09-23 13:04:52', 24, 24, 41, 1),
(322, '', '2016-09-23 13:04:52', '2016-09-23 13:04:52', 24, 24, 41, 2),
(323, '', '2016-09-23 13:04:52', '2016-09-23 13:04:52', 24, 24, 41, 4),
(324, 'áo sơ mi', '2016-09-23 13:04:52', '2016-09-23 13:04:52', 24, 24, 41, 8),
(325, '', '2016-09-23 13:04:52', '2016-09-23 13:04:52', 24, 24, 41, 12),
(326, '', '2016-09-23 13:04:52', '2016-09-23 13:04:52', 24, 24, 41, 15),
(327, '', '2016-09-23 13:04:52', '2016-09-23 13:04:52', 24, 24, 41, 17),
(328, '', '2016-09-23 13:04:52', '2016-09-23 13:04:52', 24, 24, 41, 19),
(353, 'Calf Compressors', '2016-09-29 10:03:04', '2016-10-04 16:38:59', 25, 1, 45, 1),
(354, 'Compressors de Pantorrilla', '2016-09-29 10:03:04', '2016-10-04 16:38:59', 25, 1, 45, 2),
(355, 'Compresores de Pantorrilla', '2016-09-29 10:03:04', '2016-10-04 16:38:59', 25, 1, 45, 4),
(356, 'Calf Compressors', '2016-09-29 10:03:04', '2016-10-04 16:38:59', 25, 1, 45, 8),
(357, 'Calf Compressors', '2016-09-29 10:03:04', '2016-10-04 16:38:59', 25, 1, 45, 12),
(358, 'Calf Compressors', '2016-09-29 10:03:04', '2016-10-04 16:38:59', 25, 1, 45, 15),
(359, 'Calf Compressors', '2016-09-29 10:03:04', '2016-10-04 16:38:59', 25, 1, 45, 17),
(360, 'Calf Compressors', '2016-09-29 10:03:04', '2016-10-04 16:38:59', 25, 1, 45, 19),
(377, 'Polo Long Sleeve', '2016-10-06 15:06:48', '2016-10-06 15:06:48', 25, 25, 48, 1),
(378, 'Polo Màniga Llarga', '2016-10-06 15:06:48', '2016-10-06 15:06:48', 25, 25, 48, 2),
(379, 'Polo Manga Larga', '2016-10-06 15:06:48', '2016-10-06 15:06:48', 25, 25, 48, 4),
(380, 'Polo Long Sleeve', '2016-10-06 15:06:48', '2016-10-06 15:06:48', 25, 25, 48, 8),
(381, 'Polo Long Sleeve', '2016-10-06 15:06:48', '2016-10-06 15:06:48', 25, 25, 48, 12),
(382, 'Polo Long Sleeve', '2016-10-06 15:06:48', '2016-10-06 15:06:48', 25, 25, 48, 15),
(383, 'Polo Long Sleeve', '2016-10-06 15:06:48', '2016-10-06 15:06:48', 25, 25, 48, 17),
(384, 'Polo Long Sleeve', '2016-10-06 15:06:48', '2016-10-06 15:06:48', 25, 25, 48, 19),
(385, 'T-Shirt Pro Short Sleeve', '2016-10-06 15:09:52', '2016-10-06 15:09:52', 25, 25, 49, 1),
(386, 'Camiseta Pro Màniga Curta', '2016-10-06 15:09:52', '2016-10-06 15:09:52', 25, 25, 49, 2),
(387, 'Camiseta Pro Manga Corta', '2016-10-06 15:09:52', '2016-10-06 15:09:52', 25, 25, 49, 4),
(388, 'T-Shirt Pro Short Sleeve', '2016-10-06 15:09:52', '2016-10-06 15:09:52', 25, 25, 49, 8),
(389, 'T-Shirt Pro Short Sleeve', '2016-10-06 15:09:52', '2016-10-06 15:09:52', 25, 25, 49, 12),
(390, 'T-Shirt Pro Short Sleeve', '2016-10-06 15:09:52', '2016-10-06 15:09:52', 25, 25, 49, 15),
(391, 'T-Shirt Pro Short Sleeve', '2016-10-06 15:09:52', '2016-10-06 15:09:52', 25, 25, 49, 17),
(392, 'T-Shirt Pro Short Sleeve', '2016-10-06 15:09:52', '2016-10-06 15:09:52', 25, 25, 49, 19),
(393, 'Singlet Basic Small', '2016-10-06 15:12:36', '2016-10-06 15:12:36', 25, 25, 50, 1),
(394, 'Samarreta Bàsica Petita', '2016-10-06 15:12:36', '2016-10-06 15:12:36', 25, 25, 50, 2),
(395, 'Camiseta sin mangas Básica Pequeña', '2016-10-06 15:12:36', '2016-10-06 15:12:36', 25, 25, 50, 4),
(396, 'Singlet Basic Small', '2016-10-06 15:12:36', '2016-10-06 15:12:36', 25, 25, 50, 8),
(397, 'Singlet Basic Small', '2016-10-06 15:12:36', '2016-10-06 15:12:36', 25, 25, 50, 12),
(398, 'Singlet Basic Small', '2016-10-06 15:12:36', '2016-10-06 15:12:36', 25, 25, 50, 15),
(399, 'Singlet Basic Small', '2016-10-06 15:12:36', '2016-10-06 15:12:36', 25, 25, 50, 17),
(400, 'Singlet Basic Small', '2016-10-06 15:12:36', '2016-10-06 15:12:36', 25, 25, 50, 19),
(401, 'Singlet Basic Big', '2016-10-06 15:19:41', '2016-10-06 15:19:41', 25, 25, 51, 1),
(402, 'Camiseta Tirants Bàsica Gran', '2016-10-06 15:19:41', '2016-10-06 15:19:41', 25, 25, 51, 2),
(403, 'Camiseta Tirantes Básica Grande', '2016-10-06 15:19:41', '2016-10-06 15:19:41', 25, 25, 51, 4),
(404, 'Singlet Basic Big', '2016-10-06 15:19:41', '2016-10-06 15:19:41', 25, 25, 51, 8),
(405, 'Singlet Basic Big', '2016-10-06 15:19:41', '2016-10-06 15:19:41', 25, 25, 51, 12),
(406, 'Singlet Basic Big', '2016-10-06 15:19:41', '2016-10-06 15:19:41', 25, 25, 51, 15),
(407, 'Singlet Basic Big', '2016-10-06 15:19:41', '2016-10-06 15:19:41', 25, 25, 51, 17),
(408, 'Singlet Basic Big', '2016-10-06 15:19:41', '2016-10-06 15:19:41', 25, 25, 51, 19),
(409, 'Tank Top Short', '2016-10-06 15:20:35', '2016-10-06 15:20:35', 25, 25, 52, 1),
(410, 'Top Curt', '2016-10-06 15:20:35', '2016-10-06 15:20:35', 25, 25, 52, 2),
(411, 'Top Corto', '2016-10-06 15:20:35', '2016-10-06 15:20:35', 25, 25, 52, 4),
(412, 'Tank Top Short', '2016-10-06 15:20:35', '2016-10-06 15:20:35', 25, 25, 52, 8),
(413, 'Tank Top Short', '2016-10-06 15:20:35', '2016-10-06 15:20:35', 25, 25, 52, 12),
(414, 'Tank Top Short', '2016-10-06 15:20:35', '2016-10-06 15:20:35', 25, 25, 52, 15),
(415, 'Tank Top Short', '2016-10-06 15:20:35', '2016-10-06 15:20:35', 25, 25, 52, 17),
(416, 'Tank Top Short', '2016-10-06 15:20:35', '2016-10-06 15:20:35', 25, 25, 52, 19),
(417, 'Short Pant Basic Big', '2016-10-06 15:22:37', '2016-10-06 15:22:37', 25, 25, 53, 1),
(418, 'Pantaló Curt Bàsic Gran', '2016-10-06 15:22:37', '2016-10-06 15:22:37', 25, 25, 53, 2),
(419, 'Pantalón Corto Básico Grande', '2016-10-06 15:22:37', '2016-10-06 15:22:37', 25, 25, 53, 4),
(420, 'Short Pant Basic Big', '2016-10-06 15:22:37', '2016-10-06 15:22:37', 25, 25, 53, 8),
(421, 'Short Pant Basic Big', '2016-10-06 15:22:37', '2016-10-06 15:22:37', 25, 25, 53, 12),
(422, 'Short Pant Basic Big', '2016-10-06 15:22:37', '2016-10-06 15:22:37', 25, 25, 53, 15),
(423, 'Short Pant Basic Big', '2016-10-06 15:22:37', '2016-10-06 15:22:37', 25, 25, 53, 17),
(424, 'Short Pant Basic Big', '2016-10-06 15:22:37', '2016-10-06 15:22:37', 25, 25, 53, 19),
(425, 'Short Pant Pockets', '2016-10-06 15:24:31', '2016-10-06 15:24:31', 25, 25, 54, 1),
(426, 'Pantaló Curt Butxaques', '2016-10-06 15:24:31', '2016-10-06 15:24:31', 25, 25, 54, 2),
(427, 'Pantalon Corto Bolsillos', '2016-10-06 15:24:31', '2016-10-06 15:24:31', 25, 25, 54, 4),
(428, 'Short Pant Pockets', '2016-10-06 15:24:31', '2016-10-06 15:24:31', 25, 25, 54, 8),
(429, 'Short Pant Pockets', '2016-10-06 15:24:31', '2016-10-06 15:24:31', 25, 25, 54, 12),
(430, 'Short Pant Pockets', '2016-10-06 15:24:31', '2016-10-06 15:24:31', 25, 25, 54, 15),
(431, 'Short Pant Pockets', '2016-10-06 15:24:31', '2016-10-06 15:24:31', 25, 25, 54, 17),
(432, 'Short Pant Pockets', '2016-10-06 15:24:31', '2016-10-06 15:24:31', 25, 25, 54, 19),
(433, 'Screen Print Small', '2016-10-12 14:40:39', '2016-10-12 14:40:39', 25, 25, 55, 1),
(434, 'Impresió Serigrafia Petita', '2016-10-12 14:40:39', '2016-10-12 14:40:39', 25, 25, 55, 2),
(435, 'Impresión Serigrafía Pequeña', '2016-10-12 14:40:39', '2016-10-12 14:40:39', 25, 25, 55, 4),
(436, 'Screen Print Small', '2016-10-12 14:40:39', '2016-10-12 14:40:39', 25, 25, 55, 8),
(437, 'Screen Print Small', '2016-10-12 14:40:39', '2016-10-12 14:40:39', 25, 25, 55, 12),
(438, 'Screen Print Small', '2016-10-12 14:40:39', '2016-10-12 14:40:39', 25, 25, 55, 15),
(439, 'Screen Print Small', '2016-10-12 14:40:39', '2016-10-12 14:40:39', 25, 25, 55, 17),
(440, 'Screen Print Small', '2016-10-12 14:40:39', '2016-10-12 14:40:39', 25, 25, 55, 19);

-- --------------------------------------------------------

--
-- Table structure for table `Units`
--

CREATE TABLE IF NOT EXISTS `Units` (
  `Id_unit` int(11) NOT NULL,
  `unit_Code` varchar(255) DEFAULT NULL,
  `id_Factory` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id_user` int(11) NOT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `user_position` longtext,
  `user_password` longtext,
  `is_root` bit(1) DEFAULT NULL,
  `id_Factory` int(11) DEFAULT NULL,
  `id_language` int(11) DEFAULT NULL,
  `id_Zone` int(11) DEFAULT NULL,
  `id_Agent` int(11) DEFAULT NULL,
  `id_Customer` int(11) DEFAULT NULL,
  `id_contact` int(11) DEFAULT NULL,
  `id_access_level` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `user_name`, `user_position`, `user_password`, `is_root`, `id_Factory`, `id_language`, `id_Zone`, `id_Agent`, `id_Customer`, `id_contact`, `id_access_level`) VALUES
(1, 'factory1', NULL, 'admin123', b'0', 1, 1, NULL, NULL, NULL, NULL, NULL),
(2, 'zone1', '', 'admin123', b'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(23, 'superadmin', 'super admin', 'admin123', b'1', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(24, 'factory2', 'factory admin', 'admin123', b'0', 2, 1, NULL, NULL, NULL, 66, 1),
(25, 'xevi', 'Factory administrator', '123', b'0', 1, 1, NULL, NULL, NULL, 71, 1),
(26, 'xevi VN', 'Admin VN', '123', b'0', 1, 1, 6, NULL, NULL, 72, 5),
(27, 'xevi SP', 'Admin SP', '123', b'0', 1, 2, 5, NULL, NULL, 73, 5),
(28, 'cristina', 'Customer care', '123', b'0', 1, 2, 5, 15, NULL, 84, 7),
(29, 'minguella', 'President', '123', b'0', 1, 2, 5, 15, 10, 88, 9),
(30, 'CBMontgat', 'President', '123', b'0', 1, 2, 5, 15, 11, 89, 9),
(35, 'Xevi TVV', 'Admin', '123', b'0', 1, 1, 6, 24, NULL, 97, 7),
(36, 'guim', '', '123', b'0', 1, 1, 6, 14, NULL, 98, 7),
(37, 'alex', '', '123', b'0', 1, 4, 5, 22, NULL, 104, 7),
(38, 'gemma', '', '123', b'0', 1, 2, 5, NULL, NULL, 107, 5),
(41, 'steven', 'Technical', '123456', b'0', 1, 2, 5, NULL, NULL, 113, 5),
(42, 'canal', '', '123', b'0', 1, 4, 5, 22, 19, 114, 9),
(43, 'asme', 'Utiller', '123', b'0', 1, 2, 5, 15, 22, 115, 9);

-- --------------------------------------------------------

--
-- Table structure for table `usersetting`
--

CREATE TABLE IF NOT EXISTS `usersetting` (
  `id_USetting` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_user_setting` int(11) DEFAULT NULL,
  `id_language` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `zone`
--

CREATE TABLE IF NOT EXISTS `zone` (
  `id_Zone` int(11) NOT NULL,
  `z_code` varchar(255) DEFAULT NULL,
  `z_description` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_Factory` int(11) DEFAULT NULL,
  `id_currency` int(11) DEFAULT NULL,
  `id_language` int(11) DEFAULT NULL,
  `id_contact` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `zone`
--

INSERT INTO `zone` (`id_Zone`, `z_code`, `z_description`, `created`, `updated`, `id_user_created`, `id_user_updated`, `id_Factory`, `id_currency`, `id_language`, `id_contact`) VALUES
(5, 'SP', 'Spain', '2016-09-19 11:24:49', '2016-10-06 10:25:47', 1, 25, 1, 18, 2, 68),
(6, 'VN', 'Vietnam', '2016-09-19 11:27:44', '2016-10-06 10:25:59', 1, 25, 1, 3, 1, 69);

-- --------------------------------------------------------

--
-- Table structure for table `zone_price`
--

CREATE TABLE IF NOT EXISTS `zone_price` (
  `id_zone_pl` int(11) NOT NULL,
  `zpl_date_i` datetime DEFAULT NULL,
  `zpl_date_f` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `id_user_created` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_Zone` int(11) DEFAULT NULL,
  `id_plf` int(11) DEFAULT NULL,
  `if_plf` int(11) DEFAULT NULL,
  `id_agent_pl` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `zone_price`
--

INSERT INTO `zone_price` (`id_zone_pl`, `zpl_date_i`, `zpl_date_f`, `created`, `updated`, `id_user_created`, `id_user_updated`, `id_Zone`, `id_plf`, `if_plf`, `id_agent_pl`) VALUES
(4, '2016-01-01 00:00:00', '2016-12-31 00:00:00', NULL, '2016-10-12 09:11:43', NULL, 25, 5, 13, NULL, NULL),
(5, '2015-01-01 00:00:00', '2015-12-31 00:00:00', NULL, '2016-10-12 09:12:20', NULL, 25, 5, 15, NULL, NULL),
(6, '2017-01-01 00:00:00', '2017-12-31 00:00:00', NULL, '2016-10-15 20:15:22', NULL, 25, 5, 14, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `access_level`
--
ALTER TABLE `access_level`
  ADD PRIMARY KEY (`id_access_level`),
  ADD KEY `FK8BF918E930B5C2E3` (`id_user_created`),
  ADD KEY `FK8BF918E9E56E24B6` (`id_user_updated`);

--
-- Indexes for table `access_page`
--
ALTER TABLE `access_page`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idPage` (`idPage`);

--
-- Indexes for table `agent`
--
ALTER TABLE `agent`
  ADD PRIMARY KEY (`id_Agent`),
  ADD UNIQUE KEY `ag_code` (`ag_code`),
  ADD KEY `FK587430587962C11` (`id_plz`),
  ADD KEY `FK587430530B5C2E3` (`id_user_created`),
  ADD KEY `FK587430562BFEBFC` (`id_Zone`),
  ADD KEY `FK58743057E351E17` (`id_language`),
  ADD KEY `FK5874305E56E24B6` (`id_user_updated`),
  ADD KEY `FK58743051AD8B11C` (`id_contact`);

--
-- Indexes for table `agent_price`
--
ALTER TABLE `agent_price`
  ADD PRIMARY KEY (`id_agent_pl`),
  ADD KEY `FK76C43F8F87962C11` (`id_plz`),
  ADD KEY `FK76C43F8F30B5C2E3` (`id_user_created`),
  ADD KEY `FK76C43F8FE56E24B6` (`id_user_updated`),
  ADD KEY `FK76C43F8FF27575E6` (`id_Agent`),
  ADD KEY `FK76C43F8F848602BA` (`id_product`);

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id_contact`),
  ADD KEY `FK38B7242030B5C2E3` (`id_user_created`),
  ADD KEY `FK38B72420E56E24B6` (`id_user_updated`);

--
-- Indexes for table `contract`
--
ALTER TABLE `contract`
  ADD PRIMARY KEY (`id_contract`),
  ADD KEY `FKDE351112CC25B260` (`id_Customer`),
  ADD KEY `FKDE35111262BFEBFC` (`id_Zone`),
  ADD KEY `FKDE351112F27575E6` (`id_Agent`);

--
-- Indexes for table `costing`
--
ALTER TABLE `costing`
  ADD PRIMARY KEY (`id_cost`),
  ADD UNIQUE KEY `hashid` (`hashid`),
  ADD KEY `FK38FDB8F52740CAF0` (`id_Factory`),
  ADD KEY `FK38FDB8F59737C5EC` (`id_type_products`),
  ADD KEY `FK38FDB8F530B5C2E3` (`id_user_created`),
  ADD KEY `FK38FDB8F5CC25B260` (`id_customer`),
  ADD KEY `FK38FDB8F5E56E24B6` (`id_user_updated`);

--
-- Indexes for table `costing_description`
--
ALTER TABLE `costing_description`
  ADD PRIMARY KEY (`id_cost_description`),
  ADD KEY `FK89B0D3B230B5C2E3` (`id_user_created`),
  ADD KEY `FK89B0D3B27E351E17` (`id_language`),
  ADD KEY `FK89B0D3B2E56E24B6` (`id_user_updated`),
  ADD KEY `FK89B0D3B29B7A0D66` (`id_cost`);

--
-- Indexes for table `costing_versions`
--
ALTER TABLE `costing_versions`
  ADD PRIMARY KEY (`id_cost_version`),
  ADD KEY `FKB64E3AA530B5C2E3` (`id_user_created`),
  ADD KEY `FKB64E3AA5E56E24B6` (`id_user_updated`),
  ADD KEY `FKB64E3AA59B7A0D66` (`id_cost`);

--
-- Indexes for table `costing_version_description`
--
ALTER TABLE `costing_version_description`
  ADD PRIMARY KEY (`id_cost_version_desc`),
  ADD KEY `FK213DB4CB30B5C2E3` (`id_user_created`),
  ADD KEY `FK213DB4CB64F051AF` (`id_cost_version`),
  ADD KEY `FK213DB4CB7E351E17` (`id_language`),
  ADD KEY `FK213DB4CBE56E24B6` (`id_user_updated`);

--
-- Indexes for table `currency`
--
ALTER TABLE `currency`
  ADD PRIMARY KEY (`id_currency`),
  ADD UNIQUE KEY `curr_code` (`curr_code`),
  ADD KEY `FK224BF01130B5C2E3` (`id_user_created`),
  ADD KEY `FK224BF011E56E24B6` (`id_user_updated`);

--
-- Indexes for table `currency_convert`
--
ALTER TABLE `currency_convert`
  ADD PRIMARY KEY (`id_curr_conv`),
  ADD KEY `FK6D2F138530B5C2E3` (`id_user_created`),
  ADD KEY `FK6D2F1385C87A92C6` (`id_currency`),
  ADD KEY `FK6D2F1385E56E24B6` (`id_user_updated`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id_Customer`),
  ADD UNIQUE KEY `cs_code` (`cs_code`),
  ADD KEY `FK24217FDE9F3A43F1` (`id_type_customer`),
  ADD KEY `FK24217FDE30B5C2E3` (`id_user_created`),
  ADD KEY `FK24217FDE62BFEBFC` (`id_Zone`),
  ADD KEY `FK24217FDE7E351E17` (`id_language`),
  ADD KEY `FK24217FDEE56E24B6` (`id_user_updated`),
  ADD KEY `FK24217FDE1AD8B11C` (`id_contact`),
  ADD KEY `FK24217FDEF27575E6` (`id_agent`);

--
-- Indexes for table `factory`
--
ALTER TABLE `factory`
  ADD PRIMARY KEY (`id_factory`),
  ADD KEY `FKBEEB310A30B5C2E3` (`id_user_created`),
  ADD KEY `FKBEEB310A7E351E17` (`id_language`),
  ADD KEY `FKBEEB310AC87A92C6` (`id_currency`),
  ADD KEY `FKBEEB310AE56E24B6` (`id_user_updated`),
  ADD KEY `FKBEEB310A1AD8B11C` (`id_contact`);

--
-- Indexes for table `forwarder`
--
ALTER TABLE `forwarder`
  ADD PRIMARY KEY (`id_forwarder`),
  ADD KEY `FK7D0A023230B5C2E3` (`id_user_created`),
  ADD KEY `FK7D0A0232E56E24B6` (`id_user_updated`),
  ADD KEY `FK7D0A02321AD8B11C` (`id_contact`);

--
-- Indexes for table `freight`
--
ALTER TABLE `freight`
  ADD PRIMARY KEY (`id_freight`),
  ADD KEY `FKDC04A34330B5C2E3` (`id_user_created`),
  ADD KEY `FKDC04A343E56E24B6` (`id_user_updated`);

--
-- Indexes for table `group_materials`
--
ALTER TABLE `group_materials`
  ADD PRIMARY KEY (`Id_group_mat`),
  ADD KEY `FK9EF45E6C2740CAF0` (`id_Factory`);

--
-- Indexes for table `group_of_products`
--
ALTER TABLE `group_of_products`
  ADD PRIMARY KEY (`id_group_products`),
  ADD KEY `FKFA0A250C2740CAF0` (`id_Factory`),
  ADD KEY `FKFA0A250C30B5C2E3` (`id_user_created`),
  ADD KEY `FKFA0A250CE56E24B6` (`id_user_updated`);

--
-- Indexes for table `group_product_language`
--
ALTER TABLE `group_product_language`
  ADD PRIMARY KEY (`id_group_language`),
  ADD KEY `FK55D26E6830B5C2E3` (`id_user_created`),
  ADD KEY `FK55D26E687E351E17` (`id_language`),
  ADD KEY `FK55D26E68E56E24B6` (`id_user_updated`),
  ADD KEY `FK55D26E68E7520B67` (`id_group`);

--
-- Indexes for table `incoterm`
--
ALTER TABLE `incoterm`
  ADD PRIMARY KEY (`id_incoterm`),
  ADD KEY `FK58B183D30B5C2E3` (`id_user_created`),
  ADD KEY `FK58B183DE56E24B6` (`id_user_updated`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id_language`),
  ADD UNIQUE KEY `lg_code` (`lg_code`),
  ADD KEY `FK5A7FD81B30B5C2E3` (`id_user_created`),
  ADD KEY `FK5A7FD81BE56E24B6` (`id_user_updated`);

--
-- Indexes for table `materials`
--
ALTER TABLE `materials`
  ADD PRIMARY KEY (`Id_mat`),
  ADD KEY `FK2899402C2740CAF0` (`id_Factory`),
  ADD KEY `FK2899402C30B5C2E3` (`id_user_created`),
  ADD KEY `FK2899402C3F0873E8` (`id_group_mat`),
  ADD KEY `FK2899402CE56E24B6` (`id_user_updated`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id_order`),
  ADD KEY `FKC3DF62E5CC25B260` (`id_customer`),
  ADD KEY `FKC3DF62E5F8A192B` (`ord_plf`),
  ADD KEY `FKC3DF62E586C57AD7` (`ord_plz`),
  ADD KEY `FKC3DF62E54BA2CCE8` (`id_payment`),
  ADD KEY `FKC3DF62E5702CDCBA` (`id_order_type`),
  ADD KEY `FKC3DF62E5D92D17B0` (`id_order_condition`),
  ADD KEY `FKC3DF62E51464E4AA` (`id_order_status`);

--
-- Indexes for table `order_condition`
--
ALTER TABLE `order_condition`
  ADD PRIMARY KEY (`id_order_condition`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id_order_det`),
  ADD KEY `FK521CF251B197DA0F` (`id_order`),
  ADD KEY `FK521CF251848602BA` (`id_product`),
  ADD KEY `FK521CF251DD39650E` (`id_size_det`);

--
-- Indexes for table `order_status`
--
ALTER TABLE `order_status`
  ADD PRIMARY KEY (`id_order_status`);

--
-- Indexes for table `order_type`
--
ALTER TABLE `order_type`
  ADD PRIMARY KEY (`id_order_type`);

--
-- Indexes for table `particular`
--
ALTER TABLE `particular`
  ADD PRIMARY KEY (`id_particular`),
  ADD KEY `FK17F22D530B5C2E3` (`id_user_created`),
  ADD KEY `FK17F22D5CC25B260` (`id_customer`),
  ADD KEY `FK17F22D57E351E17` (`id_language`),
  ADD KEY `FK17F22D5E56E24B6` (`id_user_updated`),
  ADD KEY `FK17F22D51AD8B11C` (`id_contact`);

--
-- Indexes for table `patterns`
--
ALTER TABLE `patterns`
  ADD PRIMARY KEY (`id_pattern`),
  ADD UNIQUE KEY `pt_code` (`pt_code`),
  ADD KEY `FK4A4486E32740CAF0` (`id_Factory`),
  ADD KEY `FK4A4486E330B5C2E3` (`id_user_created`),
  ADD KEY `FK4A4486E3E56E24B6` (`id_user_updated`),
  ADD KEY `FK4A4486E3A7F137D4` (`id_group_products`);

--
-- Indexes for table `pattern_description`
--
ALTER TABLE `pattern_description`
  ADD PRIMARY KEY (`id_pattern_des`),
  ADD KEY `FK31A5F5CD30B5C2E3` (`id_user_created`),
  ADD KEY `FK31A5F5CD7E351E17` (`id_language`),
  ADD KEY `FK31A5F5CDE56E24B6` (`id_user_updated`),
  ADD KEY `FK31A5F5CDC487DB4F` (`id_pattern`);

--
-- Indexes for table `pattern_notes`
--
ALTER TABLE `pattern_notes`
  ADD PRIMARY KEY (`id_pattern_note`),
  ADD KEY `FK911CB15230B5C2E3` (`id_user_created`),
  ADD KEY `FK911CB152C487DB4F` (`id_pattern`);

--
-- Indexes for table `pattern_part`
--
ALTER TABLE `pattern_part`
  ADD PRIMARY KEY (`id_pattern_part`),
  ADD KEY `FKF42AEB427E351E17` (`id_language`),
  ADD KEY `FKF42AEB42C487DB4F` (`id_pattern`);

--
-- Indexes for table `pattern_variantions`
--
ALTER TABLE `pattern_variantions`
  ADD PRIMARY KEY (`id_pattern_var`),
  ADD KEY `FK39092141C487DB4F` (`id_pattern`);

--
-- Indexes for table `pattern_var_des`
--
ALTER TABLE `pattern_var_des`
  ADD PRIMARY KEY (`id_pv_des`),
  ADD KEY `FK4BE4914B7E351E17` (`id_language`),
  ADD KEY `FK4BE4914B7FA15615` (`id_pattern_var`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id_payment`);

--
-- Indexes for table `person`
--
ALTER TABLE `person`
  ADD PRIMARY KEY (`id_person`),
  ADD KEY `FKC4E39B5530B5C2E3` (`id_user_created`),
  ADD KEY `FKC4E39B55E56E24B6` (`id_user_updated`),
  ADD KEY `FKC4E39B551AD8B11C` (`id_contact`);

--
-- Indexes for table `prd_cust`
--
ALTER TABLE `prd_cust`
  ADD PRIMARY KEY (`Id_prd_cust`),
  ADD KEY `FKB11821D0848602BA` (`id_product`);

--
-- Indexes for table `price_list_factory`
--
ALTER TABLE `price_list_factory`
  ADD PRIMARY KEY (`id_plf`),
  ADD KEY `FK577FE19F2740CAF0` (`id_Factory`),
  ADD KEY `FK577FE19F30B5C2E3` (`id_user_created`),
  ADD KEY `FK577FE19F62BFEBFC` (`id_Zone`),
  ADD KEY `FK577FE19F7E351E17` (`id_language`),
  ADD KEY `FK577FE19FC87A92C6` (`id_currency`),
  ADD KEY `FK577FE19FE56E24B6` (`id_user_updated`);

--
-- Indexes for table `price_list_factory_detail`
--
ALTER TABLE `price_list_factory_detail`
  ADD PRIMARY KEY (`id_plf_det`),
  ADD KEY `FKCAC5F2F12740CAF0` (`id_factory`),
  ADD KEY `FKCAC5F2F130B5C2E3` (`id_user_created`),
  ADD KEY `FKCAC5F2F164F051AF` (`id_cost_version`),
  ADD KEY `FKCAC5F2F1C87A92C6` (`id_currency`),
  ADD KEY `FKCAC5F2F1E56E24B6` (`id_user_updated`),
  ADD KEY `FKCAC5F2F1105ACA65` (`id_plf`),
  ADD KEY `FKCAC5F2F19B7A0D66` (`id_cost`);

--
-- Indexes for table `price_list_zone`
--
ALTER TABLE `price_list_zone`
  ADD PRIMARY KEY (`id_plz`),
  ADD KEY `FKCEBB433730B5C2E3` (`id_user_created`),
  ADD KEY `FKCEBB43377E351E17` (`id_language`),
  ADD KEY `FKCEBB4337C87A92C6` (`id_currency`),
  ADD KEY `FKCEBB4337E56E24B6` (`id_user_updated`),
  ADD KEY `FKCEBB4337105ACA65` (`id_plf`);

--
-- Indexes for table `price_list_zone_details`
--
ALTER TABLE `price_list_zone_details`
  ADD PRIMARY KEY (`id_plz_det`),
  ADD KEY `FK90E4B53A87962C11` (`id_plz`),
  ADD KEY `FK90E4B53A56FFBC0B` (`id_plf_det`),
  ADD KEY `FK90E4B53A30B5C2E3` (`id_user_created`),
  ADD KEY `FK90E4B53AE56E24B6` (`id_user_updated`);

--
-- Indexes for table `process`
--
ALTER TABLE `process`
  ADD PRIMARY KEY (`Id_process`),
  ADD KEY `FKED8D1E6F6765E577` (`id_unit`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id_product`),
  ADD KEY `FKED8DCCEF404CD4C8` (`id_contract`),
  ADD KEY `FKED8DCCEF9737C5EC` (`id_type_products`),
  ADD KEY `FKED8DCCEF6909A537` (`id_size`),
  ADD KEY `FKED8DCCEF30B5C2E3` (`id_user_created`),
  ADD KEY `FKED8DCCEF64F051AF` (`id_cost_version`),
  ADD KEY `FKED8DCCEF7FA15615` (`id_pattern_var`),
  ADD KEY `FKED8DCCEF85F35FED` (`id_pr_status`),
  ADD KEY `FKED8DCCEF9B7A0D66` (`id_cost`),
  ADD KEY `FKED8DCCEF848AFF0E` (`id_Project`),
  ADD KEY `FKED8DCCEFC487DB4F` (`id_Pattern`),
  ADD KEY `FKED8DCCEF2740CAF0` (`id_Factory`),
  ADD KEY `FKED8DCCEFE56E24B6` (`id_user_updated`),
  ADD KEY `FKED8DCCEF1E385468` (`id_plz_det`);

--
-- Indexes for table `product_components`
--
ALTER TABLE `product_components`
  ADD PRIMARY KEY (`Id_pr_comp`),
  ADD KEY `FKED26F066848602BA` (`id_product`),
  ADD KEY `FKED26F066E1741C68` (`id_mat`);

--
-- Indexes for table `product_process`
--
ALTER TABLE `product_process`
  ADD PRIMARY KEY (`Id_pr_process`),
  ADD KEY `FK7F02331F848602BA` (`id_product`),
  ADD KEY `FK7F02331F8484A5BA` (`id_process`);

--
-- Indexes for table `product_status`
--
ALTER TABLE `product_status`
  ADD PRIMARY KEY (`id_pr_status`),
  ADD KEY `FK10B654230B5C2E3` (`id_user_created`),
  ADD KEY `FK10B6542E56E24B6` (`id_user_updated`);

--
-- Indexes for table `prod_cust`
--
ALTER TABLE `prod_cust`
  ADD PRIMARY KEY (`id_prd_cust`),
  ADD KEY `FKC0185A3B848602BA` (`id_product`),
  ADD KEY `FKC0185A3B1E385468` (`id_plz_det`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`id_Project`),
  ADD UNIQUE KEY `id_display` (`id_display`),
  ADD KEY `FKED904B192740CAF0` (`id_Factory`),
  ADD KEY `FKED904B1930B5C2E3` (`id_user_created`),
  ADD KEY `FKED904B19CC25B260` (`id_customer`),
  ADD KEY `FKED904B19E56E24B6` (`id_user_updated`),
  ADD KEY `FKED904B197FAF178B` (`id_pj_Status`);

--
-- Indexes for table `project_comment`
--
ALTER TABLE `project_comment`
  ADD PRIMARY KEY (`id_pj_comment`),
  ADD KEY `FKA9F9B73930B5C2E3` (`id_user_created`),
  ADD KEY `FKA9F9B73962BB7C3A` (`id_user`),
  ADD KEY `FKA9F9B739E56E24B6` (`id_user_updated`),
  ADD KEY `FKA9F9B739848AFF0E` (`id_Project`);

--
-- Indexes for table `project_status`
--
ALTER TABLE `project_status`
  ADD PRIMARY KEY (`id_pj_Status`),
  ADD KEY `FK39D083D830B5C2E3` (`id_user_created`),
  ADD KEY `FK39D083D8E56E24B6` (`id_user_updated`);

--
-- Indexes for table `shipment_type`
--
ALTER TABLE `shipment_type`
  ADD PRIMARY KEY (`id_shipment_type`),
  ADD KEY `FKDA40C6BF30B5C2E3` (`id_user_created`),
  ADD KEY `FKDA40C6BFE56E24B6` (`id_user_updated`);

--
-- Indexes for table `sizes`
--
ALTER TABLE `sizes`
  ADD PRIMARY KEY (`id_size`),
  ADD KEY `FK686209230B5C2E3` (`id_user_created`),
  ADD KEY `FK6862092E56E24B6` (`id_user_updated`);

--
-- Indexes for table `sizes_details`
--
ALTER TABLE `sizes_details`
  ADD PRIMARY KEY (`id_size_det`),
  ADD KEY `FK26D607956909A537` (`id_size`);

--
-- Indexes for table `type_of_customers`
--
ALTER TABLE `type_of_customers`
  ADD PRIMARY KEY (`id_type_Customer`),
  ADD KEY `FKCA7E4CD230B5C2E3` (`id_user_created`),
  ADD KEY `FKCA7E4CD2E56E24B6` (`id_user_updated`);

--
-- Indexes for table `type_of_products`
--
ALTER TABLE `type_of_products`
  ADD PRIMARY KEY (`id_type_products`),
  ADD KEY `FK22717D472740CAF0` (`id_Factory`),
  ADD KEY `FK22717D4730B5C2E3` (`id_user_created`),
  ADD KEY `FK22717D47E56E24B6` (`id_user_updated`),
  ADD KEY `FK22717D47A7F137D4` (`id_group_products`);

--
-- Indexes for table `type_product_language`
--
ALTER TABLE `type_product_language`
  ADD PRIMARY KEY (`id_type_language`),
  ADD KEY `FKE4F0030D30B5C2E3` (`id_user_created`),
  ADD KEY `FKE4F0030D7E351E17` (`id_language`),
  ADD KEY `FKE4F0030D84F5B125` (`id_type`),
  ADD KEY `FKE4F0030DE56E24B6` (`id_user_updated`);

--
-- Indexes for table `Units`
--
ALTER TABLE `Units`
  ADD PRIMARY KEY (`Id_unit`),
  ADD KEY `FK4E1674F2740CAF0` (`id_Factory`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `FK36EBCB2740CAF0` (`id_Factory`),
  ADD KEY `FK36EBCB62BFEBFC` (`id_Zone`),
  ADD KEY `FK36EBCBCC25B260` (`id_Customer`),
  ADD KEY `FK36EBCB7E351E17` (`id_language`),
  ADD KEY `FK36EBCB1AD8B11C` (`id_contact`),
  ADD KEY `FK36EBCBF27575E6` (`id_Agent`),
  ADD KEY `FK36EBCBB032F276` (`id_access_level`);

--
-- Indexes for table `usersetting`
--
ALTER TABLE `usersetting`
  ADD PRIMARY KEY (`id_USetting`),
  ADD KEY `FK128582530B5C2E3` (`id_user_created`),
  ADD KEY `FK12858257E351E17` (`id_language`),
  ADD KEY `FK1285825E56E24B6` (`id_user_updated`),
  ADD KEY `FK128582569C6524B` (`id_user_setting`);

--
-- Indexes for table `zone`
--
ALTER TABLE `zone`
  ADD PRIMARY KEY (`id_Zone`),
  ADD UNIQUE KEY `z_code` (`z_code`),
  ADD KEY `FK3923AC2740CAF0` (`id_Factory`),
  ADD KEY `FK3923AC30B5C2E3` (`id_user_created`),
  ADD KEY `FK3923AC7E351E17` (`id_language`),
  ADD KEY `FK3923ACC87A92C6` (`id_currency`),
  ADD KEY `FK3923ACE56E24B6` (`id_user_updated`),
  ADD KEY `FK3923AC1AD8B11C` (`id_contact`);

--
-- Indexes for table `zone_price`
--
ALTER TABLE `zone_price`
  ADD PRIMARY KEY (`id_zone_pl`),
  ADD KEY `FKDEBEC6F630B5C2E3` (`id_user_created`),
  ADD KEY `FKDEBEC6F662BFEBFC` (`id_Zone`),
  ADD KEY `FKDEBEC6F6E56E24B6` (`id_user_updated`),
  ADD KEY `FKDEBEC6F6105ACA65` (`id_plf`),
  ADD KEY `FKDEBEC6F61076F967` (`if_plf`),
  ADD KEY `FKDEBEC6F6523887A9` (`id_agent_pl`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `access_level`
--
ALTER TABLE `access_level`
  MODIFY `id_access_level` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `access_page`
--
ALTER TABLE `access_page`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `agent`
--
ALTER TABLE `agent`
  MODIFY `id_Agent` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT for table `agent_price`
--
ALTER TABLE `agent_price`
  MODIFY `id_agent_pl` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `id_contact` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=118;
--
-- AUTO_INCREMENT for table `contract`
--
ALTER TABLE `contract`
  MODIFY `id_contract` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `costing`
--
ALTER TABLE `costing`
  MODIFY `id_cost` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=99;
--
-- AUTO_INCREMENT for table `costing_description`
--
ALTER TABLE `costing_description`
  MODIFY `id_cost_description` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1097;
--
-- AUTO_INCREMENT for table `costing_versions`
--
ALTER TABLE `costing_versions`
  MODIFY `id_cost_version` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=102;
--
-- AUTO_INCREMENT for table `costing_version_description`
--
ALTER TABLE `costing_version_description`
  MODIFY `id_cost_version_desc` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=443;
--
-- AUTO_INCREMENT for table `currency`
--
ALTER TABLE `currency`
  MODIFY `id_currency` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `currency_convert`
--
ALTER TABLE `currency_convert`
  MODIFY `id_curr_conv` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=133;
--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id_Customer` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT for table `factory`
--
ALTER TABLE `factory`
  MODIFY `id_factory` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `forwarder`
--
ALTER TABLE `forwarder`
  MODIFY `id_forwarder` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `freight`
--
ALTER TABLE `freight`
  MODIFY `id_freight` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `group_materials`
--
ALTER TABLE `group_materials`
  MODIFY `Id_group_mat` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `group_of_products`
--
ALTER TABLE `group_of_products`
  MODIFY `id_group_products` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=67;
--
-- AUTO_INCREMENT for table `group_product_language`
--
ALTER TABLE `group_product_language`
  MODIFY `id_group_language` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=529;
--
-- AUTO_INCREMENT for table `incoterm`
--
ALTER TABLE `incoterm`
  MODIFY `id_incoterm` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id_language` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `materials`
--
ALTER TABLE `materials`
  MODIFY `Id_mat` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id_order` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `order_condition`
--
ALTER TABLE `order_condition`
  MODIFY `id_order_condition` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id_order_det` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `order_status`
--
ALTER TABLE `order_status`
  MODIFY `id_order_status` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `order_type`
--
ALTER TABLE `order_type`
  MODIFY `id_order_type` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `particular`
--
ALTER TABLE `particular`
  MODIFY `id_particular` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `patterns`
--
ALTER TABLE `patterns`
  MODIFY `id_pattern` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `pattern_description`
--
ALTER TABLE `pattern_description`
  MODIFY `id_pattern_des` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=225;
--
-- AUTO_INCREMENT for table `pattern_notes`
--
ALTER TABLE `pattern_notes`
  MODIFY `id_pattern_note` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=39;
--
-- AUTO_INCREMENT for table `pattern_part`
--
ALTER TABLE `pattern_part`
  MODIFY `id_pattern_part` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=98;
--
-- AUTO_INCREMENT for table `pattern_variantions`
--
ALTER TABLE `pattern_variantions`
  MODIFY `id_pattern_var` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=38;
--
-- AUTO_INCREMENT for table `pattern_var_des`
--
ALTER TABLE `pattern_var_des`
  MODIFY `id_pv_des` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=289;
--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `id_payment` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `person`
--
ALTER TABLE `person`
  MODIFY `id_person` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prd_cust`
--
ALTER TABLE `prd_cust`
  MODIFY `Id_prd_cust` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `price_list_factory`
--
ALTER TABLE `price_list_factory`
  MODIFY `id_plf` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `price_list_factory_detail`
--
ALTER TABLE `price_list_factory_detail`
  MODIFY `id_plf_det` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=107;
--
-- AUTO_INCREMENT for table `price_list_zone`
--
ALTER TABLE `price_list_zone`
  MODIFY `id_plz` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `price_list_zone_details`
--
ALTER TABLE `price_list_zone_details`
  MODIFY `id_plz_det` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=85;
--
-- AUTO_INCREMENT for table `process`
--
ALTER TABLE `process`
  MODIFY `Id_process` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id_product` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `product_components`
--
ALTER TABLE `product_components`
  MODIFY `Id_pr_comp` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product_process`
--
ALTER TABLE `product_process`
  MODIFY `Id_pr_process` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product_status`
--
ALTER TABLE `product_status`
  MODIFY `id_pr_status` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `prod_cust`
--
ALTER TABLE `prod_cust`
  MODIFY `id_prd_cust` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `id_Project` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT for table `project_comment`
--
ALTER TABLE `project_comment`
  MODIFY `id_pj_comment` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `project_status`
--
ALTER TABLE `project_status`
  MODIFY `id_pj_Status` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `shipment_type`
--
ALTER TABLE `shipment_type`
  MODIFY `id_shipment_type` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sizes`
--
ALTER TABLE `sizes`
  MODIFY `id_size` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `sizes_details`
--
ALTER TABLE `sizes_details`
  MODIFY `id_size_det` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=118;
--
-- AUTO_INCREMENT for table `type_of_customers`
--
ALTER TABLE `type_of_customers`
  MODIFY `id_type_Customer` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `type_of_products`
--
ALTER TABLE `type_of_products`
  MODIFY `id_type_products` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=56;
--
-- AUTO_INCREMENT for table `type_product_language`
--
ALTER TABLE `type_product_language`
  MODIFY `id_type_language` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=441;
--
-- AUTO_INCREMENT for table `Units`
--
ALTER TABLE `Units`
  MODIFY `Id_unit` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=44;
--
-- AUTO_INCREMENT for table `usersetting`
--
ALTER TABLE `usersetting`
  MODIFY `id_USetting` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `zone`
--
ALTER TABLE `zone`
  MODIFY `id_Zone` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `zone_price`
--
ALTER TABLE `zone_price`
  MODIFY `id_zone_pl` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `access_level`
--
ALTER TABLE `access_level`
  ADD CONSTRAINT `FK8BF918E930B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK8BF918E9E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `agent`
--
ALTER TABLE `agent`
  ADD CONSTRAINT `FK58743051AD8B11C` FOREIGN KEY (`id_contact`) REFERENCES `contact` (`id_contact`),
  ADD CONSTRAINT `FK587430530B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK587430562BFEBFC` FOREIGN KEY (`id_Zone`) REFERENCES `zone` (`id_Zone`),
  ADD CONSTRAINT `FK58743057E351E17` FOREIGN KEY (`id_language`) REFERENCES `languages` (`id_language`),
  ADD CONSTRAINT `FK587430587962C11` FOREIGN KEY (`id_plz`) REFERENCES `price_list_zone` (`id_plz`),
  ADD CONSTRAINT `FK5874305E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `agent_price`
--
ALTER TABLE `agent_price`
  ADD CONSTRAINT `FK76C43F8F30B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK76C43F8F848602BA` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`),
  ADD CONSTRAINT `FK76C43F8F87962C11` FOREIGN KEY (`id_plz`) REFERENCES `price_list_zone` (`id_plz`),
  ADD CONSTRAINT `FK76C43F8FE56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK76C43F8FF27575E6` FOREIGN KEY (`id_Agent`) REFERENCES `agent` (`id_Agent`);

--
-- Constraints for table `contact`
--
ALTER TABLE `contact`
  ADD CONSTRAINT `FK38B7242030B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK38B72420E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `contract`
--
ALTER TABLE `contract`
  ADD CONSTRAINT `FKDE35111262BFEBFC` FOREIGN KEY (`id_Zone`) REFERENCES `zone` (`id_Zone`),
  ADD CONSTRAINT `FKDE351112CC25B260` FOREIGN KEY (`id_Customer`) REFERENCES `customer` (`id_Customer`),
  ADD CONSTRAINT `FKDE351112F27575E6` FOREIGN KEY (`id_Agent`) REFERENCES `agent` (`id_Agent`);

--
-- Constraints for table `costing`
--
ALTER TABLE `costing`
  ADD CONSTRAINT `FK38FDB8F52740CAF0` FOREIGN KEY (`id_Factory`) REFERENCES `factory` (`id_factory`),
  ADD CONSTRAINT `FK38FDB8F530B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK38FDB8F59737C5EC` FOREIGN KEY (`id_type_products`) REFERENCES `type_of_products` (`id_type_products`),
  ADD CONSTRAINT `FK38FDB8F5CC25B260` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id_Customer`),
  ADD CONSTRAINT `FK38FDB8F5E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `costing_description`
--
ALTER TABLE `costing_description`
  ADD CONSTRAINT `FK89B0D3B230B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK89B0D3B27E351E17` FOREIGN KEY (`id_language`) REFERENCES `languages` (`id_language`),
  ADD CONSTRAINT `FK89B0D3B29B7A0D66` FOREIGN KEY (`id_cost`) REFERENCES `costing` (`id_cost`),
  ADD CONSTRAINT `FK89B0D3B2E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `costing_versions`
--
ALTER TABLE `costing_versions`
  ADD CONSTRAINT `FKB64E3AA530B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FKB64E3AA59B7A0D66` FOREIGN KEY (`id_cost`) REFERENCES `costing` (`id_cost`),
  ADD CONSTRAINT `FKB64E3AA5E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `costing_version_description`
--
ALTER TABLE `costing_version_description`
  ADD CONSTRAINT `FK213DB4CB30B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK213DB4CB64F051AF` FOREIGN KEY (`id_cost_version`) REFERENCES `costing_versions` (`id_cost_version`),
  ADD CONSTRAINT `FK213DB4CB7E351E17` FOREIGN KEY (`id_language`) REFERENCES `languages` (`id_language`),
  ADD CONSTRAINT `FK213DB4CBE56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `currency`
--
ALTER TABLE `currency`
  ADD CONSTRAINT `FK224BF01130B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK224BF011E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `currency_convert`
--
ALTER TABLE `currency_convert`
  ADD CONSTRAINT `FK6D2F138530B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK6D2F1385C87A92C6` FOREIGN KEY (`id_currency`) REFERENCES `currency` (`id_currency`),
  ADD CONSTRAINT `FK6D2F1385E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `FK24217FDE1AD8B11C` FOREIGN KEY (`id_contact`) REFERENCES `contact` (`id_contact`),
  ADD CONSTRAINT `FK24217FDE30B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK24217FDE62BFEBFC` FOREIGN KEY (`id_Zone`) REFERENCES `zone` (`id_Zone`),
  ADD CONSTRAINT `FK24217FDE7E351E17` FOREIGN KEY (`id_language`) REFERENCES `languages` (`id_language`),
  ADD CONSTRAINT `FK24217FDE9F3A43F1` FOREIGN KEY (`id_type_customer`) REFERENCES `type_of_customers` (`id_type_Customer`),
  ADD CONSTRAINT `FK24217FDEE56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK24217FDEF27575E6` FOREIGN KEY (`id_agent`) REFERENCES `agent` (`id_Agent`);

--
-- Constraints for table `factory`
--
ALTER TABLE `factory`
  ADD CONSTRAINT `FKBEEB310A1AD8B11C` FOREIGN KEY (`id_contact`) REFERENCES `contact` (`id_contact`),
  ADD CONSTRAINT `FKBEEB310A30B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FKBEEB310A7E351E17` FOREIGN KEY (`id_language`) REFERENCES `languages` (`id_language`),
  ADD CONSTRAINT `FKBEEB310AC87A92C6` FOREIGN KEY (`id_currency`) REFERENCES `currency` (`id_currency`),
  ADD CONSTRAINT `FKBEEB310AE56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `forwarder`
--
ALTER TABLE `forwarder`
  ADD CONSTRAINT `FK7D0A02321AD8B11C` FOREIGN KEY (`id_contact`) REFERENCES `contact` (`id_contact`),
  ADD CONSTRAINT `FK7D0A023230B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK7D0A0232E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `freight`
--
ALTER TABLE `freight`
  ADD CONSTRAINT `FKDC04A34330B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FKDC04A343E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `group_materials`
--
ALTER TABLE `group_materials`
  ADD CONSTRAINT `FK9EF45E6C2740CAF0` FOREIGN KEY (`id_Factory`) REFERENCES `factory` (`id_factory`);

--
-- Constraints for table `group_of_products`
--
ALTER TABLE `group_of_products`
  ADD CONSTRAINT `FKFA0A250C2740CAF0` FOREIGN KEY (`id_Factory`) REFERENCES `factory` (`id_factory`),
  ADD CONSTRAINT `FKFA0A250C30B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FKFA0A250CE56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `group_product_language`
--
ALTER TABLE `group_product_language`
  ADD CONSTRAINT `FK55D26E6830B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK55D26E687E351E17` FOREIGN KEY (`id_language`) REFERENCES `languages` (`id_language`),
  ADD CONSTRAINT `FK55D26E68E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK55D26E68E7520B67` FOREIGN KEY (`id_group`) REFERENCES `group_of_products` (`id_group_products`);

--
-- Constraints for table `incoterm`
--
ALTER TABLE `incoterm`
  ADD CONSTRAINT `FK58B183D30B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK58B183DE56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `languages`
--
ALTER TABLE `languages`
  ADD CONSTRAINT `FK5A7FD81B30B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK5A7FD81BE56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `materials`
--
ALTER TABLE `materials`
  ADD CONSTRAINT `FK2899402C2740CAF0` FOREIGN KEY (`id_Factory`) REFERENCES `factory` (`id_factory`),
  ADD CONSTRAINT `FK2899402C30B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK2899402C3F0873E8` FOREIGN KEY (`id_group_mat`) REFERENCES `group_materials` (`Id_group_mat`),
  ADD CONSTRAINT `FK2899402CE56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `FKC3DF62E51464E4AA` FOREIGN KEY (`id_order_status`) REFERENCES `order_status` (`id_order_status`),
  ADD CONSTRAINT `FKC3DF62E54BA2CCE8` FOREIGN KEY (`id_payment`) REFERENCES `payment` (`id_payment`),
  ADD CONSTRAINT `FKC3DF62E5702CDCBA` FOREIGN KEY (`id_order_type`) REFERENCES `order_type` (`id_order_type`),
  ADD CONSTRAINT `FKC3DF62E586C57AD7` FOREIGN KEY (`ord_plz`) REFERENCES `price_list_zone` (`id_plz`),
  ADD CONSTRAINT `FKC3DF62E5CC25B260` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id_Customer`),
  ADD CONSTRAINT `FKC3DF62E5D92D17B0` FOREIGN KEY (`id_order_condition`) REFERENCES `order_condition` (`id_order_condition`),
  ADD CONSTRAINT `FKC3DF62E5F8A192B` FOREIGN KEY (`ord_plf`) REFERENCES `price_list_factory` (`id_plf`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `FK521CF251848602BA` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`),
  ADD CONSTRAINT `FK521CF251B197DA0F` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id_order`),
  ADD CONSTRAINT `FK521CF251DD39650E` FOREIGN KEY (`id_size_det`) REFERENCES `sizes_details` (`id_size_det`);

--
-- Constraints for table `particular`
--
ALTER TABLE `particular`
  ADD CONSTRAINT `FK17F22D51AD8B11C` FOREIGN KEY (`id_contact`) REFERENCES `contact` (`id_contact`),
  ADD CONSTRAINT `FK17F22D530B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK17F22D57E351E17` FOREIGN KEY (`id_language`) REFERENCES `languages` (`id_language`),
  ADD CONSTRAINT `FK17F22D5CC25B260` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id_Customer`),
  ADD CONSTRAINT `FK17F22D5E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `patterns`
--
ALTER TABLE `patterns`
  ADD CONSTRAINT `FK4A4486E32740CAF0` FOREIGN KEY (`id_Factory`) REFERENCES `factory` (`id_factory`),
  ADD CONSTRAINT `FK4A4486E330B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK4A4486E3A7F137D4` FOREIGN KEY (`id_group_products`) REFERENCES `group_of_products` (`id_group_products`),
  ADD CONSTRAINT `FK4A4486E3E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `pattern_description`
--
ALTER TABLE `pattern_description`
  ADD CONSTRAINT `FK31A5F5CD30B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK31A5F5CD7E351E17` FOREIGN KEY (`id_language`) REFERENCES `languages` (`id_language`),
  ADD CONSTRAINT `FK31A5F5CDC487DB4F` FOREIGN KEY (`id_pattern`) REFERENCES `patterns` (`id_pattern`),
  ADD CONSTRAINT `FK31A5F5CDE56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `pattern_notes`
--
ALTER TABLE `pattern_notes`
  ADD CONSTRAINT `FK911CB15230B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK911CB152C487DB4F` FOREIGN KEY (`id_pattern`) REFERENCES `patterns` (`id_pattern`);

--
-- Constraints for table `pattern_part`
--
ALTER TABLE `pattern_part`
  ADD CONSTRAINT `FKF42AEB427E351E17` FOREIGN KEY (`id_language`) REFERENCES `languages` (`id_language`),
  ADD CONSTRAINT `FKF42AEB42C487DB4F` FOREIGN KEY (`id_pattern`) REFERENCES `patterns` (`id_pattern`);

--
-- Constraints for table `pattern_variantions`
--
ALTER TABLE `pattern_variantions`
  ADD CONSTRAINT `FK39092141C487DB4F` FOREIGN KEY (`id_pattern`) REFERENCES `patterns` (`id_pattern`);

--
-- Constraints for table `pattern_var_des`
--
ALTER TABLE `pattern_var_des`
  ADD CONSTRAINT `FK4BE4914B7E351E17` FOREIGN KEY (`id_language`) REFERENCES `languages` (`id_language`),
  ADD CONSTRAINT `FK4BE4914B7FA15615` FOREIGN KEY (`id_pattern_var`) REFERENCES `pattern_variantions` (`id_pattern_var`);

--
-- Constraints for table `person`
--
ALTER TABLE `person`
  ADD CONSTRAINT `FKC4E39B551AD8B11C` FOREIGN KEY (`id_contact`) REFERENCES `contact` (`id_contact`),
  ADD CONSTRAINT `FKC4E39B5530B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FKC4E39B55E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `prd_cust`
--
ALTER TABLE `prd_cust`
  ADD CONSTRAINT `FKB11821D0848602BA` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`);

--
-- Constraints for table `price_list_factory`
--
ALTER TABLE `price_list_factory`
  ADD CONSTRAINT `FK577FE19F2740CAF0` FOREIGN KEY (`id_Factory`) REFERENCES `factory` (`id_factory`),
  ADD CONSTRAINT `FK577FE19F30B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK577FE19F62BFEBFC` FOREIGN KEY (`id_Zone`) REFERENCES `zone` (`id_Zone`),
  ADD CONSTRAINT `FK577FE19F7E351E17` FOREIGN KEY (`id_language`) REFERENCES `languages` (`id_language`),
  ADD CONSTRAINT `FK577FE19FC87A92C6` FOREIGN KEY (`id_currency`) REFERENCES `currency` (`id_currency`),
  ADD CONSTRAINT `FK577FE19FE56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `price_list_factory_detail`
--
ALTER TABLE `price_list_factory_detail`
  ADD CONSTRAINT `FKCAC5F2F1105ACA65` FOREIGN KEY (`id_plf`) REFERENCES `price_list_factory` (`id_plf`),
  ADD CONSTRAINT `FKCAC5F2F12740CAF0` FOREIGN KEY (`id_factory`) REFERENCES `factory` (`id_factory`),
  ADD CONSTRAINT `FKCAC5F2F130B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FKCAC5F2F164F051AF` FOREIGN KEY (`id_cost_version`) REFERENCES `costing_versions` (`id_cost_version`),
  ADD CONSTRAINT `FKCAC5F2F19B7A0D66` FOREIGN KEY (`id_cost`) REFERENCES `costing` (`id_cost`),
  ADD CONSTRAINT `FKCAC5F2F1C87A92C6` FOREIGN KEY (`id_currency`) REFERENCES `currency` (`id_currency`),
  ADD CONSTRAINT `FKCAC5F2F1E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `price_list_zone`
--
ALTER TABLE `price_list_zone`
  ADD CONSTRAINT `FKCEBB4337105ACA65` FOREIGN KEY (`id_plf`) REFERENCES `price_list_factory` (`id_plf`),
  ADD CONSTRAINT `FKCEBB433730B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FKCEBB43377E351E17` FOREIGN KEY (`id_language`) REFERENCES `languages` (`id_language`),
  ADD CONSTRAINT `FKCEBB4337C87A92C6` FOREIGN KEY (`id_currency`) REFERENCES `currency` (`id_currency`),
  ADD CONSTRAINT `FKCEBB4337E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `price_list_zone_details`
--
ALTER TABLE `price_list_zone_details`
  ADD CONSTRAINT `FK90E4B53A30B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK90E4B53A56FFBC0B` FOREIGN KEY (`id_plf_det`) REFERENCES `price_list_factory_detail` (`id_plf_det`),
  ADD CONSTRAINT `FK90E4B53A87962C11` FOREIGN KEY (`id_plz`) REFERENCES `price_list_zone` (`id_plz`),
  ADD CONSTRAINT `FK90E4B53AE56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `process`
--
ALTER TABLE `process`
  ADD CONSTRAINT `FKED8D1E6F6765E577` FOREIGN KEY (`id_unit`) REFERENCES `Units` (`Id_unit`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `FKED8DCCEF1E385468` FOREIGN KEY (`id_plz_det`) REFERENCES `price_list_zone_details` (`id_plz_det`),
  ADD CONSTRAINT `FKED8DCCEF2740CAF0` FOREIGN KEY (`id_Factory`) REFERENCES `factory` (`id_factory`),
  ADD CONSTRAINT `FKED8DCCEF30B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FKED8DCCEF404CD4C8` FOREIGN KEY (`id_contract`) REFERENCES `contract` (`id_contract`),
  ADD CONSTRAINT `FKED8DCCEF64F051AF` FOREIGN KEY (`id_cost_version`) REFERENCES `costing_versions` (`id_cost_version`),
  ADD CONSTRAINT `FKED8DCCEF6909A537` FOREIGN KEY (`id_size`) REFERENCES `sizes` (`id_size`),
  ADD CONSTRAINT `FKED8DCCEF7FA15615` FOREIGN KEY (`id_pattern_var`) REFERENCES `pattern_variantions` (`id_pattern_var`),
  ADD CONSTRAINT `FKED8DCCEF848AFF0E` FOREIGN KEY (`id_Project`) REFERENCES `project` (`id_Project`),
  ADD CONSTRAINT `FKED8DCCEF85F35FED` FOREIGN KEY (`id_pr_status`) REFERENCES `product_status` (`id_pr_status`),
  ADD CONSTRAINT `FKED8DCCEF9737C5EC` FOREIGN KEY (`id_type_products`) REFERENCES `type_of_products` (`id_type_products`),
  ADD CONSTRAINT `FKED8DCCEF9B7A0D66` FOREIGN KEY (`id_cost`) REFERENCES `costing` (`id_cost`),
  ADD CONSTRAINT `FKED8DCCEFC487DB4F` FOREIGN KEY (`id_Pattern`) REFERENCES `patterns` (`id_pattern`),
  ADD CONSTRAINT `FKED8DCCEFE56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `product_components`
--
ALTER TABLE `product_components`
  ADD CONSTRAINT `FKED26F066848602BA` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`),
  ADD CONSTRAINT `FKED26F066E1741C68` FOREIGN KEY (`id_mat`) REFERENCES `materials` (`Id_mat`);

--
-- Constraints for table `product_process`
--
ALTER TABLE `product_process`
  ADD CONSTRAINT `FK7F02331F8484A5BA` FOREIGN KEY (`id_process`) REFERENCES `process` (`Id_process`),
  ADD CONSTRAINT `FK7F02331F848602BA` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`);

--
-- Constraints for table `product_status`
--
ALTER TABLE `product_status`
  ADD CONSTRAINT `FK10B654230B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK10B6542E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `prod_cust`
--
ALTER TABLE `prod_cust`
  ADD CONSTRAINT `FKC0185A3B1E385468` FOREIGN KEY (`id_plz_det`) REFERENCES `price_list_zone_details` (`id_plz_det`),
  ADD CONSTRAINT `FKC0185A3B848602BA` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`);

--
-- Constraints for table `project`
--
ALTER TABLE `project`
  ADD CONSTRAINT `FKED904B192740CAF0` FOREIGN KEY (`id_Factory`) REFERENCES `factory` (`id_factory`),
  ADD CONSTRAINT `FKED904B1930B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FKED904B197FAF178B` FOREIGN KEY (`id_pj_Status`) REFERENCES `project_status` (`id_pj_Status`),
  ADD CONSTRAINT `FKED904B19CC25B260` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id_Customer`),
  ADD CONSTRAINT `FKED904B19E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `project_comment`
--
ALTER TABLE `project_comment`
  ADD CONSTRAINT `FKA9F9B73930B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FKA9F9B73962BB7C3A` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FKA9F9B739848AFF0E` FOREIGN KEY (`id_Project`) REFERENCES `project` (`id_Project`),
  ADD CONSTRAINT `FKA9F9B739E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `project_status`
--
ALTER TABLE `project_status`
  ADD CONSTRAINT `FK39D083D830B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK39D083D8E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `shipment_type`
--
ALTER TABLE `shipment_type`
  ADD CONSTRAINT `FKDA40C6BF30B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FKDA40C6BFE56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `sizes`
--
ALTER TABLE `sizes`
  ADD CONSTRAINT `FK686209230B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK6862092E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `sizes_details`
--
ALTER TABLE `sizes_details`
  ADD CONSTRAINT `FK26D607956909A537` FOREIGN KEY (`id_size`) REFERENCES `sizes` (`id_size`);

--
-- Constraints for table `type_of_customers`
--
ALTER TABLE `type_of_customers`
  ADD CONSTRAINT `FKCA7E4CD230B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FKCA7E4CD2E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `type_of_products`
--
ALTER TABLE `type_of_products`
  ADD CONSTRAINT `FK22717D472740CAF0` FOREIGN KEY (`id_Factory`) REFERENCES `factory` (`id_factory`),
  ADD CONSTRAINT `FK22717D4730B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK22717D47A7F137D4` FOREIGN KEY (`id_group_products`) REFERENCES `group_of_products` (`id_group_products`),
  ADD CONSTRAINT `FK22717D47E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `type_product_language`
--
ALTER TABLE `type_product_language`
  ADD CONSTRAINT `FKE4F0030D30B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FKE4F0030D7E351E17` FOREIGN KEY (`id_language`) REFERENCES `languages` (`id_language`),
  ADD CONSTRAINT `FKE4F0030D84F5B125` FOREIGN KEY (`id_type`) REFERENCES `type_of_products` (`id_type_products`),
  ADD CONSTRAINT `FKE4F0030DE56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `Units`
--
ALTER TABLE `Units`
  ADD CONSTRAINT `FK4E1674F2740CAF0` FOREIGN KEY (`id_Factory`) REFERENCES `factory` (`id_factory`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `FK36EBCB1AD8B11C` FOREIGN KEY (`id_contact`) REFERENCES `contact` (`id_contact`),
  ADD CONSTRAINT `FK36EBCB2740CAF0` FOREIGN KEY (`id_Factory`) REFERENCES `factory` (`id_factory`),
  ADD CONSTRAINT `FK36EBCB62BFEBFC` FOREIGN KEY (`id_Zone`) REFERENCES `zone` (`id_Zone`),
  ADD CONSTRAINT `FK36EBCB7E351E17` FOREIGN KEY (`id_language`) REFERENCES `languages` (`id_language`),
  ADD CONSTRAINT `FK36EBCBB032F276` FOREIGN KEY (`id_access_level`) REFERENCES `access_level` (`id_access_level`),
  ADD CONSTRAINT `FK36EBCBCC25B260` FOREIGN KEY (`id_Customer`) REFERENCES `customer` (`id_Customer`),
  ADD CONSTRAINT `FK36EBCBF27575E6` FOREIGN KEY (`id_Agent`) REFERENCES `agent` (`id_Agent`);

--
-- Constraints for table `usersetting`
--
ALTER TABLE `usersetting`
  ADD CONSTRAINT `FK128582530B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK128582569C6524B` FOREIGN KEY (`id_user_setting`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK12858257E351E17` FOREIGN KEY (`id_language`) REFERENCES `languages` (`id_language`),
  ADD CONSTRAINT `FK1285825E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `zone`
--
ALTER TABLE `zone`
  ADD CONSTRAINT `FK3923AC1AD8B11C` FOREIGN KEY (`id_contact`) REFERENCES `contact` (`id_contact`),
  ADD CONSTRAINT `FK3923AC2740CAF0` FOREIGN KEY (`id_Factory`) REFERENCES `factory` (`id_factory`),
  ADD CONSTRAINT `FK3923AC30B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FK3923AC7E351E17` FOREIGN KEY (`id_language`) REFERENCES `languages` (`id_language`),
  ADD CONSTRAINT `FK3923ACC87A92C6` FOREIGN KEY (`id_currency`) REFERENCES `currency` (`id_currency`),
  ADD CONSTRAINT `FK3923ACE56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `zone_price`
--
ALTER TABLE `zone_price`
  ADD CONSTRAINT `FKDEBEC6F6105ACA65` FOREIGN KEY (`id_plf`) REFERENCES `price_list_factory` (`id_plf`),
  ADD CONSTRAINT `FKDEBEC6F61076F967` FOREIGN KEY (`if_plf`) REFERENCES `price_list_factory` (`id_plf`),
  ADD CONSTRAINT `FKDEBEC6F630B5C2E3` FOREIGN KEY (`id_user_created`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `FKDEBEC6F6523887A9` FOREIGN KEY (`id_agent_pl`) REFERENCES `agent_price` (`id_agent_pl`),
  ADD CONSTRAINT `FKDEBEC6F662BFEBFC` FOREIGN KEY (`id_Zone`) REFERENCES `zone` (`id_Zone`),
  ADD CONSTRAINT `FKDEBEC6F6E56E24B6` FOREIGN KEY (`id_user_updated`) REFERENCES `user` (`id_user`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
