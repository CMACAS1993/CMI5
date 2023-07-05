-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-12-2022 a las 23:56:03
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
-- Base de datos: `uml`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `atribute`
--

CREATE TABLE `atribute` (
  `id` int(11) NOT NULL,
  `datatype_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `codeline`
--

CREATE TABLE `codeline` (
  `id` int(11) NOT NULL,
  `entry` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `codeline`
--

INSERT INTO `codeline` (`id`, `entry`) VALUES
(7, 'public String Obtener(){'),
(8, 'int pos=0; int  mayor=0;'),
(9, 'for(int i=0;i<estudiantes.length;i++){'),
(10, 'if(mayor<estudiantes[i].getnotaExamen()){'),
(11, 'mayor=estudiantes[i].getnotaExamen();'),
(12, 'pos=i;'),
(13, '}'),
(14, '}'),
(15, 'return estudiantes[pos].getNombre();'),
(16, '}'),
(17, 'public String Obtener(){');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `course`
--

CREATE TABLE `course` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `initial_date` datetime NOT NULL,
  `final_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `course`
--

INSERT INTO `course` (`id`, `name`, `initial_date`, `final_date`) VALUES
(3, 'Curso # 1 Clases UML', '2022-07-07 00:00:00', '2022-07-07 00:00:00'),
(4, 'Curso UML Avanzado', '2022-09-20 00:00:00', '2022-09-21 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `course_user`
--

CREATE TABLE `course_user` (
  `course_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `course_user`
--

INSERT INTO `course_user` (`course_id`, `user_id`) VALUES
(3, 25),
(3, 26),
(3, 27),
(4, 25),
(4, 26),
(4, 27);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `datatype`
--

CREATE TABLE `datatype` (
  `id` int(11) NOT NULL,
  `denomination` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `datatype`
--

INSERT INTO `datatype` (`id`, `denomination`) VALUES
(22, 'boolean'),
(23, 'integer'),
(24, ' string'),
(25, ' float'),
(26, ' double'),
(27, ' char'),
(28, 'datetime');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20220615191638', '2022-06-16 02:38:06', 10017),
('DoctrineMigrations\\Version20220615202551', '2022-06-16 02:38:16', 7350);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eval_code`
--

CREATE TABLE `eval_code` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `nactivity_id` int(11) NOT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eval_code_codeline`
--

CREATE TABLE `eval_code_codeline` (
  `eval_code_id` int(11) NOT NULL,
  `codeline_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `model_diagram_success`
--

CREATE TABLE `model_diagram_success` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `nactivity_id` int(11) NOT NULL,
  `data` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `archive` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `model_diagram_test`
--

CREATE TABLE `model_diagram_test` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `nactivity_id` int(11) NOT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nactivity`
--

CREATE TABLE `nactivity` (
  `id` int(11) NOT NULL,
  `nta_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(1500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `place` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `nactivity`
--

INSERT INTO `nactivity` (`id`, `nta_id`, `title`, `description`, `place`) VALUES
(1, 5, 'Ejercicio 8: Crear clase Vehículo', 'Crear una clase Vehiculo que tenga como atributos: marca, color y año del coche.', 'Remoto'),
(2, 5, 'Ejercicio 2: Crear Clase Vehículo', 'Crear una clase Vehículo que tenga los siguientes atributos color, marca y año', 'Remoto');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nta`
--

CREATE TABLE `nta` (
  `id` int(11) NOT NULL,
  `denomination` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `nta`
--

INSERT INTO `nta` (`id`, `denomination`) VALUES
(4, 'Interna'),
(5, 'Interactiva'),
(6, 'Implementación');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `operation`
--

CREATE TABLE `operation` (
  `id` int(11) NOT NULL,
  `datatype_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `operation`
--

INSERT INTO `operation` (`id`, `datatype_id`, `name`) VALUES
(14, 23, 'EdadActual'),
(15, 27, 'EdadActual'),
(16, 27, 'EdadActual');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pclass`
--

CREATE TABLE `pclass` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `nactivity_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pclass_atribute`
--

CREATE TABLE `pclass_atribute` (
  `pclass_id` int(11) NOT NULL,
  `atribute_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pclass_operation`
--

CREATE TABLE `pclass_operation` (
  `pclass_id` int(11) NOT NULL,
  `operation_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `statement`
--

CREATE TABLE `statement` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:uuid)',
  `actor` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:object)',
  `verb` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:object)',
  `object` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:object)',
  `result` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '(DC2Type:object)',
  `context` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '(DC2Type:object)',
  `timestamp` datetime DEFAULT NULL,
  `authority` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '(DC2Type:object)',
  `attachments` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '(DC2Type:object)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `statement`
