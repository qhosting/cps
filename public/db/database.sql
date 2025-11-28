-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 24, 2024 at 11:03 PM
-- Server version: 10.11.10-MariaDB
-- PHP Version: 8.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `labslicensedash_syslic`
--

-- --------------------------------------------------------

--
-- Table structure for table `black_lists`
--

CREATE TABLE `black_lists` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ip` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `buyers`
--

CREATE TABLE `buyers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `domain` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `buyers`
--

INSERT INTO `buyers` (`id`, `code`, `domain`, `status`, `created_at`, `updated_at`) VALUES
(1, 'eaece', 'syslic.net', 1, '2023-04-29 20:28:30', '2023-04-29 20:28:30');

-- --------------------------------------------------------

--
-- Table structure for table `cpanel_latests`
--

CREATE TABLE `cpanel_latests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `version` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cpanel_versions`
--

CREATE TABLE `cpanel_versions` (
  `id` int(11) NOT NULL,
  `cpversion` varchar(255) DEFAULT NULL,
  `FO` varchar(255) DEFAULT NULL,
  `FMA` varchar(255) DEFAULT NULL,
  `FIP` varchar(255) DEFAULT NULL,
  `FR` varchar(255) DEFAULT NULL,
  `FV` varchar(255) DEFAULT NULL,
  `FMM` varchar(255) DEFAULT NULL,
  `FD` varchar(255) DEFAULT NULL,
  `FIU` varchar(255) DEFAULT NULL,
  `FIV` varchar(255) DEFAULT NULL,
  `FIL` varchar(255) DEFAULT NULL,
  `FK` varchar(255) DEFAULT NULL,
  `FKT` varchar(255) DEFAULT NULL,
  `FKTH` varchar(255) DEFAULT NULL,
  `FN` varchar(255) DEFAULT NULL,
  `EW` varchar(255) DEFAULT NULL,
  `license` longtext DEFAULT NULL,
  `cpsanitycheck` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reseller_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(8,2) NOT NULL,
  `description` text NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'unpaid',
  `ip` varchar(255) DEFAULT NULL,
  `paid_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `end_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(488, 'default', '{\"uuid\":\"b78a2b9d-95ec-475b-afba-7f901993e002\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"103.110.219.51\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-26 10:47:05.283870\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"3d1255ae-8bf8-4c3b-ac4b-412be70bd300\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690368425, 1690368425),
(489, 'default', '{\"uuid\":\"e081be2c-ad61-4264-8178-221189762c6e\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-26 11:54:19.803640\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Linux; Android 10; K) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Mobile Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"5bf8ed49-de32-43bf-929c-98e8f4218296\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690372459, 1690372459),
(490, 'default', '{\"uuid\":\"363151ce-4cc2-4cb5-acb1-f5979e7e15d9\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-26 11:56:50.605111\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/115.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"15e986b8-a2cf-4ff1-84fe-cc3faa30e19d\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690372610, 1690372610),
(491, 'default', '{\"uuid\":\"099a3699-b5df-45a8-8954-a66b323393d9\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1380;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"592406bd-b958-4b73-a98d-2215b8cc6273\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690372991, 1690372991),
(492, 'default', '{\"uuid\":\"6222a37b-9a2e-438c-afee-d8ef7062b0b3\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-26 12:12:23.617167\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/115.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"68858025-30de-40ed-b0fc-05b6f74ca0e9\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690373543, 1690373543),
(493, 'default', '{\"uuid\":\"0c84cc8e-0931-4c9c-9905-d9aa91d68542\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"58.181.101.138\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-26 15:29:37.736917\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Linux; Android 10; K) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Mobile Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"5c68519a-b5df-427e-a8a6-d00963947ef9\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690385377, 1690385377),
(494, 'default', '{\"uuid\":\"93a249f8-adc0-46e7-abc9-1ac8d3485833\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"103.110.219.51\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-26 15:29:38.653153\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"3106ae58-9226-4a13-a7b9-910dfe774fc1\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690385378, 1690385378),
(495, 'default', '{\"uuid\":\"64504fc1-5942-4b27-a623-bbc1995dc5f3\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:18;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"58.181.101.138\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-26 15:46:03.335747\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Linux; Android 10; K) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Mobile Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"c576710c-dc43-4287-8377-c57c0f684a6c\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690386363, 1690386363),
(496, 'default', '{\"uuid\":\"bd7ef3f5-b196-47eb-a40a-934a946f14b0\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:13:\\\"59.103.88.138\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-26 15:48:47.202816\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Linux; Android 10; K) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Mobile Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"648d84e7-3a73-4627-ac6f-c96f9b5b5fea\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690386527, 1690386527),
(497, 'default', '{\"uuid\":\"a55e3788-5de5-44d3-ae16-35c744acfe1a\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:12:\\\"103.134.3.42\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-26 16:00:20.776864\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"44795ec6-3b2b-4537-a770-e20c325bda3b\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690387220, 1690387220),
(498, 'default', '{\"uuid\":\"bb6f5067-e96e-401d-870f-9a0cbcdc2210\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-26 16:04:50.600141\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Linux; Android 10; K) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Mobile Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"24bd7dba-e8dd-40aa-9f23-7ee4d8a3a897\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690387490, 1690387490),
(499, 'default', '{\"uuid\":\"42fee914-01fe-41c9-a15e-599363fffcfa\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-26 17:24:10.750026\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/115.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"9a7bd263-3cee-478c-94d3-0d845c9394af\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690392250, 1690392250),
(500, 'default', '{\"uuid\":\"7284536b-1793-45fc-bafd-16772aa0dd91\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:19;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-26 17:25:34.438043\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/115.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"83b19a1f-fee1-459c-949b-e14972f35b01\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690392334, 1690392334),
(501, 'default', '{\"uuid\":\"6c28d8c3-20af-4636-83e0-8e6cb5ca24b0\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-26 17:28:01.515104\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/115.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"00016767-7d33-4b6f-a21c-8504f5a78603\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690392481, 1690392481),
(502, 'default', '{\"uuid\":\"1fe258ed-7de0-4979-b1d3-c464f9f05eb8\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:19;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-26 17:28:20.033608\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/115.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"206fb451-a26d-4419-abd3-3eacc04afc40\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690392500, 1690392500),
(503, 'default', '{\"uuid\":\"5b9f9798-b026-4186-ac5c-1fc023894c36\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:19;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1389;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"b33cf7eb-b55d-4579-9fc8-ab02709915bb\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690392510, 1690392510),
(504, 'default', '{\"uuid\":\"ceda377a-1b60-488d-8e95-dfd3a91b13e5\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-26 17:29:55.128523\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/115.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"dea35fea-bbf0-4192-a136-f31f2ad8079a\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690392595, 1690392595),
(505, 'default', '{\"uuid\":\"864a4fb3-7acf-46c8-b65c-fee9876f708a\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:19;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-26 17:30:40.463240\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/115.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"ebf33ce9-ddc8-4e77-a5b7-b995bafe0891\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690392640, 1690392640),
(506, 'default', '{\"uuid\":\"7e217a23-3a4f-4619-8e08-e960411c5e17\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:20;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-26 17:32:14.937223\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/115.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"cce3959f-5588-4ecb-9139-9db58bbbc824\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690392734, 1690392734),
(507, 'default', '{\"uuid\":\"91cf1538-78bf-438e-8d82-882019bbd0c9\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-26 17:32:33.394923\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/115.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"138e5f80-75d1-4ee2-a7a4-f9a475abebbd\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690392753, 1690392753),
(508, 'default', '{\"uuid\":\"06325108-8c14-4273-b2da-955412bd6356\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:19;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-26 22:59:30.211528\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Linux; Android 10; K) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Mobile Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"ecd24cb8-b734-4a8d-8edb-c88a8fab2ae9\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690412370, 1690412370),
(509, 'default', '{\"uuid\":\"0edba845-131b-4cb0-87af-f9586805aba6\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-26 22:59:40.931841\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Linux; Android 10; K) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Mobile Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"166b1828-2639-4b77-aefe-478d53cba28a\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690412380, 1690412380),
(510, 'default', '{\"uuid\":\"ae94eccc-0aee-4c2f-9bba-b490d355b887\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-27 06:13:23.961525\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Linux; Android 10; K) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Mobile Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"166d696a-54cd-4b0d-9eb3-e1ec1f9fd694\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690438404, 1690438404),
(511, 'default', '{\"uuid\":\"901890e3-53e9-4221-843f-ee1d8a2f0863\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-27 09:26:17.469452\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Linux; Android 10; K) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Mobile Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"4985ff5b-e08b-4db8-b7e1-25728fb46d0e\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690449977, 1690449977),
(512, 'default', '{\"uuid\":\"36e5c32f-0c12-4de7-b912-f1bb2a7b7d3e\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-27 18:14:26.006290\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Linux; Android 10; K) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Mobile Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"47ba0535-2e77-47de-a7a9-25c04935c603\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690481666, 1690481666),
(513, 'default', '{\"uuid\":\"ecec08c6-39f5-4dfe-b0d9-aff379163ef7\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1390;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"19d40f1b-bdaa-44cf-b074-5c9dbf894f3e\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690485794, 1690485794),
(514, 'default', '{\"uuid\":\"fafd7021-b9dd-411b-b0db-e2572831ff28\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"103.110.219.51\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-27 19:36:03.997686\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"205ad899-2966-4197-b9db-bf1d6d0b0393\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690486564, 1690486564),
(515, 'default', '{\"uuid\":\"e50009ab-544f-4727-a087-0f49d23eeaed\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"103.110.219.51\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-28 03:44:45.370608\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/115.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"3f85b123-a042-4319-b94d-7e949a49122c\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690515885, 1690515885),
(516, 'default', '{\"uuid\":\"dba5d7b7-da57-4bba-be65-63dbc479cb83\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"103.110.219.51\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-28 03:49:55.896976\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/115.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"487be970-7ac1-4ac4-9563-1a290a4e7871\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690516195, 1690516195),
(517, 'default', '{\"uuid\":\"b6e34411-c61b-4f74-a364-879936d2124c\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:19;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-28 12:11:05.400033\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Linux; Android 10; K) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Mobile Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"d626a851-aa2c-44fc-ad18-76a8a4490dab\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690546265, 1690546265),
(518, 'default', '{\"uuid\":\"133be66e-8bcf-427e-bfa6-31c7acde2774\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:19;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-28 13:30:54.796645\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Linux; Android 10; K) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Mobile Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"8c8f312a-1ca1-4ad6-97a2-d94dfc5f8eb7\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690551054, 1690551054),
(519, 'default', '{\"uuid\":\"a3b7b114-e986-4a93-9189-7024c618345a\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:19;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-28 18:12:01.192208\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Linux; Android 10; K) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Mobile Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"7994d351-1a21-438a-a636-8ed0cab86e2b\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690567921, 1690567921),
(520, 'default', '{\"uuid\":\"4ad75dd8-12ad-4705-9b5e-7c74c586246c\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:20;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-28 19:29:45.482256\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Linux; Android 10; K) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Mobile Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"7adf6262-e2df-4d0f-8287-079919707dfa\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690572585, 1690572585),
(521, 'default', '{\"uuid\":\"72a05051-9f18-4113-a22a-56156b05a240\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:19;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-28 19:30:15.128060\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Linux; Android 10; K) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/114.0.0.0 Mobile Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"266dc841-bce3-4d9a-bd89-2aa16e2bdce3\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690572615, 1690572615),
(522, 'default', '{\"uuid\":\"f002fff2-84d2-4f82-9fb2-0db3520fe799\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:19;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-29 13:43:01.783875\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Linux; Android 10; K) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/115.0.0.0 Mobile Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"32d8d593-7cdf-41c8-8883-3a7da099b906\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690638181, 1690638181);
INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(523, 'default', '{\"uuid\":\"5fee8389-cf0a-4e2c-99f8-294922fd718c\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:19;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-29 13:43:30.155783\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Linux; Android 10; K) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/115.0.0.0 Mobile Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"d36c8723-eaa9-4eae-9313-7e207a03261d\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690638210, 1690638210),
(524, 'default', '{\"uuid\":\"9d579ee8-0e8e-4836-9a6a-6fe2770cf8c8\",\"displayName\":\"App\\\\Notifications\\\\ReNewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:19;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:42:\\\"App\\\\Notifications\\\\ReNewLicenseNotification\\\":2:{s:51:\\\"\\u0000App\\\\Notifications\\\\ReNewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1393;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"ca5c212f-e011-4131-9461-7096f8027930\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690638290, 1690638290),
(525, 'default', '{\"uuid\":\"764caa02-f750-4588-8875-a70b4cf9fa89\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:19;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"185.59.124.226\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2023-07-29 19:30:24.907047\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Linux; Android 10; K) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/115.0.0.0 Mobile Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"95eae929-a1b3-441f-8e95-78c97effb5f8\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1690659024, 1690659024),
(526, 'default', '{\"uuid\":\"f10a9c82-0456-4068-9054-39a6b4cb2b90\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:11:\\\"2.83.47.122\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-05-21 18:56:36.825582\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/124.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"3ceff3ac-0b0f-431d-a03c-7fb14f90ef53\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716317796, 1716317796),
(527, 'default', '{\"uuid\":\"6e594ef3-51f5-4ef9-bcb7-fe95d8e5a038\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:11:\\\"2.83.47.122\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-05-22 09:01:16.791776\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/124.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"edd3edae-12b0-4811-9791-aecf85ed4320\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716368476, 1716368476),
(528, 'default', '{\"uuid\":\"37dc2502-bfe2-4fa4-bd3e-6d648f9637b8\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:11:\\\"2.83.47.122\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-05-22 10:14:29.361625\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/124.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"e5504032-9acb-4a51-a147-37db6f1e20d2\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716372869, 1716372869),
(529, 'default', '{\"uuid\":\"2be1597b-5d54-4a99-a886-3b7520a75e14\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:13:\\\"208.115.237.6\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-05-25 16:45:41.350893\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/125.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"e003a43f-b4a6-4060-8c8a-06923edf0f7d\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716655541, 1716655541),
(530, 'default', '{\"uuid\":\"42d3189c-2ae8-4fd5-9937-11c70dc547ed\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:13:\\\"208.115.237.6\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-05-25 19:30:53.634629\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/125.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"4c729e5b-c060-4940-b52e-81be3ab942fb\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716665453, 1716665453),
(531, 'default', '{\"uuid\":\"7094dc5f-5a77-481a-9cc3-4e6a1eb06151\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1402;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"8a7db9c7-c45f-4369-8c8c-3bef62298c27\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716668749, 1716668749),
(532, 'default', '{\"uuid\":\"4c47c1d5-876f-4182-9d5d-7a9b8ee23027\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1408;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"2a71cc12-052f-40f1-893d-6d9004e81d26\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716684582, 1716684582),
(533, 'default', '{\"uuid\":\"3e04d382-de7f-4e40-b913-56bfde73b2cc\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:14:\\\"169.197.143.22\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-05-26 01:53:43.586032\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/125.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"b03a275d-e2ce-42e2-b183-388b8c9a3a50\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716688423, 1716688423),
(534, 'default', '{\"uuid\":\"7b5322bf-9aeb-473a-8277-9995f49a0890\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:37:\\\"2001:8a0:e57c:3600:88a:77ba:680c:c158\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-05-26 12:42:23.661251\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/125.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"07a50708-19f8-4556-b6c9-31b814e9cccb\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716727343, 1716727343),
(535, 'default', '{\"uuid\":\"5fdc80fc-fe42-4286-ad7a-5455d2dd39b7\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:37:\\\"2001:8a0:e57c:3600:88a:77ba:680c:c158\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-05-26 17:22:49.200157\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/125.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"845dc4a2-a955-48b1-952d-ce88d2dd7ec6\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716744169, 1716744169),
(536, 'default', '{\"uuid\":\"c7a38091-587d-4648-81e9-6a1aa33a91e3\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1411;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"1408824f-beda-4cea-ad92-547121dfa5a9\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716744239, 1716744239),
(537, 'default', '{\"uuid\":\"20c4ed5e-abad-45eb-a678-723c26903025\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1414;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"64f88a4e-d42e-40c9-815a-bf653c296edb\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716754108, 1716754108),
(538, 'default', '{\"uuid\":\"5b40ad55-09e8-4ae1-bc00-9402186e6b1a\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1417;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"2fc36d4b-acde-45a0-ad2f-c7b09f7234c1\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716755528, 1716755528),
(539, 'default', '{\"uuid\":\"2c875cd8-f537-4512-a963-c7b921994911\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1418;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"a6a250bf-421d-4026-8289-c23967c433a5\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716758207, 1716758207),
(540, 'default', '{\"uuid\":\"1788bf95-5d91-44b6-975f-7103e212ec78\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1419;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"459c9035-12ec-4dcb-b144-2bbe92d88b2a\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716759289, 1716759289),
(541, 'default', '{\"uuid\":\"b9928cd6-ca2c-4f06-951f-11ea58431f59\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:e57c:3600:9d7a:3212:6310:f5ef\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-05-27 14:39:03.919888\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/125.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"62e1efe6-c9c5-4b91-8385-b705deb377f6\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716820744, 1716820744),
(542, 'default', '{\"uuid\":\"3579882b-f0a1-45f5-978a-e614173dca3b\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:e57c:3600:9d7a:3212:6310:f5ef\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-05-27 16:54:14.471748\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/125.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"f444ffe8-0933-4248-9738-a29dd8627a5c\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716828854, 1716828854),
(543, 'default', '{\"uuid\":\"d5fe84ce-d6d1-404b-ae64-74703f087331\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1422;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"b1d7bae3-17bf-4f45-b534-6d60514145c6\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716830645, 1716830645),
(544, 'default', '{\"uuid\":\"d9735d3d-5bc7-4f1f-a125-e26d74a8e875\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:e57c:3600:5c42:d4ff:b9d4:26e3\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-05-27 22:53:15.412034\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/125.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"79a4e14f-00fd-40ef-9c19-c14274e6a3c6\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716850395, 1716850395),
(545, 'default', '{\"uuid\":\"d88691b5-502d-4d15-b7bf-f03f70942bce\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:e57c:3600:5c42:d4ff:b9d4:26e3\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-05-28 02:00:41.689637\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/125.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"61dca536-c42d-4add-abb5-01d3e682a159\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716861641, 1716861641),
(546, 'default', '{\"uuid\":\"6db77f92-d2d2-4ff9-a70c-ebd090652a65\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1425;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"a8c359bd-c46e-4f62-85cd-06d6a7cf0177\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716864180, 1716864180),
(547, 'default', '{\"uuid\":\"d6d70d99-f08b-4eaf-8f74-83f421ba9b4a\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:e57c:3600:5c42:d4ff:b9d4:26e3\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-05-28 08:03:16.664951\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/125.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"c00b5699-c9be-4efb-a491-3c3797b6189f\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716883396, 1716883396),
(548, 'default', '{\"uuid\":\"a27a5caa-94ee-4982-a7c3-8170ad1768db\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1428;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"075afa02-d15d-4c24-814e-962943ecd9e5\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716883567, 1716883567),
(549, 'default', '{\"uuid\":\"9e6f469d-cdfc-4456-b0df-39fec379c583\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:e57c:3600:69d9:6926:2086:d518\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-05-28 20:01:32.150787\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/125.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"10a5afbf-d131-4589-b1e9-2cfa63b59e2d\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716926492, 1716926492),
(550, 'default', '{\"uuid\":\"3197d99b-9c00-4ec3-88eb-769548cfcccc\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:e57c:3600:69d9:6926:2086:d518\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-05-28 23:17:18.708567\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/125.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"659b982f-09dc-45fa-8757-ee6af4b48717\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1716938238, 1716938238),
(551, 'default', '{\"uuid\":\"8ab45fa0-dded-47aa-a41f-647d383623d2\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:37:\\\"2001:8a0:e57c:3600:88a:77ba:680c:c158\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-05-29 20:42:58.318731\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/125.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"117a0168-f2ad-4823-829f-92774baee845\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1717015378, 1717015378),
(552, 'default', '{\"uuid\":\"8b4bce09-9929-4fdf-ac36-3f23d22162cc\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1431;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"9f2cf37d-c98d-4c0d-9f23-9c30b9498d76\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1717015471, 1717015471),
(553, 'default', '{\"uuid\":\"5519a09b-7c99-445a-b436-34ab7ed63582\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:37:\\\"2001:8a0:e57c:3600:88a:77ba:680c:c158\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-05-29 23:50:21.744323\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/125.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"86871035-f490-4785-8952-e0e20dae0ea7\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1717026621, 1717026621),
(554, 'default', '{\"uuid\":\"840d0071-1964-4bfe-9e55-f68e8a6a8564\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1434;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"4de4c095-f88d-4967-93bd-b4fb629c5b50\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1717026670, 1717026670),
(555, 'default', '{\"uuid\":\"a3e2112b-6b33-4669-979c-4204d732f01b\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:37:\\\"2001:8a0:e57c:3600:88a:77ba:680c:c158\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-05-30 02:11:13.627306\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/125.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"52d94a53-62c2-440d-b4ed-f4ce53e7740c\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1717035073, 1717035073),
(556, 'default', '{\"uuid\":\"1bb765df-143d-43e8-a5a8-b21324d1c2b4\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1437;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"cea07fa2-8716-44e6-87b7-8e7fae85f719\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1717035542, 1717035542),
(557, 'default', '{\"uuid\":\"0b113875-9a1f-482a-834b-3042ce2e4701\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1440;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"658647c8-16ba-4b21-8d10-ecc9f21edf4e\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1717036547, 1717036547),
(558, 'default', '{\"uuid\":\"837b51d0-464f-4298-b371-b53bc14b8995\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1443;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"8218e07a-f446-4e17-a3ea-13061024a6e3\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1717037359, 1717037359);
INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(559, 'default', '{\"uuid\":\"fa9db725-4493-4c69-b372-a4760064e1aa\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:37:\\\"2001:8a0:e57c:3600:88a:77ba:680c:c158\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-05-30 18:46:01.971857\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/125.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"f516f242-1ed4-45d2-bb9f-fc91b12e1624\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1717094762, 1717094762),
(560, 'default', '{\"uuid\":\"065272b0-827e-450b-a624-a080b1faebb3\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1446;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"49efba25-3ed0-4853-9010-f0750f5c9dac\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1717097061, 1717097061),
(561, 'default', '{\"uuid\":\"cd098bcb-3ffa-49bd-adc4-94ac7d9f0d02\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1449;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"e84e1fd2-b65a-4487-a1f2-d34440bedf0d\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1717100219, 1717100219),
(562, 'default', '{\"uuid\":\"1e5b639e-b47a-434c-892f-05e9650c5a0e\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1450;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"35d16b3c-4c7a-442c-b0bf-80e9f4c9e58a\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1717107616, 1717107616),
(563, 'default', '{\"uuid\":\"34ff81e1-b4ec-47b0-893c-142915f4392f\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1453;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"0d417dc9-5f39-442c-940b-81766555fcb7\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1717107895, 1717107895),
(564, 'default', '{\"uuid\":\"e1a11510-181d-4865-9b4e-aa059add6bb6\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1454;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"320e9954-0a14-411d-a5b4-cef065aa17a1\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1717109046, 1717109046),
(565, 'default', '{\"uuid\":\"39f796a5-bb53-48da-945d-1e96324657e6\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:11:\\\"2.83.47.122\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-05-31 20:18:32.264041\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/125.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"599aa623-b51d-4496-a0b3-3390c9daada5\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1717186712, 1717186712),
(566, 'default', '{\"uuid\":\"2c21b497-7b34-4627-a9e9-54e7f0775c11\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:4cbe:259e:5970:90b9\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-21 16:17:32.322272\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"0d56540d-2255-4b11-9508-37ecdf0727b7\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734797852, 1734797852),
(567, 'default', '{\"uuid\":\"bed2f1e6-bb3a-468f-bf78-9f830d287cdd\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:4cbe:259e:5970:90b9\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-21 17:35:56.766973\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"a236e33b-9289-419f-98a1-3ff58eb7dd93\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734802556, 1734802556),
(568, 'default', '{\"uuid\":\"7e276e0a-4fb9-4368-85b0-6fe4a6a4e77c\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1455;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"73777afb-dcc1-4b7a-8a35-9609db51e1d1\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734810231, 1734810231),
(569, 'default', '{\"uuid\":\"b1da8974-30b2-4e1d-9e0b-19babc046c39\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-21 21:44:16.488309\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"cf5c46c3-9a75-466e-a2d4-6d121a5d759e\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734817456, 1734817456),
(570, 'default', '{\"uuid\":\"c9ac9d7a-4302-4383-8aff-1189744a81f3\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-21 21:44:30.445158\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"5f71a175-3a44-43d7-a8be-9ed0654243fe\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734817470, 1734817470),
(571, 'default', '{\"uuid\":\"49456046-04b2-47bb-b43e-7beec663a7bb\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-21 21:51:31.798608\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"ed668cc9-4ccf-4205-a7b2-fce5af4cbd2c\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734817891, 1734817891),
(572, 'default', '{\"uuid\":\"35ce4c7b-e05a-4d7c-a0db-9a0ee018afa7\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-21 21:54:32.996139\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"a96f10f7-9869-437b-b783-5e02a65b2f4c\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734818073, 1734818073),
(573, 'default', '{\"uuid\":\"297dcb5a-18af-445b-b4be-e894cc556871\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-21 21:57:04.455237\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"e3059da3-7af7-460b-8243-f8cc6dde5bea\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734818224, 1734818224),
(574, 'default', '{\"uuid\":\"fef9f755-c1b7-4fda-ae31-4b4063ebf5da\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-21 21:58:34.125128\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"546da567-e821-4540-b698-7070ec8dc4a2\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734818314, 1734818314),
(575, 'default', '{\"uuid\":\"56950e80-6074-42b0-9605-aca84a0ac442\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-21 22:01:08.148100\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"1c9b999f-c722-4ecb-98e3-a0ed5f99440d\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734818468, 1734818468),
(576, 'default', '{\"uuid\":\"0cee7ffb-1287-45e9-af61-b20b7eeb02ec\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-21 22:01:17.470375\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"83a9edcf-7cf0-4f8d-a235-8d0453c57e2e\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734818477, 1734818477),
(577, 'default', '{\"uuid\":\"65f5c356-755b-4c46-8c2a-8280adba0a38\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-21 22:06:36.836949\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"11e39db9-3872-4bd8-a62d-826de55a59de\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734818796, 1734818796),
(578, 'default', '{\"uuid\":\"74711088-829f-436d-8e85-355d50ae1cd1\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-21 22:08:43.507315\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"3c4d992e-36f0-4f34-8908-28e1ad01b687\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734818923, 1734818923),
(579, 'default', '{\"uuid\":\"c942a12b-1b58-43f6-82d0-95920f7a5dd3\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-21 22:32:58.537461\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"151b0921-2c71-4dbc-8a6a-8d3b242f0b90\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734820378, 1734820378),
(580, 'default', '{\"uuid\":\"5eb995fe-31bd-46ad-a063-c0604fbdae7b\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-21 22:43:27.489633\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"062d4117-f357-4a67-8526-5bd8cb7d6f8f\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734821007, 1734821007),
(581, 'default', '{\"uuid\":\"800105e3-280d-4798-ba4a-ad4f43aa5149\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-21 23:01:03.621327\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"02387c97-d86b-40a9-9a52-fc799f90acc9\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734822063, 1734822063),
(582, 'default', '{\"uuid\":\"a7f3616f-9afc-407a-84bd-aebb0354dc9e\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-21 23:03:51.548093\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"e9eb47f5-d528-4942-bd97-b4abe3482f3f\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734822231, 1734822231),
(583, 'default', '{\"uuid\":\"7a50a304-ac41-4023-9a08-81f7cc0b2d36\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-21 23:11:50.213274\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"ff20a60c-65f1-4e3b-951f-6c8ee03fed25\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734822710, 1734822710),
(584, 'default', '{\"uuid\":\"f095878a-a0db-4ab6-8481-6bb6b77bab51\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-21 23:14:51.414273\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"3cc5a7a9-2455-4338-95af-8b2c4a9e28c7\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734822891, 1734822891),
(585, 'default', '{\"uuid\":\"0544a077-603b-408e-aa18-678dab26b144\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-22 01:07:17.116955\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"0ab428bc-b164-4394-a68e-1666a2400380\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734829637, 1734829637),
(586, 'default', '{\"uuid\":\"f20d2d7f-b788-4101-94a5-e11ea2d8edcb\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-22 02:36:27.354092\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"51a6118b-e1ed-4526-9d30-d9d0ae060a3b\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734834987, 1734834987),
(587, 'default', '{\"uuid\":\"9da5dfc2-f78b-498a-a93b-d493e4c2cbf6\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-22 03:57:35.389431\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"30ab99be-1c59-4120-bb98-152fa1385a7e\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734839855, 1734839855),
(588, 'default', '{\"uuid\":\"9b7c061c-03cc-4afd-b4c9-3a53b1f30132\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-22 04:04:56.207270\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"3a5c9afc-261b-4267-bf07-d2d30835102c\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734840296, 1734840296),
(589, 'default', '{\"uuid\":\"099cc07f-0418-471a-aff3-84a4f41d7d64\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-22 04:07:46.997353\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"51a483e8-0781-4cf2-af02-f96bdc3f3471\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734840467, 1734840467),
(590, 'default', '{\"uuid\":\"09e4f88c-6651-45b0-99d1-a364f6bde274\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:22;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-22 05:23:11.542762\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"baf95250-bc5d-4209-8d47-36e0613af5a8\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734844991, 1734844991),
(591, 'default', '{\"uuid\":\"9be8a695-7b77-4105-976e-c38d10a07c1a\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:23;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-22 06:55:20.950158\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"2fef5328-049e-436a-b378-144119f6c59d\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734850520, 1734850520),
(592, 'default', '{\"uuid\":\"bab9542e-55f6-4499-bff2-d9bcc0a7d8a5\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:24;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-22 06:56:52.503358\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"58ff98f7-1989-4a14-879d-dcc884747be9\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734850612, 1734850612),
(593, 'default', '{\"uuid\":\"6ec137bb-b146-44ce-83c1-71f8eeea5dec\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:25;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-22 06:59:54.032063\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"43dd1493-a0fe-41d4-b740-3a73712b8229\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734850794, 1734850794);
INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(594, 'default', '{\"uuid\":\"56e360f3-bd17-4f67-831d-a37e7d6b4814\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:26;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-22 07:01:11.517184\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"68387569-40a4-4e23-9b3a-b8d646a6fc72\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734850871, 1734850871),
(595, 'default', '{\"uuid\":\"c34b635f-64be-48ad-8230-718119bf83db\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-22 07:02:03.294836\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"487131af-e29a-4429-89c0-055ec5d43ee0\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734850923, 1734850923),
(596, 'default', '{\"uuid\":\"1f1c37c2-74e0-4516-ace1-0ba998a0d46c\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1457;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"26667bb3-cae3-4377-8fb0-bd7f22fb7919\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734854915, 1734854915),
(597, 'default', '{\"uuid\":\"cb02b322-ce26-45f9-b166-3e96038759dd\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1458;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"50967c47-76c4-49d0-aa08-2b1f7e44548f\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734855135, 1734855135),
(598, 'default', '{\"uuid\":\"464e8442-23a5-4bb0-bad6-25b9b5be813c\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1459;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"eadb7e38-4881-452d-a07b-2af6132ae53f\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734855233, 1734855233),
(599, 'default', '{\"uuid\":\"b32b9bfd-b3a2-4af3-ad61-551f6ef4846b\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:38:\\\"2001:8a0:db4f:6800:156d:1ff2:f724:b425\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-22 08:30:52.402443\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"321825bb-ddbc-478d-98c5-0d999a1b6c14\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1734856252, 1734856252),
(600, 'default', '{\"uuid\":\"15cf379e-18b9-4e9e-88ff-a2e72255a4ce\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:37:\\\"2001:8a0:db4f:6800:90d:4ac2:dbd1:c81f\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-24 23:33:10.078023\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"595d0e2a-4081-405b-95cf-d022a3b01135\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1735083190, 1735083190),
(601, 'default', '{\"uuid\":\"249f112c-7a98-40c1-896a-3a9002417765\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:37:\\\"2001:8a0:db4f:6800:90d:4ac2:dbd1:c81f\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-24 23:37:36.563796\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"f255984e-e5bb-43d6-84ad-617815019085\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1735083456, 1735083456),
(602, 'default', '{\"uuid\":\"f5a991bc-db6a-409c-8010-f01d575b3c22\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:27;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:37:\\\"2001:8a0:db4f:6800:90d:4ac2:dbd1:c81f\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-25 01:31:34.678538\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"057124d5-1712-42c1-9c57-f0240bbd9ec9\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1735090294, 1735090294),
(603, 'default', '{\"uuid\":\"0e6ba68d-bfc5-4ba7-9344-98f1fef6bda2\",\"displayName\":\"App\\\\Notifications\\\\NewLicenseNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:27;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:40:\\\"App\\\\Notifications\\\\NewLicenseNotification\\\":2:{s:49:\\\"\\u0000App\\\\Notifications\\\\NewLicenseNotification\\u0000license\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:11:\\\"app\\\\license\\\";s:2:\\\"id\\\";i:1460;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"813c5293-a90d-419f-8811-c35ba1150334\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1735092926, 1735092926),
(604, 'default', '{\"uuid\":\"d578bebe-2aba-499d-ad10-3ca8e7e132f9\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:37:\\\"2001:8a0:db4f:6800:90d:4ac2:dbd1:c81f\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-25 02:53:30.677785\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"1d3dcbf6-97be-4fb4-93e5-aa9e8fc66e03\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1735095210, 1735095210),
(605, 'default', '{\"uuid\":\"4f569bfa-2dac-4d3b-a874-c7b81d107f73\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:37:\\\"2001:8a0:db4f:6800:90d:4ac2:dbd1:c81f\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-25 02:53:59.017292\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"92316c43-f22b-4af8-a780-2a9929fbc660\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1735095239, 1735095239),
(606, 'default', '{\"uuid\":\"8e1bdeb9-6cf0-4045-b75d-79e45f10a66d\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:0;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:37:\\\"2001:8a0:db4f:6800:90d:4ac2:dbd1:c81f\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-25 02:54:56.557736\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"3439daa1-c7a3-4da2-ba83-bab3a7befba1\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1735095296, 1735095296),
(607, 'default', '{\"uuid\":\"c0077ee1-9454-4e06-9f3b-2ccc142699ad\",\"displayName\":\"App\\\\Notifications\\\\LoginNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:8:\\\"App\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:27;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:35:\\\"App\\\\Notifications\\\\LoginNotification\\\":2:{s:7:\\\"\\u0000*\\u0000data\\\";a:3:{s:2:\\\"ip\\\";s:37:\\\"2001:8a0:db4f:6800:90d:4ac2:dbd1:c81f\\\";s:4:\\\"time\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2024-12-25 03:56:55.454983\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:6:\\\"device\\\";s:111:\\\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/131.0.0.0 Safari\\/537.36\\\";}s:2:\\\"id\\\";s:36:\\\"ef9ca268-0102-43dc-a25b-74a1a296e905\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1735099015, 1735099015);

-- --------------------------------------------------------

--
-- Table structure for table `level_resellers`
--

CREATE TABLE `level_resellers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `level_resellers`
--

INSERT INTO `level_resellers` (`id`, `title`, `created_at`, `updated_at`, `user_id`) VALUES
(5, 'Owner', '2023-05-05 16:08:51', '2023-05-05 16:08:51', 0),
(9, 'Tier 1', '2024-12-22 00:43:02', '2024-12-22 00:43:02', 0);

-- --------------------------------------------------------

--
-- Table structure for table `level_reseller_options`
--

CREATE TABLE `level_reseller_options` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `level_reseller_id` bigint(20) UNSIGNED NOT NULL,
  `software_id` bigint(20) UNSIGNED NOT NULL,
  `price_reseller` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `level_reseller_options`
--

INSERT INTO `level_reseller_options` (`id`, `level_reseller_id`, `software_id`, `price_reseller`, `created_at`, `updated_at`) VALUES
(440, 9, 1, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(441, 9, 6, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(442, 9, 55, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(443, 9, 56, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(444, 9, 57, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(445, 9, 58, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(446, 9, 59, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(447, 9, 60, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(448, 9, 63, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(449, 9, 64, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(450, 9, 65, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(451, 9, 66, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(452, 9, 67, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(453, 9, 68, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(454, 9, 69, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(455, 9, 70, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(456, 9, 72, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(457, 9, 74, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(458, 9, 75, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(459, 9, 80, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(460, 9, 83, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(461, 9, 84, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(462, 9, 85, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(463, 9, 86, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(464, 9, 87, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(465, 9, 88, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(466, 9, 90, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(467, 9, 91, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(468, 9, 92, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(469, 9, 93, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(470, 9, 94, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(471, 9, 95, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(472, 9, 96, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(473, 9, 97, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(474, 9, 98, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(475, 9, 99, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(476, 9, 101, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(477, 9, 102, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(478, 9, 103, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(479, 9, 104, 0, '2024-12-22 00:43:02', '2024-12-22 00:43:02'),
(480, 5, 1, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(481, 5, 6, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(482, 5, 55, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(483, 5, 56, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(484, 5, 57, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(485, 5, 58, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(486, 5, 59, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(487, 5, 60, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(488, 5, 63, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(489, 5, 64, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(490, 5, 65, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(491, 5, 66, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(492, 5, 67, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(493, 5, 68, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(494, 5, 69, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(495, 5, 70, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(496, 5, 72, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(497, 5, 74, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(498, 5, 75, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(499, 5, 80, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(500, 5, 83, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(501, 5, 84, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(502, 5, 85, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(503, 5, 86, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(504, 5, 87, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(505, 5, 88, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(506, 5, 90, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(507, 5, 91, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(508, 5, 92, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(509, 5, 93, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(510, 5, 94, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(511, 5, 95, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(512, 5, 96, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(513, 5, 97, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(514, 5, 98, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(515, 5, 99, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(516, 5, 101, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(517, 5, 102, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(518, 5, 103, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22'),
(519, 5, 104, 0, '2024-12-22 00:43:22', '2024-12-22 00:43:22');

-- --------------------------------------------------------

--
-- Table structure for table `licenses`
--

CREATE TABLE `licenses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `software_id` bigint(20) UNSIGNED NOT NULL,
  `reseller_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `end_at` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `domain` varchar(255) DEFAULT NULL,
  `validdirs` varchar(255) DEFAULT NULL,
  `license_key` varchar(255) DEFAULT NULL,
  `billingcycle` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `message` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`message`, `created_at`, `updated_at`) VALUES
('<div class=\"col-sm-6\" style=\"line-height: 2;\">\r\n<ul>\r\n<h2><strong>--------------- PLAN---------------</strong></h2>\r\n<br>\r\n<li><strong>cPanel VPS License Price - 3$</strong></li>\r\n<li><span><strong>Softaculous License Price - 1$</strong></span></li>\r\n<li><strong>Plesk Web Host License Price - 3$</strong></li>\r\n<li><strong>Webuzo License Price - 2$</strong></li>\r\n<li><strong>CXS License Price - 1$</strong></li>\r\n<li><strong>CloudLinux License Price - 2$</strong></li>\r\n<li><strong>Imunify360 License Price - 1$</strong></li>\r\n<li><strong>cPanel Dedicated License Price - 4$</strong></li>\r\n<li><strong>Virtualizor License Price - 3$</strong></li>\r\n<li><strong>Sitepad License Price - 1$</strong></li>\r\n<li><strong>JetBackup License Price - 1$</strong></li>\r\n<li><strong>WHM Reseller License Price - 1$</strong></li>\r\n<li><strong>LiteSpeed 2 Workers License  Price - 3$</strong></li>\r\n<li><strong>LiteSpeed X Workers License Price - 5$</strong></li>\r\n<li><strong>Special Package VPS  Price - 11$</strong></li>\r\n<li><strong>Special Package DEDICATED Price - 13$</strong></li>\r\n<li><strong>Special Basic Package VPS Price - 9$</strong></li>\r\n<li><strong>Special Basic Package DEDICATED Price - 11$</strong></li>\r\n</ul>\r\n</div>\r\n<div class=\"col-sm-6\" style=\"line-height: 2;\">\r\n<ul>\r\n<h2><strong>--------------- PLAN ---------------</strong></h2>\r\n<br>\r\n<li><strong>cPanel VPS License Price - 2$</strong></li>\r\n<li><strong>Softaculous License Price - 1$</strong></li>\r\n<li><strong>Plesk Web Host License Price - 2$</strong></li>\r\n<li><strong>Webuzo License Price - 1.5$</strong></li>\r\n<li><strong>CXS License Price - 1$</strong></li>\r\n<li><strong>CloudLinux License Price - 2$</strong></li>\r\n<li><strong>Imunify360 License Price - 1$</strong></li>\r\n<li><strong>cPanel Dedicated License Price - 4$</strong></li>\r\n<li><strong>Virtualizor License Price - 3$</strong></li>\r\n<li><strong>Sitepad License Price - 1$</strong></li>\r\n<li><strong>JetBackup License Price - 1$</strong></li>\r\n<li><strong>WHM Reseller License Price - 1$</strong></li>\r\n<li><strong>LiteSpeed 2 Workers License Price - 2$</strong></li>\r\n<li><strong>LiteSpeed X Workers License Price - 5$</strong></li>\r\n<li><strong>Special Package VPS Price - 9$</strong></li>\r\n<li><strong>Special Package DEDICATED Price - 11$</strong></li>\r\n<li><strong>Special Basic Package VPS Price - 6$</strong></li>\r\n<li><strong>Special Basic Package DEDICATED Price - 8$</strong></li>\r\n</ul>\r\n</div>', NULL, '2024-12-25 08:58:39');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(10, '2020_03_10_142305_create_servers_table', 2),
(11, '2020_03_10_205821_create_resellers_table', 2),
(12, '2020_03_10_777777_create_licenses_table', 2),
(13, '2020_03_10_101147_create_software_table', 3),
(14, '2020_03_12_123717_create_messages_table', 4),
(17, '2020_03_23_113601_create_accounts_table', 5),
(18, '2020_03_23_113640_create_proxies_table', 5),
(23, '2020_03_23_121718_create_proxy_software_table', 6);

-- --------------------------------------------------------

--
-- Table structure for table `notices`
--

CREATE TABLE `notices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `content` text NOT NULL,
  `title` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notices`
--

INSERT INTO `notices` (`id`, `created_at`, `updated_at`, `content`, `title`) VALUES
(8, '2024-12-22 10:12:25', '2024-12-22 10:16:35', 'We are excited to announce the launch of SysLic v120.55.1, a powerful platform designed to help resellers easily manage and sell software licenses. With the new version, you can now offer a wide variety of popular software solutions using our seamless API and fully self-hosted white-labeled panel. From web hosting tools like cPanel/WHM and Plesk, to security solutions like Imunify360, LiteSpeed, and DDoS Mitigator, SysLic allows resellers to expand their business by offering licenses for products like WHMCS, JetBackup, Softaculous, Virtualizor, CloudLinux, Webuzo, SYSCare, Fleet SSL, Let\'s Encrypt SSL (White Label), and many more. Whether you\'re reselling cpShield, cpNginx, Linux Malware Detection (LMD), or RKHunter Interface, SysLic gives you the tools and flexibility to run your software business with ease, all while maintaining full control over your branding.', '🎉 SysLic.org Launches SysLic v120.55.1! 🎉');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `amount` double(8,2) NOT NULL,
  `status` varchar(255) DEFAULT 'Cancelled',
  `payment_method` varchar(255) DEFAULT NULL,
  `sender_number` varchar(255) DEFAULT NULL,
  `transaction_id` varchar(255) DEFAULT NULL,
  `invoice_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proxies`
--

CREATE TABLE `proxies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `port` int(11) NOT NULL,
  `expiry_date` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proxy_software`
--

CREATE TABLE `proxy_software` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `proxy_id` int(11) NOT NULL,
  `expiry_date` int(11) NOT NULL,
  `key` text DEFAULT NULL,
  `use` int(11) DEFAULT NULL,
  `used` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL,
  `priority` int(11) NOT NULL DEFAULT 1,
  `software_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `last_use` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `redeems`
--

CREATE TABLE `redeems` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `code` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `redeems`
--

INSERT INTO `redeems` (`id`, `user_id`, `code`, `amount`, `created_at`, `updated_at`) VALUES
(14, 0, '13G20492251AV9F35892Z62V9FO562', 10, '2023-04-29 21:43:28', '2023-04-29 21:43:28'),
(15, 0, 'RSB39870IVA5LW37OC5QM323K38F1H', 5, '2023-04-29 21:43:30', '2023-04-29 21:43:30'),
(19, 0, 'PECF7C4CF9QDU236E4L21KJOETD7V0', 30, '2023-07-26 12:18:31', '2023-07-26 12:18:31'),
(23, 0, 'K13QJ19ZY7LO1141C5923SBHD55G9G', 15, '2024-05-22 07:09:04', '2024-05-22 07:09:04');

-- --------------------------------------------------------

--
-- Table structure for table `resellers`
--

CREATE TABLE `resellers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `domain` varchar(255) NOT NULL,
  `balance` int(10) UNSIGNED NOT NULL,
  `end_at` varchar(255) NOT NULL,
  `main_domain` varchar(255) DEFAULT NULL,
  `folder` varchar(255) DEFAULT NULL,
  `level_id` int(11) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `key_cmd` varchar(255) DEFAULT NULL,
  `type` enum('whmcs','local') DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `trial_perm` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `resellers`
--

INSERT INTO `resellers` (`id`, `name`, `token`, `domain`, `balance`, `end_at`, `main_domain`, `folder`, `level_id`, `status`, `created_at`, `updated_at`, `key_cmd`, `type`, `client_id`, `user_id`, `trial_perm`) VALUES
(29, 'Syslic', '91611b68b7495e157c044bd4c1bd651f', 'Syslic.org', 0, '2099-12-31', 'Syslic.org', 'files', 9, 1, '2024-12-25 06:31:34', '2024-12-25 06:31:34', 'SYS', 'local', 27, 27, 0);

-- --------------------------------------------------------

--
-- Table structure for table `servers`
--

CREATE TABLE `servers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `proxy_conf` text DEFAULT NULL,
  `key` text DEFAULT NULL,
  `priority` int(11) NOT NULL DEFAULT 1,
  `use` int(11) DEFAULT 0,
  `used` int(11) DEFAULT 0,
  `software_id` bigint(20) UNSIGNED NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `last_use` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expiry_date` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `servers`
--

INSERT INTO `servers` (`id`, `name`, `proxy_conf`, `key`, `priority`, `use`, `used`, `software_id`, `status`, `created_at`, `last_use`, `updated_at`, `expiry_date`) VALUES
(1, 'plesk1', NULL, 'A00100-APQN08-TEKF82-HRQ101-APHV26', 1, 0, 1165, 3, 0, '2022-01-02 09:37:55', '2022-01-15 05:46:11', '2023-06-05 17:41:22', 15),
(2, 'plesk2', NULL, 'A00500-PJ1V08-AW0491-C44K98-562Q60', 1, 0, 50, 3, 0, '2022-01-25 08:53:53', '2022-02-06 08:02:04', '2023-06-05 17:41:22', 14),
(3, 'plesk3', NULL, 'A00Y00-ZEWD08-Y81894-STCH02-9R4V99', 1, 0, 37, 3, 0, '2022-01-30 11:35:53', '2022-02-11 18:42:16', '2023-06-05 17:41:22', 14),
(4, 'plesk4', NULL, 'A00D00-MWB508-WYF294-WDYE12-SPVX29', 1, 0, 3, 3, 0, '2022-01-30 18:09:14', '2022-02-11 18:36:04', '2023-06-05 17:41:22', 14),
(5, 'plesk5', NULL, 'A00500-GVD008-HXME99-W19639-2DQE79', 1, 0, 1, 3, 0, '2022-02-11 18:41:21', '2022-02-16 11:14:57', '2023-06-05 17:41:22', 14),
(6, 'plesk6', NULL, 'A00Y00-A07V08-SX8299-VP6K39-409F75', 1, 0, 1, 3, 0, '2022-02-11 18:42:09', '2022-02-15 00:00:06', '2023-06-05 17:41:22', 14);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `value`, `created_at`, `updated_at`) VALUES
(1, 'site_name', 'SysLic System', '2020-04-11 17:00:00', '2024-12-25 08:54:02'),
(2, 'client_login', '', '2020-04-11 17:00:00', '2020-04-12 14:13:46'),
(3, 'proxy_using', '', '2020-04-11 17:00:00', '2024-12-25 08:54:02'),
(4, 'IP_whitelist', '', '2020-04-11 17:00:00', '2024-12-25 08:54:02'),
(5, 'last_using', '1', '2020-04-11 17:00:00', '2024-12-25 08:54:02'),
(6, 'enable_api', '1', '2020-04-12 17:00:00', '2023-01-11 13:47:57'),
(7, 'api_key', 'ahgdhjkagdhjkasgjdhgashjdghjasdhjgahdgajhdgjhadghjagdhjasghjasghjgashd', '2020-04-12 17:00:00', '2023-01-11 13:47:57'),
(8, 'whmcs_username', 'admin', '2020-04-15 17:00:00', '2024-12-25 08:54:02'),
(9, 'whmcs_password', 'pass', '2020-04-15 17:00:00', '2024-12-25 08:54:02'),
(10, 'whmcs_domain', 'whmcs.syslic.org', '2020-04-15 17:00:00', '2024-12-25 08:54:02');

-- --------------------------------------------------------

--
-- Table structure for table `software`
--

CREATE TABLE `software` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `cmd` text NOT NULL,
  `softwares` text NOT NULL,
  `price_reseller` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `change_ip` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `software`
--

INSERT INTO `software` (`id`, `name`, `key`, `cmd`, `softwares`, `price_reseller`, `status`, `change_ip`, `created_at`, `updated_at`) VALUES
(1, 'cPanel VPS', 'cpanel', 'bash <( curl https://{domain}/pre.sh ) cpanel', '[\"66\",\"68\",\"74\",\"95\",\"96\",\"97\",\"98\",\"99\"]', 3, 1, 1, '2020-03-12 01:13:44', '2024-11-24 12:29:01'),
(6, 'Imunify360', 'imunify360', 'bash <( curl https://{domain}/pre.sh ) imunify360', '[]', 3, 1, 1, '2020-03-12 17:43:55', '2024-08-14 13:31:08'),
(55, 'cPanel Dedicated', 'cpaneldedicated', 'bash <( curl https://{domain}/pre.sh ) cpaneld', '[\"66\",\"68\",\"74\",\"95\",\"96\",\"97\",\"98\",\"99\"]', 4, 1, 1, '2024-08-01 07:24:44', '2024-11-24 12:28:39'),
(56, 'LiteSpeed', 'litespeed', 'bash <( curl https://{domain}/pre.sh ) litespeed', '[]', 4, 1, 1, '2024-08-01 07:25:50', '2024-08-14 13:30:32'),
(57, 'CloudLinux', 'cloudlinux', 'bash <( curl https://{domain}/pre.sh ) cloudlinux', '[]', 4, 1, 1, '2024-08-01 07:26:36', '2024-08-14 13:30:24'),
(58, 'CXS - ConfigServer eXploit Scanner', 'CXS', 'bash <( curl https://{domain}/pre.sh ) cxs', '[]', 2, 1, 1, '2024-08-01 07:28:03', '2024-08-14 13:30:16'),
(59, 'JetBackup', 'jetbackup', 'bash <( curl https://{domain}/pre.sh ) jetbackup', '[]', 1, 1, 1, '2024-08-01 07:29:20', '2024-08-14 13:30:05'),
(60, 'WHMReseller', 'whmreseller', 'bash <( curl https://{domain}/pre.sh ) whmreseller', '[]', 1, 1, 1, '2024-08-01 07:30:17', '2024-08-14 13:29:52'),
(63, 'DAReseller', 'dareseller', 'bash <( curl https://{domain}/pre.sh ) dareseller', '[]', 1, 1, 1, '2024-08-01 07:33:21', '2024-08-14 13:29:44'),
(64, 'WHMSonic', 'whmsonic', 'bash <( curl https://{domain}/pre.sh ) whmsonic', '[]', 1, 1, 1, '2024-08-01 07:33:58', '2024-08-14 13:29:35'),
(65, 'OSM - Outgoing Spam Monitor', 'osm', 'bash <( curl https://{domain}/pre.sh ) osm', '[]', 1, 1, 1, '2024-08-01 07:34:58', '2024-08-14 13:29:27'),
(66, 'Softaculous', 'softaculous', 'bash <( curl https://{domain}/pre.sh ) softaculous', '[]', 1, 1, 1, '2024-08-01 07:35:54', '2024-08-14 13:29:16'),
(67, 'Virtualizor', 'virtualizor', 'bash <( curl https://{domain}/pre.sh ) virtualizor', '[]', 2, 1, 1, '2024-08-01 07:36:58', '2024-08-14 13:29:07'),
(68, 'SitePad', 'sitepad', 'bash <( curl https://{domain}/pre.sh ) sitepad', '[]', 1, 1, 1, '2024-08-01 07:37:57', '2024-08-14 13:28:57'),
(69, 'SYSCare', 'SYSCare', 'bash <( curl https://{domain}/pre.sh ) syscare', '[]', 1, 1, 1, '2024-08-01 07:39:00', '2024-08-14 13:28:29'),
(70, 'Webuzo V3 Business', 'webuzo', 'bash <( curl https://{domain}/pre.sh ) webuzo', '[]', 3, 1, 1, '2024-08-01 07:43:27', '2024-08-14 13:27:59'),
(72, 'kernelcare', 'kernelcare', 'bash <( curl https://{domain}/pre.sh ) kernelcare', '[]', 1, 1, 1, '2024-08-01 07:46:41', '2024-08-14 13:27:40'),
(74, 'FleetSSL', 'fleetssl', 'bash <( curl https://{domain}/pre.sh ) fleetssl', '[]', 1, 1, 1, '2024-08-01 07:48:49', '2024-08-14 13:27:19'),
(75, 'Plesk', 'plesk', 'bash <( curl https://{domain}/pre.sh ) Plesk', '[]', 1, 1, 1, '2024-08-01 07:54:07', '2024-08-14 13:27:03'),
(80, 'Virtualizor Pro', 'virtualizorpro', 'bash <( curl https://{domain}/pre.sh ) VirtualizorPro', '[]', 1, 1, 1, '2024-08-05 08:50:26', '2024-08-14 13:26:04'),
(83, 'Plesk Dedicated', 'pleskdedicated', 'bash <( curl https://{domain}/pre.sh ) PleskDedicated', '[]', 1, 1, 1, '2024-08-14 08:19:59', '2024-08-14 13:26:20'),
(84, 'WHMCS + Auto Updator', 'whmcsauto', 'Download License.zip file for existing WHMCS \r\n\r\nhttps://{domain}/whmcs/License.zip\r\n- Go to public_html/vendor/whmcs/whmcs-foundation/lib/\r\n- Find and delete license.php file \r\n- Then replace license.php file   \r\n\r\nIn case you do not have WHMCS installed: https://docs.licensedash.com/whmcsauto', '[]', 0, 1, 1, '2024-08-14 08:31:52', '2024-09-23 18:17:04'),
(85, 'Bundle - Cloud VPS Personal', 'personal', 'You can install and use all of these licenses!', '[\"1\",\"6\",\"56\",\"57\",\"58\",\"59\",\"65\",\"66\",\"68\",\"74\",\"90\",\"91\",\"92\",\"93\",\"94\",\"95\",\"96\",\"97\",\"98\",\"99\"]', 15, 1, 1, '2024-08-18 04:56:23', '2024-11-24 12:29:47'),
(86, 'Bundle - Dedicated Ultimate', 'ultimate', 'You can install and use all of these licenses!', '[\"6\",\"55\",\"56\",\"57\",\"58\",\"59\",\"65\",\"66\",\"68\",\"74\",\"90\",\"91\",\"92\",\"93\",\"94\",\"95\",\"96\",\"97\",\"98\",\"99\"]', 17, 1, 1, '2024-08-18 04:58:46', '2024-11-24 12:30:29'),
(87, 'Bundle - Cloud VPS Business', 'business', 'You can install and use all of these licenses!', '[\"1\",\"6\",\"56\",\"57\",\"58\",\"59\",\"60\",\"65\",\"66\",\"67\",\"68\",\"74\",\"84\",\"90\",\"91\",\"92\",\"93\",\"94\",\"95\",\"96\",\"97\",\"98\",\"99\"]', 20, 1, 1, '2024-08-18 05:00:24', '2024-11-24 12:30:50'),
(88, 'Bundle - Dedicated Enterprise', 'enterprise', 'You can install and use all of these licenses!', '[\"6\",\"55\",\"56\",\"57\",\"58\",\"59\",\"60\",\"65\",\"66\",\"67\",\"68\",\"74\",\"84\",\"90\",\"91\",\"92\",\"93\",\"94\",\"95\",\"96\",\"97\",\"98\",\"99\"]', 25, 1, 1, '2024-08-18 05:01:50', '2024-11-24 12:31:18'),
(90, 'Linux Malware Detect Manager (LMD)', 'lmd', 'bash <( curl https://{domain}/pre.sh ) LMD', '[]', 2, 1, 1, '2024-11-18 07:21:32', '2024-11-18 07:21:32'),
(91, '(D)DoS Mitigator (cPanel)', 'ddos-mitigator', 'bash <( curl https://{domain}/pre.sh ) DDosMitigator', '[]', 2, 1, 1, '2024-11-18 07:42:01', '2024-11-18 07:42:01'),
(92, 'cPSheild v5', 'cpshield', 'bash <( curl https://{domain}/pre.sh ) cPSheild', '[]', 3, 1, 1, '2024-11-18 07:42:57', '2024-11-18 22:29:42'),
(93, 'cPRemote', 'cpremote', 'bash <( curl https://{domain}/pre.sh ) cPRemote', '[]', 4, 1, 1, '2024-11-18 07:43:34', '2024-11-18 07:43:34'),
(94, 'cPNginx', 'cpnginx', 'bash <( curl https://{domain}/pre.sh ) cPNginx', '[]', 3, 1, 1, '2024-11-18 07:43:59', '2024-11-18 07:43:59'),
(95, 'WatchMySQL', 'watchmysql', 'bash <( curl https://{domain}/pre.sh ) WatchMySQL', '[]', 0, 1, 1, '2024-11-18 14:08:51', '2024-11-18 14:08:51'),
(96, 'WHMXtra', 'whmxtra', 'bash <( curl https://{domain}/pre.sh ) WHMXtra', '[]', 0, 1, 1, '2024-11-18 15:11:17', '2024-11-18 15:11:17'),
(97, 'CleanBackups - cPanel / WHM plugin', 'cleanbackups', 'bash <( curl https://{domain}/pre.sh ) CleanBackups', '[]', 0, 1, 1, '2024-11-18 15:23:15', '2024-11-18 15:23:15'),
(98, 'Redis Plugin for cPanel', 'redis', 'bash <( curl https://{domain}/pre.sh ) Redis', '[]', 0, 1, 1, '2024-11-19 07:24:46', '2024-11-19 07:24:46'),
(99, 'Account DNS Check - cPanel', 'accountdnscheck', 'bash <( curl https://{domain}/pre.sh ) AccountDNSCheck', '[]', 0, 1, 1, '2024-11-19 07:48:01', '2024-11-19 07:48:01'),
(101, 'LetsEncrypt SSL', 'letsencrypt', 'bash <( curl https://{domain}/pre.sh ) letsencrypt', '[]', 2, 1, 1, '2024-11-27 04:57:31', '2024-12-11 16:50:56'),
(102, 'RKHunter Interface', 'rkhunter', 'bash <( curl https://{domain}/pre.sh ) rkhunter', '[]', 2, 1, 1, '2024-11-29 12:35:51', '2024-12-11 16:50:45'),
(103, 'APF Firewall Interface', 'apf', 'bash <( curl https://{domain}/pre.sh ) apf', '[]', 5, 1, 1, '2024-12-02 11:27:11', '2024-12-11 16:50:27'),
(104, 'ServerWatch', 'serverwatch', 'bash <( curl https://api.licensedash.com/pre.sh ) serverwatch', '[]', 3, 1, 1, '2024-12-18 22:56:55', '2024-12-18 22:56:55');

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` char(36) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `priority` varchar(255) NOT NULL DEFAULT 'low',
  `status` varchar(255) NOT NULL DEFAULT 'open',
  `is_resolved` tinyint(1) NOT NULL DEFAULT 0,
  `is_locked` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role` varchar(20) NOT NULL DEFAULT 'reseller',
  `username` varchar(255) NOT NULL,
  `email` varchar(320) NOT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `reseller_limit` int(11) DEFAULT 0,
  `reseller_count` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role`, `username`, `email`, `password`, `remember_token`, `created_at`, `updated_at`, `reseller_limit`, `reseller_count`) VALUES
(27, 'admin', 'admin', 'admin@licensedash.com', '$2a$12$LNmBNaBrykuPMD8rGbq07e4W6E3T/IHn.Hq0v5xZJdqMqY3fnJXZm', NULL, '2024-12-25 06:31:34', '2024-12-25 06:31:34', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `virtual_servers`
--

CREATE TABLE `virtual_servers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `server_ip` varchar(255) NOT NULL,
  `server_key` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `virtual_servers`
--

INSERT INTO `virtual_servers` (`id`, `title`, `server_ip`, `server_key`, `created_at`, `updated_at`) VALUES
(1, 'softaculous', '188.40.148.91', 'softaculous', '2022-05-01 17:28:53', '2022-05-01 17:28:53'),
(2, 'Virtualizor', '188.40.148.91', 'virtualizor', '2022-05-01 17:29:06', '2022-05-01 17:29:06'),
(3, 'WhmSonic', '188.40.148.91', 'whmsonic', '2022-05-01 17:29:20', '2022-05-01 17:29:20'),
(4, 'Whmreseller', '188.40.148.91', 'whmreseller', '2022-05-01 17:29:36', '2022-05-01 17:29:36');

-- --------------------------------------------------------

--
-- Table structure for table `white_lists`
--

CREATE TABLE `white_lists` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ip` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `white_lists`
--

INSERT INTO `white_lists` (`id`, `ip`, `status`, `created_at`, `updated_at`) VALUES
(4, '109.199.104.148', 1, '2024-05-25 22:25:04', '2024-05-25 22:25:04'),
(5, '2.83.47.122', 1, '2024-05-25 22:26:44', '2024-05-25 22:26:44');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `black_lists`
--
ALTER TABLE `black_lists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `buyers`
--
ALTER TABLE `buyers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cpanel_latests`
--
ALTER TABLE `cpanel_latests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cpanel_versions`
--
ALTER TABLE `cpanel_versions`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `level_resellers`
--
ALTER TABLE `level_resellers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `level_reseller_options`
--
ALTER TABLE `level_reseller_options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `level_reseller_options_ibfk_1` (`software_id`),
  ADD KEY `level_reseller_options_ibfk_2` (`level_reseller_id`);

--
-- Indexes for table `licenses`
--
ALTER TABLE `licenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notices`
--
ALTER TABLE `notices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `proxies`
--
ALTER TABLE `proxies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `proxy_software`
--
ALTER TABLE `proxy_software`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `redeems`
--
ALTER TABLE `redeems`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `redeems_code_unique` (`code`);

--
-- Indexes for table `resellers`
--
ALTER TABLE `resellers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `servers`
--
ALTER TABLE `servers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `software`
--
ALTER TABLE `software`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `virtual_servers`
--
ALTER TABLE `virtual_servers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `white_lists`
--
ALTER TABLE `white_lists`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `black_lists`
--
ALTER TABLE `black_lists`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `buyers`
--
ALTER TABLE `buyers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cpanel_latests`
--
ALTER TABLE `cpanel_latests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cpanel_versions`
--
ALTER TABLE `cpanel_versions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=159;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=608;

--
-- AUTO_INCREMENT for table `level_resellers`
--
ALTER TABLE `level_resellers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `level_reseller_options`
--
ALTER TABLE `level_reseller_options`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=520;

--
-- AUTO_INCREMENT for table `licenses`
--
ALTER TABLE `licenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1461;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `notices`
--
ALTER TABLE `notices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=154;

--
-- AUTO_INCREMENT for table `proxies`
--
ALTER TABLE `proxies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `proxy_software`
--
ALTER TABLE `proxy_software`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `redeems`
--
ALTER TABLE `redeems`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `resellers`
--
ALTER TABLE `resellers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `servers`
--
ALTER TABLE `servers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `software`
--
ALTER TABLE `software`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `virtual_servers`
--
ALTER TABLE `virtual_servers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `white_lists`
--
ALTER TABLE `white_lists`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `level_reseller_options`
--
ALTER TABLE `level_reseller_options`
  ADD CONSTRAINT `level_reseller_options_ibfk_1` FOREIGN KEY (`software_id`) REFERENCES `software` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `level_reseller_options_ibfk_2` FOREIGN KEY (`level_reseller_id`) REFERENCES `level_resellers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
