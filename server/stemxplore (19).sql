-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 06, 2026 at 06:32 PM
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
-- Table structure for table `career_field`
--

CREATE TABLE `career_field` (
  `field_id` int(11) NOT NULL,
  `field_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `career_field`
--

INSERT INTO `career_field` (`field_id`, `field_name`) VALUES
(1, 'Science'),
(2, 'Techonology'),
(3, 'Engineering'),
(4, 'Mathematics');

-- --------------------------------------------------------

--
-- Table structure for table `career_job`
--

CREATE TABLE `career_job` (
  `job_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `job_title_en` varchar(255) NOT NULL,
  `desc_en` varchar(255) NOT NULL,
  `desc_ms` varchar(255) NOT NULL,
  `image` varchar(200) NOT NULL,
  `job_title_ms` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `career_job`
--

INSERT INTO `career_job` (`job_id`, `field_id`, `job_title_en`, `desc_en`, `desc_ms`, `image`, `job_title_ms`) VALUES
(1, 1, 'Biologist', 'Study living organisms', 'Kaji organisma hidup', 'assets/career/science/biologist.png', 'Ahli biologi'),
(2, 2, 'Software Developer', 'Create applications and systems', 'Cipta aplikasi dan sistem', 'assets/career/technology/software.png', 'Pembangun Perisian'),
(3, 3, 'Civil Engineer', 'Design buildings and infrastructure', 'Reka bentuk bangunan dan infrastruktur', 'assets/career/engineering/civileng.png', 'Jurutera Awam'),
(4, 4, 'Data Scientist', 'Analyze data using mathematics', 'Menganalisis data menggunakan matematik', '', 'Saintis Data'),
(5, 1, 'Chemist', 'Works with chemicals in laboratories, pharmaceuticals, or manufacturing.', 'bekerja dengan bahan kimia di makmal, farmaseutikal atau pembuatan.', 'assets/career/science/chemistry.png', 'Ahli kimia'),
(6, 1, 'Microbiologist', 'Studies microorganisms like bacteria and viruses.', 'mengkaji mikroorganisma seperti bakteria dan virus.', 'assets/career/science/micro.png', 'Ahli mikrobiologi'),
(7, 1, 'Food Scientist', 'Develops and improves food safety and food production.', 'membangun dan menambah baik keselamatan makanan dan pengeluaran makanan.', 'assets/career/science/food.png', 'Saintis Makanan'),
(8, 2, 'Web Developer', 'Develops websites using HTML, CSS, PHP, JavaScript.', 'membangunkan laman web menggunakan HTML, CSS, PHP, JavaScript.', 'assets/career/technology/web.png', 'Pembangun Web'),
(9, 2, 'Cybersecurity Analyst', 'Protects systems from hackers and cyber threats.', 'melindungi sistem daripada penggodam dan ancaman siber.', 'assets/career/technology/cyber.png', 'Penganalisis Keselamatan Siber'),
(10, 2, 'AI / Machine Learning Engineer', 'Develops artificial intelligence systems.', 'membangunkan sistem kecerdasan buatan.', 'assets/career/technology/ai.png', 'Jurutera AI / Pembelajaran Mesin'),
(11, 3, 'Mechanical Engineer', 'Designs machines, engines, and mechanical systems', 'mereka bentuk mesin, enjin dan sistem mekanikal', 'assets/career/engineering/mechanicaleng.png', 'Jurutera Mekanikal'),
(12, 3, 'Aerospace Engineer', 'Designs aircraft and space technologies', 'mereka bentuk teknologi pesawat dan angkasa lepas', 'assets/career/engineering/aeroeng.png', 'Jurutera Aeroangkasa'),
(13, 3, 'Electrical Engineer\r\n', 'Works with electrical systems, power grids, and electronics', 'berfungsi dengan sistem elektrik, grid kuasa dan elektronik', 'assets/career/engineering/electriceng.png', 'Jurutera Elektrik'),
(14, 4, 'Data Scientist', 'Collects and analyzes numerical data for research or government.', 'mengumpul dan menganalisis data berangka untuk penyelidikan atau kerajaan.', '', 'Ahli Statistik'),
(15, 4, 'Mathematics Lecturer/Teacher', 'Teaches mathematics at school or university', 'mengajar matematik di sekolah atau universiti', '', 'Pensyarah/Guru Matematik'),
(16, 4, 'Quantitative Analyst', 'Uses mathematics to predict financial markets', 'menggunakan matematik untuk meramalkan pasaran kewangan', '', 'Penganalisis Kuantitatif');

-- --------------------------------------------------------

--
-- Table structure for table `career_qustion`
--

CREATE TABLE `career_qustion` (
  `cquestion_id` int(11) NOT NULL,
  `cquestion_en` varchar(255) NOT NULL,
  `cquestion_ms` varchar(255) NOT NULL,
  `option1_en` varchar(255) NOT NULL,
  `option1_ms` varchar(255) NOT NULL,
  `option1_field` varchar(255) NOT NULL,
  `option2_en` varchar(255) NOT NULL,
  `option2_ms` varchar(255) NOT NULL,
  `option2_field` varchar(255) NOT NULL,
  `option3_en` varchar(255) NOT NULL,
  `option3_ms` varchar(255) NOT NULL,
  `option3_field` varchar(255) NOT NULL,
  `option4_en` varchar(255) NOT NULL,
  `option4_ms` varchar(255) NOT NULL,
  `option4_field` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `career_qustion`
--

INSERT INTO `career_qustion` (`cquestion_id`, `cquestion_en`, `cquestion_ms`, `option1_en`, `option1_ms`, `option1_field`, `option2_en`, `option2_ms`, `option2_field`, `option3_en`, `option3_ms`, `option3_field`, `option4_en`, `option4_ms`, `option4_field`) VALUES
(1, 'Which activity do you enjoy the most?', 'Aktiviti mana yang paling anda suka?', 'Doing science experiments', 'Melakukan eksperimen sains', '1', 'Programming a computer', 'Memprogram komputer', '2', 'Building machines', 'Membina mesin', '3', 'Solving math puzzles', 'Menyelesaikan teka-teki matematik', '4'),
(2, 'Which school subject do you like the most?', 'Subjek sekolah mana yang paling anda suka?', 'Biology or Chemistry', 'Biologi atau Kimia', '1', 'Computer studies', 'Pengajian komputer', '2', 'Design and Technology', 'Reka Bentuk dan Teknologi', '3', 'Mathematics', 'Matematik', '4'),
(3, 'What type of problem do you enjoy solving?', 'Jenis masalah apa yang anda suka selesaikan?', 'Understanding nature', 'Memahami alam semula jadi', '1', 'Creating software', 'Mencipta perisian', '2', 'Fixing machines', 'Membaiki mesin', '3', 'Working with numbers', 'Bekerja dengan nombor', '4'),
(4, 'Which activity sounds most interesting?', 'Aktiviti mana paling menarik?', 'Researching animals', 'Mengkaji haiwan', '1', 'Developing mobile apps', 'Membangunkan aplikasi mudah alih', '2', 'Designing bridges', 'Mereka bentuk jambatan', '3', 'Analyzing data', 'Menganalisis data', '4'),
(5, 'What would you enjoy doing in the future?', 'Apa yang anda suka lakukan pada masa depan?', 'Working in a laboratory', 'Bekerja di makmal', '1', 'Creating websites', 'Mencipta laman web', '2', 'Designing robots', 'Mereka bentuk robot', '3', 'Becoming a statistician', 'Menjadi ahli statistik', '4'),
(6, 'Which task sounds most fun?', 'Tugasan mana paling menyeronokkan?', 'Studying plants', 'Mengkaji tumbuhan', '1', 'Building software', 'Membina perisian', '2', 'Constructing buildings', 'Membina bangunan', '3', 'Calculating probabilities', 'Mengira kebarangkalian', '4');

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
(5, 'image', 'assets/learning/science/chap1/page5.png', 5),
(6, 'image', 'assets/learning/math/mtchap2.png', 6),
(7, 'image', 'assets/learning/math/mtchap1.png', 7),
(8, 'image', 'assets/learning/science/chap2pro.png', 8),
(9, 'image', 'assets/learning/science/chap3pro.png', 9),
(10, 'image', 'assets/learning/science/chap4pro.png', 10),
(11, 'image', 'assets/learning/science/chap5.png', 11),
(12, 'image', 'assets/learning/science/chap6.png', 12),
(13, 'image', 'assets/learning/science/chap7.png', 13),
(14, 'image', 'assets/learning/science/chap8.png', 14),
(15, 'image', 'assets/learning/science/chap9pro.png', 15),
(16, 'image', 'assets/learning/science/chap10pro.png', 16),
(17, 'image', 'assets/learning/math/mtchap3.png', 17),
(18, 'image', 'assets/learning/math/mtchap4.png', 18),
(19, 'image', 'assets/learning/math/mtchap5.png', 19),
(20, 'image', 'assets/learning/math/mtchap6.png', 20),
(21, 'image', 'assets/learning/math/mtchap7.png', 21),
(22, 'image', 'assets/learning/math/mtchap8.png', 22),
(23, 'image', 'assets/learning/math/mtchap9.png', 23),
(24, 'image', 'assets/learning/rbt/rbtchap1.png', 24),
(25, 'image', 'assets/learning/rbt/rbtchap2.png', 25),
(26, 'image', 'assets/learning/rbt/rbtchap3.png', 26),
(27, 'image', 'assets/learning/ask/askchap1.png', 27),
(28, 'image', 'assets/learning/ask/askchap2.png', 28),
(29, 'image', 'assets/learning/ask/askchap3.png', 29),
(30, 'image', 'assets/learning/ask/askchap4.png', 30);

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
(5, 1, 'Eyes', 'Mata', 'The retina contains 2 types of photoreceptors;\r\nrod cells - sensitive to different intensities of light.\r\ncone cells - sensitive to the color of light in bright conditions', 'Retina mengandungi 2 jenis fotoreseptor;\r\nsel rod - sensitif terhadap keamatan cahaya yang berbeza.\r\nsel kon - sensitif terhadap warna cahaya dalam keadaan terang', 5, 'no'),
(6, 11, 'Index Notation', 'Tatatanda Indeks', '', '\n', 1, 'no'),
(7, 12, 'Standard Form', 'Bentuk Piawai', '', '', 2, 'no'),
(8, 2, 'Respiration', 'Respirasi', '', '', 1, 'no'),
(9, 3, 'Transportation', 'Pengangkutan', '', '', 1, 'no'),
(10, 4, 'Reactivity of Metals', 'Kereaktifan Logam', '', '', 1, 'yes'),
(11, 5, 'Thermochemistry', 'Termokimia', '', '', 1, 'no'),
(12, 6, 'Electricity & Magnetism', 'Elektrik & Kemagnetan', '', '', 1, 'no'),
(13, 7, 'Energy & Power', 'Tenaga & Kuasa', '', '', 1, 'no'),
(14, 8, 'Radioactivity', 'Keradioaktifan', '', '', 1, 'no'),
(15, 9, 'Space Weather', 'Cuaca Angkasa Lepas', '', '', 1, 'no'),
(16, 10, 'Space Exploration', 'Penerokaan Angkasa Lepas', '', '', 1, 'no'),
(17, 13, 'Savings & Investments, Credit & Debit', 'Simpanan & Pelaburan, Kredit & Hutang', '', '', 1, 'no'),
(18, 14, 'Scale Drawings', 'Lukisan Berskala', '', '', 1, 'no'),
(19, 15, 'Trigonometric Ratios', 'Nisbah Trigonometri', '', '', 1, 'no'),
(20, 16, 'Angles & Tangents of Circle', 'Sudut & Tangen Bulatan', '', '', 1, 'no'),
(21, 17, 'Plans & Elevation', 'Pelan & Dongakan', '', '', 1, 'no'),
(22, 18, 'Loci in 2 Dimensions', 'Lokus dalam 2 Dimensi', '', '', 1, 'no'),
(23, 19, 'Straight Lines', 'Garis Lurus', '', '', 1, 'no'),
(24, 24, 'Mechatronics Design', 'Reka Bentuk Mekatronik', '', '', 1, 'no'),
(25, 25, 'Product Production', 'Penghasilan Produk', '', '', 1, 'no'),
(26, 26, 'Design as a Marketing Instrument', 'Reka Bentuk sebagai Isturement Pemasaran', '', '', 1, 'no'),
(27, 20, 'Basic Concepts of Computer Thinking', 'Konsep Asas Pemikiran Komputer', '', '', 1, 'no'),
(28, 21, 'Data Representation', 'Perwakilan Data', '', '', 1, 'no'),
(29, 22, 'Algorithm', 'Algoritma', '', '', 1, 'no'),
(30, 23, 'Instruction Code', 'Kod Arahan', '', '', 1, 'no');

-- --------------------------------------------------------

--
-- Table structure for table `stem_quiz`
--

CREATE TABLE `stem_quiz` (
  `quiz_id` int(11) NOT NULL,
  `quiz_title_en` varchar(255) NOT NULL,
  `quiz_title_ms` varchar(255) NOT NULL,
  `quiz_subject_en` varchar(255) NOT NULL,
  `quiz_subject_ms` varchar(255) NOT NULL,
  `quiz_total_question` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stem_quiz`
--

INSERT INTO `stem_quiz` (`quiz_id`, `quiz_title_en`, `quiz_title_ms`, `quiz_subject_en`, `quiz_subject_ms`, `quiz_total_question`) VALUES
(1, 'Chapter 1-Stimuli and Responses', 'Bab 1-Rangsangan dan Gerak Balas', 'Science', 'Sains', 5),
(2, 'Chapter 1-Algebra', 'Bab 1-Algebra', 'Mathematics', 'Matematik', 5),
(3, 'Chapter 2-Respiration', 'Bab 2-Respirasi', 'Science', 'Sains', 10),
(4, 'Chapter 3-Transportation', 'Bab 3-Pengangkutan', 'Science', 'Sains', 10),
(5, 'Chapter 4-Reactivity of Metals', 'Bab 4-Kereaktifan Logam', 'Science', 'Sains', 10),
(6, 'Chapter 5-Thermochemistry', 'Bab 5-Termokimia', 'Science', 'Sains', 10),
(7, 'Chapter 6-Electricity & Magnetism', 'Bab 6-Elektrik & Kemagnetan', 'Science', 'Sains', 10),
(8, 'Chapter 7-Energy & Power', 'Bab 7-Tenaga & Kuasa', 'Science', 'Sains', 10),
(9, 'Chapter 8-Radioactivity', 'Bab 8-Keradioaktifan', 'Science', 'Sains', 10),
(10, 'Chapter 9-Space Weather', 'Bab 9-Cuaca Angkasa Lepas', 'Science', 'Sains', 10),
(11, 'Chapter 10-Space Exploration', 'Bab 10-Penerokaan Angkasa Lepas', 'Science', 'Sains', 10),
(12, 'Chapter 2-Standard Form', 'Bab 2-Bentuk Piawai', 'Mathematics', 'Matematik', 10),
(13, 'Chapter 3-Savings & Investments, Credit & Debit', 'Bab 3-Simpanan & Pelaburan, Kredit & Hutang', 'Mathematics', 'Matematik', 10),
(14, 'Chapter 4-Scale Drawings', 'Bab 4-Lukisan Berskala', 'Mathematics', 'Matematik', 10),
(15, 'Chapter 5-Trigonometric Ratios', 'Bab 5-Nisbah Trigonometri', 'Mathematics', 'Matematik', 10),
(16, 'Chapter 6-Angles & Tangents of Circle', 'Bab 6-Sudut & Tangen Bulatan', 'Mathematics', 'Matematik', 10),
(17, 'Chapter 7-Plans & Elevation', 'Bab 7-Pelan & Dongakan', 'Mathematics', 'Matematik', 10),
(18, 'Chapter 8-Loci in 2 Dimensions', 'Bab 8-Lokus dalam 2 Dimensi', 'Mathematics', 'Matematik', 10),
(19, 'Chapter 9-Straight Lines', 'Bab 9-Garis Lurus', 'Mathematics', 'Matematik', 10),
(20, 'Chapter 1-Basic Concepts of Computer Thinking', 'Bab 1-Konsep Asas Pemikiran Komputer', 'Fundamentals of Computer Science', 'Asas Sains Komputer', 10),
(21, 'Chapter 2-Data Representation', 'Bab 2-Perwakilan Data', 'Fundamentals of Computer Science', 'Asas Sains Komputer', 10),
(22, 'Chapter 3-Algorithm', 'Bab 3-Algoritma', 'Fundamentals of Computer Science', 'Asas Sains Komputer', 10),
(23, 'Chapter 4-Instruction Code', 'Bab 4-Kod Arahan', 'Fundamentals of Computer Science', 'Asas Sains Komputer', 10),
(24, 'Chapter 1-Mechatronics Design', 'Bab 1-Reka Bentuk Mekatronik', 'Design And Technology', 'Reka Bentuk Dan Teknologi', 10),
(25, 'Chapter 2-Product Production', 'Bab 2-Penghasilan Produk', 'Design And Technology', 'Reka Bentuk Dan Teknologi', 10),
(26, 'Chapter 3-Design as a Marketing Instrument', 'Bab 3-Reka Bentuk sebagai Isturement Pemasaran', 'Design And Technology', 'Reka Bentuk Dan Teknologi', 10);

-- --------------------------------------------------------

--
-- Table structure for table `stem_quiz_question`
--

CREATE TABLE `stem_quiz_question` (
  `question_id` int(11) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `question_text_en` text NOT NULL,
  `question_text_ms` text NOT NULL,
  `question_image` varchar(255) NOT NULL,
  `opt_a_en` varchar(255) NOT NULL,
  `opt_a_ms` varchar(255) NOT NULL,
  `opt_a_image` varchar(255) NOT NULL,
  `opt_b_en` varchar(255) NOT NULL,
  `opt_b_ms` varchar(255) NOT NULL,
  `opt_b_image` varchar(255) NOT NULL,
  `opt_c_en` varchar(255) NOT NULL,
  `opt_c_ms` varchar(255) NOT NULL,
  `opt_c_image` varchar(255) NOT NULL,
  `opt_d_en` varchar(255) NOT NULL,
  `opt_d_ms` varchar(255) NOT NULL,
  `opt_d_image` varchar(255) NOT NULL,
  `correct_answer_en` varchar(255) NOT NULL,
  `correct_answer_ms` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stem_quiz_question`
--

INSERT INTO `stem_quiz_question` (`question_id`, `quiz_id`, `question_text_en`, `question_text_ms`, `question_image`, `opt_a_en`, `opt_a_ms`, `opt_a_image`, `opt_b_en`, `opt_b_ms`, `opt_b_image`, `opt_c_en`, `opt_c_ms`, `opt_c_image`, `opt_d_en`, `opt_d_ms`, `opt_d_image`, `correct_answer_en`, `correct_answer_ms`) VALUES
(1, 1, 'What is the main function of the human nervous system?', 'Apakah fungsi utama sistem saraf manusia?', '', 'Transport oxygen', 'Mengangkut oksigen', '', 'Control and coordinate body activities', 'Mengawal dan menyelaras aktiviti badan', '', 'Digest food', 'Mencerna makanan', '', 'Produce hormones', 'Menghasilkan hormon', '', 'Control and coordinate body activities', 'Mengawal dan menyelaras aktiviti badan'),
(2, 1, 'Which part of the brain controls balance?', 'Bahagian otak manakah yang mengawal keseimbangan?', '', 'Cerebrum', 'Serebrum', '', 'Cerebellum', 'Serebelum', '', 'Medulla', 'Medula', '', 'Spinal cord', 'Saraf tunjang', '', 'Cerebellum', 'Serebelum'),
(3, 1, 'The unit of force is?', 'Unit bagi daya ialah?', '', 'Pascal', 'Pascal', '', 'Newton', 'Newton', '', 'Joule', 'Joule', '', 'Watt', 'Watt', '', 'Newton', 'Newton'),
(4, 1, 'Which organ detects light?', 'Organ manakah mengesan cahaya?', '', 'Ear', 'Telinga', '', 'Skin', 'Kulit', '', 'Eye', 'Mata', 'assets/quiz/science/chap1/q1.png', 'Nose', 'Hidung', '', 'Eye', 'Mata'),
(5, 1, 'Reflex action is controlled by?', 'Tindakan refleks dikawal oleh?', '', 'Brain', 'Otak', '', 'Spinal cord', 'Saraf tunjang', '', 'Heart', 'Jantung', '', 'Lungs', 'Paru-paru', '', 'Spinal cord', 'Saraf tunjang'),
(6, 2, '2x + 4 = 10. What is x?', '2x + 4 = 10. Berapakah nilai x?', '', '2', '2', '', '3', '3', '', '4', '4', '', '5', '5', '', '3', '3'),
(7, 2, 'What is 15% of 200?', 'Berapakah 15% daripada 200?', '', '20', '20', '', '25', '25', '', '30', '30', '', '35', '35', '', '30', '30'),
(8, 2, 'Solve: 3²', 'Selesaikan: 3²', '', '6', '6', '', '9', '9', '', '12', '12', '', '3', '3', '', '9', '9'),
(9, 2, 'Factorise: x² + 5x + 6', 'Faktorkan: x² + 5x + 6', '', '(x+2)(x+3)', '(x+2)(x+3)', '', '(x+1)(x+6)', '(x+1)(x+6)', '', '(x+3)(x+3)', '(x+3)(x+3)', '', '(x+6)(x+6)', '(x+6)(x+6)', '', '(x+2)(x+3)', '(x+2)(x+3)'),
(10, 2, 'What is the value of π (approx)?', 'Nilai π (anggaran)?', '', '3.14', '3.14', '', '2.14', '2.14', '', '4.13', '4.13', '', '3.41', '3.41', '', '3.14', '3.14'),
(11, 3, 'Which structure is located between the pharynx and the trachea in the human respiratory system?', 'Struktur yang manakah terletak di antara farinks dan trakea dalam sistem pernafasan manusia?', '', 'Oesophagus', 'Esofagus', '', 'Larynx', 'Anak tekak\r\n', '', 'Alveolus', 'Alveolus', '', 'Bronchus', 'Bronchus', '', 'Larynx', 'Anak tekak'),
(12, 3, 'During inhalation, what specific change occurs to the diaphragm to facilitate air entering the lungs?\r\n\r\n', 'Semasa penyedutan, apakah perubahan khusus yang berlaku pada diafragma untuk memudahkan udara memasuki paru-paru?', '', 'It relaxes and flattens', 'Ia melegakan dan meratakan', '', 'It relaxes and curves upwards', 'Ia mengendur dan melengkung ke atas', '', 'It contracts and flattens', 'Ia mengecut dan merata', '', 'It contracts and moves upwards', 'Ia mengecut dan bergerak ke atas', '', 'It contracts and flattens', 'Ia mengecut dan merata'),
(13, 3, 'Which unstable, bright red compound is formed when hemoglobin combines with oxygen in the red blood cells?', 'Sebatian merah terang yang tidak stabil, yang manakah terbentuk apabila hemoglobin bergabung dengan oksigen dalam sel darah merah?', '', 'Oxyhemoglobin', 'Oksihemoglobin', '', 'Deoxyhaemoglobin', 'Deoksihemoglobin', '', 'Ox glucose', 'Oksiglukosa', '', 'Carboxyhemoglobin', 'Karboksihemoglobin', '', 'Oxyhemoglobin', 'Oksihemoglobin'),
(14, 3, 'What is the primary cause of the stoma opening in plants during the day?', 'Apakah punca utama pembukaan stoma pada tumbuhan pada siang hari?', '', 'Guard cells become turgid as water enters via osmosis', 'Sel pengawal menjadi keruh apabila air masuk melalui osmosis', '', 'Carbon dioxide concentration increases inside the leaf', 'Kepekatan karbon dioksida meningkat di dalam daun', '', 'Sunlight causes the guard cells to shrink', 'Cahaya matahari menyebabkan sel pengawal mengecut', '', 'Guard cells become flaccid due to water loss', 'Sel pengawal menjadi lembap akibat kehilangan air', '', 'Guard cells become turgid as water enters via osmosis', 'Sel pengawal menjadi keruh apabila air masuk melalui osmosis'),
(15, 3, 'Which gas, produced by the combustion of coal in power stations, is known to irritate the air passage and cause bronchitis?', 'Gas yang manakah dihasilkan oleh pembakaran arang batu di stesen janakuasa yang diketahui merengsakan laluan udara dan menyebabkan bronkitis?', '', 'Carbon dioxide', 'Karbon dioksida', '', 'Sulphur dioxide', 'Sulfur dioksida', '', 'Carbon monoxide', 'Karbon Monoksida', '', 'Nitrogen dioxide', 'Nitrogen dioksida', '', 'Sulphur dioxide', 'Sulfur dioksida'),
(16, 3, 'How do the tracheoles in an insect\'s respiratory system increase the efficiency of gaseous exchange?', 'Bagaimanakah trakeol dalam sistem pernafasan serangga meningkatkan kecekapan pertukaran gas?', '', 'They are connected to a dense network of blood capillaries', 'Mereka disambungkan kepada rangkaian kapilari darah yang padat', '', 'They are large in number and have thin, moist walls', 'Bilangannya besar dan mempunyai dinding yang nipis dan lembap', '', 'They use valves to pump air throughout the body', 'Mereka menggunakan injap untuk mengepam udara ke seluruh badan', '', 'They have thick walls to prevent gas leakage', 'Mereka mempunyai dinding tebal untuk mengelakkan kebocoran gas', '', 'They are large in number and have thin, moist walls', 'Bilangannya besar dan mempunyai dinding yang nipis dan lembap'),
(17, 3, 'In the process of cellular respiration, which of the following chemical equations correctly summarizes the reaction occurring in body cells?', 'Dalam proses respirasi selular, yang manakah antara persamaan kimia berikut meringkaskan tindak balas yang berlaku dalam sel badan dengan betul?', '', 'Oxygen + water > glucose + carbon dioxide + energy\r\n', 'Oxygen + water > glucose + carbon dioxide + energy', '', 'Glucose + carbon dioxide > oxygen + water + energy\r\n', 'Glucose + carbon dioxide > oxygen + water + energy', '', 'Glucose + oxygen > carbon dioxide + water + energy\r\n', 'Glucose + oxygen > carbon dioxide + water + energy', '', 'carbon dioxide + water > glucose + oxygen', 'carbon dioxide + water > glucose + oxygen', '', 'Glucose + oxygen > carbon dioxide + water + energy', 'Glucose + oxygen > carbon dioxide + water + energy'),
(18, 3, 'What is the specific role of the epiglottis during the process of swallowing food?', 'Apakah peranan khusus epiglotis semasa proses menelan makanan?', '', 'It opens the trachea to allow simultaneous breathing', 'Ia membuka trakea untuk membolehkan pernafasan serentak', '', 'It contracts to move the rib cage upwards\r\n', 'Ia mengecut untuk menggerakkan sangkar tulang rusuk ke atas', '', 'It pushes the bolus into the larynx', 'Ia menolak bolus ke dalam anak tekak', '', 'It drops down and closes the trachea', 'Ia jatuh ke bawah dan menutup trakea', '', 'It drops down and closes the trachea', 'Ia jatuh ke bawah dan menutup trakea'),
(19, 3, 'Which respiratory disease is characterized by the permanent damage of the alveoli, often caused by irritants such as cigarette smoke?', 'Penyakit pernafasan yang manakah dicirikan oleh kerosakan kekal pada alveoli, yang sering disebabkan oleh perengsa seperti asap rokok?', '', 'Lung cancer', 'Kanser paru-paru', '', 'Emphysema', 'Emfisema', '', 'Asthma', 'Asma', '', 'Bronchitis', 'Bronkitis', '', 'Emphysema', 'Emfisema'),
(20, 3, 'How does the human body typically respond to the lower concentration of oxygen found at high altitudes?', 'Bagaimanakah tubuh manusia biasanya bertindak balas terhadap kepekatan oksigen yang lebih rendah yang terdapat di altitud tinggi?', '', 'By narrowing the blood capillaries', 'Dengan menyempitkan kapilari darah', '', 'By reducing the rate of breathing', 'Dengan mengurangkan kadar pernafasan', '', 'By producing more red blood cells', 'Dengan menghasilkan lebih banyak sel darah merah', '', 'By decreasing the rate of heart contractions\r\n\r\n', 'Dengan mengurangkan kadar pengecutan jantung', '', 'By narrowing the blood capillaries', 'Dengan menyempitkan kapilari darah'),
(21, 4, 'Why do simple unicellular organisms, such as *Amoeba sp.*, not require a specialised transport system?', 'Mengapakah organisma unisel ringkas, seperti *Amoeba sp.*, tidak memerlukan sistem pengangkutan khusus?', '', 'Their cell membranes are impermeable to oxygen and nutrients.', 'Membran sel mereka tidak telap kepada oksigen dan nutrien.', '', 'They use active transport exclusively instead of a circulatory system.', 'Mereka menggunakan pengangkutan aktif secara eksklusif dan bukannya sistem peredaran darah.', '', 'They do not produce waste products like carbon dioxide that need elimination\r\n', 'Mereka tidak menghasilkan produk sisa seperti karbon dioksida yang perlu disingkirkan', '', 'Their small volume allows substances to enter directly via diffusion through the cell membrane.', 'Isipadunya yang kecil membolehkan bahan masuk terus melalui resapan melalui membran sel.', '', 'Their small volume allows substances to enter directly via diffusion through the cell membrane.', 'Isipadunya yang kecil membolehkan bahan masuk terus melalui resapan melalui membran sel.'),
(22, 4, 'In the human heart, why is the muscular wall of the left ventricle significantly thicker than that of the right ventricle?', 'Dalam jantung manusia, mengapakah dinding otot ventrikel kiri jauh lebih tebal daripada ventrikel kanan?', '', 'To prevent the mixing of oxygenated and deoxygenated blood.\r\n', 'Untuk mengelakkan percampuran darah beroksigen dan darah terdeoksigen.', '', 'Untuk menahan tekanan darah tinggi yang kembali dari vena pulmonari.', 'Untuk menahan tekanan darah tinggi yang kembali dari vena pulmonari.', '', 'To generate enough pressure to pump oxygenated blood to the entire body.\r\n', 'untuk menghasilkan tekanan yang mencukupi bagi mengepam darah beroksigen ke seluruh badan.', '', 'To pump deoxygenated blood to the lungs at high pressure.\r\n', 'Untuk mengepam darah terdeoksigen ke paru-paru pada tekanan tinggi.', '', 'To generate enough pressure to pump oxygenated blood to the entire body.\r\n', 'untuk menghasilkan tekanan yang mencukupi bagi mengepam darah beroksigen ke seluruh badan.'),
(23, 4, 'Which of the following correctly describes the function of the bicuspid valve in the human heart?', 'Antara berikut, yang manakah menerangkan dengan betul fungsi injap bikuspid dalam jantung manusia?', '', 'It separates the left side of the heart from the right side.', 'Ia memisahkan bahagian kiri jantung dari bahagian kanan.', '', 'It prevents blood in the aorta from flowing back into the left ventricle.', 'Ia menghalang darah dalam aorta daripada mengalir kembali ke ventrikel kiri.', '', 'It controls the flow of deoxygenated blood into the right ventricle.', 'Ia mengawal aliran darah terdeoksigen ke dalam ventrikel kanan.', '', 'It ensures blood flows in one direction from the left atrium into the left ventricle.', 'Ia memastikan darah mengalir dalam satu arah dari atrium kiri ke ventrikel kiri.', '', 'It ensures blood flows in one direction from the left atrium into the left ventricle.\r\n', 'Ia memastikan darah mengalir dalam satu arah dari atrium kiri ke ventrikel kiri.'),
(24, 4, 'When separating human blood using the centrifugal method, what constitutes approximately 55% of the total volume?', 'Apabila mengasingkan darah manusia menggunakan kaedah emparan, apakah yang membentuk kira-kira 55% daripada jumlah isipadu?', '', 'Haemoglobin', 'Hemoglobin', '', 'Red blood cells', 'Sel darah merah', '', 'White blood cells and platelets', 'Sel darah putih dan platelet', '', 'Blood plasma', 'Plasma darah', '', 'Blood plasma', 'Plasma darah'),
(25, 4, 'An individual with blood group AB is known as a \'universal recipient\' because their blood :', 'Individu yang mempunyai kumpulan darah AB dikenali sebagai \'penerima universal\' kerana darah mereka:', '', 'Can produce new red blood cells faster than other blood groups.', 'Boleh menghasilkan sel darah merah baharu lebih cepat daripada kumpulan darah lain.', '', 'Does not contain Anti-A or Anti-B antibodies in the plasma.', 'Tidak mengandungi antibodi Anti-A atau Anti-B dalam plasma.', '', 'Contains both Anti-A and Anti-B antibodies in the plasma.', 'Mengandungi antibodi Anti-A dan Anti-B dalam plasma.', '', 'Does not contain A or B antigens on the red blood cells.', 'Tidak mengandungi antigen A atau B pada sel darah merah.', '', 'Does not contain Anti-A or Anti-B antibodies in the plasma.', 'Tidak mengandungi antibodi Anti-A atau Anti-B dalam plasma.'),
(26, 4, 'Which factor will typically result in a decrease in the rate of transpiration in a balsam plant?', 'Faktor yang manakah biasanya akan mengakibatkan penurunan kadar transpirasi dalam tumbuhan balsam?', '', 'An increase in the surrounding temperature', 'Peningkatan suhu persekitaran', '', 'An increase in surrounding air humidity', 'Peningkatan kelembapan udara sekitar', '', 'An increase in air movement or wind speed', 'Peningkatan pergerakan udara atau kelajuan angin', '', 'An increase in light intensity', 'Peningkatan keamatan cahaya', '', 'An increase in surrounding air humidity', 'Peningkatan kelembapan udara sekitar'),
(27, 4, 'In a vascular bundle of a plant stem, what is the primary role of the phloem tissue?', 'Dalam berkas vaskular batang tumbuhan, apakah peranan utama tisu floem?', '', 'Transporting manufactured food (sucrose) from the leaves to all parts of the plant.', 'Mengangkut makanan buatan (sukrosa) dari daun ke semua bahagian tumbuhan.', '', 'Regulating the opening and closing of stomata to control water loss.', 'Mengawal pembukaan dan penutupan stomata untuk mengawal kehilangan air.', '', 'Transporting water and dissolved mineral salts from the roots to the leaves.\r\n', 'Mengangkut air dan garam mineral terlarut dari akar ke daun.', '', 'Providing structural support to the plant via lignin-thickened walls.', 'Memberikan sokongan struktur kepada tumbuhan melalui dinding yang ditebalkan lignin.', '', 'Transporting manufactured food (sucrose) from the leaves to all parts of the plant.', 'Mengangkut makanan buatan (sukrosa) dari daun ke semua bahagian tumbuhan.'),
(28, 4, 'How does the heart of a fish differ from the heart of a mammal in terms of structure and blood flow?', 'Bagaimanakah jantung ikan berbeza daripada jantung mamalia dari segi struktur dan aliran darah?', '', 'A fish heart contains only oxygenated blood.', 'Jantung ikan hanya mengandungi darah beroksigen.', '', 'A fish heart has three chambers and undergoes a double circulatory system.\r\n', 'Jantung ikan mempunyai tiga ruang dan menjalani sistem peredaran darah berganda.', '', 'A fish heart has only two chambers (one atrium and one ventricle) and blood flows through it once per cycle.\r\n\r\n', 'Jantung ikan hanya mempunyai dua ruang (satu atrium dan satu ventrikel) dan darah mengalir melaluinya sekali setiap kitaran.', '', 'A fish heart lacks atria and consists only of ventricles.', 'Jantung ikan kekurangan atrium dan hanya terdiri daripada ventrikel.', '', 'A fish heart has only two chambers (one atrium and one ventricle) and blood flows through it once per cycle.\r\n\r\n', 'Jantung ikan hanya mempunyai dua ruang (satu atrium dan satu ventrikel) dan darah mengalir melaluinya sekali setiap kitaran.'),
(29, 4, 'Which of the following is a characteristic feature of arteries that distinguishes them from veins?', 'Antara berikut, yang manakah merupakan ciri khas arteri yang membezakannya daripada vena?', '', 'They always carry deoxygenated blood.', 'Mereka sentiasa membawa darah terdeoksigen.', '', 'They carry blood under high pressure away from the heart.\r\n', 'Mereka membawa darah di bawah tekanan tinggi keluar dari jantung.', '', 'They possess valves to prevent the backflow of blood.\r\n', 'Mereka mempunyai injap untuk mencegah aliran balik darah.', '', 'They have thin, less muscular walls to allow for diffusion.', 'Mereka mempunyai dinding yang nipis dan kurang berotot untuk membolehkan resapan.', '', 'They carry blood under high pressure away from the heart.\r\n\r\n\r\n', 'Mereka membawa darah di bawah tekanan tinggi keluar dari jantung.'),
(30, 4, 'What occurs during the \'dub\' sound heard during a heartbeat?\r\n', 'Apakah yang berlaku semasa bunyi \'dub\' kedengaran semasa degupan jantung?', '', 'The closure of the semilunar valves at the aorta and pulmonary artery.', 'Penutupan injap semilunar pada aorta dan arteri pulmonari.', '', 'The rapid flow of blood through the capillaries.', 'Aliran darah yang cepat melalui kapilari.', '', 'The contraction of the atria to fill the ventricles.', 'Pengecutan atrium untuk mengisi ventrikel.', '', 'The closure of bicuspid and tricuspid valves.', 'Penutupan injap bikuspid dan trikuspid.', '', 'The closure of the semilunar valves at the aorta and pulmonary artery.\r\n', 'Penutupan injap semilunar pada aorta dan arteri pulmonari.'),
(31, 5, 'Which of the following metals is found in its elemental form in the Earth\'s crust due to its very low reactivity?', 'Antara logam berikut, yang manakah terdapat dalam bentuk unsurnya dalam kerak Bumi kerana kereaktifannya yang sangat rendah?', '', 'Aluminium', 'Aluminium', '', 'Iron', 'Besi', '', 'Gold', 'Emas', '', 'Zinc', 'Zink', '', 'Gold', 'Emas'),
(32, 5, 'In the experiment to study the reaction of metals with oxygen, what is the specific role of the potassium manganate (VII) crystals?', 'Dalam eksperimen untuk mengkaji tindak balas logam dengan oksigen, apakah peranan khusus hablur kalium manganat(VII)?', '', 'To provide oxygen for the reaction', 'Untuk membekalkan oksigen bagi tindak balas', '', 'To act as a catalyst for the metal combustion', 'Bertindak sebagai pemangkin pembakaran logam', '', 'To absorb excess heat from the Bunsen burner', 'Untuk menyerap haba berlebihan daripada penunu Bunsen', '', 'To indicate the temperature of the boiling tube', 'Untuk menunjukkan suhu tabung didih', '', 'To provide oxygen for the reaction', 'Untuk membekalkan oksigen bagi tindak balas'),
(33, 5, 'According to the reactivity series provided, where is carbon positioned relative to other elements?', 'Menurut siri kereaktifan yang diberikan, di manakah kedudukan karbon relatif kepada unsur lain?', '', 'Between Aluminium and Zinc', 'Antara Aluminium dan Zink', '', 'Between Zinc and Iron', 'Antara Zink dan Besi', '', 'Between Magnesium and Aluminium', 'Antara Magnesium dan Aluminium', '', 'Above Potassium', 'Di atas Kalium', '', 'Between Aluminium and Zinc', 'Antara Aluminium dan Zink'),
(34, 5, 'What is the systematic name for the mineral known commonly as Cassiterite?', 'Apakah nama sistematik bagi mineral yang dikenali sebagai Kasiterit?', '', 'Aluminium oxide', '', '', 'Tin(IV) oxide', '', '', 'Lead(II) sulphide', '', '', 'Iron(III) oxide', '', '', 'Tin(IV) oxide', ''),
(35, 5, 'Which method is used to extract metals that are more reactive than carbon, such as Calcium and Magnesium?', 'Kaedah yang manakah digunakan untuk mengekstrak logam yang lebih reaktif daripada karbon, seperti Kalsium dan Magnesium?', '', 'Reduction of metal oxides with carbon', '', '', 'Reduction using hydrogen gas', '', '', 'Direct heating of the metallic compounds', '', '', 'Electrolysis of molten metallic compounds', '', '', 'Electrolysis of molten metallic compounds', ''),
(36, 5, 'Which of the following is a chemical characteristic of the mineral Galena?', 'Antara berikut, yang manakah merupakan ciri kimia bagi mineral Galena?', '', 'It reacts with acid to release carbon dioxide', '', '', 'It is a pure element found in the Earth\'s crust', '', '', 'It contains aluminium and oxygen', '', '', 'It is composed of lead and sulphur', '', '', 'It is composed of lead and sulphur', ''),
(37, 5, 'During the heating of calcium carbonate, what change is observed in limewater, and what does it indicate?', 'Semasa pemanasan kalsium karbonat, apakah perubahan yang diperhatikan dalam air kapur, dan apakah yang ditunjukkannya?', '', 'It becomes acidic, indicating the release of hydrogen', '', '', 'It remains clear, indicating no gas was released', '', '', 'It turns blue, indicating the release of oxygen', '', '', 'It turns cloudy, indicating the release of carbon dioxide', '', '', 'It turns cloudy, indicating the release of carbon dioxide', ''),
(38, 5, 'What is a major environmental issue specifically associated with poorly planned mining activities in Malaysia?', 'Apakah isu alam sekitar utama yang khususnya berkaitan dengan aktiviti perlombongan yang dirancang dengan tidak teliti di Malaysia?', '', 'Increased volcanic activity', '', '', 'Soil erosion and destruction of habitats', '', '', 'Depletion of the ozone layer', '', '', 'Decreased electrical energy consumption', '', '', 'Soil erosion and destruction of habitats', ''),
(39, 5, 'Which statement correctly describes the reactivity of metals towards oxygen?', 'Pernyataan yang manakah dengan betul menerangkan kereaktifan logam terhadap oksigen?', '', 'Less reactive metals produce a brighter flame than more reactive\r\nmetals', '', '', 'All metals react with oxygen at the same rate', '', '', 'More reactive metals react more vigorously with oxygen', '', '', 'Reactivity towards oxygen decreases as you move up the series\r\nfrom Gold to Potassium', '', '', 'More reactive metals react more vigorously with oxygen', ''),
(40, 5, 'Which statement correctly describes the reactivity of metals towards oxygen?', 'Pernyataan yang manakah dengan betul menerangkan kereaktifan logam terhadap oksigen?', '', 'It acts as a fuel to cool down the furnace', 'Ia bertindak sebagai bahan api untuk menyejukkan relau', '', 'It is used to filter out impurities from the molten slag', 'Ia digunakan untuk menapis bendasing daripada sanga cair', '', 'It acts as a reducing agent to remove oxygen from iron oxide', 'Ia bertindak sebagai agen penurunan untuk menyingkirkan oksigen daripada oksida besi', '', 'It combines with iron to form a natural compound', 'Ia bergabung dengan besi untuk membentuk sebatian semula jadi', '', 'It acts as a reducing agent to remove oxygen from iron oxide', 'Ia bertindak sebagai agen penurunan untuk menyingkirkan oksigen daripada oksida besi'),
(41, 6, 'Which field of science specifically examines the heat changes that occur during a chemical reaction?', 'Bidang sains yang manakah secara khusus mengkaji perubahan haba yang berlaku semasa tindak balas kimia?', '', 'Thermodynamics', 'Termodinamik', '', 'Thermochemistry', 'Termokimia', '', 'Endothermic kinetics', 'Kinetik endotermik', '', 'Thermal equilibrium', 'Keseimbangan terma', '', 'Thermochemistry', 'Termokimia'),
(42, 6, 'Based on the Greek origins provided in the text, what does the prefix \'exo\' mean in the context of an exothermic reaction?', 'Bidang sains yang manakah secara khusus mengkaji perubahan haba yang berlaku semasa tindak balas kimia?', '', 'Inside', 'Di Dalam', '', 'Change', 'Perubahan', '', 'Outside', 'Di Luar', '', 'Heat', 'Haba', '', 'Outside', 'Di Luar'),
(43, 6, 'If a student measures the temperature of a reaction mixture and finds that the thermometer reading has dropped, how should the reaction be classified?', 'Jika seorang pelajar mengukur suhu campuran tindak balas dan mendapati bacaan termometer telah menurun, bagaimanakah tindak balas tersebut harus dikelaskan?', '', 'Neutralization', 'Peneutralan', '', 'Thermal equilibrium', 'Keseimbangan terma', '', 'Endothermic', 'Di Luar', '', 'Exothermic', 'Exothermic', '', 'Endothermic', 'Endothermic'),
(44, 6, 'During a chemical reaction, what happens to the chemical energy stored in the reactants?', 'Semasa tindak balas kimia, apakah yang berlaku kepada tenaga kimia yang tersimpan dalam bahan tindak balas?', '', 'It remains unchanged while the surroundings provide heat.', 'Ia kekal tidak berubah sementara persekitaran membekalkan haba.', '', 'It is destroyed to create heat for the surroundings.', 'Ia dimusnahkan untuk menghasilkan haba bagi persekitaran.', '', 'It is converted into kinetic energy only.', 'Ia ditukar kepada tenaga kinetik sahaja.', '', 'It is converted to heat energy and released or absorbed.', 'Ia ditukar kepada tenaga haba dan dibebaskan atau diserap.', '', 'It is converted to heat energy and released or absorbed.', 'Ia ditukar kepada tenaga haba dan dibebaskan atau diserap.'),
(45, 6, 'Which of the following is a common biological example of an exothermic reaction?', 'Antara berikut, yang manakah merupakan contoh biologi lazim bagi tindak balas eksotermik?', '', 'Photosynthesis', 'Fotosintesis', '', 'Extraction of iron', 'Pengekstrakan besi', '', 'Respiration', 'Respirasi', '', 'Baking a cake', 'Membakar kek', '', 'Respiration', 'Respirasi'),
(46, 6, 'How do instant hot packs assist in relieving muscle cramps according to the source material?', 'Bagaimanakah pek panas segera membantu melegakan kekejangan otot mengikut bahan sumber?', '', 'By using endothermic reactions to cool the muscle tissue.', 'Dengan menggunakan tindak balas endotermik untuk menyejukkan tisu otot.', '', 'By releasing heat to increase the size of the lumen in blood\r\ncapillaries.', 'Dengan melepaskan haba untuk meningkatkan saiz lumen dalam kapilari darah.', '', 'By releasing chemical energy directly into the muscle cells.', 'Dengan melepaskan tenaga kimia terus ke dalam sel-sel otot.', '', 'By absorbing heat to constrict the blood vessels.', 'Dengan menyerap haba untuk menyempitkan saluran darah.', '', 'By releasing heat to increase the size of the lumen in blood\r\ncapillaries.', 'Dengan melepaskan haba untuk meningkatkan saiz lumen dalam kapilari darah.'),
(47, 6, 'In the industrial process of extracting iron from iron ore, what type of heat change occurs?', 'Dalam proses perindustrian pengekstrakan besi daripada bijih besi, apakah jenis perubahan haba yang berlaku?', '', 'Heat is absorbed from the surroundings.', 'Haba diserap dari persekitaran.', '', 'Heat is created by the iron itself.', 'Haba dihasilkan oleh seterika itu sendiri.', '', 'Heat is released to the surroundings.', 'Haba dibebaskan ke persekitaran.', '', 'There is no net heat change.', 'Tiada perubahan haba bersih.', '', 'Heat is absorbed from the surroundings.', 'Haba diserap dari persekitaran.'),
(48, 6, 'Which observation serves as the operational definition for the release of heat in an experiment comparing reaction types?', 'Pemerhatian yang manakah berfungsi sebagai definisi operasi bagi pembebasan haba dalam satu eksperimen yang membandingkan jenis tindak balas?', '', 'The disappearance of the reactants.', 'Kehilangan bahan tindak balas.', '', 'The formation of a solid precipitate.', 'Pembentukan endapan pepejal.', '', 'A rise in the reading on the thermometer.', 'Peningkatan bacaan pada termometer.', '', 'A decrease in the temperature of the container.', 'Penurunan suhu bekas.', '', 'A rise in the reading on the thermometer.', 'Peningkatan bacaan pada termometer.'),
(49, 6, 'Which of the following processes is categorized as endothermic?', 'Antara proses berikut, yang manakah dikategorikan sebagai endotermik?', '', 'Dissolving ammonium salt in water', 'Melarutkan garam ammonium dalam air', '', 'Burning a piece of paper', 'Membakar sehelai kertas', '', 'Neutralisation of acid with alkali', 'Peneutralan asid dengan alkali', '', 'A bomb explosion', 'Letupan bom', '', 'Dissolving ammonium salt in water', 'Melarutkan garam ammonium dalam air'),
(50, 6, 'What is the relationship between temperature and heat during thermal equilibrium as mentioned in the \'InfoScience\' section?', 'Apakah hubungan antara suhu dan haba semasa keseimbangan terma seperti yang dinyatakan dalam bahagian \'MaklumatSains\'?', '', 'There is no net flow of heat between objects at the same\r\ntemperature.', 'Tiada aliran haba bersih antara objek pada suhu yang sama.', '', 'Heat continues to move from the colder object to the hotter one.', 'Haba terus bergerak dari objek yang lebih sejuk ke objek yang lebih panas.', '', 'Temperature increases as heat is absorbed during equilibrium.', 'Suhu meningkat apabila haba diserap semasa keseimbangan.', '', 'Heat and temperature are the same physical quantity.', 'Haba dan suhu adalah kuantiti fizik yang sama.', '', 'There is no net flow of heat between objects at the same\r\ntemperature.', 'Tiada aliran haba bersih antara objek pada suhu yang sama.'),
(51, 7, 'Which of the following energy sources is classified as non-renewable according to the source material?', 'Antara sumber tenaga berikut, yang manakah dikelaskan sebagai tidak boleh diperbaharui mengikut bahan sumbernya?', '', 'Wind energy', 'Tenaga angin', '', 'Hydroelectric', 'Hidroelektrik', '', 'Solar energy', 'Tenaga solar', '', 'Natural gas', 'Gas asli', '', 'Natural gas', 'Gas asli'),
(52, 7, 'During an experiment with a copper wire and a magnet, what condition must be met to produce an induced current?', 'Semasa satu eksperimen dengan dawai kuprum dan magnet, apakah syarat yang mesti dipenuhi untuk menghasilkan arus aruhan?', '', 'The copper wire must be insulated with thick plastic.', 'Wayar kuprum mesti dilindungi dengan plastik tebal.', '', 'The magnet must be demagnetised before starting.', 'Magnet mesti dinyahmagnetkan sebelum dimulakan.', '', 'The magnet must be placed stationary inside the coil.', 'Magnet mesti diletakkan pegun di dalam gegelung.', '', 'There must be relative motion between the magnet and the wire.', 'Mesti ada gerakan relatif antara magnet dan dawai.', '', 'There must be relative motion between the magnet and the wire.', 'Mesti ada gerakan relatif antara magnet dan dawai.'),
(53, 7, 'What is the primary difference between direct current (d.c.) and alternating current (a.c.)?', 'Apakah perbezaan utama antara arus terus (a.t.) dan arus ulang-alik (a.t.)?', '', 'The direction of current flow.', 'Arah aliran arus.', '', 'The ability to light up an LED.', 'Keupayaan untuk menyalakan LED.', '', 'The type of wire used for transmission.', 'Jenis wayar yang digunakan untuk penghantaran.', '', 'Only d.c. can be measured with a galvanometer.', 'Hanya d.c. sahaja yang boleh diukur dengan galvanometer.', '', 'The direction of current flow.', 'Arah aliran arus.'),
(54, 7, 'In a step-down transformer, how does the number of turns in the primary coil compare to the number of turns in the secondary coil?', 'Dalam transformer langkah ke bawah, bagaimanakah bilangan lilitan dalam gegelung primer berbanding dengan bilangan lilitan dalam gegelung sekunder?', '', 'Primary coil less than secondary coil', 'Gegelung primer kurang daripada gegelung sekunder', '', 'Primary coil more than secondary coil', 'Gegelung primer lebih daripada gegelung sekunder', '', 'Secondary coil equal to 2 times primary coil', 'Gegelung sekunder bersamaan dengan 2 kali ganda gegelung primer', '', 'Primary coil equal to secondary coil', 'Gegelung primer sama dengan gegelung sekunder', '', 'Primary coil more than secondary coil', 'Gegelung primer lebih daripada gegelung sekunder'),
(55, 7, 'Which component in the electricity transmission and distribution system is responsible for increasing voltage to 132 kV or 500 kV for long-distance travel?', 'Komponen yang manakah dalam sistem penghantaran dan pengagihan elektrik yang bertanggungjawab untuk meningkatkan voltan kepada 132 kV atau 500 kV untuk perjalanan jarak jauh?', '', 'Step-down transformer', 'Transformer langkah ke bawah', '', 'Branch substation', 'Pencawang cawangan', '', 'Step-up transformer', 'Transformer langkah naik', '', 'Main substation', 'Pencawang utama', '', 'Step-up transformer', 'Transformer langkah naik'),
(56, 7, 'Why is the alternating current voltage stepped down to 240 V before reaching residential homes?', 'Mengapakah voltan arus ulang-alik diturunkan kepada 240 V sebelum sampai ke rumah kediaman?', '', 'To increase the current flow into the house.', 'Untuk meningkatkan aliran arus masuk ke dalam rumah.', '', 'To prevent the National Grid from overheating.', 'Untuk mengelakkan Grid Nasional daripada terlalu panas.', '', 'To convert the current from a.c. to d.c.', 'Untuk menukar arus daripada a.c. kepada d.c.', '', 'To ensure it is at a safe level for domestic appliances.', 'Untuk memastikan ia berada pada tahap yang selamat untuk peralatan rumah tangga.', '', 'To ensure it is at a safe level for domestic appliances.', 'Untuk memastikan ia berada pada tahap yang selamat untuk peralatan rumah tangga.'),
(57, 7, 'Based on the experiment in the text, what happens to the brightness of a bulb connected to the secondary coil if it has fewer turns than the primary coil?', 'Berdasarkan eksperimen dalam teks, apakah yang berlaku kepada kecerahan mentol yang disambungkan ke gegelung sekunder jika ia mempunyai lilitan yang lebih sedikit daripada gegelung primer?', '', 'It is brighter than the bulb on the primary side.', 'Ia lebih terang daripada mentol di bahagian utama.', '', 'It is dimmer than the bulb on the primary side.', 'Ia lebih malap daripada mentol di bahagian utama.', '', 'The bulb will immediately blow out.', 'Mentol itu akan serta-merta padam.', '', 'The brightness remains exactly the same.', 'Kecerahannya tetap sama.', '', 'It is dimmer than the bulb on the primary side.', 'Ia lebih malap daripada mentol di bahagian utama.'),
(58, 7, 'Which device is used as a source of electricity that specifically produces direct current (d.c.)?', 'Peranti yang manakah digunakan sebagai sumber elektrik yang menghasilkan arus terus (d.c.) secara khusus?', '', 'National Grid Network', 'Rangkaian Grid Kebangsaan', '', 'Step-up transformer', 'Transformer langkah naik', '', 'Bicycle dynamo', 'Dinamo basikal', '', 'Dry cell', 'Sel kering', '', 'Dry cell', 'Sel kering'),
(59, 7, 'What is detected by a galvanometer when its pointer deflects during the movement of a magnet through a coil?', 'Apakah yang dikesan oleh galvanometer apabila penunjuknya terpesong semasa pergerakan magnet melalui gegelung?', '', 'Total resistance of the wire', 'Jumlah rintangan dawai', '', 'Induced current', 'Arus teraruh', '', 'Electrical insulation', 'Penebat elektrik', '', 'Dry cell', 'Sel kering', '', 'Induced current', 'Arus teraruh'),
(60, 7, 'Which of the following describes the function of the \'National Grid Network\'?', 'Antara berikut, yang manakah menerangkan fungsi \'Rangkaian Grid Nasional\'?', '', 'Converting all solar energy into nuclear energy.', 'Menukar semua tenaga suria kepada tenaga nuklear.', '', 'Calculating the monthly cost of electricity for consumers.', 'Mengira kos elektrik bulanan untuk pengguna.', '', 'Directly powering high-voltage smoke detectors in hospitals.', 'Menguasakan pengesan asap voltan tinggi secara langsung di hospital.', '', 'Linking power stations to substations across the country.', 'Menghubungkan stesen janakuasa ke pencawang elektrik di seluruh negara.', '', 'Linking power stations to substations across the country.', 'Menghubungkan stesen janakuasa ke pencawang elektrik di seluruh negara.');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `career_field`
--
ALTER TABLE `career_field`
  ADD PRIMARY KEY (`field_id`);

--
-- Indexes for table `career_job`
--
ALTER TABLE `career_job`
  ADD PRIMARY KEY (`job_id`);

--
-- Indexes for table `career_qustion`
--
ALTER TABLE `career_qustion`
  ADD PRIMARY KEY (`cquestion_id`);

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
-- Indexes for table `stem_quiz`
--
ALTER TABLE `stem_quiz`
  ADD PRIMARY KEY (`quiz_id`);

--
-- Indexes for table `stem_quiz_question`
--
ALTER TABLE `stem_quiz_question`
  ADD PRIMARY KEY (`question_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `career_field`
--
ALTER TABLE `career_field`
  MODIFY `field_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `career_job`
--
ALTER TABLE `career_job`
  MODIFY `job_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `career_qustion`
--
ALTER TABLE `career_qustion`
  MODIFY `cquestion_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `learning_media`
--
ALTER TABLE `learning_media`
  MODIFY `media_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

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
  MODIFY `page_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `stem_quiz`
--
ALTER TABLE `stem_quiz`
  MODIFY `quiz_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `stem_quiz_question`
--
ALTER TABLE `stem_quiz_question`
  MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