--

INSERT INTO `statement` (`id`, `actor`, `verb`, `object`, `result`, `context`, `timestamp`, `authority`, `attachments`) VALUES
('1fd7b65b-00d3-46dc-b44a-ae23c4d7e4ec', 'a:2:{s:4:\"name\";s:14:\"Cristian Macas\";s:4:\"mbox\";s:19:\"cristian@macasP.com\";}', 'a:2:{s:2:\"id\";s:41:\"http://adlnet.gov/expapi/verbs/renunciado\";s:7:\"display\";a:2:{s:5:\"en-US\";s:6:\"waived\";s:2:\"es\";s:10:\"renunciado\";}}', 'a:3:{s:10:\"objectType\";s:0:\"\";s:2:\"id\";s:0:\"\";s:10:\"definition\";s:0:\"\";}', 'a:2:{s:10:\"completion\";b:1;s:7:\"success\";b:0;}', 'a:5:{s:10:\"instructor\";s:14:\"Cristian Macas\";s:4:\"team\";s:14:\"Cristian Macas\";s:17:\"contextActivities\";s:20:\"Curso # 1 Clases UML\";s:8:\"platform\";s:12:\"XPerienceUML\";s:10:\"extensions\";s:67:\"http://localhost/v2cristian/umlexperience/location\": \"umlexprience\"\";}', '2022-12-19 20:23:38', 'N;', 'N;'),
('3d213f63-74a1-41b9-8421-d7cf0501791d', 'a:2:{s:4:\"name\";s:14:\"Cristian Macas\";s:4:\"mbox\";s:19:\"cristian@macasP.com\";}', 'a:2:{s:2:\"id\";s:41:\"http://adlnet.gov/expapi/verbs/renunciado\";s:7:\"display\";a:2:{s:5:\"en-US\";s:6:\"waived\";s:2:\"es\";s:10:\"renunciado\";}}', 'a:3:{s:10:\"objectType\";s:0:\"\";s:2:\"id\";s:0:\"\";s:10:\"definition\";s:0:\"\";}', 'a:2:{s:10:\"completion\";b:1;s:7:\"success\";b:0;}', 'a:5:{s:10:\"instructor\";s:14:\"Cristian Macas\";s:4:\"team\";s:14:\"Cristian Macas\";s:17:\"contextActivities\";s:20:\"Curso # 1 Clases UML\";s:8:\"platform\";s:12:\"XPerienceUML\";s:10:\"extensions\";s:67:\"http://localhost/v2cristian/umlexperience/location\": \"umlexprience\"\";}', '2022-12-28 14:23:20', 'N;', 'N;'),
('6bb1b79f-23b6-4776-a76f-7d79b4ac3ec9', 'a:2:{s:4:\"name\";s:14:\"Cristian Macas\";s:4:\"mbox\";s:19:\"cristian@macasP.com\";}', 'a:2:{s:2:\"id\";s:41:\"http://adlnet.gov/expapi/verbs/abandonado\";s:7:\"display\";a:2:{s:5:\"en-US\";s:9:\"abandoned\";s:2:\"es\";s:10:\"abandonado\";}}', 'a:3:{s:10:\"objectType\";s:0:\"\";s:2:\"id\";s:0:\"\";s:10:\"definition\";s:0:\"\";}', 'a:2:{s:10:\"completion\";b:1;s:7:\"success\";b:0;}', 'a:5:{s:10:\"instructor\";s:14:\"Cristian Macas\";s:4:\"team\";s:14:\"Cristian Macas\";s:17:\"contextActivities\";s:20:\"Curso # 1 Clases UML\";s:8:\"platform\";s:12:\"XPerienceUML\";s:10:\"extensions\";s:67:\"http://localhost/v2cristian/umlexperience/location\": \"umlexprience\"\";}', '2022-12-28 14:23:18', 'N;', 'N;'),
('8f353834-0f98-42d5-9d7e-ea0bd6d33554', 'a:2:{s:4:\"name\";s:14:\"Cristian Macas\";s:4:\"mbox\";s:19:\"cristian@macasP.com\";}', 'a:2:{s:2:\"id\";s:41:\"http://adlnet.gov/expapi/verbs/abandonado\";s:7:\"display\";a:2:{s:5:\"en-US\";s:9:\"abandoned\";s:2:\"es\";s:10:\"abandonado\";}}', 'a:3:{s:10:\"objectType\";s:0:\"\";s:2:\"id\";s:0:\"\";s:10:\"definition\";s:0:\"\";}', 'a:2:{s:10:\"completion\";b:1;s:7:\"success\";b:0;}', 'a:5:{s:10:\"instructor\";s:14:\"Cristian Macas\";s:4:\"team\";s:14:\"Cristian Macas\";s:17:\"contextActivities\";s:20:\"Curso # 1 Clases UML\";s:8:\"platform\";s:12:\"XPerienceUML\";s:10:\"extensions\";s:67:\"http://localhost/v2cristian/umlexperience/location\": \"umlexprience\"\";}', '2022-12-23 21:59:38', 'N;', 'N;'),
('a71eb635-7ea9-4eb6-b19e-a6b8efbdaddb', 'a:2:{s:4:\"name\";s:14:\"Cristian Macas\";s:4:\"mbox\";s:19:\"cristian@macasP.com\";}', 'a:2:{s:2:\"id\";s:41:\"http://adlnet.gov/expapi/verbs/abandonado\";s:7:\"display\";a:2:{s:5:\"en-US\";s:9:\"abandoned\";s:2:\"es\";s:10:\"abandonado\";}}', 'a:3:{s:10:\"objectType\";s:0:\"\";s:2:\"id\";s:0:\"\";s:10:\"definition\";s:0:\"\";}', 'a:2:{s:10:\"completion\";b:1;s:7:\"success\";b:0;}', 'a:5:{s:10:\"instructor\";s:14:\"Cristian Macas\";s:4:\"team\";s:14:\"Cristian Macas\";s:17:\"contextActivities\";s:20:\"Curso # 1 Clases UML\";s:8:\"platform\";s:12:\"XPerienceUML\";s:10:\"extensions\";s:67:\"http://localhost/v2cristian/umlexperience/location\": \"umlexprience\"\";}', '2022-12-23 21:59:41', 'N;', 'N;'),
('ab7e4e14-d61f-4228-8928-42285c2fbd08', 'a:2:{s:4:\"name\";s:14:\"Cristian Macas\";s:4:\"mbox\";s:19:\"cristian@macasP.com\";}', 'a:2:{s:2:\"id\";s:41:\"http://adlnet.gov/expapi/verbs/renunciado\";s:7:\"display\";a:2:{s:5:\"en-US\";s:6:\"waived\";s:2:\"es\";s:10:\"renunciado\";}}', 'a:3:{s:10:\"objectType\";s:0:\"\";s:2:\"id\";s:0:\"\";s:10:\"definition\";s:0:\"\";}', 'a:2:{s:10:\"completion\";b:1;s:7:\"success\";b:0;}', 'a:5:{s:10:\"instructor\";s:14:\"Cristian Macas\";s:4:\"team\";s:14:\"Cristian Macas\";s:17:\"contextActivities\";s:20:\"Curso # 1 Clases UML\";s:8:\"platform\";s:12:\"XPerienceUML\";s:10:\"extensions\";s:67:\"http://localhost/v2cristian/umlexperience/location\": \"umlexprience\"\";}', '2022-12-23 21:59:40', 'N;', 'N;'),
('bee5538f-fec5-4d6d-9f8b-3a7c315ad6fd', 'a:2:{s:4:\"name\";s:14:\"Cristian Macas\";s:4:\"mbox\";s:19:\"cristian@macasP.com\";}', 'a:2:{s:2:\"id\";s:41:\"http://adlnet.gov/expapi/verbs/abandonado\";s:7:\"display\";a:2:{s:5:\"en-US\";s:9:\"abandoned\";s:2:\"es\";s:10:\"abandonado\";}}', 'a:3:{s:10:\"objectType\";s:0:\"\";s:2:\"id\";s:0:\"\";s:10:\"definition\";s:0:\"\";}', 'a:2:{s:10:\"completion\";b:1;s:7:\"success\";b:0;}', 'a:5:{s:10:\"instructor\";s:14:\"Cristian Macas\";s:4:\"team\";s:14:\"Cristian Macas\";s:17:\"contextActivities\";s:20:\"Curso # 1 Clases UML\";s:8:\"platform\";s:12:\"XPerienceUML\";s:10:\"extensions\";s:67:\"http://localhost/v2cristian/umlexperience/location\": \"umlexprience\"\";}', '2022-12-29 22:38:10', 'N;', 'N;'),
('c3a2e904-6157-47c8-8110-a878223af1e8', 'a:2:{s:4:\"name\";s:14:\"Cristian Macas\";s:4:\"mbox\";s:19:\"cristian@macasP.com\";}', 'a:2:{s:2:\"id\";s:41:\"http://adlnet.gov/expapi/verbs/renunciado\";s:7:\"display\";a:2:{s:5:\"en-US\";s:6:\"waived\";s:2:\"es\";s:10:\"renunciado\";}}', 'a:3:{s:10:\"objectType\";s:0:\"\";s:2:\"id\";s:0:\"\";s:10:\"definition\";s:0:\"\";}', 'a:2:{s:10:\"completion\";b:1;s:7:\"success\";b:0;}', 'a:5:{s:10:\"instructor\";s:14:\"Cristian Macas\";s:4:\"team\";s:14:\"Cristian Macas\";s:17:\"contextActivities\";s:20:\"Curso # 1 Clases UML\";s:8:\"platform\";s:12:\"XPerienceUML\";s:10:\"extensions\";s:67:\"http://localhost/v2cristian/umlexperience/location\": \"umlexprience\"\";}', '2022-12-27 16:31:38', 'N;', 'N;'),
('ca9b13aa-6b2d-48b1-ba1b-c4357b0b33fd', 'a:2:{s:4:\"name\";s:14:\"Cristian Macas\";s:4:\"mbox\";s:19:\"cristian@macasP.com\";}', 'a:2:{s:2:\"id\";s:41:\"http://adlnet.gov/expapi/verbs/abandonado\";s:7:\"display\";a:2:{s:5:\"en-US\";s:9:\"abandoned\";s:2:\"es\";s:10:\"abandonado\";}}', 'a:3:{s:10:\"objectType\";s:0:\"\";s:2:\"id\";s:0:\"\";s:10:\"definition\";s:0:\"\";}', 'a:2:{s:10:\"completion\";b:1;s:7:\"success\";b:0;}', 'a:5:{s:10:\"instructor\";s:14:\"Cristian Macas\";s:4:\"team\";s:14:\"Cristian Macas\";s:17:\"contextActivities\";s:20:\"Curso # 1 Clases UML\";s:8:\"platform\";s:12:\"XPerienceUML\";s:10:\"extensions\";s:67:\"http://localhost/v2cristian/umlexperience/location\": \"umlexprience\"\";}', '2022-12-19 20:23:35', 'N;', 'N;'),
('d17b4ba0-a3cc-4217-a2a5-a71563593724', 'a:2:{s:4:\"name\";s:14:\"Cristian Macas\";s:4:\"mbox\";s:19:\"cristian@macasP.com\";}', 'a:2:{s:2:\"id\";s:41:\"http://adlnet.gov/expapi/verbs/renunciado\";s:7:\"display\";a:2:{s:5:\"en-US\";s:6:\"waived\";s:2:\"es\";s:10:\"renunciado\";}}', 'a:3:{s:10:\"objectType\";s:0:\"\";s:2:\"id\";s:0:\"\";s:10:\"definition\";s:0:\"\";}', 'a:2:{s:10:\"completion\";b:1;s:7:\"success\";b:0;}', 'a:5:{s:10:\"instructor\";s:14:\"Cristian Macas\";s:4:\"team\";s:14:\"Cristian Macas\";s:17:\"contextActivities\";s:20:\"Curso # 1 Clases UML\";s:8:\"platform\";s:12:\"XPerienceUML\";s:10:\"extensions\";s:67:\"http://localhost/v2cristian/umlexperience/location\": \"umlexprience\"\";}', '2022-12-29 22:38:10', 'N;', 'N;'),
('ec9b2df8-c690-429f-9813-c8859ace6332', 'a:2:{s:4:\"name\";s:14:\"Cristian Macas\";s:4:\"mbox\";s:19:\"cristian@macasP.com\";}', 'a:2:{s:2:\"id\";s:41:\"http://adlnet.gov/expapi/verbs/renunciado\";s:7:\"display\";a:2:{s:5:\"en-US\";s:6:\"waived\";s:2:\"es\";s:10:\"renunciado\";}}', 'a:3:{s:10:\"objectType\";s:0:\"\";s:2:\"id\";s:0:\"\";s:10:\"definition\";s:0:\"\";}', 'a:2:{s:10:\"completion\";b:1;s:7:\"success\";b:0;}', 'a:5:{s:10:\"instructor\";s:14:\"Cristian Macas\";s:4:\"team\";s:14:\"Cristian Macas\";s:17:\"contextActivities\";s:20:\"Curso # 1 Clases UML\";s:8:\"platform\";s:12:\"XPerienceUML\";s:10:\"extensions\";s:67:\"http://localhost/v2cristian/umlexperience/location\": \"umlexprience\"\";}', '2022-12-23 21:59:41', 'N;', 'N;'),
('fc7c183c-673e-4e66-995c-468b3667d167', 'a:2:{s:4:\"name\";s:14:\"Cristian Macas\";s:4:\"mbox\";s:19:\"cristian@macasP.com\";}', 'a:2:{s:2:\"id\";s:41:\"http://adlnet.gov/expapi/verbs/abandonado\";s:7:\"display\";a:2:{s:5:\"en-US\";s:9:\"abandoned\";s:2:\"es\";s:10:\"abandonado\";}}', 'a:3:{s:10:\"objectType\";s:0:\"\";s:2:\"id\";s:0:\"\";s:10:\"definition\";s:0:\"\";}', 'a:2:{s:10:\"completion\";b:1;s:7:\"success\";b:0;}', 'a:5:{s:10:\"instructor\";s:14:\"Cristian Macas\";s:4:\"team\";s:14:\"Cristian Macas\";s:17:\"contextActivities\";s:20:\"Curso # 1 Clases UML\";s:8:\"platform\";s:12:\"XPerienceUML\";s:10:\"extensions\";s:67:\"http://localhost/v2cristian/umlexperience/location\": \"umlexprience\"\";}', '2022-12-27 16:31:36', 'N;', 'N;');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stud_pclass`
--

CREATE TABLE `stud_pclass` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `nactivity_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stud_pclass_atribute`
--

CREATE TABLE `stud_pclass_atribute` (
  `stud_pclass_id` int(11) NOT NULL,
  `atribute_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stud_pclass_operation`
--

CREATE TABLE `stud_pclass_operation` (
  `stud_pclass_id` int(11) NOT NULL,
  `operation_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `success_code`
