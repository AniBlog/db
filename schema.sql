CREATE DATABASE  IF NOT EXISTS `rss_aggregator` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `rss_aggregator`;
-- MySQL dump 10.13  Distrib 8.0.29, for macos12 (x86_64)
--
-- Host: 134.122.105.68    Database: rss_aggregator
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `discovered_sites_blacklist`
--

DROP TABLE IF EXISTS `discovered_sites_blacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discovered_sites_blacklist` (
  `pk_blacklisted_id` int NOT NULL AUTO_INCREMENT,
  `host` varchar(255) NOT NULL,
  PRIMARY KEY (`pk_blacklisted_id`),
  UNIQUE KEY `host_UNIQUE` (`host`)
) ENGINE=InnoDB AUTO_INCREMENT=245 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `discovered_sites_queue`
--

DROP TABLE IF EXISTS `discovered_sites_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discovered_sites_queue` (
  `pk_prospect_id` int NOT NULL AUTO_INCREMENT,
  `fqdn` varchar(255) NOT NULL,
  `feed_url` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('accepted','pending','rejected') NOT NULL DEFAULT 'pending',
  `score` int NOT NULL DEFAULT '0',
  `encountered` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`pk_prospect_id`),
  KEY `prospectFqdn_idx` (`fqdn`),
  KEY `state_idx` (`status`,`score` DESC,`encountered` DESC)
) ENGINE=InnoDB AUTO_INCREMENT=22292 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `discovered_youtube_channels`
--

