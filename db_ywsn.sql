-- phpMyAdmin SQL Dump
-- version 4.7.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 04, 2018 at 05:52 AM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.1.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_ywsn`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Negara` ()  BEGIN
	SELECT * FROM u_negara;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_SignUp` (IN `username` VARCHAR(100), IN `password` VARCHAR(100), IN `full_name` VARCHAR(100), IN `surname` VARCHAR(50), IN `id_type` VARCHAR(100), IN `id_number` VARCHAR(100), IN `citizenship` VARCHAR(50), IN `gender` VARCHAR(10), IN `birth_place` VARCHAR(200), IN `birth_date` DATE, IN `religion` VARCHAR(50), IN `blood_type` CHAR(2), IN `occupation` VARCHAR(100), IN `marital_status` VARCHAR(50), IN `nationality` CHAR(2), IN `country` VARCHAR(50), IN `province` VARCHAR(50), IN `address` VARCHAR(300), IN `zip_code` VARCHAR(20), IN `telephone` VARCHAR(20), IN `mobile` VARCHAR(20), IN `email` VARCHAR(50), IN `varmode` CHAR(6))  BEGIN

DECLARE AI INT DEFAULT 0;
DECLARE id INT;
DECLARE contact_type VARCHAR(10);

IF varmode = 'INSERT' THEN

	IF (SELECT count(nama_lengkap) FROM u_pribadi WHERE nama_lengkap='full_name' AND no_identitas='id_number') < 1 THEN 
	
        INSERT INTO u_pribadi 
		(
			nama_lengkap, 
			nama_panggilan, 
			jenis_identitas, 
			no_identitas, 
			tempat_lahir, 
			tanggal_lahir, 
			jenis_kelamin, 
			golongan_darah, 
			pekerjaan, 
			agama, 
			status_pernikahan
		) VALUES(
			full_name, 
			surname, 
			id_type, 
			id_number, 
			birth_place, 
			birth_date, 
			gender, 
			blood_type, 
			occupation, 
			religion, 
			marital_status
		);
        
		
        SET AI =+ 1;
        
        IF EXISTS(SELECT telephone) THEN
			SET contact_type='Home';
            INSERT INTO u_kontak(id_pribadi, jenis_kontak, no_kontak) VALUES(AI, contact_type, telephone);
		ELSEIF EXISTS(SELECT mobile) THEN
			SET contact_type='Mobile';
            INSERT INTO u_kontak(id_pribadi, jenis_kontak, no_kontak) VALUES(AI, contact_type, mobile);
		ELSEIF EXISTS(SELECT email) THEN
			SET contact_type='Email';
            INSERT INTO u_kontak(id_pribadi, jenis_kontak, no_kontak) VALUES(AI, contact_type, telephone);
        END IF;
        
        
        INSERT INTO u_alamat(id_pribadi, negara, provinsi, kota, alamat, kode_pos)
        VALUES(AI, nationality, province, country, address, zip_code);
        
        
	END IF;

ELSEIF varmode='UPDATE' THEN

	UPDATE u_pribadi SET nama_lengkap = full_name;

    

END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_test` (`nama` VARCHAR(10))  BEGIN
	INSERT INTO test(name) VALUES(nama);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `b_bimbel`
--