--

CREATE TABLE `success_code` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `nactivity_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `success_code_codeline`
--

CREATE TABLE `success_code_codeline` (
  `success_code_id` int(11) NOT NULL,
  `codeline_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `name`) VALUES
(25, 'cristian@macasP.com', '[\"ROLE_ADMIN\"]', '$argon2id$v=19$m=65536,t=4,p=1$LnpzYWlmNnRscnpBNU9JQw$NZIeUcJPuMoH/2HO63RxiFGI5Z71xBT72+6ExevQ+cc', 'Cristian Macas'),
(26, 'cristian@macas.com', '[\"ROLE_ADMIN\"]', '$argon2id$v=19$m=65536,t=4,p=1$VzAyLnNTS3loYUNpc25hbw$SYZLZosgWuAG4EIRh+WLwqf9FkNvEIUQoR2UQTpXJC8', 'Cristian Macas'),
(27, 'cristianMacas@student.com', '[\"ROLE_USER\"]', '$argon2id$v=19$m=65536,t=4,p=1$SDVmUTVScERTd2x2aTV0Nw$iKKjh4esWmo/CKia6DLCqfFD5U1SB21BGYgTRcfxBjo', 'Cristian Macas');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `atribute`
--
ALTER TABLE `atribute`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_6128E945C815A09` (`datatype_id`);

--
-- Indices de la tabla `codeline`
--
ALTER TABLE `codeline`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `course_user`
--
ALTER TABLE `course_user`
  ADD PRIMARY KEY (`course_id`,`user_id`),
  ADD KEY `IDX_45310B4F591CC992` (`course_id`),
  ADD KEY `IDX_45310B4FA76ED395` (`user_id`);

--
-- Indices de la tabla `datatype`
--
ALTER TABLE `datatype`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `eval_code`
--
ALTER TABLE `eval_code`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_242777BC591CC992` (`course_id`),
  ADD KEY `IDX_242777BC50F1A803` (`nactivity_id`);

