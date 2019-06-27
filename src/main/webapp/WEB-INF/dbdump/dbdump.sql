-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.3.15-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- firstprac 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `firstprac` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `firstprac`;

-- 테이블 firstprac.user_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `user_info` (
  `user_idx` int(11) NOT NULL AUTO_INCREMENT,
  `user_register_date` datetime NOT NULL DEFAULT current_timestamp(),
  `user_name` varchar(200) CHARACTER SET utf8 NOT NULL COMMENT '이름',
  `user_social_secunum` varchar(200) CHARACTER SET utf8 DEFAULT NULL COMMENT '주민등록번호(encrypt)',
  `user_sex` varchar(200) CHARACTER SET utf8 DEFAULT NULL COMMENT '성별MF',
  `user_comp` varchar(200) CHARACTER SET utf8 DEFAULT NULL COMMENT '소속회사',
  `user_comp_enterdate` date DEFAULT NULL,
  `user_dept` varchar(200) CHARACTER SET utf8 DEFAULT NULL COMMENT '부서',
  `user_spot` varchar(200) CHARACTER SET utf8 DEFAULT NULL COMMENT '직위',
  `user_army_serv` varchar(200) CHARACTER SET utf8 DEFAULT NULL COMMENT '병역구분',
  `user_marital_status` varchar(200) CHARACTER SET utf8 DEFAULT NULL COMMENT '결혼여부YN',
  `user_army_serv_enter` date DEFAULT NULL,
  `user_army_serv_leave` date DEFAULT NULL,
  `user_army_serv_period` varchar(200) CHARACTER SET utf8 DEFAULT NULL COMMENT '역종/병과',
  `user_telnum_wired` varchar(200) CHARACTER SET utf8 DEFAULT NULL COMMENT '유선전화번호',
  `user_telnum_wireless` varchar(200) CHARACTER SET utf8 DEFAULT NULL COMMENT '무선전화번호',
  `user_email` varchar(200) CHARACTER SET utf8 DEFAULT NULL COMMENT '이메일',
  `user_zipcode` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `user_address` varchar(200) CHARACTER SET utf8 DEFAULT NULL COMMENT '주소',
  PRIMARY KEY (`user_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=176 DEFAULT CHARSET=utf8mb4;

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 firstprac.user_info_career 구조 내보내기
CREATE TABLE IF NOT EXISTS `user_info_career` (
  `career_idx` int(11) NOT NULL AUTO_INCREMENT,
  `user_idx` int(11) NOT NULL DEFAULT 0,
  `career_comp_name` varchar(200) DEFAULT NULL,
  `career_enterdate` date DEFAULT NULL,
  `career_leavedate` date DEFAULT NULL,
  `career_spot` varchar(200) DEFAULT NULL,
  `career_responsib` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`career_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=238 DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 firstprac.user_info_edu 구조 내보내기
CREATE TABLE IF NOT EXISTS `user_info_edu` (
  `edu_idx` int(11) NOT NULL AUTO_INCREMENT,
  `user_idx` int(11) DEFAULT NULL,
  `edu_school_name` varchar(200) DEFAULT NULL,
  `edu_status` varchar(200) DEFAULT NULL,
  `edu_year` varchar(200) DEFAULT NULL,
  `edu_month` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`edu_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=291 DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 firstprac.user_info_licen 구조 내보내기
CREATE TABLE IF NOT EXISTS `user_info_licen` (
  `licen_idx` int(11) NOT NULL AUTO_INCREMENT,
  `user_idx` int(11) DEFAULT NULL,
  `licen_name` varchar(200) DEFAULT NULL,
  `licen_skill_level` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`licen_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=270 DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 firstprac.user_info_qualifi 구조 내보내기
CREATE TABLE IF NOT EXISTS `user_info_qualifi` (
  `qualifi_idx` int(11) NOT NULL AUTO_INCREMENT,
  `user_idx` int(11) DEFAULT NULL,
  `qualifi_name` varchar(200) DEFAULT NULL,
  `qualifi_getdate` date DEFAULT NULL,
  PRIMARY KEY (`qualifi_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=279 DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 firstprac.user_info_skill 구조 내보내기
CREATE TABLE IF NOT EXISTS `user_info_skill` (
  `skill_idx` int(11) NOT NULL AUTO_INCREMENT,
  `user_idx` int(11) DEFAULT NULL,
  `skill_project_name` varchar(1000) DEFAULT NULL,
  `skill_startdate` date DEFAULT NULL,
  `skill_enddate` date DEFAULT NULL,
  `skill_customer_comp` varchar(1000) DEFAULT NULL,
  `skill_work_comp` varchar(1000) DEFAULT NULL,
  `skill_applied` varchar(1000) DEFAULT NULL,
  `skill_industry` varchar(1000) DEFAULT NULL,
  `skill_role` varchar(1000) DEFAULT NULL,
  `skill_model` varchar(1000) DEFAULT NULL,
  `skill_os` varchar(1000) DEFAULT NULL,
  `skill_lang` varchar(1000) DEFAULT NULL,
  `skill_dbms` varchar(1000) DEFAULT NULL,
  `skill_comm` varchar(1000) DEFAULT NULL,
  `skill_tool` varchar(1000) DEFAULT NULL,
  `skill_etc` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`skill_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=335 DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.
-- 테이블 firstprac.user_info_training 구조 내보내기
CREATE TABLE IF NOT EXISTS `user_info_training` (
  `training_idx` int(11) NOT NULL AUTO_INCREMENT,
  `user_idx` int(11) DEFAULT NULL,
  `training_name` varchar(200) DEFAULT NULL,
  `training_startdate` date DEFAULT NULL,
  `training_enddate` date DEFAULT NULL,
  `training_agency` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`training_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8;

-- 내보낼 데이터가 선택되어 있지 않습니다.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
