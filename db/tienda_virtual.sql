-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-10-2022 a las 18:08:08
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tienda_virtual`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `seleCarrito` (IN `usuario_id` INT(11))   BEGIN
SELECT productos.nombre, productos.descripcion, productos.precio_venta, carrito.cantidad, carrito.id, carrito.producto_id AS producto_id 
FROM productos 
INNER JOIN carrito ON productos.id = carrito.producto_id
WHERE carrito.usuario_id = usuario_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `seleCompra` (IN `usuario_id` INT(11))   BEGIN
SELECT compras.id, productos.nombre, productos.descripcion, compras.cantidad, compras.total, compras.estado
FROM productos 
INNER JOIN compras ON productos.id = compras.producto_id
WHERE compras.usuario_id = usuario_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito`
--

CREATE TABLE `carrito` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` int(40) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `carrito`
--

INSERT INTO `carrito` (`id`, `usuario_id`, `producto_id`, `cantidad`) VALUES
(5, 4, 1, 2),
(11, 2, 40, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` int(40) NOT NULL,
  `total` int(100) NOT NULL,
  `estado` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id`, `usuario_id`, `producto_id`, `cantidad`, `total`, `estado`) VALUES
(7, 2, 1, 4, 8000, 'Comprado'),
(9, 2, 40, 3, 3300000, 'Comprado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text NOT NULL,
  `costo` int(40) NOT NULL,
  `precio_venta` int(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `descripcion`, `costo`, `precio_venta`) VALUES
(1, 'plátano', 'plátano verde ', 1000, 2000),
(9, 'mouse', '200 de dpi, 4 botones, drag click, rgb, inalámbrico ', 25000, 30000),
(10, 'carro', 'color rojo, 0 km', 20000000, 30000000),
(39, 'Teclado inalámbrico Logitech K400 Plus', 'Es inalámbrico y funciona con pilas.\nIncluye touchpad.\nResiste a salpicaduras.\nTecla plana.\nCon conector USB.\nMedidas: 354.3mm de ancho, 139.9mm de alto y 23.5mm de profundidad.\nIndispensable para tus actividades.', 100000, 116375),
(40, 'Laptop Asus VivoBook E410MA', 'Procesador Intel Celeron.\nMemoria RAM de 4GB.\nPantalla LED de 14\".\nResolución de 1366x768 px.\nEs antirreflejo.\nTarjeta gráfica Intel UHD Graphics 600.\nConexión wifi y bluetooth.\nCuenta con 3 puertos USB y puerto HDMI.\nPosee pad numérico.\nModo de sonido SonicMaster.\nLa duración de la batería depende del uso que se le dé al producto...', 900000, 1100000),
(41, 'Nintendo Switch OLED 64GB Standard color blanco y negro', 'Incluye 2 controles.\nResolución de 1920px x 1080px.\nMemoria RAM de 4GB.\nTiene pantalla táctil.\nLa duración de la batería es de 9h.\nHoras de diversión garantizada.\nCuenta con: 1 joy-con grip, 1 adaptador de corriente, 1 dock, 1 cable hdmi, 2 correas para joy-con.\nLa duración de la batería depende del uso que se le dé al producto...', 1500000, 1834900),
(42, 'Microsoft Xbox Series S 512GB Standard color blanco', 'Incluye control.\nResolución de 2560px x 1440px.\nMemoria RAM de 10GB.\nHoras de diversión garantizada.\nCuenta con: 1 cable hdmi, 1 cable de alimentación ca.\nLa duración de la batería depende del uso que se le dé al producto...', 1200000, 1534900),
(43, 'Sony PlayStation 5 825GB Standard color blanco y negro', 'Incluye control.\nResolución de 3840px x 2160px.\nMemoria RAM de 16GB.\nHoras de diversión garantizada.\nCuenta con: 1 soporte vertical, 1 cable de alimentación ac, 1 cable usb, 1 cable hdmi, 1 guía de inicio rápido, 1 guía de seguridad.\nLa duración de la batería depende del uso que se le dé al producto...', 3754900, 4200000),
(44, 'Xiaomi Redmi Note 11', 'Dispositivo desbloqueado para que elijas la compañía telefónica que prefieras.\nPantalla AMOLED de 6.43\".\nTiene 4 cámaras traseras de 50Mpx/8Mpx/2Mpx/2Mpx.\nCámara delantera de 13Mpx.\nProcesador Snapdragon 680 Octa-Core de 2.4GHz con 4GB de RAM.\nBatería de 5000mAh.\nMemoria interna de 128GB.\nCon reconocimiento facial y sensor de huella dactilar.\nResistente al polvo.', 759900, 850000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre_completo` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `clave` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre_completo`, `correo`, `clave`) VALUES
(1, 'examplename', 'example@gmail.co', 'Si1234'),
(2, 'Emanuel', 'ezp@gmail.com', 'Ezp1225'),
(3, 'maria nemecia', 'maria@gmail.com', 'Maria123'),
(4, 'duver', 'duver@gmail.com', 'Duver123');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `producto_id` (`producto_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `carrito`
--
ALTER TABLE `carrito`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `carrito_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `compras_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