--
-- Indices de la tabla `eval_code_codeline`
--
ALTER TABLE `eval_code_codeline`
  ADD PRIMARY KEY (`eval_code_id`,`codeline_id`),
  ADD KEY `IDX_C47D34F46F71983A` (`eval_code_id`),
  ADD KEY `IDX_C47D34F4CBCECA63` (`codeline_id`);

--
-- Indices de la tabla `model_diagram_success`
--
ALTER TABLE `model_diagram_success`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D6B7D839591CC992` (`course_id`),
  ADD KEY `IDX_D6B7D83950F1A803` (`nactivity_id`);

--
-- Indices de la tabla `model_diagram_test`
--
ALTER TABLE `model_diagram_test`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_E04B22DE591CC992` (`course_id`),
  ADD KEY `IDX_E04B22DE50F1A803` (`nactivity_id`);

--
-- Indices de la tabla `nactivity`
--
ALTER TABLE `nactivity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_BBFE98AB95F405C2` (`nta_id`);

--
-- Indices de la tabla `nta`
--
ALTER TABLE `nta`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `operation`
--
ALTER TABLE `operation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_1981A66D5C815A09` (`datatype_id`);

--
-- Indices de la tabla `pclass`
--
ALTER TABLE `pclass`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_918942E0591CC992` (`course_id`),
  ADD KEY `IDX_918942E050F1A803` (`nactivity_id`);

--
-- Indices de la tabla `pclass_atribute`
--
ALTER TABLE `pclass_atribute`
  ADD PRIMARY KEY (`pclass_id`,`atribute_id`),
  ADD KEY `IDX_B2E8E54899880302` (`pclass_id`),
  ADD KEY `IDX_B2E8E548CAE21197` (`atribute_id`);

--
-- Indices de la tabla `pclass_operation`
--
ALTER TABLE `pclass_operation`
  ADD PRIMARY KEY (`pclass_id`,`operation_id`),
  ADD KEY `IDX_9650C2F999880302` (`pclass_id`),
  ADD KEY `IDX_9650C2F944AC3583` (`operation_id`);

--
-- Indices de la tabla `statement`
--
ALTER TABLE `statement`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `stud_pclass`
--
ALTER TABLE `stud_pclass`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_E8A6F23A591CC992` (`course_id`),
  ADD KEY `IDX_E8A6F23A50F1A803` (`nactivity_id`);

