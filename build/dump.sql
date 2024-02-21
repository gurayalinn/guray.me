SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;

START TRANSACTION;
SET time_zone = "+00:00";
USE `db`;

-- --------------------------------------------------------

--
-- Database: `db`
--

-- --------------------------------------------------------
-- TABLES
-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
`uid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'User ID',
`username` varchar(20)  COLLATE  utf8mb4_unicode_ci NOT NULL COMMENT 'User Name',
`password` varchar(255) NOT NULL COMMENT 'User Password Hash',
`email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'User Email',
`createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'User at Created',
`updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'User at Updated',
`admin` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'User: 0, Admin: 1',
PRIMARY KEY (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`admin`,`username`, `password`, `email`, `createdAt`) VALUES
(1, 'admin', '$2y$10$7wOzYc.AXpXc1nE/b0IqLOsP2w1cK9LZXDUi6hoSyuWBDj3DoBjOK', 'info@guray.me', '2024-01-01 00:00:00');

COMMIT;

-- hash: $2y$10$7wOzYc.AXpXc1nE/b0IqLOsP2w1cK9LZXDUi6hoSyuWBDj3DoBjOK : admin

