-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 04, 2026 at 05:55 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `stemxplore`
--

-- --------------------------------------------------------

--
-- Table structure for table `learning_media`
--

CREATE TABLE `learning_media` (
  `media_id` int(11) NOT NULL,
  `media_type` enum('image','video','','') NOT NULL,
  `media_url` varchar(255) NOT NULL,
  `page_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `learning_media`
--

INSERT INTO `learning_media` (`media_id`, `media_type`, `media_url`, `page_id`) VALUES
(1, 'image', 'assets/learning/science/chap1/page1.png', 1),
(2, 'image', 'assets/learning/science/chap1/page2.jpg', 2),
(3, 'image', 'assets/learning/science/chap1/page3.png', 3),
(4, 'image', 'assets/learning/science/chap1/page4.png', 4),
(5, 'image', 'assets/learning/science/chap1/page5.png', 5);

-- --------------------------------------------------------

--
-- Table structure for table `stem_faq`
--

CREATE TABLE `stem_faq` (
  `faq_id` int(11) NOT NULL,
  `faq_question_en` varchar(255) NOT NULL,
  `faq_question_ms` varchar(255) NOT NULL,
  `faq_answer_en` varchar(255) NOT NULL,
  `faq_answer_ms` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stem_faq`
--

INSERT INTO `stem_faq` (`faq_id`, `faq_question_en`, `faq_question_ms`, `faq_answer_en`, `faq_answer_ms`) VALUES
(1, 'What is STEM?', 'Apakah STEM?', 'STEM stands for Science, Technology, Engineering, and Mathematics. It is all about learning how things work, solving problems, and creating new inventions.', 'STEM bermaksud Sains, Teknologi, Kejuruteraan dan Matematik. Ia berkaitan dengan mempelajari cara sesuatu berfungsi, menyelesaikan masalah dan mencipta ciptaan baharu.'),
(2, 'What subjects are included in STEM?', 'Apakah subjek yang termasuk dalam STEM?', 'Science (Physics, Chemistry, Biology), Technology (computers, coding, gadgets), Engineering (building, designing, machines), and Mathematics (numbers, calculations, patterns).', 'Sains (Fizik, Kimia, Biologi), Teknologi (komputer, pengekodan, gajet), Kejuruteraan (membina, mereka bentuk, mesin), dan Matematik (nombor, pengiraan, corak).'),
(3, 'What can I choose after Form 3?', 'Apa yang boleh saya pilih selepas Tingkatan 3?', 'After Form 3, students can choose to enter the Science Stream, Arts Stream, Technical or Vocational Stream, Kolej Vokasional (KV), SBP, MRSM, or other secondary school pathways depending on their interests and academic performance.', 'Selepas Tingkatan 3, pelajar boleh memilih untuk memasuki Aliran Sains, Aliran Sastera, Aliran Teknikal atau Vokasional, Kolej Vokasional (KV), SBP, MRSM atau laluan sekolah menengah lain bergantung pada minat dan prestasi akademik mereka.'),
(4, 'What is Kolej Vokasional (KV)?', 'Apakah itu Kolej Vokasional (KV)?', 'Kolej Vokasional (KV) is an education pathway that focuses on technical and practical skills such as electrical technology, automotive technology, computer systems and other vocational fields, preparing students for skilled careers or further diploma stud', 'Kolej Vokasional (KV) merupakan laluan pendidikan yang memberi tumpuan kepada kemahiran teknikal dan praktikal seperti teknologi elektrik, teknologi automotif, sistem komputer dan bidang vokasional lain, bagi menyediakan pelajar untuk kerjaya mahir atau m'),
(5, 'Can I still have a successful career if I choose TVET or KV?', 'Bolehkah saya masih mempunyai kerjaya yang berjaya jika saya memilih TVET atau KV?', 'Yes, students who choose TVET or Kolej Vokasional can still achieve successful careers because technical and vocational skills are highly needed in many industries, and they can continue their studies at diploma or degree level.', 'Ya, pelajar yang memilih TVET atau Kolej Vokasional masih boleh mencapai kerjaya yang berjaya kerana kemahiran teknikal dan vokasional sangat diperlukan dalam banyak industri, dan mereka boleh melanjutkan pelajaran mereka di peringkat diploma atau ijazah.'),
(6, 'What university courses can I take if I choose the Science Stream?', 'Apakah kursus universiti yang boleh saya ambil jika saya memilih Aliran Sains?', 'Students from the Science Stream can apply for university courses such as Medicine, Engineering, Computer Science, Information Technology, Pharmacy, Biotechnology, Environmental Science, Architecture and other STEM-related programmes', 'Pelajar dari Aliran Sains boleh memohon untuk kursus universiti seperti Perubatan, Kejuruteraan, Sains Komputer, Teknologi Maklumat, Farmasi, Bioteknologi, Sains Alam Sekitar, Seni Bina dan program berkaitan STEM yang lain.'),
(7, 'What can I do with STEM in the future?', 'Apa yang boleh saya lakukan dengan STEM pada masa hadapan?', 'You can become a scientist, engineer, doctor, programmer, or even start your own tech company! STEM careers are creative and high in demand.', 'Anda boleh menjadi saintis, jurutera, doktor, pengaturcara atau memulakan syarikat teknologi anda sendiri! Kerjaya STEM adalah kreatif dan mendapat permintaan tinggi.'),
(8, 'What careers can I pursue if I take STEM subjects?', 'Apakah kerjaya yang boleh saya ceburi jika saya mengambil subjek STEM?', 'Students who take STEM subjects can pursue careers such as doctor, engineer, pharmacist, software developer, data analyst, scientist, architect, environmental specialist and many other high-demand professions.', 'Pelajar yang mengambil subjek STEM boleh meneruskan kerjaya seperti doktor, jurutera, ahli farmasi, pembangun perisian, penganalisis data, saintis, arkitek, pakar alam sekitar dan pelbagai profesion lain yang mempunyai permintaan tinggi.'),
(9, 'Why is math important in STEM', 'Mengapa matematik penting dalam STEM', 'Math helps us count, measure and solve a problem', 'Matematik membantu kita mengira, mengukur dan menyelesaikan masalah'),
(10, 'Is STEM difficult to study?', 'Adakah STEM sukar untuk dipelajari?', 'STEM subjects may be challenging, but with consistent effort, interest and practice, students can understand the concepts and develop strong problem-solving and critical thinking skills.', 'Subjek STEM mungkin mencabar, tetapi dengan usaha, minat dan latihan yang konsisten, pelajar dapat memahami konsep dan mengembangkan kemahiran penyelesaian masalah dan pemikiran kritis yang kuat.');

-- --------------------------------------------------------

--
-- Table structure for table `stem_highlight`
--

CREATE TABLE `stem_highlight` (
  `highlight_id` int(11) NOT NULL,
  `highlight_title_en` varchar(255) NOT NULL,
  `highlight_title_ms` varchar(255) NOT NULL,
  `highlight_desc_en` text NOT NULL,
  `highlight_desc_ms` text NOT NULL,
  `highlight_type` enum('image','video','','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stem_highlight`
--

INSERT INTO `stem_highlight` (`highlight_id`, `highlight_title_en`, `highlight_title_ms`, `highlight_desc_en`, `highlight_desc_ms`, `highlight_type`) VALUES
(1, 'Real-Life Impact of STEM', 'Kesan STEM dalam Kehidupan Sebenar', 'STEM helps solve real-world problems such as climate change, disease prevention, clean water supply, and sustainable cities.\r\nFor example, engineers design eco-friendly buildings, scientists develop vaccines, and data experts analyze information to improve decision-making.\r\nBy studying STEM, students can contribute to building a better future for society.', 'STEM membantu menyelesaikan masalah dunia sebenar seperti perubahan iklim, pencegahan penyakit, bekalan air bersih dan bandar yang mampan.\r\nContohnya, jurutera mereka bentuk bangunan mesra alam, saintis membangunkan vaksin dan pakar data menganalisis maklumat untuk meningkatkan proses membuat keputusan.\r\nDengan mempelajari STEM, pelajar boleh menyumbang kepada pembinaan masa depan yang lebih baik untuk masyarakat.\r\n', 'image'),
(2, 'STEM and Future Technology', 'STEM dan Teknologi Masa Depan', 'STEM plays an important role in developing future technologies such as:\r\nArtificial Intelligence (AI)\r\nRobotics\r\nRenewable Energy\r\nSpace Exploration\r\nMedical Technology\r\nStudents who choose STEM today may become the innovators and leaders of tomorrow’s world', 'STEM memainkan peranan penting dalam membangunkan teknologi masa hadapan seperti:\r\nKecerdasan Buatan (AI)\r\nRobotik\r\nTenaga Boleh Diperbaharui\r\nPenerokaan Angkasa Lepas\r\nTeknologi Perubatan\r\nPelajar yang memilih STEM hari ini boleh menjadi inovator dan pemimpin dunia masa hadapan', 'image'),
(3, 'From Kampung to NASA – The Journey of Sheikh Muszaphar', 'Dari Kampung ke NASA – Perjalanan Sheikh Muszaphar', 'Sheikh Muszaphar Shukor was the first Malaysian astronaut. He was born in Kuala Lumpur and studied medicine before becoming a spaceflight participant.\r\nIn 2007, he traveled to space through a mission organized by the Russian space agency. His journey shows that with education, discipline, and strong interest in science, Malaysians can achieve international success.\r\nHis achievement inspires many students to pursue careers in science, medicine, and space technology.', 'Sheikh Muszaphar Shukor merupakan angkasawan Malaysia yang pertama. Beliau dilahirkan di Kuala Lumpur dan belajar perubatan sebelum menjadi peserta penerbangan angkasa lepas.\r\nPada tahun 2007, beliau mengembara ke angkasa lepas melalui misi yang dianjurkan oleh agensi angkasa lepas Rusia. Perjalanannya menunjukkan bahawa dengan pendidikan, disiplin dan minat yang mendalam terhadap sains, rakyat Malaysia boleh mencapai kejayaan di peringkat antarabangsa.\r\nPencapaiannya memberi inspirasi kepada ramai pelajar untuk meneruskan kerjaya dalam sains, perubatan dan teknologi angkasa lepas.', 'image'),
(4, 'High-Demand Tech Career: Software Developer', 'Kerjaya Teknologi Permintaan Tinggi: Pembangun Perisian', 'Software developers create programs, apps, and systems that power mobile phones, computers, and smart devices. This job is in high demand in Malaysia and around the world.\r\nBecause technology is used everywhere — in banking, entertainment, healthcare, education, and more — companies are always looking for skilled developers. Graduates with skills in coding, problem-solving, and software design often find jobs quickly after university.\r\nEntry-level salaries for software developers in Malaysia are competitive, and with experience, professionals can earn even more, especially in big tech companies or startups', 'Pembangun perisian mencipta program, aplikasi dan sistem yang menguasakan telefon bimbit, komputer dan peranti pintar. Pekerjaan ini mendapat permintaan tinggi di Malaysia dan di seluruh dunia.\r\nOleh kerana teknologi digunakan di mana-mana sahaja — dalam perbankan, hiburan, penjagaan kesihatan, pendidikan dan banyak lagi — syarikat sentiasa mencari pembangun yang mahir. Graduan yang mempunyai kemahiran dalam pengekodan, penyelesaian masalah dan reka bentuk perisian sering mendapat pekerjaan dengan cepat selepas tamat pengajian universiti.\r\nGaji peringkat permulaan untuk pembangun perisian di Malaysia adalah kompetitif, dan dengan pengalaman, profesional boleh mendapat lebih banyak pendapatan, terutamanya dalam syarikat teknologi besar atau syarikat baharu.', 'image');

-- --------------------------------------------------------

--
-- Table structure for table `stem_highlight_media`
--

CREATE TABLE `stem_highlight_media` (
  `media_id` int(11) NOT NULL,
  `highlight_id` int(11) NOT NULL,
  `media_url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stem_highlight_media`
--

INSERT INTO `stem_highlight_media` (`media_id`, `highlight_id`, `media_url`) VALUES
(1, 1, 'assets/highlight/highlight1.png'),
(2, 2, 'assets/highlight/highlight2.png'),
(3, 3, 'assets/highlight/highlight3.jpg'),
(4, 4, 'assets/highlight/highlight4.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `stem_info`
--

CREATE TABLE `stem_info` (
  `info_id` int(11) NOT NULL,
  `info_title_en` varchar(255) NOT NULL,
  `info_title_ms` varchar(255) NOT NULL,
  `info_desc_en` text NOT NULL,
  `info_desc_ms` text NOT NULL,
  `info_type` enum('image','video','','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stem_info`
--

INSERT INTO `stem_info` (`info_id`, `info_title_en`, `info_title_ms`, `info_desc_en`, `info_desc_ms`, `info_type`) VALUES
(1, 'What is STEM?', 'Apakah STEM?', 'STEM stands for Science, Technology, Engineering, and Mathematics. These four subjects work together to help us understand the world and solve real-life problems.\r\nScience helps us explore how things work.\r\nTechnology allows us to create tools and systems.\r\nEngineering helps us design and build solutions.\r\nMathematics helps us calculate, measure, and analyze data.\r\nAfter Form 3, choosing the STEM stream means you will study subjects like Additional Mathematics, Physics, Chemistry, and Biology. These subjects prepare you for future careers in high-demand industries.\r\n', 'STEM bermaksud Sains, Teknologi, Kejuruteraan dan Matematik. Keempat-empat subjek ini bekerjasama untuk membantu kita memahami dunia dan menyelesaikan masalah kehidupan sebenar.\r\nSains membantu kita meneroka cara sesuatu berfungsi.\r\nTeknologi membolehkan kita mencipta alatan dan sistem.\r\nKejuruteraan membantu kita mereka bentuk dan membina penyelesaian.\r\nMatematik membantu kita mengira, mengukur dan menganalisis data.\r\nSelepas Tingkatan 3, memilih aliran STEM bermakna anda akan mempelajari subjek seperti Matematik Tambahan, Fizik, Kimia dan Biologi. Subjek-subjek ini menyediakan anda untuk kerjaya masa depan dalam industri yang mempunyai permintaan tinggi.\r\n', 'image'),
(2, 'Why Choose the STEM Stream After Form 3?', 'Mengapa Memilih Aliran STEM Selepas Tingkatan 3?', 'After completing Form 3, students can choose between Arts or STEM streams in upper secondary school.\r\nChoosing STEM opens more opportunities for university courses and future careers. Many professional fields such as medicine, engineering, data science, architecture, and computer science require a strong foundation in STEM subjects.\r\nIf you enjoy problem-solving, experiments, technology, or building things, STEM might be the right choice for you.\r\n', 'Selepas tamat Tingkatan 3, pelajar boleh memilih antara aliran Sastera atau STEM di sekolah menengah atas.\r\nMemilih STEM membuka lebih banyak peluang untuk kursus universiti dan kerjaya masa depan. Banyak bidang profesional seperti perubatan, kejuruteraan, sains data, seni bina dan sains komputer memerlukan asas yang kukuh dalam subjek STEM.\r\nJika anda gemar menyelesaikan masalah, eksperimen, teknologi atau membina sesuatu, STEM mungkin pilihan yang tepat untuk anda.\r\n', 'image'),
(3, 'Subjects in the STEM Stream', 'Subjek dalam Aliran STEM', 'When you choose the STEM stream after Form 3, you may study:\r\nAdditional Mathematics\r\nPhysics\r\nChemistry\r\nBiology\r\nComputer Science\r\nThese subjects may seem challenging at first, but they help develop critical thinking, logical reasoning, and analytical skills. With consistent practice and effort, students can succeed and build strong academic foundations.\r\n', 'Apabila anda memilih aliran STEM selepas Tingkatan 3, anda boleh mempelajari:\r\nMatematik Tambahan\r\nFizik\r\nKimia\r\nBiologi\r\nSains Komputer\r\nSubjek-subjek ini mungkin kelihatan mencabar pada mulanya, tetapi ia membantu membangunkan pemikiran kritis, penaakulan logik dan kemahiran analitikal. Dengan latihan dan usaha yang konsisten, pelajar boleh berjaya dan membina asas akademik yang kukuh.\r\n', 'image'),
(4, 'STEM Career Opportunities', 'Peluang Kerjaya STEM', 'STEM graduates are in high demand worldwide. Some popular STEM careers include:\r\nDoctor\r\nEngineer\r\nSoftware Developer\r\nData Analyst\r\nScientist\r\nArchitect\r\nThese careers often offer strong job stability, good salary potential, and opportunities to work internationally.', 'Graduan STEM mendapat permintaan tinggi di seluruh dunia. Antara kerjaya STEM yang popular termasuk:\r\nDoktor\r\nJurutera\r\nPembangun Perisian\r\nPenganalisis Data\r\nSaintis\r\nArkitek\r\nKerjaya ini selalunya menawarkan kestabilan pekerjaan yang kukuh, potensi gaji yang baik dan peluang untuk bekerja di peringkat antarabangsa.\r\n', 'image'),
(5, 'Activities STEM You Can Do at Home - Build a Simple Water Filter', 'Aktiviti STEM Yang Boleh Anda Lakukan di Rumah - Bina Penapis Air Mudah', 'You can build a simple water filter using a plastic bottle, sand, small stones, and cotton.\r\nClean water is very important for human health. In real life, water treatment plants use multiple layers of filtration to remove dirt and harmful particles.\r\nEach layer in your filter has a function:\r\nStones trap larger particles like leaves or large dirt pieces.\r\nSand traps smaller particles.\r\nCotton acts as a final filter to catch fine particles.\r\nThe water that comes out should look clearer than before. However, it is important to remember that this filtered water is NOT safe to drink because harmful bacteria may still be present.\r\n', 'Anda boleh membina penapis air mudah menggunakan botol plastik, pasir, batu kecil dan kapas.\r\nAir bersih sangat penting untuk kesihatan manusia. Dalam kehidupan sebenar, loji rawatan air menggunakan pelbagai lapisan penapisan untuk membuang kotoran dan zarah berbahaya.\r\nSetiap lapisan dalam penapis anda mempunyai fungsi:\r\nBatu memerangkap zarah yang lebih besar seperti daun atau kepingan kotoran besar.\r\nPasir memerangkap zarah yang lebih kecil.\r\nKapas bertindak sebagai penapis terakhir untuk menangkap zarah halus.\r\nAir yang keluar sepatutnya kelihatan lebih jernih daripada sebelumnya. Walau bagaimanapun, adalah penting untuk diingat bahawa air yang ditapis ini TIDAK selamat untuk diminum kerana bakteria berbahaya mungkin masih ada.\r\n', 'video');

-- --------------------------------------------------------

--
-- Table structure for table `stem_info_media`
--

CREATE TABLE `stem_info_media` (
  `media_id` int(11) NOT NULL,
  `info_id` int(11) NOT NULL,
  `media_url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stem_info_media`
--

INSERT INTO `stem_info_media` (`media_id`, `info_id`, `media_url`) VALUES
(1, 1, 'assets/info/info1.jpg'),
(2, 2, 'assets/info/info2.png'),
(3, 3, 'assets/info/info3.jpg'),
(4, 4, 'assets/info/info4.jpg'),
(5, 5, 'assets/info/info5.mp4');

-- --------------------------------------------------------

--
-- Table structure for table `stem_learning`
--

CREATE TABLE `stem_learning` (
  `learning_id` int(11) NOT NULL,
  `learning_title_en` varchar(255) NOT NULL,
  `learning_title_ms` varchar(255) NOT NULL,
  `learning_subject_en` varchar(255) NOT NULL,
  `learning_subject_ms` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stem_learning`
--

INSERT INTO `stem_learning` (`learning_id`, `learning_title_en`, `learning_title_ms`, `learning_subject_en`, `learning_subject_ms`) VALUES
(1, 'Chapter 1-Stimuli & Responses', 'Bab 1-Rangsangan & Gerak Balas', 'Science', 'Sains'),
(2, 'Chapter 2-Respiration', 'Bab 2-Respirasi', 'Science', 'Sains'),
(3, 'Chapter 3-Transportation', 'Bab 3-Pengangkutan', 'Science', 'Sains'),
(4, 'Chapter 4-Reactivity of Metals', 'Bab 4-Kereaktifan Logam', 'Science', 'Sains'),
(5, 'Chapter 5-Thermochemistry', 'Bab 5-Termokimia', 'Science', 'Sains'),
(6, 'Chapter 6-Electricity & Magnetism', 'Bab 6-Elektrik & Kemagnetan', 'Science', 'Sains'),
(7, 'Chapter 7-Energy & Power', 'Bab 7-Tenaga & Kuasa', 'Science', 'Sains'),
(8, 'Chapter 8-Radioactivity', 'Bab 8-Keradioaktifan', 'Science', 'Sains'),
(9, 'Chapter 9-Space Weather', 'Bab 9-Cuaca Angkasa Lepas', 'Science', 'Sains'),
(10, 'Chapter 10-Space Exploration', 'Bab 10-Penerokaan Angkasa Lepas', 'Science', 'Sains'),
(11, 'Chapter 1-Indices', 'Bab 1-Indeks', 'Mathematics', 'Matematik'),
(12, 'Chapter 2-Standard Form', 'Bab 2-Bentuk Piawai', 'Mathematics', 'Matematik'),
(13, 'Chapter 3-Savings & Investments, Credit & Debit', 'Bab 3-Simpanan & Pelaburan, Kredit & Hutang', 'Mathematics', 'Matematik'),
(14, 'Chapter 4-Scale Drawings', 'Bab 4-Lukisan Berskala', 'Mathematics', 'Matematik'),
(15, 'Chapter 5-Trigonometric Ratios', 'Bab 5-Nisbah Trigonometri', 'Mathematics', 'Matematik'),
(16, 'Chapter 6-Angles & Tangents of Circle', 'Bab 6-Sudut & Tangen Bulatan', 'Mathematics', 'Matematik'),
(17, 'Chapter 7-Plans & Elevation', 'Bab 7-Pelan & Dongakan', 'Mathematics', 'Matematik'),
(18, 'Chapter 8-Loci in 2 Dimensions', 'Bab 8-Lokus dalam 2 Dimensi', 'Mathematics', 'Matematik'),
(19, 'Chapter 9-Straight Lines', 'Bab 9-Garis Lurus', 'Mathematics', 'Matematik'),
(20, 'Chapter 1-Basic Concepts of Computer Thinking', 'Bab 1-Konsep Asas Pemikiran Komputer', 'Fundamentals of Computer Science', 'Asas Sains Komputer'),
(21, 'Chapter 2-Data Representation', 'Bab 2-Perwakilan Data', 'Fundamentals of Computer Science', 'Asas Sains Komputer'),
(22, 'Chapter 3-Algorithm', 'Bab 3-Algoritma', 'Fundamentals of Computer Science', 'Asas Sains Komputer'),
(23, 'Chapter 4-Instruction Code', 'Bab 4-Kod Arahan', 'Fundamentals of Computer Science', 'Asas Sains Komputer'),
(24, 'Chapter 1-Mechatronics Design', 'Bab 1-Reka Bentuk Mekatronik', 'Design And Technology', 'Reka Bentuk Dan Teknologi'),
(25, 'Chapter 2-Product Production', 'Bab 2-Penghasilan Produk', 'Design And Technology', 'Reka Bentuk Dan Teknologi'),
(26, 'Chapter 3-Design as a Marketing Instrument', 'Bab 3-Reka Bentuk sebagai Isturement Pemasaran', 'Design And Technology', 'Reka Bentuk Dan Teknologi');

-- --------------------------------------------------------

--
-- Table structure for table `stem_learning_page`
--

CREATE TABLE `stem_learning_page` (
  `page_id` int(11) NOT NULL,
  `learning_id` int(11) NOT NULL,
  `page_title_en` text NOT NULL,
  `page_title_ms` text NOT NULL,
  `page_desc_en` text NOT NULL,
  `page_desc_ms` text NOT NULL,
  `page_order` int(11) NOT NULL,
  `bookmark` enum('yes','no','','') NOT NULL DEFAULT 'no'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stem_learning_page`
--

INSERT INTO `stem_learning_page` (`page_id`, `learning_id`, `page_title_en`, `page_title_ms`, `page_desc_en`, `page_desc_ms`, `page_order`, `bookmark`) VALUES
(1, 1, '1.1 Human Nervous System', '1.1 Sistem Saraf Manusia', 'The human nervous system consists of : \r\nCentral nervous system\r\nPeripheral nervous system', 'Sistem saraf manusia terdiri daripada:\r\nSistem saraf pusat\r\nSistem saraf periferal', 1, 'yes'),
(2, 1, 'The importance of human nervous system', 'Kepentingan sistem saraf manusia', 'Detect stimuli\r\nSending information in the form of impulses\r\nInterpreting impulses\r\nGenerate appropriate response', 'Mengesan rangsangan\r\nMenghantar maklumat dalam bentuk impuls\r\nMentafsir impuls\r\nMenjana tindak balas yang sesuai', 2, 'yes'),
(3, 1, 'Reactions to Voluntary actions and Involuntary actions ', 'Reaksi terhadap Tindakan Sukarela dan Tindakan Tanpa Sukarela', 'Voluntary actions is an action that is realised and done according to someone’s will.\r\nInvoluntary actions is an action that happens immediately without realising it or thinking about it', 'Tindakan sukarela adalah tindakan yang direalisasikan dan dilakukan mengikut kehendak seseorang.\r\nTindakan tidak sukarela adalah tindakan yang berlaku serta-merta tanpa disedari atau difikirkan', 3, 'no'),
(4, 1, '1.2 Stimuli and Response in Humans', '1.2 Rangsangan dan Gerak Balas dalam Manusia', 'Humans have five sense organs namely eyes,ears, nose, skin and tongue.\r\nStimulus is a change in the environment that can be detected by receptors. Example: light, sound, heat, smell.\r\nResponse is action taken by the body after detecting a stimulus.\r\nPathway of Impulse : Stimulus → Receptor → Sensory neuron → CNS → Motor neuron → Effector → Response.', 'Manusia mempunyai lima organ deria iaitu mata, telinga, hidung, kulit dan lidah.\r\nRangsangan ialah perubahan persekitaran yang boleh dikesan oleh reseptor. Contoh: cahaya, bunyi, haba, bau.\r\nGerak balas ialah tindakan yang diambil oleh badan selepas mengesan rangsangan.\r\nLaluan Impuls: Rangsangan → Reseptor → Neuron deria → SSP → Neuron motor → Efektor → Gerak balas.', 4, 'no'),
(5, 1, 'Eyes', 'Mata', 'The retina contains 2 types of photoreceptors;\r\nrod cells - sensitive to different intensities of light.\r\ncone cells - sensitive to the color of light in bright conditions', 'Retina mengandungi 2 jenis fotoreseptor;\r\nsel rod - sensitif terhadap keamatan cahaya yang berbeza.\r\nsel kon - sensitif terhadap warna cahaya dalam keadaan terang', 5, 'no');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `learning_media`
--
ALTER TABLE `learning_media`
  ADD PRIMARY KEY (`media_id`);

--
-- Indexes for table `stem_faq`
--
ALTER TABLE `stem_faq`
  ADD PRIMARY KEY (`faq_id`);

--
-- Indexes for table `stem_highlight`
--
ALTER TABLE `stem_highlight`
  ADD PRIMARY KEY (`highlight_id`);

--
-- Indexes for table `stem_highlight_media`
--
ALTER TABLE `stem_highlight_media`
  ADD PRIMARY KEY (`media_id`);

--
-- Indexes for table `stem_info`
--
ALTER TABLE `stem_info`
  ADD PRIMARY KEY (`info_id`);

--
-- Indexes for table `stem_info_media`
--
ALTER TABLE `stem_info_media`
  ADD PRIMARY KEY (`media_id`);

--
-- Indexes for table `stem_learning`
--
ALTER TABLE `stem_learning`
  ADD PRIMARY KEY (`learning_id`);

--
-- Indexes for table `stem_learning_page`
--
ALTER TABLE `stem_learning_page`
  ADD PRIMARY KEY (`page_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `learning_media`
--
ALTER TABLE `learning_media`
  MODIFY `media_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `stem_faq`
--
ALTER TABLE `stem_faq`
  MODIFY `faq_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `stem_highlight`
--
ALTER TABLE `stem_highlight`
  MODIFY `highlight_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `stem_highlight_media`
--
ALTER TABLE `stem_highlight_media`
  MODIFY `media_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `stem_info`
--
ALTER TABLE `stem_info`
  MODIFY `info_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `stem_info_media`
--
ALTER TABLE `stem_info_media`
  MODIFY `media_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `stem_learning`
--
ALTER TABLE `stem_learning`
  MODIFY `learning_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `stem_learning_page`
--
ALTER TABLE `stem_learning_page`
  MODIFY `page_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