--
-- Indices de la tabla `stud_pclass_atribute`
--
ALTER TABLE `stud_pclass_atribute`
  ADD PRIMARY KEY (`stud_pclass_id`,`atribute_id`),
  ADD KEY `IDX_F0EFED345682207C` (`stud_pclass_id`),
  ADD KEY `IDX_F0EFED34CAE21197` (`atribute_id`);

--
-- Indices de la tabla `stud_pclass_operation`
--
ALTER TABLE `stud_pclass_operation`
  ADD PRIMARY KEY (`stud_pclass_id`,`operation_id`),
  ADD KEY `IDX_CFA1F8E65682207C` (`stud_pclass_id`),
  ADD KEY `IDX_CFA1F8E644AC3583` (`operation_id`);

--
-- Indices de la tabla `success_code`
--
ALTER TABLE `success_code`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_DC65C550591CC992` (`course_id`),
  ADD KEY `IDX_DC65C55050F1A803` (`nactivity_id`);

--
-- Indices de la tabla `success_code_codeline`
--
ALTER TABLE `success_code_codeline`
  ADD PRIMARY KEY (`success_code_id`,`codeline_id`),
  ADD KEY `IDX_A6F968F581A85D80` (`success_code_id`),
  ADD KEY `IDX_A6F968F5CBCECA63` (`codeline_id`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `atribute`
--
ALTER TABLE `atribute`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `codeline`
--
ALTER TABLE `codeline`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `course`
--
ALTER TABLE `course`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `datatype`
--
ALTER TABLE `datatype`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `eval_code`
--
ALTER TABLE `eval_code`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `model_diagram_success`
--
ALTER TABLE `model_diagram_success`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `model_diagram_test`
--
ALTER TABLE `model_diagram_test`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `nactivity`
--
ALTER TABLE `nactivity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `nta`
--
ALTER TABLE `nta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `operation`
--
ALTER TABLE `operation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `pclass`
--
ALTER TABLE `pclass`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `stud_pclass`
--
ALTER TABLE `stud_pclass`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `success_code`
--
ALTER TABLE `success_code`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `atribute`
--
ALTER TABLE `atribute`
  ADD CONSTRAINT `FK_6128E945C815A09` FOREIGN KEY (`datatype_id`) REFERENCES `datatype` (`id`);

