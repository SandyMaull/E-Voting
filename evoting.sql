-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 16, 2021 at 11:47 PM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 7.4.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `evoting`
--

-- --------------------------------------------------------

--
-- Table structure for table `allowed_section`
--

CREATE TABLE `allowed_section` (
  `id` int(11) UNSIGNED NOT NULL,
  `nama` varchar(255) NOT NULL,
  `jenis_data` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `allowed_section`
--

INSERT INTO `allowed_section` (`id`, `nama`, `jenis_data`, `created_at`, `updated_at`) VALUES
(3, 'Teknik Informatika', 'Prodi', '2021-06-13 23:43:43', '2021-06-13 23:43:43');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8_unicode_ci NOT NULL,
  `queue` text COLLATE utf8_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kandidats`
--

CREATE TABLE `kandidats` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `identitas` varchar(18) COLLATE utf8_unicode_ci NOT NULL,
  `jurusan` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `visi` text COLLATE utf8_unicode_ci NOT NULL,
  `misi` text COLLATE utf8_unicode_ci NOT NULL,
  `pengalaman` text COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(225) COLLATE utf8_unicode_ci NOT NULL,
  `voting_id` int(10) UNSIGNED NOT NULL,
  `tim_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(15, '2014_10_12_000000_create_users_table', 1),
(16, '2014_10_12_100000_create_password_resets_table', 1),
(17, '2019_08_19_000000_create_failed_jobs_table', 1),
(18, '2020_09_28_165202_create_votings_table', 1),
(19, '2020_09_28_165246_create_kandidats_table', 1),
(20, '2020_09_28_165254_create_voters_table', 1),
(21, '2020_09_28_165255_create_tervotes_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tervotes`
--

CREATE TABLE `tervotes` (
  `id` int(10) UNSIGNED NOT NULL,
  `tim_id` int(10) UNSIGNED NOT NULL,
  `voting_dpm` int(11) NOT NULL,
  `voters_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tim`
--

CREATE TABLE `tim` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama_tim` varchar(191) NOT NULL,
  `semboyan` text NOT NULL,
  `pemilihan` enum('BEM','DPM') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tim`
--

INSERT INTO `tim` (`id`, `nama_tim`, `semboyan`, `pemilihan`, `created_at`, `updated_at`) VALUES
(6, 'Tim BEM 1', 'BEM 1', 'BEM', '2021-01-03 11:13:04', '2021-01-17 09:18:30'),
(9, 'Tim BEM 2', 'BEM 2', 'BEM', '2021-01-17 09:28:03', '2021-01-17 09:28:03'),
(11, 'Tim DPM 1', 'DPM 1', 'DPM', '2021-01-18 05:32:05', '2021-01-18 05:32:05');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nim` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `jurusan` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `roles` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Users',
  `has_vote` int(11) DEFAULT NULL,
  `verified` tinyint(1) NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `nim`, `jurusan`, `password`, `roles`, `has_vote`, `verified`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Sandy Maulana', '17.01.071.106', 'Teknik Informatika', '$2y$10$bSHa6gEWoEI9VZBSWuTsYe51FHkkun3fqKD1qZsIPP7KJsC2TNeeu', 'Admin', NULL, 1, NULL, '2020-09-28 09:50:23', '2020-09-28 09:50:23');

-- --------------------------------------------------------

--
-- Table structure for table `voters`
--

CREATE TABLE `voters` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `tipe` enum('Mahasiswa','Dosen') COLLATE utf8_unicode_ci DEFAULT NULL,
  `identitas` varchar(18) COLLATE utf8_unicode_ci NOT NULL,
  `prodi` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `foto_siakad` varchar(225) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nmor_wa` varchar(225) COLLATE utf8_unicode_ci DEFAULT NULL,
  `has_vote` int(11) NOT NULL DEFAULT 0,
  `verified` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `votings`
--

CREATE TABLE `votings` (
  `id` int(10) UNSIGNED NOT NULL,
  `judul` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mulai` date NOT NULL,
  `berakhir` date NOT NULL,
  `pending` varchar(191) CHARACTER SET utf8mb4 NOT NULL,
  `result` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `votings`
--

INSERT INTO `votings` (`id`, `judul`, `mulai`, `berakhir`, `pending`, `result`, `created_at`, `updated_at`) VALUES
(1, 'Pemilihan Dekan Fakultas Teknologi Rekayasa Sistem', '2021-06-14', '2021-06-15', '{\"status\":\"false\",\"ket\":\"\"}', 'berjalan', NULL, '2021-06-13 21:09:56');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `allowed_section`
--
ALTER TABLE `allowed_section`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kandidats`
--
ALTER TABLE `kandidats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kandidats_voting_id_foreign` (`voting_id`),
  ADD KEY `kandidats_tim_id_foreign` (`tim_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `tervotes`
--
ALTER TABLE `tervotes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tervotes_voters_id_foreign` (`voters_id`),
  ADD KEY `tervotes_tim_id_foreign` (`tim_id`);

--
-- Indexes for table `tim`
--
ALTER TABLE `tim`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_nim_unique` (`nim`);

--
-- Indexes for table `voters`
--
ALTER TABLE `voters`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `identitas` (`identitas`) USING BTREE;

--
-- Indexes for table `votings`
--
ALTER TABLE `votings`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `allowed_section`
--
ALTER TABLE `allowed_section`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kandidats`
--
ALTER TABLE `kandidats`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `tervotes`
--
ALTER TABLE `tervotes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

--
-- AUTO_INCREMENT for table `tim`
--
ALTER TABLE `tim`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `voters`
--
ALTER TABLE `voters`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=273;

--
-- AUTO_INCREMENT for table `votings`
--
ALTER TABLE `votings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `kandidats`
--
ALTER TABLE `kandidats`
  ADD CONSTRAINT `kandidats_tim_id_foreign` FOREIGN KEY (`tim_id`) REFERENCES `tim` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kandidats_voting_id_foreign` FOREIGN KEY (`voting_id`) REFERENCES `votings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tervotes`
--
ALTER TABLE `tervotes`
  ADD CONSTRAINT `tervotes_tim_id_foreign` FOREIGN KEY (`tim_id`) REFERENCES `tim` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tervotes_voters_id_foreign` FOREIGN KEY (`voters_id`) REFERENCES `voters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
