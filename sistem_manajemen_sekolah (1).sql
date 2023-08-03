-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 03, 2023 at 10:16 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sistem_manajemen_sekolah`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateNilaiSiswa` (IN `p_ID_Siswa` VARCHAR(20), IN `p_ID_Guru_Mata_Pelajaran` VARCHAR(20), IN `p_Nilai_Akhir` FLOAT)   BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_ID_Nilai FLOAT;
    
    DECLARE cur CURSOR FOR
        SELECT ID_Nilai
        FROM nilai
        WHERE ID_Siswa = p_ID_Siswa
        AND ID_Guru_Mata_Pelajaran = p_ID_Guru_Mata_Pelajaran;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_ID_Nilai;
        IF done THEN
            LEAVE read_loop;
        END IF;

       
        UPDATE nilai
        SET Nilai_Akhir = p_Nilai_Akhir
        WHERE ID_Siswa = p_ID_Siswa AND ID_Guru_Mata_Pelajaran = p_ID_Guru_Mata_Pelajaran;
    END LOOP;

    CLOSE cur;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `GetSiswa` (`idSiswa` VARCHAR(11)) RETURNS INT(11)  BEGIN
    DECLARE result INT;

    SELECT COUNT(*)
    INTO result
    FROM nilai
    WHERE ID_Siswa = idSiswa;

    RETURN result;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `NilaiRata` (`ID_Siswa` VARCHAR(20)) RETURNS FLOAT  BEGIN
    DECLARE avgScore FLOAT;
    SELECT AVG(Nilai_Akhir) INTO avgScore FROM Nilai WHERE ID_Siswa = ID_Siswa;
    RETURN avgScore;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `guru`
--

