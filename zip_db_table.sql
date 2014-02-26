-- phpMyAdmin SQL Dump
-- version 2.11.11.3
-- http://www.phpmyadmin.net
--
-- ホスト: localhost
-- 生成時間: 2013 年 12 月 10 日 15:01
-- サーバのバージョン: 5.0.95
-- PHP のバージョン: 5.1.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- データベース: `zip_cnv`
--

-- --------------------------------------------------------

--
-- テーブルの構造 `zip`
--

CREATE TABLE IF NOT EXISTS `zip` (
  `id` int(11) NOT NULL,
  `addr` varchar(256) NOT NULL,
  `comment` varchar(128) NOT NULL,
  `is_default` tinyint(4) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `addr_2` (`addr`),
  FULLTEXT KEY `addr` (`addr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- ビュー用の代替構造 `zipview`
--
CREATE TABLE IF NOT EXISTS `zipview` (
`id` int(11)
,`zip_num` longblob
,`zip_disp` varbinary(8)
,`addr` varchar(256)
,`comment` varchar(128)
);
-- --------------------------------------------------------

--
-- ビュー用の構造 `zipview`
--
DROP TABLE IF EXISTS `zipview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `zip_cnv`.`zipview` AS select `zip_cnv`.`zip`.`id` AS `id`,concat(repeat(_utf8'0',(7 - char_length(`zip_cnv`.`zip`.`id`))),`zip_cnv`.`zip`.`id`) AS `zip_num`,concat(substr(concat(repeat(_utf8'0',(7 - char_length(`zip_cnv`.`zip`.`id`))),`zip_cnv`.`zip`.`id`),1,3),_utf8'-',substr(concat(repeat(_utf8'0',(7 - char_length(`zip_cnv`.`zip`.`id`))),`zip_cnv`.`zip`.`id`),4,4)) AS `zip_disp`,`zip_cnv`.`zip`.`addr` AS `addr`,`zip_cnv`.`zip`.`comment` AS `comment` from `zip_cnv`.`zip`;

