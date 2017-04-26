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

USE  system_engine_bot_db
--
-- Table structure for table `receipt`
--

DROP TABLE IF EXISTS `receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `receipt` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `receipt_name` varchar(45) NOT NULL,
  `date_time` varchar(45) NOT NULL,
  `products` varchar(500) NOT NULL,
  `price_total` varchar(45) NOT NULL,
  `method` int(11) NOT NULL,
  `currency_unit` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipt`
--

LOCK TABLES `receipt` WRITE;
/*!40000 ALTER TABLE `receipt` DISABLE KEYS */;
INSERT INTO `receipt` VALUES (4,'Receipt 2017-04-16 04:38:41','2017-04-16 04:38:41','[{ Optional(2) : { productId : Optional(2), count : 1 } },{ Optional(1) : { productId : Optional(1), count : 2 } },{ Optional(3) : { productId : Optional(3), count : 1 } }]','200 $',1,1,2),(5,'Receipt 2017-04-16 04:40:01','2017-04-16 04:40:01','[{ Optional(4) : { productId : Optional(4), count : 2 } },{ Optional(3) : { productId : Optional(3), count : 1 } },{ Optional(2) : { productId : Optional(2), count : 1 } },{ Optional(1) : { productId : Optional(1), count : 1 } }]','250 $',1,1,2),(6,'Receipt 2017-04-16 04:44:14','2017-04-16 04:44:14','[{ Optional(6) : { productId : Optional(6), count : 4 } },{ Optional(7) : { productId : Optional(7), count : 4 } },{ Optional(2) : { productId : Optional(2), count : 5 } },{ Optional(1) : { productId : Optional(1), count : 6 } }]','350 $',1,1,2),(7,'Receipt 2017-04-16 04:45:53','2017-04-16 04:45:53','[{ Optional(12) : { productId : Optional(12), count : 8 } },{ Optional(10) : { productId : Optional(10), count : 4 } },{ Optional(2) : { productId : Optional(2), count : 1 } },{ Optional(11) : { productId : Optional(11), count : 3 } },{ Optional(4) : { productId : Optional(4), count : 4 } },{ Optional(3) : { productId : Optional(3), count : 4 } },{ Optional(1) : { productId : Optional(1), count : 2 } }]','1300 $',1,1,2),(8,'Receipt 2017-04-16 04:46:36','2017-04-16 04:46:36','[{ Optional(10) : { productId : Optional(10), count : 1 } },{ Optional(11) : { productId : Optional(11), count : 1 } }]','100 $',1,1,2),(9,'Receipt 2017-04-17 12:08:38','2017-04-17 12:08:38','[{ Optional(17) : { productId : Optional(17), count : 5 } },{ Optional(19) : { productId : Optional(19), count : 1 } }]','150 $',1,1,2);
/*!40000 ALTER TABLE `receipt` ENABLE KEYS */;
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