CREATE TABLE `guru` (
  `ID_Guru` varchar(20) NOT NULL,
  `Nama_Guru` varchar(50) DEFAULT NULL,
  `Tanggal_Lahir` date DEFAULT NULL,
  `Alamat` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `guru`
--

INSERT INTO `guru` (`ID_Guru`, `Nama_Guru`, `Tanggal_Lahir`, `Alamat`) VALUES
('G001', 'Ningsi', '1980-03-10', 'Jl. Kapuas'),
('G002', 'Sahrul', '1975-08-20', 'Jl. Kilongan'),
('G003', 'Dian', '1990-01-05', 'Jl. Barbarsari');

-- --------------------------------------------------------

--
-- Table structure for table `guru_mata_pelajaran`
--

CREATE TABLE `guru_mata_pelajaran` (
  `ID_Guru_Mata_Pelajaran` varchar(20) NOT NULL,
  `Nama_Guru_Mata_Pelajaran` varchar(50) DEFAULT NULL,
  `Deskripsi_Mata_Pelajaran` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `guru_mata_pelajaran`
--

INSERT INTO `guru_mata_pelajaran` (`ID_Guru_Mata_Pelajaran`, `Nama_Guru_Mata_Pelajaran`, `Deskripsi_Mata_Pelajaran`) VALUES
('GMP001', 'Juang Sambeta - Matik', 'Matematika'),
('GMP002', 'Nicolas atas - English', 'Bahasa Inggris'),
('GMP003', 'Ahas Kutaha - IPA', 'Ilmu Pengetahuan Sosial');

-- --------------------------------------------------------

--
-- Table structure for table `kelas`
--

CREATE TABLE `kelas` (
  `ID_Kelas` varchar(20) NOT NULL,
  `Nama_Kelas` varchar(10) DEFAULT NULL,
  `Wali_Kelas` varchar(20) DEFAULT NULL,
  `ID_Siswa` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kelas`
--

INSERT INTO `kelas` (`ID_Kelas`, `Nama_Kelas`, `Wali_Kelas`, `ID_Siswa`) VALUES
('K001', 'Kelas A', 'G001', 'S001'),
('K002', 'Kelas A', 'G001', 'S002'),
('K003', 'Kelas A', 'G001', 'S003'),
('K004', 'Kelas A', 'G001', 'S004'),
('K005', 'Kelas A', 'G001', 'S005'),
('K006', 'Kelas B', 'G002', 'S006'),
('K007', 'Kelas B', 'G002', 'S007'),
('K008', 'Kelas B', 'G002', 'S008'),
('K009', 'Kelas B', 'G002', 'S009'),
('K010', 'Kelas B', 'G002', 'S010'),
('K011', 'Kelas C', 'G003', 'S011'),
('K012', 'Kelas C', 'G003', 'S012'),
('K013', 'Kelas C', 'G003', 'S013'),
('K014', 'Kelas C', 'G003', 'S014'),
('K015', 'Kelas C', 'G003', 'S015');

-- --------------------------------------------------------

--
-- Table structure for table `nilai`
--

CREATE TABLE `nilai` (
  `ID_Nilai` varchar(20) NOT NULL,
  `ID_Siswa` varchar(20) DEFAULT NULL,
  `ID_Guru_Mata_Pelajaran` varchar(20) DEFAULT NULL,
  `Nilai_Akhir` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nilai`
--

INSERT INTO `nilai` (`ID_Nilai`, `ID_Siswa`, `ID_Guru_Mata_Pelajaran`, `Nilai_Akhir`) VALUES
('N001', 'S001', 'GMP001', 99),
('N002', 'S002', 'GMP001', 78),
('N003', 'S003', 'GMP001', 79.5),
('N004', 'S004', 'GMP001', 89.2),
('N005', 'S005', 'GMP001', 85.2),
('N006', 'S006', 'GMP001', 82.2),
('N007', 'S007', 'GMP001', 90.2),
('N008', 'S008', 'GMP001', 97.2),
('N009', 'S009', 'GMP001', 89.2),
('N010', 'S010', 'GMP001', 76.2),
('N011', 'S011', 'GMP001', 88.2),
('N012', 'S012', 'GMP001', 98.2),
('N013', 'S013', 'GMP001', 76.2),
('N014', 'S014', 'GMP001', 89.2),
('N015', 'S015', 'GMP001', 69.2),
('N016', 'S001', 'GMP002', 89.5),
('N017', 'S002', 'GMP002', 69),
('N018', 'S003', 'GMP002', 98.5),
('N019', 'S004', 'GMP002', 97.2),
('N020', 'S005', 'GMP002', 79.2),
('N021', 'S006', 'GMP002', 88.2),
('N022', 'S007', 'GMP002', 87.2),
('N023', 'S008', 'GMP002', 86.2),
('N024', 'S009', 'GMP002', 97.2),
('N025', 'S010', 'GMP002', 96.2),
('N026', 'S011', 'GMP002', 96.2),
('N027', 'S012', 'GMP002', 84.2),
('N028', 'S013', 'GMP002', 83.2),
('N029', 'S014', 'GMP002', 83.2),
('N030', 'S015', 'GMP002', 86.2),
('N031', 'S001', 'GMP003', 81.5),
('N032', 'S002', 'GMP003', 75),
('N033', 'S003', 'GMP003', 98.5),
('N034', 'S004', 'GMP003', 89.2),
('N035', 'S005', 'GMP003', 68.2),
('N036', 'S006', 'GMP003', 89.2),
('N037', 'S007', 'GMP003', 97.2),
('N038', 'S008', 'GMP003', 96.2),
('N039', 'S009', 'GMP003', 86.2),
('N040', 'S010', 'GMP003', 85.2),
('N041', 'S011', 'GMP003', 84.2),
('N042', 'S012', 'GMP003', 83.2),
('N043', 'S013', 'GMP003', 82.2),
('N044', 'S014', 'GMP003', 85.2),
('N045', 'S015', 'GMP003', 87.2);

-- --------------------------------------------------------

--
-- Table structure for table `nilai_baru`
--

CREATE TABLE `nilai_baru` (
  `ID_Siswa` varchar(20) NOT NULL,
  `ID_Guru_Mata_Pelajaran` varchar(20) NOT NULL,
  `Nilai_Akhir` float NOT NULL,
  `average_score` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `nilai_baru`
--
DELIMITER $$
CREATE TRIGGER `UpdateAverageScore` AFTER INSERT ON `nilai_baru` FOR EACH ROW BEGIN
    DECLARE totalScore DECIMAL(10, 2);
    DECLARE totalSubjects INT;
    DECLARE avgScore DECIMAL(5, 2);

    -- Menghitung total nilai dan jumlah mata pelajaran untuk siswa dan mata pelajaran tertentu
    SELECT SUM(Nilai_Akhir), COUNT(*) INTO totalScore, totalSubjects
    FROM nilai_baru
    WHERE ID_Siswa = NEW.ID_Siswa
    AND ID_Guru_Mata_Pelajaran = NEW.ID_Guru_Mata_Pelajaran;

    IF totalSubjects > 0 THEN
        SET avgScore = totalScore / totalSubjects;

        -- Memeriksa apakah kombinasi siswa dan mata pelajaran sudah ada di tabel average_score
        IF (SELECT COUNT(*) FROM average_score
            WHERE ID_Siswa = NEW.ID_Siswa
            AND ID_Guru_Mata_Pelajaran = NEW.ID_Guru_Mata_Pelajaran) > 0 THEN
            -- Jika sudah ada, perbarui nilai rata-rata
            UPDATE average_score
            SET Average_Score = avgScore
            WHERE ID_Siswa = NEW.ID_Siswa
            AND ID_Guru_Mata_Pelajaran = NEW.ID_Guru_Mata_Pelajaran;
        ELSE
            -- Jika belum ada, masukkan data baru dengan nilai rata-rata
            INSERT INTO average_score (ID_Siswa, ID_Guru_Mata_Pelajaran, Average_Score)
            VALUES (NEW.ID_Siswa, NEW.ID_Guru_Mata_Pelajaran, avgScore);
        END IF;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `siswa`
--

CREATE TABLE `siswa` (
  `ID_Siswa` varchar(20) NOT NULL,
  `Nama_Siswa` varchar(50) DEFAULT NULL,
  `Tanggal_Lahir` date DEFAULT NULL,
  `Alamat` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `siswa`
--

INSERT INTO `siswa` (`ID_Siswa`, `Nama_Siswa`, `Tanggal_Lahir`, `Alamat`) VALUES
('S001', 'Aric Yohanes', '2005-05-15', 'Jl. Merdeka '),
('S002', 'Fadhlur Rahman', '2004-09-22', 'Jl. Jendral Sudirman '),
('S003', 'Kadek Aditiya Prayogi', '2006-02-10', 'Jl. Gatot Subroto '),
('S004', 'Agung Prayogi', '2006-04-11', 'Jl.Tajem '),
('S005', 'Deni Masulili', '2006-07-16', 'Jl. Godean'),
('S006', 'Sony Cina Pelit', '2006-11-09', 'Jl. Maguo'),
('S007', 'Yoga Prayoga', '2005-04-29', 'Jl. Pulau Seribu'),
('S008', 'Yahya Agung', '2005-02-08', 'Jl. Pulau Duaribu'),
('S009', 'Icho Makel', '2004-02-15', 'Jl. Pesisir Pantai'),
('S010', 'Zilong exp', '2005-05-14', 'Jl. Samping Jurang'),
('S011', 'Fauzan Ijat', '2006-10-05', 'Jl. Pantai Tsunami'),
('S012', 'Zull Bantul', '2004-10-05', 'Jl. Bantul'),
('S013', 'Kadek Doddy ', '2005-06-05', 'Jl. Congcat'),
('S014', 'Kemi Sugus', '2006-04-14', 'Jl. Klaten'),
('S015', 'Pajar Jeruk', '2004-02-11', 'Jl. Wonosobo');

-- --------------------------------------------------------

--
-- Table structure for table `siswa_mata_pelajaran`
--

CREATE TABLE `siswa_mata_pelajaran` (
  `ID_Siswa` varchar(20) NOT NULL,
  `ID_Guru_Mata_Pelajaran` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `siswa_mata_pelajaran`
--

INSERT INTO `siswa_mata_pelajaran` (`ID_Siswa`, `ID_Guru_Mata_Pelajaran`) VALUES
('S001', 'GMP001'),
('S001', 'GMP002'),
('S001', 'GMP003'),
('S002', 'GMP001'),
('S002', 'GMP002'),
('S002', 'GMP003'),
('S003', 'GMP001'),
('S003', 'GMP002'),
('S003', 'GMP003'),
('S004', 'GMP001'),
('S004', 'GMP002'),
('S004', 'GMP003'),
('S005', 'GMP001'),
('S005', 'GMP002'),
('S005', 'GMP003'),
('S006', 'GMP001'),
('S006', 'GMP002'),
('S006', 'GMP003'),
('S007', 'GMP001'),
('S007', 'GMP002'),
('S007', 'GMP003'),
('S008', 'GMP001'),
('S008', 'GMP002'),
('S008', 'GMP003'),
('S009', 'GMP001'),
('S009', 'GMP002'),
('S009', 'GMP003'),
('S010', 'GMP001'),
('S010', 'GMP002'),
('S010', 'GMP003'),
('S011', 'GMP001'),
('S011', 'GMP002'),
('S011', 'GMP003'),
('S012', 'GMP001'),
('S012', 'GMP002'),
('S012', 'GMP003'),
('S013', 'GMP001'),
('S013', 'GMP002'),
('S013', 'GMP003'),
('S014', 'GMP001'),
('S014', 'GMP002'),
('S014', 'GMP003'),
('S015', 'GMP001'),
('S015', 'GMP002'),
('S015', 'GMP003');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `guru`
--
ALTER TABLE `guru`
  ADD PRIMARY KEY (`ID_Guru`);

--
-- Indexes for table `guru_mata_pelajaran`
--
ALTER TABLE `guru_mata_pelajaran`
  ADD PRIMARY KEY (`ID_Guru_Mata_Pelajaran`);

--
-- Indexes for table `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`ID_Kelas`),
  ADD KEY `ID_Siswa` (`ID_Siswa`),
  ADD KEY `Wali_Kelas` (`Wali_Kelas`);

--
-- Indexes for table `nilai`
--
ALTER TABLE `nilai`
  ADD PRIMARY KEY (`ID_Nilai`),
  ADD KEY `ID_Siswa` (`ID_Siswa`),
  ADD KEY `ID_Guru_Mata_Pelajaran` (`ID_Guru_Mata_Pelajaran`);

--
-- Indexes for table `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`ID_Siswa`);

--
-- Indexes for table `siswa_mata_pelajaran`
--
ALTER TABLE `siswa_mata_pelajaran`
  ADD PRIMARY KEY (`ID_Siswa`,`ID_Guru_Mata_Pelajaran`),
  ADD KEY `ID_Guru_Mata_Pelajaran` (`ID_Guru_Mata_Pelajaran`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `kelas`
--
ALTER TABLE `kelas`
  ADD CONSTRAINT `kelas_ibfk_1` FOREIGN KEY (`ID_Siswa`) REFERENCES `siswa` (`ID_Siswa`),
  ADD CONSTRAINT `kelas_ibfk_2` FOREIGN KEY (`Wali_Kelas`) REFERENCES `guru` (`ID_Guru`);

--
-- Constraints for table `nilai`
--
ALTER TABLE `nilai`
  ADD CONSTRAINT `nilai_ibfk_1` FOREIGN KEY (`ID_Siswa`) REFERENCES `siswa` (`ID_Siswa`),
  ADD CONSTRAINT `nilai_ibfk_2` FOREIGN KEY (`ID_Guru_Mata_Pelajaran`) REFERENCES `guru_mata_pelajaran` (`ID_Guru_Mata_Pelajaran`);

--
-- Constraints for table `siswa_mata_pelajaran`
--
ALTER TABLE `siswa_mata_pelajaran`
  ADD CONSTRAINT `siswa_mata_pelajaran_ibfk_1` FOREIGN KEY (`ID_Siswa`) REFERENCES `siswa` (`ID_Siswa`),
  ADD CONSTRAINT `siswa_mata_pelajaran_ibfk_2` FOREIGN KEY (`ID_Guru_Mata_Pelajaran`) REFERENCES `guru_mata_pelajaran` (`ID_Guru_Mata_Pelajaran`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
