-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: twitter_db
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `followers`
--

DROP TABLE IF EXISTS `followers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `followers` (
  `followers_id` int NOT NULL,
  `following_id` int NOT NULL,
  PRIMARY KEY (`followers_id`,`following_id`),
  CONSTRAINT `check_followers_id` CHECK ((`followers_id` <> `following_id`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `followers`
--

LOCK TABLES `followers` WRITE;
/*!40000 ALTER TABLE `followers` DISABLE KEYS */;
INSERT INTO `followers` VALUES (1,2),(2,1),(3,1),(3,6),(4,1),(5,2),(6,3);
/*!40000 ALTER TABLE `followers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tweet_likes`
--

DROP TABLE IF EXISTS `tweet_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tweet_likes` (
  `user_id` int NOT NULL,
  `tweet_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`tweet_id`),
  KEY `tweet_id` (`tweet_id`),
  CONSTRAINT `tweet_likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `tweet_likes_ibfk_2` FOREIGN KEY (`tweet_id`) REFERENCES `tweets` (`tweet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tweet_likes`
--

LOCK TABLES `tweet_likes` WRITE;
/*!40000 ALTER TABLE `tweet_likes` DISABLE KEYS */;
INSERT INTO `tweet_likes` VALUES (2,1),(3,1),(1,2),(6,3);
/*!40000 ALTER TABLE `tweet_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tweets`
--

DROP TABLE IF EXISTS `tweets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tweets` (
  `tweet_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `tweet_text` varchar(280) NOT NULL,
  `num_likes` int DEFAULT '0',
  `num_comments` int DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT (now()),
  PRIMARY KEY (`tweet_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `tweets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tweets`
--

LOCK TABLES `tweets` WRITE;
/*!40000 ALTER TABLE `tweets` DISABLE KEYS */;
INSERT INTO `tweets` VALUES (1,1,'Este año se viene balón de oro.',0,0,'2025-06-25 10:08:17'),(2,5,'Seguro que Musiala aun sueña conmigo.',0,0,'2025-06-25 10:08:17'),(3,2,'@vjr7, Beach Ball!!!! xD',0,0,'2025-06-25 10:08:17'),(4,4,'@mbappe09, se parece a Donatello.',0,0,'2025-06-25 10:08:17'),(5,6,'@courtois01, Le dijo la jirafa a al tortuga...',0,0,'2025-06-25 10:08:17'),(6,1,'@bellingham5, eso es racismo...',0,0,'2025-06-25 10:41:58');
/*!40000 ALTER TABLE `tweets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_handle` varchar(50) NOT NULL,
  `email_address` varchar(50) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `phonenumber` char(10) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT (now()),
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_handle` (`user_handle`),
  UNIQUE KEY `email_address` (`email_address`),
  UNIQUE KEY `phonenumber` (`phonenumber`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'vjr7','vinijr@realmadrid.com','Vinícius','Júnior','6001234567','2025-06-23 12:49:59'),(2,'bellingham5','jbellingham@realmadrid.com','Jude','Bellingham','6002345678','2025-06-23 12:50:20'),(3,'modric10','lmodric@realmadrid.com','Luka','Modrić','6003456789','2025-06-23 12:50:40'),(4,'courtois1','tcourtois@realmadrid.com','Thibaut','Courtois','6004567890','2025-06-23 12:50:44'),(5,'carvajal2','dcarvajal@realmadrid.com','Dani','Carvajal','6005678901','2025-06-23 12:50:46'),(6,'mbappe09','kmbappe@realmadrid.com','Kilian','Mbappe','6005678147','2025-06-23 12:52:15');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-25 12:13:32
