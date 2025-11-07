


CREATE DATABASE pasteleria CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE pasteleria;

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-11-2025 a las 20:49:32
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pasteleria`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingredientes`
--

CREATE TABLE `ingredientes` (
  `id_ingrediente` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_creado` datetime DEFAULT current_timestamp(),
  `fecha_vencimiento` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pasteles`
--

CREATE TABLE `pasteles` (
  `id_pastel` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `preparado_por` varchar(100) DEFAULT NULL,
  `fecha_creado` datetime DEFAULT current_timestamp(),
  `fecha_vencimiento` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pastel_ingrediente`
--

CREATE TABLE `pastel_ingrediente` (
  `id_pastel` int(11) NOT NULL,
  `id_ingrediente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ingredientes`
--
ALTER TABLE `ingredientes`
  ADD PRIMARY KEY (`id_ingrediente`);

--
-- Indices de la tabla `pasteles`
--
ALTER TABLE `pasteles`
  ADD PRIMARY KEY (`id_pastel`);

--
-- Indices de la tabla `pastel_ingrediente`
--
ALTER TABLE `pastel_ingrediente`
  ADD PRIMARY KEY (`id_pastel`,`id_ingrediente`),
  ADD KEY `id_ingrediente` (`id_ingrediente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ingredientes`
--
ALTER TABLE `ingredientes`
  MODIFY `id_ingrediente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pasteles`
--
ALTER TABLE `pasteles`
  MODIFY `id_pastel` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `pastel_ingrediente`
--
ALTER TABLE `pastel_ingrediente`
  ADD CONSTRAINT `pastel_ingrediente_ibfk_1` FOREIGN KEY (`id_pastel`) REFERENCES `pasteles` (`id_pastel`) ON DELETE CASCADE,
  ADD CONSTRAINT `pastel_ingrediente_ibfk_2` FOREIGN KEY (`id_ingrediente`) REFERENCES `ingredientes` (`id_ingrediente`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
