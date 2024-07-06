START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bbdms`
--

CREATE TABLE `tbladmin` (
  `ID` int(10) NOT NULL,
  `AdminName` varchar(120) DEFAULT NULL,
  `UserName` varchar(120) DEFAULT NULL,
  `MobileNumber` bigint(10) DEFAULT NULL,
  `Email` varchar(200) DEFAULT NULL,
  `Password` varchar(200) DEFAULT NULL,
  `AdminRegdate` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


INSERT INTO `tbladmin` (`ID`, `AdminName`, `UserName`, `MobileNumber`, `Email`, `Password`, `AdminRegdate`) VALUES
(1, 'Admin', 'admin', 8979555558, 'admin@gmail.com', '202cb962ac59075b964b07152d234b70', '2022-07-28 04:36:52');


CREATE TABLE `tblblooddonars` (
  `id` int(11) NOT NULL,
  `donorId` varchar(8) NOT NULL UNIQUE,
  `FullName` varchar(100) DEFAULT NULL,
  `MobileNumber` char(11) DEFAULT NULL,
  `EmailId` varchar(100) DEFAULT NULL,
  `Gender` varchar(20) DEFAULT NULL,
  `Age` int(11) DEFAULT NULL,
  `BloodGroup` varchar(20) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Message` mediumtext DEFAULT NULL,
  `PostingDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(1) DEFAULT NULL,
  `Password` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `tblbloodgroup` (
  `id` int(2) NOT NULL,
  `BloodGroup` varchar(20) DEFAULT NULL,
  `PostingDate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `tblbloodrequirer` (
  `ID` int(10) NOT NULL,
  `BloodDonarID` int(10) DEFAULT NULL,
  `name` varchar(250) DEFAULT NULL,
  `EmailId` varchar(250) DEFAULT NULL,
  `ContactNumber` bigint(10) DEFAULT NULL,
  `BloodRequirefor` varchar(250) DEFAULT NULL,
  `Message` mediumtext DEFAULT NULL,
  `ApplyDate` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `tblcontactusinfo` (
  `id` int(11) NOT NULL,
  `Address` tinytext DEFAULT NULL,
  `EmailId` varchar(255) DEFAULT NULL,
  `ContactNo` char(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `tblcontactusquery` (
  `id` int(8) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `EmailId` varchar(120) DEFAULT NULL,
  `ContactNumber` char(11) DEFAULT NULL,
  `Message` longtext DEFAULT NULL,
  `PostingDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `tblpages` (
  `id` int(11) NOT NULL,
  `PageName` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL DEFAULT '',
  `detail` longtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


ALTER TABLE `tbladmin`
  ADD PRIMARY KEY (`ID`);

ALTER TABLE `tblblooddonars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bgroup` (`BloodGroup`);

ALTER TABLE `tblbloodgroup`
  ADD PRIMARY KEY (`id`),
  ADD KEY `BloodGroup` (`BloodGroup`),
  ADD KEY `BloodGroup_2` (`BloodGroup`);


ALTER TABLE `tblbloodrequirer`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `donorid` (`BloodDonarID`);


ALTER TABLE `tblcontactusinfo`
  ADD PRIMARY KEY (`id`);


ALTER TABLE `tblcontactusquery`
  ADD PRIMARY KEY (`id`);


ALTER TABLE `tblpages`
  ADD PRIMARY KEY (`id`);


ALTER TABLE `tbladmin`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;


ALTER TABLE `tblblooddonars`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;


ALTER TABLE `tblbloodgroup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;


ALTER TABLE `tblbloodrequirer`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;


ALTER TABLE `tblcontactusinfo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;


ALTER TABLE `tblcontactusquery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;


ALTER TABLE `tblpages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
COMMIT;

ALTER TABLE `tblbloodrequirer` ADD FOREIGN KEY (BloodDonarID) REFERENCES `tblblooddonars`(id);

CREATE TABLE `manages_bbdms`(
`admin_id` int(1) NOT NULL,
`email_id` varchar(20) DEFAULT NULL
);

CREATE TABLE `manages_donor`(
`admin_id` int(1) NOT NULL,
`donor_id` int(2) DEFAULT NULL
);

CREATE TABLE `manages_bg`(
`admin_id` int(1) NOT NULL,
`bg_id` varchar(20) DEFAULT NULL
);

CREATE TABLE `manages_contactquery`(
`admin_id` int(1) NOT NULL,
`id` int(1) DEFAULT NULL
);

CREATE TABLE `manages_requirer`(
`admin_id` int(1) NOT NULL,
`req_id` varchar(20) DEFAULT NULL
);

-- CREATE TABLE `manages_bbdms`(
-- `admin_id` int(1) NOT NULL,
-- `email_id` varchar(20) DEFAULT NULL
-- );

ALTER TABLE `manages_bbdms` ADD FOREIGN KEY (`admin_id`) REFERENCES `tbladmin`(`ID`);
ALTER TABLE `manages_bbdms` ADD FOREIGN KEY (`email_id`) REFERENCES `tblcontactusinfo`(`EmailId`);

ALTER TABLE `manages_donor` ADD FOREIGN KEY (`admin_id`) REFERENCES `tbladmin`(`ID`);
ALTER TABLE `manages_donor` ADD FOREIGN KEY (`donor_id`) REFERENCES `tblblooddonars`(`id`);

ALTER TABLE `manages_bg` ADD FOREIGN KEY (`admin_id`) REFERENCES `tbladmin`(`ID`);
ALTER TABLE `manages_bg` ADD FOREIGN KEY (`bg_id`) REFERENCES `tblbloodgroup`(`id`);

ALTER TABLE `manages_contactquery` ADD FOREIGN KEY (`admin_id`) REFERENCES `tbladmin`(`ID`);
ALTER TABLE `manages_contactquery` ADD FOREIGN KEY (`id`) REFERENCES `tblcontactusquery`(`id`);

ALTER TABLE `manages_requirer` ADD FOREIGN KEY (`admin_id`) REFERENCES `tbladmin`(`ID`);
ALTER TABLE `manages_requirer` ADD FOREIGN KEY (`req_id`) REFERENCES `tblbloodrequirer`(`ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
