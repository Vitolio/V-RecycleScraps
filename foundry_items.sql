-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 45.140.165.82
-- Généré le : dim. 10 déc. 2023 à 18:29
-- Version du serveur : 10.11.3-MariaDB-1
-- Version de PHP : 7.3.29-1~deb10u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `s3504_cityv_70`
--

-- --------------------------------------------------------

--
-- Structure de la table `foundry_items`
--

CREATE TABLE `foundry_items` (
  `ID` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `stock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `foundry_items`
--

INSERT INTO `foundry_items` (`ID`, `name`, `stock`) VALUES
(1, 'glass', 0),
(2, 'rubber', 0),
(3, 'plastic', 0),
(4, 'iron', 0),
(5, 'aluminum', 0),
(6, 'aluminumoxide', 0),
(7, 'copper', 0),
(8, 'metalscrap', 0),
(9, 'ironoxide', 0),
(10, 'steel', 0);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `foundry_items`
--
ALTER TABLE `foundry_items`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `foundry_items`
--
ALTER TABLE `foundry_items`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
