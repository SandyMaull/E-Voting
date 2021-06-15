-- MySQL dump 10.18  Distrib 10.3.27-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: evotingftrs
-- ------------------------------------------------------
-- Server version	10.3.27-MariaDB-0+deb10u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `allowed_section`
--

DROP TABLE IF EXISTS `allowed_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allowed_section` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allowed_section`
--

LOCK TABLES `allowed_section` WRITE;
/*!40000 ALTER TABLE `allowed_section` DISABLE KEYS */;
INSERT INTO `allowed_section` VALUES (3,'Teknik Informatika','2021-06-13 23:43:43','2021-06-13 23:43:43'),(4,'Teknik Industri','2021-06-15 09:36:12','2021-06-15 09:36:12'),(5,'Teknik Mesin','2021-06-15 10:52:26','2021-06-15 10:52:26'),(6,'Teknik Civil','2021-06-15 10:52:45','2021-06-15 10:52:45');
/*!40000 ALTER TABLE `allowed_section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8_unicode_ci NOT NULL,
  `queue` text COLLATE utf8_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kandidats`
--

DROP TABLE IF EXISTS `kandidats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kandidats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `identitas` varchar(18) COLLATE utf8_unicode_ci NOT NULL,
  `jurusan` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `visi` text COLLATE utf8_unicode_ci NOT NULL,
  `misi` text COLLATE utf8_unicode_ci NOT NULL,
  `pengalaman` text COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(225) COLLATE utf8_unicode_ci NOT NULL,
  `voting_id` int(10) unsigned NOT NULL,
  `tim_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kandidats_voting_id_foreign` (`voting_id`),
  KEY `kandidats_tim_id_foreign` (`tim_id`),
  CONSTRAINT `kandidats_tim_id_foreign` FOREIGN KEY (`tim_id`) REFERENCES `tim` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `kandidats_voting_id_foreign` FOREIGN KEY (`voting_id`) REFERENCES `votings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kandidats`
--

