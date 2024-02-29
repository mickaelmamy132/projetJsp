-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 29 fév. 2024 à 12:44
-- Version du serveur :  10.4.17-MariaDB
-- Version de PHP : 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `gestionenseignant`
--

-- --------------------------------------------------------

--
-- Structure de la table `ensegnant`
--

CREATE TABLE `ensegnant` (
  `matricule` int(255) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `taux` float NOT NULL,
  `heure` int(255) NOT NULL,
  `prestation` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ensegnant`
--

INSERT INTO `ensegnant` (`matricule`, `nom`, `taux`, `heure`, `prestation`) VALUES
(25, 'marchelin', 50, 45, 2250),
(27, 'jimmy ', 78, 5, 390),
(30, 'Pots', 20, 12, 240);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `ensegnant`
--
ALTER TABLE `ensegnant`
  ADD PRIMARY KEY (`matricule`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `ensegnant`
--
ALTER TABLE `ensegnant`
  MODIFY `matricule` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