--
-- Filtros para la tabla `course_user`
--
ALTER TABLE `course_user`
  ADD CONSTRAINT `FK_45310B4F591CC992` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_45310B4FA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `eval_code`
--
ALTER TABLE `eval_code`
  ADD CONSTRAINT `FK_242777BC50F1A803` FOREIGN KEY (`nactivity_id`) REFERENCES `nactivity` (`id`),
  ADD CONSTRAINT `FK_242777BC591CC992` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`);

--
-- Filtros para la tabla `eval_code_codeline`
--
ALTER TABLE `eval_code_codeline`
  ADD CONSTRAINT `FK_C47D34F46F71983A` FOREIGN KEY (`eval_code_id`) REFERENCES `eval_code` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_C47D34F4CBCECA63` FOREIGN KEY (`codeline_id`) REFERENCES `codeline` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `model_diagram_success`
--
ALTER TABLE `model_diagram_success`
  ADD CONSTRAINT `FK_D6B7D83950F1A803` FOREIGN KEY (`nactivity_id`) REFERENCES `nactivity` (`id`),
  ADD CONSTRAINT `FK_D6B7D839591CC992` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`);

--
-- Filtros para la tabla `model_diagram_test`
--
ALTER TABLE `model_diagram_test`
  ADD CONSTRAINT `FK_E04B22DE50F1A803` FOREIGN KEY (`nactivity_id`) REFERENCES `nactivity` (`id`),
  ADD CONSTRAINT `FK_E04B22DE591CC992` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`);