LOCK TABLES `kandidats` WRITE;
/*!40000 ALTER TABLE `kandidats` DISABLE KEYS */;
INSERT INTO `kandidats` VALUES (28,'Ahmad Juliansyah,S.kom. M.ta, CISA, C|EH,CISM,fcns','091290834901782',NULL,'Menjadi rumah pembelajaran yang nyaman, menyenangkan, nikmat, ikeh- ikeh & kimoci','{\"1\":\"1.1. to be FEAR\",\"2\":\"2.2. To the Bone\"}','{\"1\":\"1.Pernah jadi ketua RT\",\"2\":\"2.Pernah jadi ketua BPD\"}','1623635062_60c6b4760eb71.PNG',1,11,'2021-06-14 09:44:22','2021-06-14 09:47:30'),(29,'Sugiono.Ph.d','0912908349',NULL,'Menjadi rumah pembelajaran yang nyaman, nikmat, menyenangkan, yamete, ikeh-ikeh kimoci','{\"1\":\"1.1. kuat\",\"2\":\"2.2. semagat\",\"3\":\"3.3. lembur\",\"4\":\"4.4. selamanya\"}','{\"1\":\"1.Direktur JAV production\",\"2\":\"2.Manajen XNXX\"}','1623723384_60c80d7861f37.jpg',1,11,'2021-06-14 11:51:55','2021-06-15 10:16:24');
/*!40000 ALTER TABLE `kandidats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (15,'2014_10_12_000000_create_users_table',1),(16,'2014_10_12_100000_create_password_resets_table',1),(17,'2019_08_19_000000_create_failed_jobs_table',1),(18,'2020_09_28_165202_create_votings_table',1),(19,'2020_09_28_165246_create_kandidats_table',1),(20,'2020_09_28_165254_create_voters_table',1),(21,'2020_09_28_165255_create_tervotes_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tervotes`
--

DROP TABLE IF EXISTS `tervotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tervotes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tim_id` int(10) unsigned NOT NULL,
  `voting_dpm` int(11) NOT NULL,
  `voters_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tervotes_voters_id_foreign` (`voters_id`),
  KEY `tervotes_tim_id_foreign` (`tim_id`),
  CONSTRAINT `tervotes_tim_id_foreign` FOREIGN KEY (`tim_id`) REFERENCES `tim` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tervotes_voters_id_foreign` FOREIGN KEY (`voters_id`) REFERENCES `voters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tervotes`
--

LOCK TABLES `tervotes` WRITE;
/*!40000 ALTER TABLE `tervotes` DISABLE KEYS */;
INSERT INTO `tervotes` VALUES (131,6,28,275,'2021-06-14 11:17:12','2021-06-14 11:17:12'),(132,6,28,276,'2021-06-14 11:30:33','2021-06-14 11:30:33');
/*!40000 ALTER TABLE `tervotes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tim`
--

DROP TABLE IF EXISTS `tim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tim` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama_tim` varchar(191) NOT NULL,
  `semboyan` text NOT NULL,
  `pemilihan` enum('BEM','DPM') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tim`
--

LOCK TABLES `tim` WRITE;
/*!40000 ALTER TABLE `tim` DISABLE KEYS */;
INSERT INTO `tim` VALUES (6,'Tim BEM 1','BEM 1','BEM','2021-01-03 11:13:04','2021-01-17 09:18:30'),(9,'Tim BEM 2','BEM 2','BEM','2021-01-17 09:28:03','2021-01-17 09:28:03'),(11,'Tim DPM 1','DPM 1','DPM','2021-01-18 05:32:05','2021-01-18 05:32:05');
/*!40000 ALTER TABLE `tim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nim` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `jurusan` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `roles` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Users',
  `has_vote` int(11) DEFAULT NULL,
  `verified` tinyint(1) NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_nim_unique` (`nim`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Sandy Maulana','17.01.071.106','Teknik Informatika','$2y$10$Ebgrso9KIIIdEA785oePl.GInJUBYYN6UKfV8XFpsPyinmivmwdfq','Admin',NULL,1,'UFkVtTjUIKyDlBBTHHvqYYc7yqTMHzW0YGZ1z6lnDU9Y2ZMn6OxXxntfCTLA','2020-09-28 09:50:23','2020-09-28 09:50:23');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voters`
--

DROP TABLE IF EXISTS `voters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `voters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
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
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identitas` (`identitas`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=277 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voters`
--

LOCK TABLES `voters` WRITE;
/*!40000 ALTER TABLE `voters` DISABLE KEYS */;
INSERT INTO `voters` VALUES (275,'Sandy Maulana','Mahasiswa','17.01.071.106','Teknik Informatika','$2y$10$I5hsqhdcj7BmsAfN3sTwC.A2ju0dUQ18emGWmoKRLRW4e18Joyn/q',NULL,'6282260879023',1,1,'2021-06-14 11:06:31','2021-06-14 11:17:12'),(276,'Ahmad Juliansyah','Mahasiswa','20.02.071.021','Teknik Informatika','$2y$10$Kd6MhEdxhCGpAEqfp5sgXO6ekWPpqr8OIrGD8insjuLAIu7CHe7Wy',NULL,'6282342359160',0,0,'2021-06-14 11:26:08','2021-06-14 11:54:00');
/*!40000 ALTER TABLE `voters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `votings`
--

DROP TABLE IF EXISTS `votings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `votings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `judul` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mulai` date NOT NULL,
  `berakhir` date NOT NULL,
  `pending` varchar(191) CHARACTER SET utf8mb4 NOT NULL,
  `result` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `votings`
--

LOCK TABLES `votings` WRITE;
/*!40000 ALTER TABLE `votings` DISABLE KEYS */;
INSERT INTO `votings` VALUES (1,'Pemilihan Dekan Fakultas Teknologi Rekayasa Sistem','2021-06-14','2021-06-16','{\"status\":\"false\",\"ket\":\"\"}','berjalan',NULL,'2021-06-15 09:37:09');
/*!40000 ALTER TABLE `votings` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-15  6:59:58