CREATE TABLE `b_bimbel` (
  `id_pribadi` bigint(20) NOT NULL,
  `angkatan_bimbel` varchar(100) NOT NULL,
  `id_pesesrta_bimbel` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `b_donasi`
--

CREATE TABLE `b_donasi` (
  `id_donasi` int(9) NOT NULL,
  `id_donatur` int(4) NOT NULL,
  `id_program` int(4) NOT NULL,
  `tanggal_donasi` date NOT NULL,
  `nama_pemilik_rekening` varchar(300) DEFAULT NULL,
  `no_ref_bank` varchar(50) DEFAULT NULL,
  `mata_uang` varchar(100) NOT NULL,
  `nominal` decimal(10,2) NOT NULL,
  `kurs` decimal(10,2) DEFAULT NULL,
  `keterangan_kurs` varchar(200) DEFAULT NULL,
  `nama_dedikasi` varchar(300) DEFAULT NULL,
  `cicilan_ke` int(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(4) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `b_donatur`
--

CREATE TABLE `b_donatur` (
  `tanggal_ikut` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `id_pribadi` int(9) NOT NULL,
  `id_donatur` int(4) NOT NULL,
  `sumber_informasi` varchar(300) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(50) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `b_donatur`
--

INSERT INTO `b_donatur` (`tanggal_ikut`, `id_pribadi`, `id_donatur`, `sumber_informasi`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
('2017-12-15 04:29:43', 1, 1, 'Test', '2017-12-14 21:29:43', NULL, '2017-12-14 21:29:43', NULL),
('2017-12-19 05:15:38', 3, 3, 'Test 2', '2017-12-18 22:15:38', NULL, '2017-12-18 22:15:38', NULL),
('2017-12-19 05:15:54', 4, 4, 'Test 3', '2017-12-18 22:15:54', NULL, '2017-12-18 22:15:54', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `b_jenis_prog`
--

CREATE TABLE `b_jenis_prog` (
  `id_jenis_prog` int(4) NOT NULL,
  `nama_jenis_prog` varchar(45) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(4) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `update_by` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `b_jenis_prog`
--

INSERT INTO `b_jenis_prog` (`id_jenis_prog`, `nama_jenis_prog`, `created_at`, `created_by`, `updated_at`, `update_by`) VALUES
(1, 'Test 1', '2017-09-29 03:07:51', NULL, '2017-09-30 00:46:00', NULL),
(2, 'Test 2', '2017-09-29 03:09:19', NULL, '2017-09-29 03:09:19', NULL),
(3, 'Test 3', '2017-09-29 23:03:08', NULL, '2017-09-29 23:03:08', NULL),
(4, 'Test 4', '2017-09-30 01:00:45', NULL, '2017-10-01 01:45:55', NULL),
(5, 'ada', '2017-10-05 02:43:15', NULL, '2017-10-05 02:43:15', NULL),
(6, 'Testing', '2017-10-10 05:11:53', NULL, '2017-10-10 05:11:53', NULL),
(7, 'Cicilan', '2017-12-27 03:55:18', NULL, '2017-12-27 03:55:18', NULL),
(8, 'Jenis A', '2017-12-27 03:59:47', NULL, '2017-12-27 03:59:47', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `b_program_dana`
--

CREATE TABLE `b_program_dana` (
  `id_program` int(4) NOT NULL,
  `nama_program` varchar(200) DEFAULT NULL,
  `poster_path` varchar(100) DEFAULT NULL,
  `poster_name` varchar(50) DEFAULT NULL,
  `nominal` decimal(10,2) DEFAULT NULL,
  `cicilan` tinyint(1) DEFAULT NULL,
  `souvenir` tinyint(1) DEFAULT NULL,
  `deskripsi_souvenir` varchar(100) DEFAULT NULL,
  `id_jenis_prog` int(4) DEFAULT NULL,
  `mulai_program` date DEFAULT NULL,
  `akhir_program` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(4) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `b_program_dana`
--

INSERT INTO `b_program_dana` (`id_program`, `nama_program`, `poster_path`, `poster_name`, `nominal`, `cicilan`, `souvenir`, `deskripsi_souvenir`, `id_jenis_prog`, `mulai_program`, `akhir_program`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(1, 'Technologic', '/profile_images/', '1507784131.jpg', '990000.00', 1, NULL, NULL, 1, '2017-10-12', '2017-10-26', '2017-10-11 21:55:31', NULL, '2017-10-11 21:55:31', NULL),
(2, 'SDLC', 'profile_images/', '.jpg', '480000.00', 1, NULL, NULL, 2, '2017-10-13', '2017-10-31', '2017-10-13 03:51:00', NULL, '2017-10-13 03:51:00', NULL),
(3, 'Test', '/profile_images/', '1508331258.jpg', '150000.00', 1, NULL, NULL, 3, '2017-10-18', '2017-10-31', '2017-10-18 05:54:18', NULL, '2017-10-18 05:54:18', NULL),
(4, 'Me', '/profile_images/', '1508331317.jpg', '23000.00', 1, NULL, NULL, 4, '2017-10-18', '2017-10-31', '2017-10-18 05:55:17', NULL, '2017-10-18 05:55:17', NULL),
(5, 'ada', '/profile_images/', '1508331533.JPG', '500000.00', 1, NULL, NULL, 5, '2017-10-18', '2017-10-31', '2017-10-18 05:58:53', NULL, '2017-10-18 05:58:53', NULL),
(6, 'blabla', '/profile_images/', '1508331665.JPG', '5000000.00', 1, NULL, NULL, 6, '2017-10-17', '2017-10-31', '2017-10-18 06:01:05', NULL, '2017-10-18 06:01:05', NULL),
(7, 'bababa', '/profile_images/', '1508414267.jpg', '560000.00', 1, 1, NULL, 6, '2017-10-19', '2017-10-31', '2017-10-19 04:57:47', NULL, '2017-10-19 04:57:47', NULL),
(8, 'no cicil', '/profile_images/', '1508414325.jpg', '5000000.00', 0, 1, NULL, 1, '2017-10-19', '2017-10-31', '2017-10-19 04:58:45', NULL, '2017-10-19 04:58:45', NULL),
(9, 'test 999', '/profile_images/', '1510736969.jpg', '10000.00', 0, 0, NULL, 5, '2017-11-15', '2017-12-31', '2017-11-15 02:09:29', NULL, '2017-11-15 02:09:29', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(15, '2014_10_12_000000_create_users_table', 1),
(16, '2014_10_12_100000_create_password_resets_table', 1),
(17, '2017_11_14_101652_buat_tabel_setting', 1),
(18, '2017_11_29_085806_create_roles_table', 2),
(19, '2017_11_29_085918_create_user_roles_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `m_anggota_mah`
--

CREATE TABLE `m_anggota_mah` (
  `nomor_anggota` varchar(300) NOT NULL,
  `tanggal_gabung` date NOT NULL,
  `nominal_komitmen` decimal(10,0) NOT NULL,
  `status_mah` varchar(300) DEFAULT NULL,
  `id_pribadi` bigint(20) NOT NULL,
  `id_anggota` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `m_pembayaran_mah`
--

CREATE TABLE `m_pembayaran_mah` (
  `nominal` decimal(10,0) NOT NULL,
  `tanggal_bayar` date NOT NULL,
  `pembayaran_bulan` varchar(100) NOT NULL,
  `id_anggota` bigint(20) NOT NULL,
  `id_transaksi` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `package`
--

CREATE TABLE `package` (
  `id` int(10) NOT NULL,
  `pack_name` varchar(255) DEFAULT NULL,
  `amount` decimal(9,2) DEFAULT NULL,
  `note` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `p_karyawan`
--

CREATE TABLE `p_karyawan` (
  `id_pribadi` int(11) NOT NULL,
  `nama_lengkap` varchar(300) NOT NULL,
  `gaji` int(11) NOT NULL,
  `posisi` varchar(300) NOT NULL,
  `grade` char(10) NOT NULL,
  `tanggal_masuk` date NOT NULL,
  `tanggal_kontrak_akhir` date NOT NULL,
  `kode_karyawan` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `departemen` varchar(50) NOT NULL,
  `no_ktp` varchar(50) NOT NULL,
  `no_npwp` varchar(50) NOT NULL,
  `institusi` varchar(300) NOT NULL,
  `supervisor` varchar(300) NOT NULL,
  `id_supervisor` bigint(20) NOT NULL,
  `id_karyawan` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `p_sangha`
--

CREATE TABLE `p_sangha` (
  `id_pribadi` bigint(20) NOT NULL,
  `nama_lengkap` varchar(300) NOT NULL,
  `nam_ordain` varchar(300) NOT NULL,
  `no_bpjs` varchar(50) NOT NULL,
  `no_polis` varchar(50) NOT NULL,
  `id_sangha` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(4) NOT NULL,
  `roles_name` varchar(100) NOT NULL,
  `description` varchar(200) NOT NULL,
  `created_by` int(4) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int(4) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `roles_name`, `description`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(1, 'Admin', 'Administrator', NULL, '2017-11-29 10:45:39', NULL, '0000-00-00 00:00:00'),
(2, 'Operator', 'Operator Input transaction', NULL, '2017-11-29 10:45:39', NULL, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `r_akomodasi`
--

CREATE TABLE `r_akomodasi` (
  `id` int(4) NOT NULL,
  `nama_villa` varchar(100) NOT NULL,
  `kamar` int(4) DEFAULT NULL,
  `lantai` int(3) DEFAULT NULL,
  `kapasitas` int(11) NOT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `created_by` int(4) DEFAULT NULL,
  `updated_date` datetime(6) DEFAULT NULL,
  `updated_by` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `r_kamar`
--

CREATE TABLE `r_kamar` (
  `id` int(4) NOT NULL,
  `id_akomodasi` int(4) DEFAULT NULL,
  `nama_kamar` varchar(200) NOT NULL,
  `kapasitas` int(3) NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `created_by` int(4) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `updated_by` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `r_paket`
--

CREATE TABLE `r_paket` (
  `nama_paket` varchar(300) NOT NULL,
  `biaya` decimal(10,0) NOT NULL,
  `flag_lokal` tinyint(1) NOT NULL,
  `id_retret` int(10) NOT NULL,
  `id` int(10) NOT NULL,
  `catatan` text,
  `created_date` datetime(6) NOT NULL,
  `created_by` int(4) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `updated_by` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `r_pembayaran`
--

CREATE TABLE `r_pembayaran` (
  `tanggal_transaksi` date NOT NULL,
  `jumlah` decimal(10,0) NOT NULL,
  `nama_rekening` varchar(300) DEFAULT NULL,
  `mata_uang` varchar(300) DEFAULT NULL,
  `keterangan` varchar(300) DEFAULT NULL,
  `id_registrasi` int(10) NOT NULL,
  `id_transaksi` int(10) NOT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `created_by` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `r_registrasi`
--

CREATE TABLE `r_registrasi` (
  `id` int(10) NOT NULL,
  `tanggal_registrasi` date NOT NULL,
  `id_pribadi` bigint(20) NOT NULL,
  `id_retret` int(10) NOT NULL,
  `id_paket` int(10) NOT NULL,
  `motivasi` varchar(300) CHARACTER SET latin1 DEFAULT NULL,
  `vegetarian` tinyint(1) DEFAULT NULL,
  `riwayat_penyakit` varchar(300) CHARACTER SET latin1 DEFAULT NULL,
  `kontak_darurat` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `keterangan` varchar(300) CHARACTER SET latin1 DEFAULT NULL,
  `kesanggupan_bayar` decimal(10,2) DEFAULT NULL,
  `daftar_ulang` tinyint(1) NOT NULL,
  `tanggal_datang` date DEFAULT NULL,
  `tanggal_pulang` date DEFAULT NULL,
  `flag_ikut_bus_datang` tinyint(1) DEFAULT NULL,
  `flag_ikut_bus_pulang` tinyint(1) DEFAULT NULL,
  `permintaan_khusus` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `subsidi` tinyint(1) DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `created_by` int(4) DEFAULT NULL,
  `updated_date` datetime(6) DEFAULT NULL,
  `updated_by` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `r_reg_akomodasi`
--

CREATE TABLE `r_reg_akomodasi` (
  `id` int(4) NOT NULL,
  `id_registrasi` int(10) NOT NULL,
  `id_kamar` int(4) NOT NULL,
  `keterangan` varchar(500) DEFAULT NULL,
  `created_date` datetime(6) NOT NULL,
  `created_by` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `r_topik`
--

CREATE TABLE `r_topik` (
  `id` int(10) NOT NULL,
  `topik_retret` varchar(200) CHARACTER SET latin1 NOT NULL,
  `guru` varchar(200) CHARACTER SET latin1 NOT NULL,
  `tanggal_mulai` date NOT NULL,
  `tanggal_selesai` date NOT NULL,
  `tahun` char(4) CHARACTER SET latin1 NOT NULL,
  `lokasi` varchar(300) CHARACTER SET latin1 NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `created_by` int(4) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `updated_by` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `r_vendor`
--

CREATE TABLE `r_vendor` (
  `id` int(4) NOT NULL,
  `nama_vendor` varchar(100) DEFAULT NULL,
  `alamat` varchar(200) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `no_telp` varchar(50) DEFAULT NULL,
  `no_hp` varchar(50) DEFAULT NULL,
  `kategori` varchar(45) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `created_by` int(4) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `updated_by` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

CREATE TABLE `setting` (
  `id_setting` int(10) UNSIGNED NOT NULL,
  `nama_perusahaan` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `telepon` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `name` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `test`
--

INSERT INTO `test` (`name`) VALUES
('HENDRA');

-- --------------------------------------------------------

--
-- Table structure for table `t_buku`
--

CREATE TABLE `t_buku` (
  `kode_buku` varchar(100) NOT NULL,
  `judul_buku` varchar(300) NOT NULL,
  `bahasa` varchar(20) DEFAULT NULL,
  `tanggal_publikasi` date DEFAULT NULL,
  `tebal_buku` int(11) DEFAULT NULL,
  `penceramah` varchar(300) DEFAULT NULL,
  `stok` int(11) NOT NULL DEFAULT '0',
  `flag_ebook` tinyint(1) DEFAULT NULL,
  `buku_keluar` int(11) DEFAULT NULL,
  `buku_masuk` int(11) NOT NULL,
  `id_buku` bigint(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `t_distribusi`
--

CREATE TABLE `t_distribusi` (
  `id_buku` bigint(20) NOT NULL,
  `id_pribadi` bigint(20) NOT NULL,
  `tanggal_distribusi` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `id_distribusi` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `t_penerima_transkrip`
--

CREATE TABLE `t_penerima_transkrip` (
  `tanggal_bergabung` date NOT NULL,
  `id_pribadi` int(11) NOT NULL,
  `sumber_informasi` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(4) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level` int(10) UNSIGNED NOT NULL DEFAULT '2',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `foto`, `level`, `remember_token`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Hendra\' Gunawan', 'Hendra.yap@gmail.com', '$2y$10$HJGiw1uZ6yfuQYO64bONQO4NZPkw1Sut.6h58qL4sADJCOmyej/le', 'user.png', 1, NULL, NULL, NULL, NULL, NULL),
(2, 'Suniati', 'suni@gmail.com', '$2y$10$GKiPOR1brDULPbNvG4AtiOLYENmTOhGMiJYBdtZWSznwCZD8hwZ3q', 'user.png', 2, 'mXKNUl8dSKSjspk2FJmNsLwKcW0IdIsXLHqkAlIG8IWQ1ociLhXlXj2j7fiN', NULL, NULL, NULL, NULL),
(3, 'Hegun', 'hendra.gunawan@wilwatikta.or.id', '$2y$10$L.atNB5uUCxJUd1xpdZ5F.B/hGVZ8Ty0bDAyP3nGS.1tW/n7xHrK.', NULL, 1, '7puieARZcFxECq7NeAzQOrU1RsK9YXei39BzvmeQVdGdvmizH8GJ5ZXbNgXi', NULL, NULL, '2017-11-29 00:48:05', '2017-11-29 00:48:05');

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `id` int(4) NOT NULL,
  `roles_id` int(4) NOT NULL,
  `user_id` int(4) NOT NULL,
  `created_by` int(4) NOT NULL,
  `updated_by` int(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`id`, `roles_id`, `user_id`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 1, 3, 1, 1, '2017-11-29 10:49:49', NULL),
(2, 2, 2, 0, 0, '2017-11-29 10:49:49', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `u_alamat`
--

CREATE TABLE `u_alamat` (
  `alamat` varchar(300) NOT NULL,
  `kota` varchar(100) DEFAULT NULL,
  `provinsi` varchar(100) DEFAULT NULL,
  `kode_pos` varchar(10) DEFAULT NULL,
  `id_negara` int(4) NOT NULL,
  `id_pribadi` int(9) NOT NULL,
  `id_alamat` bigint(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `u_kontak`
--

CREATE TABLE `u_kontak` (
  `id` int(4) NOT NULL,
  `jenis_kontak` varchar(100) NOT NULL COMMENT 'Handphone or Email',
  `no_kontak` varchar(30) NOT NULL,
  `id_pribadi` int(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `u_kontak`
--

INSERT INTO `u_kontak` (`id`, `jenis_kontak`, `no_kontak`, `id_pribadi`) VALUES
(1, 'Email', 'test@gmail.com', 1),
(2, 'Handphone', '+628156006000', 1),
(5, 'Email', 'Test2@gmail.com', 3),
(6, 'Handphone', '+628135005050', 3),
(7, 'Email', 'Test3@gmail.com', 4),
(8, 'Handphone', '+628137007332', 4);

-- --------------------------------------------------------

--
-- Table structure for table `u_negara`
--

CREATE TABLE `u_negara` (
  `id_negara` int(4) NOT NULL,
  `kode_negara` varchar(100) NOT NULL,
  `nama_negara` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `u_negara`
--

INSERT INTO `u_negara` (`id_negara`, `kode_negara`, `nama_negara`) VALUES
(1, 'AF', 'AFGHANISTAN'),
(2, 'AL', 'ALBANIA'),
(3, 'DZ', 'ALGERIA'),
(4, 'AS', 'AMERICAN SAMOA'),
(5, 'AD', 'ANDORRA'),
(6, 'AO', 'ANGOLA'),
(7, 'AI', 'ANGUILLA'),
(8, 'AQ', 'ANTARCTICA'),
(9, 'AG', 'ANTIGUA AND BARBUDA'),
(10, 'AR', 'ARGENTINA'),
(11, 'AM', 'ARMENIA'),
(12, 'AW', 'ARUBA'),
(13, 'AU', 'AUSTRALIA'),
(14, 'AT', 'AUSTRIA'),
(15, 'AZ', 'AZERBAIJAN'),
(16, 'BS', 'BAHAMAS'),
(17, 'BH', 'BAHRAIN'),
(18, 'BD', 'BANGLADESH'),
(19, 'BB', 'BARBADOS'),
(20, 'BY', 'BELARUS'),
(21, 'BE', 'BELGIUM'),
(22, 'BZ', 'BELIZE'),
(23, 'BJ', 'BENIN'),
(24, 'BM', 'BERMUDA'),
(25, 'BT', 'BHUTAN'),
(26, 'BO', 'BOLIVIA'),
(27, 'BA', 'BOSNIA AND HERZEGOVINA'),
(28, 'BW', 'BOTSWANA'),
(29, 'BV', 'BOUVET ISLAND'),
(30, 'BR', 'BRAZIL'),
(31, 'IO', 'BRITISH INDIAN OCEAN TERRITORY'),
(32, 'BN', 'BRUNEI DARUSSALAM'),
(33, 'BG', 'BULGARIA'),
(34, 'BF', 'BURKINA FASO'),
(35, 'BI', 'BURUNDI'),
(36, 'KH', 'CAMBODIA'),
(37, 'CM', 'CAMEROON'),
(38, 'CA', 'CANADA'),
(39, 'CV', 'CAPE VERDE'),
(40, 'KY', 'CAYMAN ISLANDS'),
(41, 'CF', 'CENTRAL AFRICAN REPUBLIC'),
(42, 'TD', 'CHAD'),
(43, 'CL', 'CHILE'),
(44, 'CN', 'CHINA'),
(45, 'CX', 'CHRISTMAS ISLAND'),
(46, 'CC', 'COCOS (KEELING) ISLANDS'),
(47, 'CO', 'COLOMBIA'),
(48, 'KM', 'COMOROS'),
(49, 'CG', 'CONGO'),
(50, 'CD', 'CONGO,'),
(51, 'CK', 'COOK ISLANDS'),
(52, 'CR', 'COSTA RICA'),
(53, 'CI', 'CÔTE D’IVOIRE'),
(54, 'HR', 'CROATIA'),
(55, 'CU', 'CUBA'),
(56, 'CY', 'CYPRUS'),
(57, 'CZ', 'CZECH REPUBLIC'),
(58, 'DK', 'DENMARK'),
(59, 'DJ', 'DJIBOUTI'),
(60, 'DM', 'DOMINICA'),
(61, 'DO', 'DOMINICAN REPUBLIC'),
(62, 'EC', 'ECUADOR'),
(63, 'EG', 'EGYPT'),
(64, 'SV', 'EL SALVADOR'),
(65, 'GQ', 'EQUATORIAL GUINEA'),
(66, 'ER', 'ERITREA'),
(67, 'EE', 'ESTONIA'),
(68, 'ET', 'ETHIOPIA'),
(69, 'FK', 'FALKLAND ISLANDS (MALVINAS)'),
(70, 'FO', 'FAROE ISLANDS'),
(71, 'FJ', 'FIJI'),
(72, 'FI', 'FINLAND'),
(73, 'FR', 'FRANCE'),
(74, 'GF', 'FRENCH GUIANA'),
(75, 'PF', 'FRENCH POLYNESIA'),
(76, 'TF', 'FRENCH SOUTHERN TERRITORIES'),
(77, 'GA', 'GABON'),
(78, 'GM', 'GAMBIA'),
(79, 'GE', 'GEORGIA'),
(80, 'DE', 'GERMANY'),
(81, 'GH', 'GHANA'),
(82, 'GI', 'GIBRALTAR'),
(83, 'GR', 'GREECE'),
(84, 'GL', 'GREENLAND'),
(85, 'GD', 'GRENADA'),
(86, 'GP', 'GUADELOUPE'),
(87, 'GU', 'GUAM'),
(88, 'GT', 'GUATEMALA'),
(89, 'GN', 'GUINEA'),
(90, 'GW', 'GUINEA-BISSAU'),
(91, 'GY', 'GUYANA'),
(92, 'HT', 'HAITI'),
(93, 'HM', 'HEARD ISLAND AND MCDONALD ISLANDS'),
(94, 'VA', 'HOLY SEE (VATICAN CITY STATE)'),
(95, 'HN', 'HONDURAS'),
(96, 'HK', 'HONG KONG'),
(97, 'HU', 'HUNGARY'),
(98, 'IS', 'ICELAND'),
(99, 'IN', 'INDIA'),
(100, 'ID', 'INDONESIA'),
(101, 'IR', 'IRAN, ISLAMIC REPUBLIC OF'),
(102, 'IQ', 'IRAQ'),
(103, 'IE', 'IRELAND'),
(104, 'IL', 'ISRAEL'),
(105, 'IT', 'ITALY'),
(106, 'JM', 'JAMAICA'),
(107, 'JP', 'JAPAN'),
(108, 'JO', 'JORDAN'),
(109, 'KZ', 'KAZAKHSTAN'),
(110, 'KE', 'KENYA'),
(111, 'KI', 'KIRIBATI'),
(112, 'KP', 'KOREA,'),
(113, 'KR', 'KOREA, REPUBLIC OF'),
(114, 'KW', 'KUWAIT'),
(115, 'KG', 'KYRGYZSTAN'),
(116, 'LA', 'LAO PEOPLE’S DEMOCRATIC REPUBLIC'),
(117, 'LV', 'LATVIA'),
(118, 'LB', 'LEBANON'),
(119, 'LS', 'LESOTHO'),
(120, 'LR', 'LIBERIA'),
(121, 'LY', 'LIBYAN ARAB JAMAHIRIYA'),
(122, 'LI', 'LIECHTENSTEIN'),
(123, 'LT', 'LITHUANIA'),
(124, 'LU', 'LUXEMBOURG'),
(125, 'MO', 'MACAO'),
(126, 'MK', 'MACEDONIA,'),
(127, 'MG', 'MADAGASCAR'),
(128, 'MW', 'MALAWI'),
(129, 'MY', 'MALAYSIA'),
(130, 'MV', 'MALDIVES'),
(131, 'ML', 'MALI'),
(132, 'MT', 'MALTA'),
(133, 'MH', 'MARSHALL ISLANDS'),
(134, 'MQ', 'MARTINIQUE'),
(135, 'MR', 'MAURITANIA'),
(136, 'MU', 'MAURITIUS'),
(137, 'YT', 'MAYOTTE'),
(138, 'MX', 'MEXICO'),
(139, 'FM', 'MICRONESIA, FEDERATED STATES OF'),
(140, 'MD', 'MOLDOVA, REPUBLIC OF'),
(141, 'MC', 'MONACO'),
(142, 'MN', 'MONGOLIA'),
(143, 'MS', 'MONTSERRAT'),
(144, 'MA', 'MOROCCO'),
(145, 'MZ', 'MOZAMBIQUE'),
(146, 'MM', 'MYANMAR'),
(147, 'NA', 'NAMIBIA'),
(148, 'NR', 'NAURU'),
(149, 'NP', 'NEPAL'),
(150, 'NL', 'NETHERLANDS'),
(151, 'AN', 'NETHERLANDS ANTILLES'),
(152, 'NC', 'NEW CALEDONIA'),
(153, 'NZ', 'NEW ZEALAND'),
(154, 'NI', 'NICARAGUA'),
(155, 'NE', 'NIGER'),
(156, 'NG', 'NIGERIA'),
(157, 'NU', 'NIUE'),
(158, 'NF', 'NORFOLK ISLAND'),
(159, 'MP', 'NORTHERN MARIANA ISLANDS'),
(160, 'NO', 'NORWAY'),
(161, 'OM', 'OMAN'),
(162, 'PK', 'PAKISTAN'),
(163, 'PW', 'PALAU'),
(164, 'PS', 'PALESTINIAN TERRITORY, OCCUPIED'),
(165, 'PA', 'PANAMA'),
(166, 'PG', 'PAPUA NEW GUINEA'),
(167, 'PY', 'PARAGUAY'),
(168, 'PE', 'PERU'),
(169, 'PH', 'PHILIPPINES'),
(170, 'PN', 'PITCAIRN'),
(171, 'PL', 'POLAND'),
(172, 'PT', 'PORTUGAL'),
(173, 'PR', 'PUERTO RICO'),
(174, 'QA', 'QATAR'),
(175, 'RE', 'RÉUNION'),
(176, 'RO', 'ROMANIA'),
(177, 'RU', 'RUSSIAN FEDERATION'),
(178, 'RW', 'RWANDA'),
(179, 'SH', 'SAINT HELENA'),
(180, 'KN', 'SAINT KITTS AND NEVIS'),
(181, 'LC', 'SAINT LUCIA'),
(182, 'PM', 'SAINT PIERRE AND MIQUELON'),
(183, 'VC', 'SAINT VINCENT AND THE GRENADINES'),
(184, 'WS', 'SAMOA'),
(185, 'SM', 'SAN MARINO'),
(186, 'ST', 'SAO TOME AND PRINCIPE'),
(187, 'SA', 'SAUDI ARABIA'),
(188, 'SN', 'SENEGAL'),
(189, 'CS', 'SERBIA AND MONTENEGRO'),
(190, 'SC', 'SEYCHELLES'),
(191, 'SL', 'SIERRA LEONE'),
(192, 'SG', 'SINGAPORE'),
(193, 'SK', 'SLOVAKIA'),
(194, 'SI', 'SLOVENIA'),
(195, 'SB', 'SOLOMON ISLANDS'),
(196, 'SO', 'SOMALIA'),
(197, 'ZA', 'SOUTH AFRICA'),
(198, 'GS', 'SOUTH GEORGIA AND'),
(199, 'ES', 'SPAIN'),
(200, 'LK', 'SRI LANKA'),
(201, 'SD', 'SUDAN'),
(202, 'SR', 'SURINAME'),
(203, 'SJ', 'SVALBARD AND JAN MAYEN'),
(204, 'SZ', 'SWAZILAND'),
(205, 'SE', 'SWEDEN'),
(206, 'CH', 'SWITZERLAND'),
(207, 'SY', 'SYRIAN ARAB REPUBLIC'),
(208, 'TW', 'TAIWAN, PROVINCE OF CHINA'),
(209, 'TJ', 'TAJIKISTAN'),
(210, 'TZ', 'TANZANIA, UNITED REPUBLIC OF'),
(211, 'TH', 'THAILAND'),
(212, 'TL', 'TIMOR-LESTE'),
(213, 'TG', 'TOGO'),
(214, 'TK', 'TOKELAU'),
(215, 'TO', 'TONGA'),
(216, 'TT', 'TRINIDAD AND TOBAGO'),
(217, 'TN', 'TUNISIA'),
(218, 'TR', 'TURKEY'),
(219, 'TM', 'TURKMENISTAN'),
(220, 'TC', 'TURKS AND CAICOS ISLANDS'),
(221, 'TV', 'TUVALU'),
(222, 'UG', 'UGANDA'),
(223, 'UA', 'UKRAINE'),
(224, 'AE', 'UNITED ARAB EMIRATES'),
(225, 'GB', 'UNITED KINGDOM'),
(226, 'US', 'UNITED STATES'),
(227, 'UM', 'UNITED STATES MINOR OUTLYING ISLANDS'),
(228, 'UY', 'URUGUAY'),
(229, 'UZ', 'UZBEKISTAN'),
(230, 'VU', 'VANUATU'),
(231, 'VE', 'VENEZUELA'),
(232, 'VN', 'VIET NAM'),
(233, 'VG', 'VIRGIN ISLANDS, BRITISH'),
(234, 'VI', 'VIRGIN ISLANDS, U.S.'),
(235, 'WF', 'WALLIS AND FUTUNA'),
(236, 'EH', 'WESTERN SAHARA'),
(237, 'YE', 'YEMEN'),
(238, 'ZM', 'ZAMBIA');

-- --------------------------------------------------------

--
-- Table structure for table `u_pendidikan`
--

CREATE TABLE `u_pendidikan` (
  `id` int(9) NOT NULL,
  `jenjang` varchar(100) NOT NULL,
  `nama_institusi` varchar(300) NOT NULL,
  `jurusan` varchar(300) DEFAULT NULL,
  `tahun_masuk` varchar(10) DEFAULT NULL,
  `id_pribadi` int(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `u_pribadi`
--

CREATE TABLE `u_pribadi` (
  `id` int(9) NOT NULL,
  `jenis_identitas` varchar(50) DEFAULT NULL,
  `no_identitas` varchar(100) DEFAULT NULL,
  `nama_lengkap` varchar(150) NOT NULL,
  `tanggal_lahir` date NOT NULL DEFAULT '3000-01-01',
  `nama_panggilan` varchar(300) DEFAULT NULL,
  `tempat_lahir` varchar(100) DEFAULT NULL,
  `jenis_kelamin` varchar(50) DEFAULT NULL,
  `golongan_darah` varchar(10) DEFAULT NULL,
  `agama` varchar(30) DEFAULT NULL,
  `pekerjaan` varchar(50) DEFAULT NULL,
  `status_pernikahan` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(4) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `u_pribadi`
--

INSERT INTO `u_pribadi` (`id`, `jenis_identitas`, `no_identitas`, `nama_lengkap`, `tanggal_lahir`, `nama_panggilan`, `tempat_lahir`, `jenis_kelamin`, `golongan_darah`, `agama`, `pekerjaan`, `status_pernikahan`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(1, NULL, NULL, 'Test', '3000-01-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-12-14 21:29:42', NULL, '2017-12-14 21:29:42', NULL),
(3, NULL, NULL, 'Test 2', '3000-01-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-12-18 22:15:38', NULL, '2017-12-18 22:15:38', NULL),
(4, NULL, NULL, 'Test 3', '3000-01-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-12-18 22:15:54', NULL, '2017-12-18 22:15:54', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `u_rekening`
--

CREATE TABLE `u_rekening` (
  `id_rek` int(4) NOT NULL,
  `id_pribadi` int(4) NOT NULL,
  `nama_bank` varchar(50) NOT NULL,
  `no_rek` text NOT NULL,
  `nama_rek` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `u_relasi`
--

CREATE TABLE `u_relasi` (
  `id` int(9) NOT NULL,
  `id_pribadi` int(9) NOT NULL,
  `hubungan` varchar(300) NOT NULL,
  `id_relasi_pribadi` int(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `b_bimbel`
--
ALTER TABLE `b_bimbel`
  ADD PRIMARY KEY (`id_pesesrta_bimbel`);

--
-- Indexes for table `b_donasi`
--
ALTER TABLE `b_donasi`
  ADD PRIMARY KEY (`id_donasi`),
  ADD KEY `donatur_donasi_idx` (`id_donatur`),
  ADD KEY `donasi_program_idx` (`id_program`);

--
-- Indexes for table `b_donatur`
--
ALTER TABLE `b_donatur`
  ADD PRIMARY KEY (`id_donatur`),
  ADD KEY `donatur_pribadi_idx` (`id_pribadi`);

--
-- Indexes for table `b_jenis_prog`
--
ALTER TABLE `b_jenis_prog`
  ADD PRIMARY KEY (`id_jenis_prog`);

--
-- Indexes for table `b_program_dana`
--
ALTER TABLE `b_program_dana`
  ADD PRIMARY KEY (`id_program`),
  ADD KEY `program_jenis_idx` (`id_jenis_prog`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `m_anggota_mah`
--
ALTER TABLE `m_anggota_mah`
  ADD PRIMARY KEY (`id_anggota`);

--
-- Indexes for table `m_pembayaran_mah`
--
ALTER TABLE `m_pembayaran_mah`
  ADD PRIMARY KEY (`id_transaksi`);

--
-- Indexes for table `package`
--
ALTER TABLE `package`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `p_karyawan`
--
ALTER TABLE `p_karyawan`
  ADD PRIMARY KEY (`id_karyawan`);

--
-- Indexes for table `p_sangha`
--
ALTER TABLE `p_sangha`
  ADD PRIMARY KEY (`id_sangha`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `r_akomodasi`
--
ALTER TABLE `r_akomodasi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `r_kamar`
--
ALTER TABLE `r_kamar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kamar_akomodasi_idx` (`id_akomodasi`);

--
-- Indexes for table `r_paket`
--
ALTER TABLE `r_paket`
  ADD PRIMARY KEY (`id`),
  ADD KEY `paket_retret_idx` (`id_retret`);

--
-- Indexes for table `r_pembayaran`
--
ALTER TABLE `r_pembayaran`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `pembayaran_registrasi_idx` (`id_registrasi`);

--
-- Indexes for table `r_registrasi`
--
ALTER TABLE `r_registrasi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `peserta` (`id_pribadi`),
  ADD KEY `paket_peserta` (`id_paket`);

--
-- Indexes for table `r_reg_akomodasi`
--
ALTER TABLE `r_reg_akomodasi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `registrasi_akomodasi_idx` (`id_registrasi`),
  ADD KEY `registrasi_kamar_idx` (`id_kamar`);

--
-- Indexes for table `r_topik`
--
ALTER TABLE `r_topik`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `r_vendor`
--
ALTER TABLE `r_vendor`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `setting`
--
ALTER TABLE `setting`
  ADD PRIMARY KEY (`id_setting`);

--
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `t_buku`
--
ALTER TABLE `t_buku`
  ADD PRIMARY KEY (`id_buku`);

--
-- Indexes for table `t_distribusi`
--
ALTER TABLE `t_distribusi`
  ADD PRIMARY KEY (`id_distribusi`);

--
-- Indexes for table `t_penerima_transkrip`
--
ALTER TABLE `t_penerima_transkrip`
  ADD PRIMARY KEY (`id_pribadi`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `roles_id` (`roles_id`);

--
-- Indexes for table `u_alamat`
--
ALTER TABLE `u_alamat`
  ADD PRIMARY KEY (`id_alamat`),
  ADD KEY `idx_u_alamat_id_pribadi` (`id_pribadi`),
  ADD KEY `u_alamat_negara_idx` (`id_negara`);

--
-- Indexes for table `u_kontak`
--
ALTER TABLE `u_kontak`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `id_pribadi` (`id_pribadi`) USING BTREE;

--
-- Indexes for table `u_negara`
--
ALTER TABLE `u_negara`
  ADD PRIMARY KEY (`id_negara`);

--
-- Indexes for table `u_pendidikan`
--
ALTER TABLE `u_pendidikan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `u_pribadi`
--
ALTER TABLE `u_pribadi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `u_rekening`
--
ALTER TABLE `u_rekening`
  ADD PRIMARY KEY (`id_rek`);

--
-- Indexes for table `u_relasi`
--
ALTER TABLE `u_relasi`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_pribadi` (`id_pribadi`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `b_bimbel`
--
ALTER TABLE `b_bimbel`
  MODIFY `id_pesesrta_bimbel` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `b_donasi`
--
ALTER TABLE `b_donasi`
  MODIFY `id_donasi` int(9) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `b_donatur`
--
ALTER TABLE `b_donatur`
  MODIFY `id_donatur` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `b_jenis_prog`
--
ALTER TABLE `b_jenis_prog`
  MODIFY `id_jenis_prog` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `b_program_dana`
--
ALTER TABLE `b_program_dana`
  MODIFY `id_program` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `m_anggota_mah`
--
ALTER TABLE `m_anggota_mah`
  MODIFY `id_anggota` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `m_pembayaran_mah`
--
ALTER TABLE `m_pembayaran_mah`
  MODIFY `id_transaksi` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `package`
--
ALTER TABLE `package`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `p_karyawan`
--
ALTER TABLE `p_karyawan`
  MODIFY `id_karyawan` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `p_sangha`
--
ALTER TABLE `p_sangha`
  MODIFY `id_sangha` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `r_kamar`
--
ALTER TABLE `r_kamar`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `r_topik`
--
ALTER TABLE `r_topik`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `r_vendor`
--
ALTER TABLE `r_vendor`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `setting`
--
ALTER TABLE `setting`
  MODIFY `id_setting` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `t_buku`
--
ALTER TABLE `t_buku`
  MODIFY `id_buku` bigint(9) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `t_distribusi`
--
ALTER TABLE `t_distribusi`
  MODIFY `id_distribusi` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `u_alamat`
--
ALTER TABLE `u_alamat`
  MODIFY `id_alamat` bigint(9) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `u_kontak`
--
ALTER TABLE `u_kontak`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `u_negara`
--
ALTER TABLE `u_negara`
  MODIFY `id_negara` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=239;

--
-- AUTO_INCREMENT for table `u_pendidikan`
--
ALTER TABLE `u_pendidikan`
  MODIFY `id` int(9) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `u_pribadi`
--
ALTER TABLE `u_pribadi`
  MODIFY `id` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `u_rekening`
--
ALTER TABLE `u_rekening`
  MODIFY `id_rek` int(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `u_relasi`
--
ALTER TABLE `u_relasi`
  MODIFY `id` int(9) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `b_donasi`
--
ALTER TABLE `b_donasi`
  ADD CONSTRAINT `b_donasi_program` FOREIGN KEY (`id_program`) REFERENCES `b_program_dana` (`id_program`) ON UPDATE CASCADE,
  ADD CONSTRAINT `b_donatur_donasi` FOREIGN KEY (`id_donatur`) REFERENCES `b_donatur` (`id_donatur`) ON UPDATE CASCADE;

--
-- Constraints for table `b_donatur`
--
ALTER TABLE `b_donatur`
  ADD CONSTRAINT `b_donatur_ibfk_1` FOREIGN KEY (`id_pribadi`) REFERENCES `u_pribadi` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `b_program_dana`
--
ALTER TABLE `b_program_dana`
  ADD CONSTRAINT `b_program_dana_ibfk_1` FOREIGN KEY (`id_jenis_prog`) REFERENCES `b_jenis_prog` (`id_jenis_prog`) ON UPDATE CASCADE;

--
-- Constraints for table `r_kamar`
--
ALTER TABLE `r_kamar`
  ADD CONSTRAINT `kamar_akomodasi` FOREIGN KEY (`id_akomodasi`) REFERENCES `r_akomodasi` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `r_paket`
--
ALTER TABLE `r_paket`
  ADD CONSTRAINT `paket_retret` FOREIGN KEY (`id_retret`) REFERENCES `r_topik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `r_pembayaran`
--
ALTER TABLE `r_pembayaran`
  ADD CONSTRAINT `pembayaran_registrasi` FOREIGN KEY (`id_registrasi`) REFERENCES `r_registrasi` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `r_registrasi`
--
ALTER TABLE `r_registrasi`
  ADD CONSTRAINT `r_registrasi_ibfk_1` FOREIGN KEY (`id_paket`) REFERENCES `r_paket` (`id`);

--
-- Constraints for table `r_reg_akomodasi`
--
ALTER TABLE `r_reg_akomodasi`
  ADD CONSTRAINT `registrasi_akomodasi` FOREIGN KEY (`id_registrasi`) REFERENCES `r_registrasi` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `registrasi_kamar` FOREIGN KEY (`id_kamar`) REFERENCES `r_kamar` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`roles_id`) REFERENCES `roles` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `u_alamat`
--
ALTER TABLE `u_alamat`
  ADD CONSTRAINT `u_alamat_ibfk_1` FOREIGN KEY (`id_pribadi`) REFERENCES `u_pribadi` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `u_alamat_negara` FOREIGN KEY (`id_negara`) REFERENCES `u_negara` (`id_negara`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `u_kontak`
--
ALTER TABLE `u_kontak`
  ADD CONSTRAINT `fk_pribadi_kontak` FOREIGN KEY (`id_pribadi`) REFERENCES `u_pribadi` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `u_relasi`
--
ALTER TABLE `u_relasi`
  ADD CONSTRAINT `u_relasi_ibfk_1` FOREIGN KEY (`id_pribadi`) REFERENCES `u_pribadi` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
