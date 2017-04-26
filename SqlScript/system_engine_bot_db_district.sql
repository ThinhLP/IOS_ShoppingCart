-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 127.0.0.1    Database: system_engine_bot_db
-- ------------------------------------------------------
-- Server version	5.7.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `district`
--

DROP TABLE IF EXISTS `district`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `district` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `nearby` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `district`
--

LOCK TABLES `district` WRITE;
/*!40000 ALTER TABLE `district` DISABLE KEYS */;
INSERT INTO `district` VALUES (4,'Quận 1','Quận 1;Quận 2;Quận 3;Quận 4;Quận 5;Quận Phú Nhuận;Quận Bình Thạnh'),(5,'Quận 10','Quận 10;Quận 1;Quận 5;Quận 3;Quận 11;Quận Tân Phú'),(6,'Quận Thủ Đức','Quận Thủ Đức;Quận 9;Quận 12;Quận 2'),(7,'Quận 4','Quận 4;Quận 1;Quận 2;Quận 5;Quận 7;Quận 8'),(8,'Quận 3','Quận 1;Quận 5;Quận Bình Thạnh;Quận Phú Nhuận;Quận Tân Bình'),(9,'Quận 8','Quận 8;Quận 4;Quận 5;Quận 6;Quận 7;Bình Chánh'),(10,'Quận Tân Phú','Quận Tân Phú;Quận 11;Quận 12;Quận Tân Bình;Quận Bình Tân'),(11,'Quận Tân Bình','Quận Tân Bình;Quận 12;Quận Tân Phú;Quận Gò Vấp;Quận Phú Nhuận'),(12,'Quận 5','Quận 5;Quận 1;Quận 4;Quận 6;Quận 8;Quận 10;Quận 11'),(13,'Quận Phú Nhuận','Quận Phú Nhuận;Quận Gò Vấp;Quận Tân Bình;Quận Bình Thạnh;Quận 1;Quận 3'),(14,'Củ Chi',NULL),(15,'Quận Bình Thạnh','Quận Bình Thạnh;Quận Gò Vấp;Quận Thủ Đức;Quận Phú Nhuận;Quận 1;Quận 2'),(16,'Quận 6','Quận 6;Quận 5;Quận 11;Quận Bình Tân;Quận Tân Phú'),(17,'Quận 9','Quận 9;Quận 2;Quận Thủ Đức'),(18,'Quận Gò Vấp','Quận Gò Vấp;Quận Tân Bình;Quận 12'),(19,'Quận 2','Quận 2;Quận 9;Quận Thủ Đức;Quận Bình Thạnh'),(20,'Quận 7','Quận 7;Quận 2;Quận 4;Quận 8;Nhà Bè;Bình Chánh'),(21,'Quận 11','Quận 11;Quận 5;Quận 6;Quận 10;Quận Tân Phú'),(22,'Quận 12','Quận 12;Quận Gò Vấp;Quận Thủ Đức;Quận Tân Bình'),(23,'Quận Bình Tân','Quận Bình Tân;Quận Tân Phú;Quận 6;Quận 8'),(24,'Bình Chánh',NULL),(25,'Nhà Bè',NULL),(26,'Hóc Môn',NULL),(27,'Cần Giờ',NULL),(31,'Tân Bình',NULL),(32,'District 5',NULL),(33,'District 1',NULL),(34,'District 3',NULL),(35,'District 10',NULL),(36,'Thủ Đức',NULL);
/*!40000 ALTER TABLE `district` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-04-20 13:23:53