DROP TABLE IF EXISTS `discovered_youtube_channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discovered_youtube_channels` (
  `pk_yt_channel_id` int NOT NULL AUTO_INCREMENT,
  `channel_id` varchar(255) NOT NULL,
  `channel_name` varchar(255) NOT NULL,
  `linked_video_id` varchar(255) DEFAULT NULL,
  `linked_video_title` text,
  `modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('accepted','pending','rejected') NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`pk_yt_channel_id`),
  UNIQUE KEY `channel_id_UNIQUE` (`channel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55187 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `files` (
  `pk_file_id` int NOT NULL AUTO_INCREMENT,
  `fk_post_id` int DEFAULT NULL,
  `external_url` varchar(255) NOT NULL,
  `file_category` enum('featured_image','other') NOT NULL DEFAULT 'featured_image',
  `mime_type` varchar(255) DEFAULT NULL,
  `file_size` int DEFAULT NULL,
  `ingested_uri` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state` enum('pending','retrieved','failed') NOT NULL DEFAULT 'pending',
  `attempts` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`pk_file_id`),
  KEY `PostFiles_idx` (`fk_post_id`),
  KEY `FileCat_idx` (`file_category`),
  KEY `State_idx` (`state`),
  KEY `Created_idx` (`created` DESC),
  CONSTRAINT `PostFiles` FOREIGN KEY (`fk_post_id`) REFERENCES `posts` (`pk_post_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=69947 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `pk_genre_id` int NOT NULL AUTO_INCREMENT,
  `genre` varchar(255) NOT NULL,
  PRIMARY KEY (`pk_genre_id`),
  UNIQUE KEY `genre_UNIQUE` (`genre`),
  KEY `genre_INDEX` (`genre`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `groups` (
  `pk_group_id` int NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) NOT NULL,
  PRIMARY KEY (`pk_group_id`),
  KEY `groupName` (`group_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `pk_media_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `start_date` date NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `guid` int NOT NULL,
  `auto_index` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`pk_media_id`),
  UNIQUE KEY `guid_UNIQUE` (`guid`),
  KEY `guid_INDEX` (`guid`),
  KEY `matchPostToMedia_idx` (`pk_media_id`,`auto_index`,`title`),
  KEY `startDates` (`start_date`,`title`)
) ENGINE=InnoDB AUTO_INCREMENT=18498 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `media_genres`
--

DROP TABLE IF EXISTS `media_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_genres` (
  `pk_media_genre_id` int NOT NULL AUTO_INCREMENT,
  `fk_media_id` int NOT NULL,
  `fk_genre_id` int NOT NULL,
  PRIMARY KEY (`pk_media_genre_id`),
  KEY `genreWithMedia_idx` (`fk_genre_id`),
  KEY `mediaWithGenre_idx` (`fk_media_id`),
  CONSTRAINT `genreWithMedia` FOREIGN KEY (`fk_genre_id`) REFERENCES `genres` (`pk_genre_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mediaWithGenre` FOREIGN KEY (`fk_media_id`) REFERENCES `media` (`pk_media_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9473967 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `media_synonyms`
--

DROP TABLE IF EXISTS `media_synonyms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_synonyms` (
  `pk_synonyms_id` int NOT NULL AUTO_INCREMENT,
  `fk_media_id` int NOT NULL,
  `synonym` text NOT NULL,
  PRIMARY KEY (`pk_synonyms_id`),
  KEY `mediaSynonym_idx` (`fk_media_id`),
  CONSTRAINT `mediaSynonym` FOREIGN KEY (`fk_media_id`) REFERENCES `media` (`pk_media_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4616482 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `media_titles`
--

DROP TABLE IF EXISTS `media_titles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_titles` (
  `pk_media_title_id` int NOT NULL AUTO_INCREMENT,
  `fk_media_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`pk_media_title_id`),
  KEY `mediaTitles_idx` (`fk_media_id`),
  CONSTRAINT `mediaTitles` FOREIGN KEY (`fk_media_id`) REFERENCES `media` (`pk_media_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9666354 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `post_content`
--

DROP TABLE IF EXISTS `post_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_content` (
  `pk_post_content_id` int NOT NULL AUTO_INCREMENT,
  `fk_post_id` int NOT NULL,
  `content` longtext,
  PRIMARY KEY (`pk_post_content_id`),
  KEY `contents_for_post_idx` (`fk_post_id`),
  CONSTRAINT `contents_for_post` FOREIGN KEY (`fk_post_id`) REFERENCES `posts` (`pk_post_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=174063 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `post_media`
--

DROP TABLE IF EXISTS `post_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_media` (
  `pk_post_media_id` int NOT NULL AUTO_INCREMENT,
  `fk_post_id` int NOT NULL,
  `fk_media_id` int NOT NULL,
  PRIMARY KEY (`pk_post_media_id`),
  KEY `postMedia_idx` (`fk_media_id`),
  KEY `mediaPost_idx` (`fk_post_id`),
  CONSTRAINT `mediaPost` FOREIGN KEY (`fk_post_id`) REFERENCES `posts` (`pk_post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `postMedia` FOREIGN KEY (`fk_media_id`) REFERENCES `media` (`pk_media_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=102277 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `post_tags`
--

DROP TABLE IF EXISTS `post_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_tags` (
  `pk_post_tag` int NOT NULL AUTO_INCREMENT,
  `fk_post_id` int NOT NULL,
  `fk_tag_id` int NOT NULL,
  PRIMARY KEY (`pk_post_tag`),
  KEY `postWithTag_idx` (`fk_post_id`),
  KEY `tagWithPost_idx` (`fk_tag_id`),
  CONSTRAINT `postWithTag` FOREIGN KEY (`fk_post_id`) REFERENCES `posts` (`pk_post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tagWithPost` FOREIGN KEY (`fk_tag_id`) REFERENCES `tags` (`pk_tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=694347 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `post_verify`
--

DROP TABLE IF EXISTS `post_verify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_verify` (
  `pk_verified_id` int NOT NULL AUTO_INCREMENT,
  `fk_post_id` int NOT NULL,
  `response_code` int NOT NULL,
  `mime_type` varchar(255) DEFAULT NULL,
  `modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_verified_id`),
  KEY `postVerified_idx` (`fk_post_id`),
  CONSTRAINT `postVerified` FOREIGN KEY (`fk_post_id`) REFERENCES `posts` (`pk_post_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=474338 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `pk_post_id` int NOT NULL AUTO_INCREMENT,
  `fk_site_id` int NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `post_title` varchar(255) DEFAULT NULL,
  `pub_date` datetime NOT NULL,
  `link` varchar(255) NOT NULL,
  `site_title` varchar(255) DEFAULT NULL,
  `description` text,
  `image` varchar(255) DEFAULT NULL,
  `content` longtext,
  `view_count` int NOT NULL DEFAULT '0',
  `visible` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`pk_post_id`),
  KEY `postOwner_idx` (`fk_site_id`),
  KEY `postLinkLookup` (`link`) COMMENT 'Speed up searching for posts by their link value; only way to avoid duplicates',
  KEY `importPostToSolr_idx` (`modified`,`pub_date`),
  KEY `postsCreatedInLastX_idx` (`created`),
  KEY `postsPublishedInLastX_idx` (`pub_date` DESC),
  CONSTRAINT `postOwner` FOREIGN KEY (`fk_site_id`) REFERENCES `sites` (`pk_site_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=105789 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sites` (
  `pk_site_id` int NOT NULL AUTO_INCREMENT,
  `feed_name` varchar(255) NOT NULL DEFAULT 'To be added',
  `feed_url` varchar(255) NOT NULL,
  `type` enum('blog','youtube','Aniblog','Anitube') NOT NULL DEFAULT 'Aniblog',
  `active` tinyint NOT NULL DEFAULT '1',
  `alt_name` varchar(255) DEFAULT '',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_checked` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT 'Last SUCCESSFUL check on RSS',
  `days_since_last_post` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`pk_site_id`),
  UNIQUE KEY `feed_url_UNIQUE` (`feed_url`),
  KEY `activeSitesOnly_idx` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=1612 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `pk_tag_id` int NOT NULL AUTO_INCREMENT,
  `tag` varchar(255) NOT NULL,
  PRIMARY KEY (`pk_tag_id`),
  UNIQUE KEY `tag_UNIQUE` (`tag`),
  KEY `tag_INDEX` (`tag`)
) ENGINE=InnoDB AUTO_INCREMENT=95696 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `pk_user_id` int NOT NULL AUTO_INCREMENT,
  `email_address` varchar(255) NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_user_id`),
  UNIQUE KEY `email_address_UNIQUE` (`email_address`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_groups` (
  `pk_user_group_id` int NOT NULL AUTO_INCREMENT,
  `fk_user_id` int NOT NULL,
  `fk_group_id` int NOT NULL,
  PRIMARY KEY (`pk_user_group_id`),
  KEY `userInGroup_idx` (`fk_user_id`),
  KEY `groupAscociatedWithUser_idx` (`fk_group_id`),
  CONSTRAINT `groupAscociatedWithUser` FOREIGN KEY (`fk_group_id`) REFERENCES `groups` (`pk_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userInGroup` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`pk_user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_subscriptions`
--

DROP TABLE IF EXISTS `users_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_subscriptions` (
  `pk_subscription_id` int NOT NULL AUTO_INCREMENT,
  `fk_user_id` int NOT NULL,
  `fk_site_id` int NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk_subscription_id`),
  UNIQUE KEY `sitePerUser` (`fk_user_id`,`fk_site_id`),
  KEY `subOwner_idx` (`fk_user_id`),
  KEY `subbedSite_idx` (`fk_site_id`),
  CONSTRAINT `subbedSite` FOREIGN KEY (`fk_site_id`) REFERENCES `sites` (`pk_site_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `subOwner` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`pk_user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-06 14:54:02
