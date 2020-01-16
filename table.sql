-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 16, 2020 at 04:59 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `teretana`
--

-- --------------------------------------------------------

--
-- Table structure for table `clanarina`
--

CREATE TABLE `clanarina` (
  `clanarina_id` int(11) NOT NULL,
  `id_korisnika` int(11) DEFAULT NULL,
  `uclanjen_do` date DEFAULT NULL,
  `broj_dolazaka` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `clanarina`
--

INSERT INTO `clanarina` (`clanarina_id`, `id_korisnika`, `uclanjen_do`, `broj_dolazaka`) VALUES
(1, 1, '2020-02-15', 11),
(2, 2, '2020-02-14', 8),
(3, 3, '2020-02-15', 11),
(4, 12, '2020-02-15', 12),
(31, 9, '2020-02-15', 11);

-- --------------------------------------------------------

--
-- Table structure for table `evidencija`
--

CREATE TABLE `evidencija` (
  `evidencija_id` int(11) NOT NULL,
  `visina` float DEFAULT NULL,
  `tezina` float DEFAULT NULL,
  `datum_mjerenja` date NOT NULL,
  `id_korisnika` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `evidencija`
--

INSERT INTO `evidencija` (`evidencija_id`, `visina`, `tezina`, `datum_mjerenja`, `id_korisnika`) VALUES
(1, 165, 56, '2019-04-14', 1),
(2, 170, 47, '2013-04-19', 5),
(3, 165, 47, '2013-01-08', 3),
(4, 166, 60, '2019-05-14', 1),
(5, 165, 62, '2019-07-14', 1),
(6, 147, 56, '2020-01-14', 2);

--
-- Triggers `evidencija`
--
DELIMITER $$
CREATE TRIGGER `datum_check_insert` BEFORE INSERT ON `evidencija` FOR EACH ROW BEGIN
    SET @found = NULL;

    SELECT
        korisnik_id INTO @found
    FROM
        korisnik
    WHERE
            korisnik_id = NEW.id_korisnika
        AND NEW.datum_mjerenja BETWEEN datum_uclanivanja AND CURDATE();

    IF @found IS NULL THEN
        SET @msg = CONCAT('Nije moguće umetnuti, korisnik dana ', NEW.datum_mjerenja,' nije bio učlanjen');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
    END IF;
    END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `datum_check_update` BEFORE UPDATE ON `evidencija` FOR EACH ROW BEGIN
    SET @found = NULL;

    SELECT
        korisnik_id INTO @found
    FROM
        korisnik
    WHERE
            korisnik_id = NEW.id_korisnika
        AND NEW.datum_mjerenja BETWEEN datum_uclanivanja AND CURDATE();

    IF @found IS NULL THEN
        SET @msg = CONCAT('Nije moguće umetnuti, korisnik dana ', NEW.datum_mjerenja,' nije bio učlanjen');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
    END IF;
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `korisnik`
--

CREATE TABLE `korisnik` (
  `korisnik_id` int(11) NOT NULL,
  `ime` varchar(20) NOT NULL,
  `prezime` varchar(20) NOT NULL,
  `dob` int(11) DEFAULT NULL,
  `datum_uclanivanja` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `korisnik`
--

INSERT INTO `korisnik` (`korisnik_id`, `ime`, `prezime`, `dob`, `datum_uclanivanja`) VALUES
(1, 'Kata', 'Janković', 27, '2018-04-27'),
(2, 'Mato', 'Jerković', 24, '2015-07-22'),
(3, 'Bojana', 'Mikulić', 27, '2017-09-19'),
(4, 'Stanko', 'Brajković', 18, '2018-01-30'),
(5, 'Anja', 'Antunović', 28, '2018-05-31'),
(6, 'Silvija', 'Novak', 41, '2013-05-02'),
(7, 'Anđeklo', 'Đurić', 18, '2013-12-06'),
(8, 'Dario', 'Kos', 35, '2015-03-05'),
(9, 'Marko', 'Kalamarko', 52, '2020-01-13'),
(11, 'Anđelka', 'Kolar', 24, '2020-01-13'),
(12, 'Andreas', 'Malina', 29, '2019-01-14');

-- --------------------------------------------------------

--
-- Table structure for table `pomocno_osoblje`
--

CREATE TABLE `pomocno_osoblje` (
  `radnik_id` int(11) NOT NULL,
  `ime` varchar(20) NOT NULL,
  `prezime` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pomocno_osoblje`
--

INSERT INTO `pomocno_osoblje` (`radnik_id`, `ime`, `prezime`) VALUES
(1, 'Đurđa', 'Stojanović'),
(2, 'Ivan', 'Lovrić'),
(3, 'Darijo', 'Janković'),
(4, 'Živko ', 'Katić'),
(5, 'Jurica ', 'Kovač'),
(6, 'Zdenko ', 'Ivanković');

-- --------------------------------------------------------

--
-- Table structure for table `radi`
--

CREATE TABLE `radi` (
  `id_teretane` int(11) NOT NULL,
  `id_radnika` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `radi`
--

INSERT INTO `radi` (`id_teretane`, `id_radnika`) VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 5);

-- --------------------------------------------------------

--
-- Table structure for table `radnik_u_smjeni`
--

CREATE TABLE `radnik_u_smjeni` (
  `id_radnika` int(11) NOT NULL,
  `id_smjene` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `radnik_u_smjeni`
--

INSERT INTO `radnik_u_smjeni` (`id_radnika`, `id_smjene`) VALUES
(1, 1),
(1, 5),
(2, 2),
(4, 4),
(5, 6),
(6, 8);

-- --------------------------------------------------------

--
-- Table structure for table `smjena`
--

CREATE TABLE `smjena` (
  `smjena_id` int(11) NOT NULL,
  `od` time NOT NULL,
  `do` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `smjena`
--

INSERT INTO `smjena` (`smjena_id`, `od`, `do`) VALUES
(1, '08:00:00', '14:00:00'),
(2, '14:00:00', '22:00:00'),
(3, '08:00:00', '14:00:00'),
(4, '14:00:00', '22:00:00'),
(5, '08:00:00', '14:00:00'),
(6, '14:00:00', '22:00:00'),
(7, '08:00:00', '14:00:00'),
(8, '14:00:00', '22:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `teretana`
--

CREATE TABLE `teretana` (
  `teretana_id` int(11) NOT NULL,
  `adresa` varchar(40) NOT NULL,
  `datum_otvaranja` date NOT NULL,
  `id_vlasnika` int(11) DEFAULT NULL,
  `naziv` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `teretana`
--

INSERT INTO `teretana` (`teretana_id`, `adresa`, `datum_otvaranja`, `id_vlasnika`, `naziv`) VALUES
(1, 'Zagrebačka ul. 47, 42000', '2013-06-11', 1, '5 Star'),
(2, 'Ul. Mihovila Pavleka Miškine 53, 42000', '2014-10-15', 2, 'Gibi Gib');

-- --------------------------------------------------------

--
-- Table structure for table `termin`
--

CREATE TABLE `termin` (
  `id_termina` int(11) NOT NULL,
  `id_teretane` int(11) NOT NULL,
  `id_korisnika` int(11) NOT NULL,
  `id_trenera` int(11) NOT NULL,
  `vrijeme` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `vrsta_termina` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `termin`
--

INSERT INTO `termin` (`id_termina`, `id_teretane`, `id_korisnika`, `id_trenera`, `vrijeme`, `vrsta_termina`) VALUES
(0, 1, 1, 1, '2020-01-11 10:32:00', 'Trbuh'),
(0, 1, 5, 2, '2020-01-16 18:00:00', 'Leđa'),
(0, 2, 4, 2, '2020-01-21 13:30:00', 'Prsa'),
(0, 2, 7, 2, '2020-01-22 11:15:00', 'Ramena'),
(0, 2, 8, 4, '2020-01-19 10:30:00', 'Trbuh'),
(1, 1, 1, 1, '2020-01-15 18:00:00', 'Vježbanje ramena'),
(2, 1, 2, 2, '2020-01-16 17:00:00', 'Donji dio tijela'),
(3, 2, 6, 4, '2020-01-17 14:00:00', 'Push');

-- --------------------------------------------------------

--
-- Table structure for table `trener`
--

CREATE TABLE `trener` (
  `trener_id` int(11) NOT NULL,
  `ime` varchar(20) NOT NULL,
  `prezime` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `trener`
--

INSERT INTO `trener` (`trener_id`, `ime`, `prezime`) VALUES
(1, 'Krešimir ', 'Grgić'),
(2, 'Zdenko ', 'Kuprešak'),
(3, 'Dajana ', 'Lučić'),
(4, 'Biljana ', 'Barić');

-- --------------------------------------------------------

--
-- Table structure for table `trener_u_smjeni`
--

CREATE TABLE `trener_u_smjeni` (
  `id_trenera` int(11) NOT NULL,
  `id_smjene` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `trener_u_smjeni`
--

INSERT INTO `trener_u_smjeni` (`id_trenera`, `id_smjene`) VALUES
(1, 1),
(1, 6),
(2, 2),
(2, 5),
(3, 3),
(3, 8),
(4, 4),
(4, 7);

-- --------------------------------------------------------

--
-- Table structure for table `vlasnik`
--

CREATE TABLE `vlasnik` (
  `vlasnik_id` int(11) NOT NULL,
  `ime` varchar(20) NOT NULL,
  `prezime` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `vlasnik`
--

INSERT INTO `vlasnik` (`vlasnik_id`, `ime`, `prezime`) VALUES
(1, 'Marko', 'Kruljac'),
(2, 'Zora', 'Vuković'),
(3, 'Dunja', 'Jurišić');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `clanarina`
--
ALTER TABLE `clanarina`
  ADD PRIMARY KEY (`clanarina_id`),
  ADD UNIQUE KEY `id_korisnika_2` (`id_korisnika`),
  ADD KEY `id_korisnika` (`id_korisnika`);

--
-- Indexes for table `evidencija`
--
ALTER TABLE `evidencija`
  ADD PRIMARY KEY (`evidencija_id`),
  ADD KEY `id_korisnika` (`id_korisnika`);

--
-- Indexes for table `korisnik`
--
ALTER TABLE `korisnik`
  ADD PRIMARY KEY (`korisnik_id`);

--
-- Indexes for table `pomocno_osoblje`
--
ALTER TABLE `pomocno_osoblje`
  ADD PRIMARY KEY (`radnik_id`);

--
-- Indexes for table `radi`
--
ALTER TABLE `radi`
  ADD PRIMARY KEY (`id_teretane`,`id_radnika`),
  ADD KEY `id_radnika` (`id_radnika`);

--
-- Indexes for table `radnik_u_smjeni`
--
ALTER TABLE `radnik_u_smjeni`
  ADD PRIMARY KEY (`id_radnika`,`id_smjene`),
  ADD KEY `id_smjene` (`id_smjene`);

--
-- Indexes for table `smjena`
--
ALTER TABLE `smjena`
  ADD PRIMARY KEY (`smjena_id`);

--
-- Indexes for table `teretana`
--
ALTER TABLE `teretana`
  ADD PRIMARY KEY (`teretana_id`),
  ADD KEY `id_vlasnika` (`id_vlasnika`);

--
-- Indexes for table `termin`
--
ALTER TABLE `termin`
  ADD PRIMARY KEY (`id_termina`,`id_teretane`,`id_korisnika`,`id_trenera`,`vrijeme`),
  ADD KEY `id_trenera` (`id_trenera`),
  ADD KEY `id_korisnika` (`id_korisnika`),
  ADD KEY `id_teretane` (`id_teretane`);

--
-- Indexes for table `trener`
--
ALTER TABLE `trener`
  ADD PRIMARY KEY (`trener_id`);

--
-- Indexes for table `trener_u_smjeni`
--
ALTER TABLE `trener_u_smjeni`
  ADD PRIMARY KEY (`id_trenera`,`id_smjene`),
  ADD KEY `id_smjene` (`id_smjene`);

--
-- Indexes for table `vlasnik`
--
ALTER TABLE `vlasnik`
  ADD PRIMARY KEY (`vlasnik_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `clanarina`
--
ALTER TABLE `clanarina`
  MODIFY `clanarina_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `evidencija`
--
ALTER TABLE `evidencija`
  MODIFY `evidencija_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `korisnik`
--
ALTER TABLE `korisnik`
  MODIFY `korisnik_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `pomocno_osoblje`
--
ALTER TABLE `pomocno_osoblje`
  MODIFY `radnik_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `smjena`
--
ALTER TABLE `smjena`
  MODIFY `smjena_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `teretana`
--
ALTER TABLE `teretana`
  MODIFY `teretana_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `trener`
--
ALTER TABLE `trener`
  MODIFY `trener_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `vlasnik`
--
ALTER TABLE `vlasnik`
  MODIFY `vlasnik_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `clanarina`
--
ALTER TABLE `clanarina`
  ADD CONSTRAINT `clanarina_ibfk_1` FOREIGN KEY (`id_korisnika`) REFERENCES `korisnik` (`korisnik_id`) ON DELETE CASCADE;

--
-- Constraints for table `evidencija`
--
ALTER TABLE `evidencija`
  ADD CONSTRAINT `evidencija_ibfk_1` FOREIGN KEY (`id_korisnika`) REFERENCES `korisnik` (`korisnik_id`);

--
-- Constraints for table `radi`
--
ALTER TABLE `radi`
  ADD CONSTRAINT `radi_ibfk_1` FOREIGN KEY (`id_teretane`) REFERENCES `teretana` (`teretana_id`),
  ADD CONSTRAINT `radi_ibfk_2` FOREIGN KEY (`id_radnika`) REFERENCES `pomocno_osoblje` (`radnik_id`);

--
-- Constraints for table `radnik_u_smjeni`
--
ALTER TABLE `radnik_u_smjeni`
  ADD CONSTRAINT `radnik_u_smjeni_ibfk_1` FOREIGN KEY (`id_radnika`) REFERENCES `pomocno_osoblje` (`radnik_id`),
  ADD CONSTRAINT `radnik_u_smjeni_ibfk_2` FOREIGN KEY (`id_smjene`) REFERENCES `smjena` (`smjena_id`);

--
-- Constraints for table `teretana`
--
ALTER TABLE `teretana`
  ADD CONSTRAINT `teretana_ibfk_1` FOREIGN KEY (`id_vlasnika`) REFERENCES `vlasnik` (`vlasnik_id`) ON DELETE CASCADE;

--
-- Constraints for table `termin`
--
ALTER TABLE `termin`
  ADD CONSTRAINT `termin_ibfk_1` FOREIGN KEY (`id_trenera`) REFERENCES `trener` (`trener_id`),
  ADD CONSTRAINT `termin_ibfk_2` FOREIGN KEY (`id_korisnika`) REFERENCES `korisnik` (`korisnik_id`),
  ADD CONSTRAINT `termin_ibfk_3` FOREIGN KEY (`id_teretane`) REFERENCES `teretana` (`teretana_id`);

--
-- Constraints for table `trener_u_smjeni`
--
ALTER TABLE `trener_u_smjeni`
  ADD CONSTRAINT `trener_u_smjeni_ibfk_1` FOREIGN KEY (`id_trenera`) REFERENCES `trener` (`trener_id`),
  ADD CONSTRAINT `trener_u_smjeni_ibfk_2` FOREIGN KEY (`id_smjene`) REFERENCES `smjena` (`smjena_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