--
-- Filtros para la tabla `nactivity`
--
ALTER TABLE `nactivity`
  ADD CONSTRAINT `FK_BBFE98AB95F405C2` FOREIGN KEY (`nta_id`) REFERENCES `nta` (`id`);

--
-- Filtros para la tabla `operation`
--
ALTER TABLE `operation`
  ADD CONSTRAINT `FK_1981A66D5C815A09` FOREIGN KEY (`datatype_id`) REFERENCES `datatype` (`id`);

--
-- Filtros para la tabla `pclass`
--
ALTER TABLE `pclass`
  ADD CONSTRAINT `FK_918942E050F1A803` FOREIGN KEY (`nactivity_id`) REFERENCES `nactivity` (`id`),
  ADD CONSTRAINT `FK_918942E0591CC992` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`);

--
-- Filtros para la tabla `pclass_atribute`
--
ALTER TABLE `pclass_atribute`
  ADD CONSTRAINT `FK_B2E8E54899880302` FOREIGN KEY (`pclass_id`) REFERENCES `pclass` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_B2E8E548CAE21197` FOREIGN KEY (`atribute_id`) REFERENCES `atribute` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `pclass_operation`
--
ALTER TABLE `pclass_operation`
  ADD CONSTRAINT `FK_9650C2F944AC3583` FOREIGN KEY (`operation_id`) REFERENCES `operation` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_9650C2F999880302` FOREIGN KEY (`pclass_id`) REFERENCES `pclass` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `stud_pclass`
--
ALTER TABLE `stud_pclass`
  ADD CONSTRAINT `FK_E8A6F23A50F1A803` FOREIGN KEY (`nactivity_id`) REFERENCES `nactivity` (`id`),
  ADD CONSTRAINT `FK_E8A6F23A591CC992` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`);

