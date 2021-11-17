-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.26

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
-- Table structure for table `autor`
--

DROP TABLE IF EXISTS `autor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autor` (
  `idAutor` int NOT NULL AUTO_INCREMENT,
  `NombreAutor` varchar(45) NOT NULL,
  PRIMARY KEY (`idAutor`),
  UNIQUE KEY `numero_inventario_UNIQUE` (`NombreAutor`),
  UNIQUE KEY `idLibro_UNIQUE` (`idAutor`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autor`
--

LOCK TABLES `autor` WRITE;
/*!40000 ALTER TABLE `autor` DISABLE KEYS */;
INSERT INTO `autor` VALUES (4,'Coello'),(5,'Geremias'),(6,'Neruda');
/*!40000 ALTER TABLE `autor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carrera`
--

DROP TABLE IF EXISTS `carrera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carrera` (
  `idCarrera` int NOT NULL AUTO_INCREMENT,
  `NombreCarrera` varchar(45) NOT NULL,
  `AñoCarrera` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`idCarrera`),
  UNIQUE KEY `numero_inventario_UNIQUE` (`NombreCarrera`),
  UNIQUE KEY `idLibro_UNIQUE` (`idCarrera`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrera`
--

LOCK TABLES `carrera` WRITE;
/*!40000 ALTER TABLE `carrera` DISABLE KEYS */;
INSERT INTO `carrera` VALUES (1,'Analista de Sistemas','2020'),(2,'Preceptoria','2015'),(3,'Magisterio','2019');
/*!40000 ALTER TABLE `carrera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `idCategoria` int NOT NULL AUTO_INCREMENT,
  `categorianombre` varchar(30) NOT NULL,
  `DescripcionCategoria` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idCategoria`),
  UNIQUE KEY `numero_inventario_UNIQUE` (`categorianombre`),
  UNIQUE KEY `idLibro_UNIQUE` (`idCategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Suspenso','Literario'),(2,'Lengua y Literatura','Primaria'),(3,'Matematicas','Aplicada y Economia');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `editorial`
--

DROP TABLE IF EXISTS `editorial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `editorial` (
  `idEditorial` int NOT NULL AUTO_INCREMENT,
  `NombreEditorial` varchar(45) NOT NULL,
  PRIMARY KEY (`idEditorial`),
  UNIQUE KEY `numero_inventario_UNIQUE` (`NombreEditorial`),
  UNIQUE KEY `idLibro_UNIQUE` (`idEditorial`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `editorial`
--

LOCK TABLES `editorial` WRITE;
/*!40000 ALTER TABLE `editorial` DISABLE KEYS */;
INSERT INTO `editorial` VALUES (3,'Alta Editorial'),(2,'Los Pajaros Blancos'),(1,'Santillana');
/*!40000 ALTER TABLE `editorial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `isbn`
--

DROP TABLE IF EXISTS `isbn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `isbn` (
  `idISBN` int NOT NULL AUTO_INCREMENT,
  `ISBN` int NOT NULL,
  PRIMARY KEY (`idISBN`,`ISBN`),
  UNIQUE KEY `numero_inventario_UNIQUE` (`ISBN`),
  UNIQUE KEY `idLibro_UNIQUE` (`idISBN`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `isbn`
--

LOCK TABLES `isbn` WRITE;
/*!40000 ALTER TABLE `isbn` DISABLE KEYS */;
INSERT INTO `isbn` VALUES (1,111111),(2,222222),(3,333333),(4,444444);
/*!40000 ALTER TABLE `isbn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libros`
--

DROP TABLE IF EXISTS `libros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libros` (
  `idLibro` int NOT NULL AUTO_INCREMENT,
  `numero_inventario` varchar(45) NOT NULL,
  `stock` int unsigned NOT NULL DEFAULT '0',
  `nombre` varchar(256) DEFAULT NULL,
  `Autor_idAutor` int NOT NULL,
  `ISBN_idISBN` int NOT NULL,
  `Categoria_idCategoria` int NOT NULL,
  `idEditorial` int NOT NULL,
  PRIMARY KEY (`idLibro`,`Autor_idAutor`,`Categoria_idCategoria`),
  UNIQUE KEY `numero_inventario_UNIQUE` (`numero_inventario`),
  UNIQUE KEY `idLibro_UNIQUE` (`idLibro`),
  KEY `fk_Libros_Autor1_idx` (`Autor_idAutor`),
  KEY `fk_Libros_ISBN1_idx` (`ISBN_idISBN`),
  KEY `fk_Libros_Categoria1_idx` (`Categoria_idCategoria`),
  KEY `fk_Libros_Editorial_idx` (`idEditorial`),
  CONSTRAINT `fk_Libros_Autor1` FOREIGN KEY (`Autor_idAutor`) REFERENCES `autor` (`idAutor`),
  CONSTRAINT `fk_Libros_Categoria1` FOREIGN KEY (`Categoria_idCategoria`) REFERENCES `categoria` (`idCategoria`),
  CONSTRAINT `fk_Libros_Editorial` FOREIGN KEY (`idEditorial`) REFERENCES `editorial` (`idEditorial`),
  CONSTRAINT `fk_Libros_ISBN1` FOREIGN KEY (`ISBN_idISBN`) REFERENCES `isbn` (`idISBN`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libros`
--

LOCK TABLES `libros` WRITE;
/*!40000 ALTER TABLE `libros` DISABLE KEYS */;
INSERT INTO `libros` VALUES (1,'223452',15,'El libro de Nirvana',5,2,2,1);
/*!40000 ALTER TABLE `libros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimientos`
--

DROP TABLE IF EXISTS `movimientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimientos` (
  `idMovimientos` int NOT NULL AUTO_INCREMENT,
  `idEstudiante` int NOT NULL,
  `IdLibro` int NOT NULL,
  `cantidad` int NOT NULL DEFAULT '0',
  `esRetiro` tinyint NOT NULL DEFAULT '0',
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `TiempoEstadia_idTiempoEstadia` int NOT NULL,
  PRIMARY KEY (`idMovimientos`,`TiempoEstadia_idTiempoEstadia`),
  UNIQUE KEY `idMovimientos_UNIQUE` (`idMovimientos`),
  KEY `Libros_Movimientos_idx` (`IdLibro`),
  KEY `Estudiantes_Movimientos_idx` (`idEstudiante`),
  KEY `fk_Movimientos_TiempoEstadia1_idx` (`TiempoEstadia_idTiempoEstadia`),
  CONSTRAINT `Estudiantes_Movimientos` FOREIGN KEY (`idEstudiante`) REFERENCES `usuarios` (`idUsuario`),
  CONSTRAINT `fk_Movimientos_TiempoEstadia1` FOREIGN KEY (`TiempoEstadia_idTiempoEstadia`) REFERENCES `tiempoestadia` (`idTiempoEstadia`),
  CONSTRAINT `Libros_Movimientos` FOREIGN KEY (`IdLibro`) REFERENCES `libros` (`idLibro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientos`
--

LOCK TABLES `movimientos` WRITE;
/*!40000 ALTER TABLE `movimientos` DISABLE KEYS */;
/*!40000 ALTER TABLE `movimientos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tiempoestadia`
--

DROP TABLE IF EXISTS `tiempoestadia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tiempoestadia` (
  `idTiempoEstadia` int NOT NULL AUTO_INCREMENT,
  `TiempoEstadia` int NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTiempoEstadia`),
  UNIQUE KEY `numero_inventario_UNIQUE` (`TiempoEstadia`),
  UNIQUE KEY `idLibro_UNIQUE` (`idTiempoEstadia`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tiempoestadia`
--

LOCK TABLES `tiempoestadia` WRITE;
/*!40000 ALTER TABLE `tiempoestadia` DISABLE KEYS */;
INSERT INTO `tiempoestadia` VALUES (1,3,'Alumnos'),(2,5,'Profesores'),(3,7,'Administrativo');
/*!40000 ALTER TABLE `tiempoestadia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tiposusuario`
--

DROP TABLE IF EXISTS `tiposusuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tiposusuario` (
  `idTipoUsuario` int NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTipoUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tiposusuario`
--

LOCK TABLES `tiposusuario` WRITE;
/*!40000 ALTER TABLE `tiposusuario` DISABLE KEYS */;
INSERT INTO `tiposusuario` VALUES (1,'Administrativo'),(2,'Alumno'),(3,'Profesorado');
/*!40000 ALTER TABLE `tiposusuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `nombre_apellido` varchar(80) NOT NULL,
  `dni` varchar(15) NOT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `CorreoUsuario` varchar(45) NOT NULL,
  `UsuariosDireccion` varchar(45) DEFAULT NULL,
  `idTipoUsuario` int NOT NULL,
  `idCarrera` int DEFAULT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `idEstudiantes_UNIQUE` (`idUsuario`),
  UNIQUE KEY `dni_UNIQUE` (`dni`),
  KEY `Usuario_TIpoUsuario_idx` (`idTipoUsuario`),
  KEY `Usuario_Carrera_idx` (`idCarrera`),
  CONSTRAINT `Usuario_Carrera` FOREIGN KEY (`idCarrera`) REFERENCES `carrera` (`idCarrera`),
  CONSTRAINT `Usuario_TIpoUsuario` FOREIGN KEY (`idTipoUsuario`) REFERENCES `tiposusuario` (`idTipoUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Lucas Geremias','37586819','3764665268','geremias@email.com','ch102 mz 11 casa 8',3,1),(2,'Lizi','23453435','395938490','lizi@email.com','en la cll',2,2);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-17  2:49:14
