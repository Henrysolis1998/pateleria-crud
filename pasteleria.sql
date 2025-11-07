CREATE DATABASE IF NOT EXISTS pasteleria CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE pasteleria;

-- --------------------------------------------------------
-- Tabla ingredientes (sin campos de fecha)
-- --------------------------------------------------------
CREATE TABLE `ingredientes` (
  `id_ingrediente` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  PRIMARY KEY (`id_ingrediente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- Tabla pasteles (con campos de fecha)
-- --------------------------------------------------------
CREATE TABLE `pasteles` (
  `id_pastel` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `preparado_por` varchar(100) DEFAULT NULL,
  `fecha_creado` datetime DEFAULT current_timestamp(),
  `fecha_vencimiento` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id_pastel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- Tabla puente pastel_ingrediente
-- --------------------------------------------------------
CREATE TABLE `pastel_ingrediente` (
  `id_pastel` int(11) NOT NULL,
  `id_ingrediente` int(11) NOT NULL,
  PRIMARY KEY (`id_pastel`,`id_ingrediente`),
  KEY `id_ingrediente` (`id_ingrediente`),
  CONSTRAINT `pastel_ingrediente_ibfk_1` FOREIGN KEY (`id_pastel`) REFERENCES `pasteles` (`id_pastel`) ON DELETE CASCADE,
  CONSTRAINT `pastel_ingrediente_ibfk_2` FOREIGN KEY (`id_ingrediente`) REFERENCES `ingredientes` (`id_ingrediente`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