--
-- Filtros para la tabla `stud_pclass_atribute`
--
ALTER TABLE `stud_pclass_atribute`
  ADD CONSTRAINT `FK_F0EFED345682207C` FOREIGN KEY (`stud_pclass_id`) REFERENCES `stud_pclass` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_F0EFED34CAE21197` FOREIGN KEY (`atribute_id`) REFERENCES `atribute` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `stud_pclass_operation`
--
ALTER TABLE `stud_pclass_operation`
  ADD CONSTRAINT `FK_CFA1F8E644AC3583` FOREIGN KEY (`operation_id`) REFERENCES `operation` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_CFA1F8E65682207C` FOREIGN KEY (`stud_pclass_id`) REFERENCES `stud_pclass` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `success_code`
--
ALTER TABLE `success_code`
  ADD CONSTRAINT `FK_DC65C55050F1A803` FOREIGN KEY (`nactivity_id`) REFERENCES `nactivity` (`id`),
  ADD CONSTRAINT `FK_DC65C550591CC992` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`);

--
-- Filtros para la tabla `success_code_codeline`
--
ALTER TABLE `success_code_codeline`
  ADD CONSTRAINT `FK_A6F968F581A85D80` FOREIGN KEY (`success_code_id`) REFERENCES `success_code` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_A6F968F5CBCECA63` FOREIGN KEY (`codeline_id`) REFERENCES `codeline` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
