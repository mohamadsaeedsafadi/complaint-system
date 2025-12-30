-- Database Backup
-- Date: 2025-12-29 16:35:15

SET FOREIGN_KEY_CHECKS=0;


DROP TABLE IF EXISTS `activity_logs`;
CREATE TABLE `activity_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `action` varchar(255) NOT NULL,
  `route` varchar(255) DEFAULT NULL,
  `method` varchar(10) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `request_payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`request_payload`)),
  `response_status` int(11) DEFAULT NULL,
  `duration_ms` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `activity_logs_user_id_foreign` (`user_id`),
  KEY `activity_logs_action_index` (`action`),
  CONSTRAINT `activity_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `activity_logs` VALUES ('1',NULL,'register','api/register','POST','127.0.0.1','{\"name\":\"admin\",\"email\":\"hhamode053@gmail.com\",\"phone\":\"0933596060\",\"role\":\"admin\"}','201','5224','2025-11-27 19:03:29','2025-11-27 19:03:29');
INSERT INTO `activity_logs` VALUES ('2',NULL,'send_otp','api/send-otp','POST','127.0.0.1','{\"user_id\":\"1\",\"method\":\"email\"}','200','14536','2025-11-27 19:03:58','2025-11-27 19:03:58');
INSERT INTO `activity_logs` VALUES ('3',NULL,'send_otp','api/verify-otp','POST','127.0.0.1','{\"user_id\":1,\"code\":\"899030\"}','200','350','2025-11-27 19:04:19','2025-11-27 19:04:19');
INSERT INTO `activity_logs` VALUES ('4',NULL,'login','api/login','POST','127.0.0.1','{\"phone\":\"093359606\"}','422','193','2025-11-27 19:05:26','2025-11-27 19:05:26');
INSERT INTO `activity_logs` VALUES ('5',NULL,'login','api/login','POST','127.0.0.1','{\"phone\":\"0933596060\"}','401','442','2025-11-27 19:05:34','2025-11-27 19:05:34');
INSERT INTO `activity_logs` VALUES ('6',NULL,'login','api/login','POST','127.0.0.1','{\"phone\":\"0933596060\"}','401','434','2025-11-27 19:05:40','2025-11-27 19:05:40');
INSERT INTO `activity_logs` VALUES ('7',NULL,'login','api/login','POST','127.0.0.1','{\"phone\":\"0933596060\"}','401','344','2025-11-27 19:05:43','2025-11-27 19:05:43');
INSERT INTO `activity_logs` VALUES ('8',NULL,'login','api/login','POST','127.0.0.1','{\"phone\":\"0933596060\"}','401','388','2025-11-27 19:05:45','2025-11-27 19:05:45');
INSERT INTO `activity_logs` VALUES ('9',NULL,'login','api/login','POST','127.0.0.1','{\"phone\":\"0933596060\"}','423','7248','2025-11-27 19:05:54','2025-11-27 19:05:54');
INSERT INTO `activity_logs` VALUES ('10',NULL,'login','api/login','POST','127.0.0.1','{\"phone\":\"0933596060\"}','423','100','2025-11-27 19:07:51','2025-11-27 19:07:51');
INSERT INTO `activity_logs` VALUES ('11',NULL,'login','api/login','POST','127.0.0.1','{\"phone\":\"0933596060\"}','423','45','2025-11-27 19:07:59','2025-11-27 19:07:59');
INSERT INTO `activity_logs` VALUES ('12',NULL,'login','api/login','POST','127.0.0.1','{\"phone\":\"0933596060\"}','423','64','2025-11-27 19:12:28','2025-11-27 19:12:28');
INSERT INTO `activity_logs` VALUES ('13',NULL,'login','api/login','POST','127.0.0.1','{\"phone\":\"0933596060\"}','423','49','2025-11-27 19:13:35','2025-11-27 19:13:35');
INSERT INTO `activity_logs` VALUES ('14',NULL,'login','api/login','POST','127.0.0.1','{\"phone\":\"0933596060\"}','200','607','2025-11-27 19:16:12','2025-11-27 19:16:12');
INSERT INTO `activity_logs` VALUES ('15',NULL,'create_department','api/admin/departments','POST','127.0.0.1','{\"department_id\":1}','200',NULL,'2025-11-27 19:16:43','2025-11-27 19:16:43');
INSERT INTO `activity_logs` VALUES ('16',NULL,'create','api/admin/departments','POST','127.0.0.1','{\"name\":\"\\u0645\\u0624\\u0633\\u0633\\u0629 \\u0627\\u0644\\u0645\\u064a\\u0627\\u0647\",\"code\":\"WATE\",\"description\":\"\\u0627\\u0644\\u0645\\u0624\\u0633\\u0633\\u0629 \\u0627\\u0644\\u0639\\u0627\\u0645\\u0629 \\u0644\\u0644\\u0645\\u064a\\u0627\\u0647 \\u0641\\u064a \\u062f\\u0645\\u0634\\u0642\"}','201','521','2025-11-27 19:16:43','2025-11-27 19:16:43');
INSERT INTO `activity_logs` VALUES ('17',NULL,'create','api/admin/employees','POST','127.0.0.1','{\"name\":\"ahmad\",\"email\":\"ahdmdad5@edxample.com\",\"phone\":\"4\",\"department_id\":\"1\"}','401','42','2025-11-27 19:17:46','2025-11-27 19:17:46');
INSERT INTO `activity_logs` VALUES ('18',NULL,'create_employee','api/admin/employees','POST','127.0.0.1','{\"employee_id\":2}','200',NULL,'2025-11-27 19:17:54','2025-11-27 19:17:54');
INSERT INTO `activity_logs` VALUES ('19',NULL,'create','api/admin/employees','POST','127.0.0.1','{\"name\":\"ahmad\",\"email\":\"ahdmdad5@edxample.com\",\"phone\":\"4\",\"department_id\":\"1\"}','201','620','2025-11-27 19:17:55','2025-11-27 19:17:55');
INSERT INTO `activity_logs` VALUES ('20',NULL,'send_otp','api/sendotpforemp','POST','127.0.0.1','{\"phone\":\"4\",\"method\":\"whatsapp\",\"value\":\"4\"}','200','107','2025-11-27 19:18:27','2025-11-27 19:18:27');
INSERT INTO `activity_logs` VALUES ('21',NULL,'send_otp','api/verify-otp','POST','127.0.0.1','{\"user_id\":2,\"code\":\"720145\"}','200','157','2025-11-27 19:18:51','2025-11-27 19:18:51');
INSERT INTO `activity_logs` VALUES ('22',NULL,'login','api/login','POST','127.0.0.1','{\"phone\":\"4\"}','200','428','2025-11-27 19:19:48','2025-11-27 19:19:48');
INSERT INTO `activity_logs` VALUES ('23',NULL,'get_api_assigned-complaints','api/assigned-complaints','GET','127.0.0.1','[]','200','437','2025-11-27 19:20:08','2025-11-27 19:20:08');
INSERT INTO `activity_logs` VALUES ('24',NULL,'register','api/register','POST','127.0.0.1','{\"name\":\"admin\",\"email\":\"hhamode053@gmail.kcom\",\"phone\":\"0\",\"role\":\"citizen\"}','201','378','2025-11-27 19:20:47','2025-11-27 19:20:47');
INSERT INTO `activity_logs` VALUES ('25',NULL,'send_otp','api/send-otp','POST','127.0.0.1','{\"user_id\":\"3\",\"method\":\"whatsapp\"}','200','169','2025-11-27 19:21:02','2025-11-27 19:21:02');
INSERT INTO `activity_logs` VALUES ('26',NULL,'send_otp','api/verify-otp','POST','127.0.0.1','{\"user_id\":3,\"code\":\"652211\"}','200','216','2025-11-27 19:21:15','2025-11-27 19:21:15');
INSERT INTO `activity_logs` VALUES ('27',NULL,'login','api/login','POST','127.0.0.1','{\"phone\":\"0\"}','200','364','2025-11-27 19:21:22','2025-11-27 19:21:22');
INSERT INTO `activity_logs` VALUES ('28','3','create_complaint','api/complaints','POST','127.0.0.1','{\"title\":\"\\u0627\\u0646\\u0642\\u0637\\u0627\\u0639 \\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0641\\u064a \\u0627\\u0644\\u062d\\u064a\",\"description\":\"\\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0645\\u0642\\u0637\\u0648\\u0639\\u0629 \\u0645\\u0646\\u0630 \\u064a\\u0648\\u0645\\u064a\\u0646 \\u0641\\u064a \\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f\",\"department_id\":\"1\",\"location\":\"\\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f - \\u062f\\u0645\\u0634\\u0642\",\"attachments\":[{},{}],\"user_id\":3,\"reference_no\":\"CMP-20251127-0001\",\"status\":\"new\"}','200',NULL,'2025-11-27 19:22:37','2025-11-27 19:22:37');
INSERT INTO `activity_logs` VALUES ('29',NULL,'create','api/complaints','POST','127.0.0.1','{\"title\":\"\\u0627\\u0646\\u0642\\u0637\\u0627\\u0639 \\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0641\\u064a \\u0627\\u0644\\u062d\\u064a\",\"description\":\"\\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0645\\u0642\\u0637\\u0648\\u0639\\u0629 \\u0645\\u0646\\u0630 \\u064a\\u0648\\u0645\\u064a\\u0646 \\u0641\\u064a \\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f\",\"department_id\":\"1\",\"location\":\"\\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f - \\u062f\\u0645\\u0634\\u0642\"}','201','1374','2025-11-27 19:22:37','2025-11-27 19:22:37');
INSERT INTO `activity_logs` VALUES ('30','3','create_complaint','api/complaints','POST','127.0.0.1','{\"title\":\"\\u0627\\u0646\\u0642\\u0637\\u0627\\u0639 \\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0641\\u064a \\u0627\\u0644\\u062d\\u064a\",\"description\":\"\\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0645\\u0642\\u0637\\u0648\\u0639\\u0629 \\u0645\\u0646\\u0630 \\u064a\\u0648\\u0645\\u064a\\u0646 \\u0641\\u064a \\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f\",\"department_id\":\"1\",\"location\":\"\\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f - \\u062f\\u0645\\u0634\\u0642\",\"attachments\":[{},{}],\"user_id\":3,\"reference_no\":\"CMP-20251127-0002\",\"status\":\"new\"}','200',NULL,'2025-11-27 19:24:42','2025-11-27 19:24:42');
INSERT INTO `activity_logs` VALUES ('31',NULL,'create','api/complaints','POST','127.0.0.1','{\"title\":\"\\u0627\\u0646\\u0642\\u0637\\u0627\\u0639 \\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0641\\u064a \\u0627\\u0644\\u062d\\u064a\",\"description\":\"\\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0645\\u0642\\u0637\\u0648\\u0639\\u0629 \\u0645\\u0646\\u0630 \\u064a\\u0648\\u0645\\u064a\\u0646 \\u0641\\u064a \\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f\",\"department_id\":\"1\",\"location\":\"\\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f - \\u062f\\u0645\\u0634\\u0642\"}','201','952','2025-11-27 19:24:42','2025-11-27 19:24:42');
INSERT INTO `activity_logs` VALUES ('32','2','update_complaint_status','api/updateStatus/1','PATCH','127.0.0.1','{\"complaint_id\":1,\"from\":\"new\",\"to\":\"in_progress\"}','200',NULL,'2025-11-27 19:27:43','2025-11-27 19:27:43');
INSERT INTO `activity_logs` VALUES ('33',NULL,'update','api/updateStatus/1','PATCH','127.0.0.1','{\"status\":\"in_progress\",\"note\":\"jjjjj\"}','200','834','2025-11-27 19:27:43','2025-11-27 19:27:43');
INSERT INTO `activity_logs` VALUES ('34','2','update_complaint_status','api/updateStatus/1','PATCH','127.0.0.1','{\"complaint_id\":1,\"from\":\"in_progress\",\"to\":\"in_progress\"}','200',NULL,'2025-11-27 19:28:12','2025-11-27 19:28:12');
INSERT INTO `activity_logs` VALUES ('35',NULL,'update','api/updateStatus/1','PATCH','127.0.0.1','{\"status\":\"in_progress\",\"note\":\"jjjjj\"}','200','536','2025-11-27 19:28:13','2025-11-27 19:28:13');
INSERT INTO `activity_logs` VALUES ('36',NULL,'create_employee','api/admin/employees','POST','127.0.0.1','{\"employee_id\":4}','200',NULL,'2025-11-27 19:28:30','2025-11-27 19:28:30');
INSERT INTO `activity_logs` VALUES ('37',NULL,'create','api/admin/employees','POST','127.0.0.1','{\"name\":\"ahmad\",\"email\":\"ahdmdasd5@edxample.com\",\"phone\":\"44\",\"department_id\":\"1\"}','201','685','2025-11-27 19:28:30','2025-11-27 19:28:30');
INSERT INTO `activity_logs` VALUES ('38',NULL,'send_otp','api/sendotpforemp','POST','127.0.0.1','[]','500','117','2025-11-27 19:28:48','2025-11-27 19:28:48');
INSERT INTO `activity_logs` VALUES ('39',NULL,'send_otp','api/sendotpforemp','POST','127.0.0.1','{\"phone\":\"44\",\"method\":\"whatsapp\"}','500','34','2025-11-27 19:28:57','2025-11-27 19:28:57');
INSERT INTO `activity_logs` VALUES ('40',NULL,'send_otp','api/sendotpforemp','POST','127.0.0.1','{\"phone\":\"44\",\"method\":\"whatsapp\",\"value\":\"44\"}','500','71','2025-11-27 19:29:02','2025-11-27 19:29:02');
INSERT INTO `activity_logs` VALUES ('41',NULL,'send_otp','api/sendotpforemp','POST','127.0.0.1','{\"phone\":\"44\",\"method\":\"whatsapp\",\"value\":\"44\"}','500','78','2025-11-27 19:29:13','2025-11-27 19:29:13');
INSERT INTO `activity_logs` VALUES ('42',NULL,'send_otp','api/sendotpforemp','POST','127.0.0.1','{\"phone\":\"44\",\"method\":\"whatsapp\",\"value\":\"44\"}','500','34','2025-11-27 19:29:23','2025-11-27 19:29:23');
INSERT INTO `activity_logs` VALUES ('43',NULL,'send_otp','api/sendotpforemp','POST','127.0.0.1','{\"phone\":\"44\",\"method\":\"whatsapp\"}','422','69','2025-11-27 19:36:10','2025-11-27 19:36:10');
INSERT INTO `activity_logs` VALUES ('44',NULL,'send_otp','api/sendotpforemp','POST','127.0.0.1','{\"phone\":\"44\",\"method\":\"whatsapp\",\"value\":\"44\"}','200','255','2025-11-27 19:36:15','2025-11-27 19:36:15');
INSERT INTO `activity_logs` VALUES ('45',NULL,'send_otp','api/verify-otp','POST','127.0.0.1','{\"user_id\":4,\"code\":\"359240\"}','200','275','2025-11-27 19:36:29','2025-11-27 19:36:29');
INSERT INTO `activity_logs` VALUES ('46',NULL,'update','api/updateStatus/1','PATCH','127.0.0.1','{\"status\":\"in_progress\",\"note\":\"jjjjj\"}','403','142','2025-11-27 19:36:56','2025-11-27 19:36:56');
INSERT INTO `activity_logs` VALUES ('47',NULL,'login','api/login','POST','127.0.0.1','{\"phone\":\"0\"}','200','646','2025-11-27 19:37:12','2025-11-27 19:37:12');
INSERT INTO `activity_logs` VALUES ('48',NULL,'update','api/updateStatus/1','PATCH','127.0.0.1','{\"status\":\"in_progress\",\"note\":\"jjjjj\"}','403','99','2025-11-27 19:37:25','2025-11-27 19:37:25');
INSERT INTO `activity_logs` VALUES ('49',NULL,'login','api/login','POST','127.0.0.1','{\"phone\":\"44\"}','200','463','2025-11-27 19:37:41','2025-11-27 19:37:41');
INSERT INTO `activity_logs` VALUES ('50','4','update_complaint_status','api/updateStatus/1','PATCH','127.0.0.1','{\"complaint_id\":1,\"from\":\"in_progress\",\"to\":\"in_progress\"}','200',NULL,'2025-11-27 19:37:56','2025-11-27 19:37:56');
INSERT INTO `activity_logs` VALUES ('51',NULL,'update','api/updateStatus/1','PATCH','127.0.0.1','{\"status\":\"in_progress\",\"note\":\"jjjjj\"}','200','379','2025-11-27 19:37:56','2025-11-27 19:37:56');
INSERT INTO `activity_logs` VALUES ('52',NULL,'login','api/login','POST','127.0.0.1','{\"phone\":\"0\"}','200','463','2025-11-27 19:38:20','2025-11-27 19:38:20');
INSERT INTO `activity_logs` VALUES ('53',NULL,'login','api/login','POST','127.0.0.1','{\"phone\":\"4\"}','200','476','2025-11-27 19:38:31','2025-11-27 19:38:31');
INSERT INTO `activity_logs` VALUES ('54',NULL,'update','api/updateStatus/1','PATCH','127.0.0.1','{\"status\":\"in_progress\",\"note\":\"jjjjj\"}','423','149','2025-11-27 19:38:44','2025-11-27 19:38:44');
INSERT INTO `activity_logs` VALUES ('55',NULL,'view_system_overview','api/admin/dashboard','GET','127.0.0.1','[]','200',NULL,'2025-11-27 19:41:02','2025-11-27 19:41:02');
INSERT INTO `activity_logs` VALUES ('56',NULL,'get_api_admin_dashboard','api/admin/dashboard','GET','127.0.0.1','[]','200','532','2025-11-27 19:41:02','2025-11-27 19:41:02');
INSERT INTO `activity_logs` VALUES ('57',NULL,'get_api_admin_logs','api/admin/logs','GET','127.0.0.1','{\"phone\":\"2\"}','200','211','2025-11-27 19:41:19','2025-11-27 19:41:19');
INSERT INTO `activity_logs` VALUES ('58',NULL,'export_csv','api/admin/export/csv','GET','127.0.0.1','{\"type\":\"users\"}','200',NULL,'2025-11-27 19:42:26','2025-11-27 19:42:26');
INSERT INTO `activity_logs` VALUES ('59',NULL,'get_api_admin_export_csv','api/admin/export/csv','GET','127.0.0.1','{\"type\":\"users\"}','200','426','2025-11-27 19:42:27','2025-11-27 19:42:27');
INSERT INTO `activity_logs` VALUES ('60',NULL,'export_csv','api/admin/export/csv','GET','127.0.0.1','{\"type\":\"complaints\"}','200',NULL,'2025-11-27 19:42:45','2025-11-27 19:42:45');
INSERT INTO `activity_logs` VALUES ('61',NULL,'get_api_admin_export_csv','api/admin/export/csv','GET','127.0.0.1','{\"type\":\"complaints\"}','200','315','2025-11-27 19:42:45','2025-11-27 19:42:45');
INSERT INTO `activity_logs` VALUES ('62',NULL,'export_csv','api/admin/export/csv','GET','127.0.0.1','{\"type\":\"logs\"}','200',NULL,'2025-11-27 19:42:52','2025-11-27 19:42:52');
INSERT INTO `activity_logs` VALUES ('63',NULL,'get_api_admin_export_csv','api/admin/export/csv','GET','127.0.0.1','{\"type\":\"logs\"}','200','289','2025-11-27 19:42:52','2025-11-27 19:42:52');
INSERT INTO `activity_logs` VALUES ('64',NULL,'get_api_admin_export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','401','120','2025-11-27 19:43:02','2025-11-27 19:43:02');
INSERT INTO `activity_logs` VALUES ('65',NULL,'get_api_admin_export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"complaints\"}','401','59','2025-11-27 19:43:12','2025-11-27 19:43:12');
INSERT INTO `activity_logs` VALUES ('66',NULL,'get_api_admin_export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"logs\"}','401','136','2025-11-27 19:43:20','2025-11-27 19:43:20');
INSERT INTO `activity_logs` VALUES ('67',NULL,'export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"logs\"}','200',NULL,'2025-11-27 19:43:49','2025-11-27 19:43:49');
INSERT INTO `activity_logs` VALUES ('68',NULL,'get_api_admin_export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"logs\"}','200','2182','2025-11-27 19:43:51','2025-11-27 19:43:51');
INSERT INTO `activity_logs` VALUES ('69',NULL,'export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"complaints\"}','200',NULL,'2025-11-27 19:44:03','2025-11-27 19:44:03');
INSERT INTO `activity_logs` VALUES ('70',NULL,'get_api_admin_export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"complaints\"}','200','828','2025-11-27 19:44:04','2025-11-27 19:44:04');
INSERT INTO `activity_logs` VALUES ('71',NULL,'export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','200',NULL,'2025-11-27 19:44:10','2025-11-27 19:44:10');
INSERT INTO `activity_logs` VALUES ('72',NULL,'get_api_admin_export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','200','652','2025-11-27 19:44:11','2025-11-27 19:44:11');
INSERT INTO `activity_logs` VALUES ('73',NULL,'register','api/register','POST','127.0.0.1','{\"name\":\"admin\",\"email\":\"hhamode053@gmail.kcom\",\"phone\":\"0\",\"role\":\"citizen\"}','422','4235','2025-12-13 14:44:38','2025-12-13 14:44:38');
INSERT INTO `activity_logs` VALUES ('74',NULL,'register','api/register','POST','127.0.0.1','{\"name\":\"admin\",\"email\":\"hhamosde053@gmail.kcom\",\"phone\":\"0\",\"role\":\"citizen\"}','422','42','2025-12-13 14:44:46','2025-12-13 14:44:46');
INSERT INTO `activity_logs` VALUES ('75',NULL,'register','api/register','POST','127.0.0.1','{\"name\":\"admin\",\"email\":\"hhamosde053@gmail.kcom\",\"phone\":\"20\",\"role\":\"citizen\"}','201','530','2025-12-13 14:45:12','2025-12-13 14:45:12');
INSERT INTO `activity_logs` VALUES ('76',NULL,'send_otp','api/verify-otp','POST','127.0.0.1','{\"user_id\":5,\"code\":\"359240\"}','403','282','2025-12-13 14:45:27','2025-12-13 14:45:27');
INSERT INTO `activity_logs` VALUES ('77',NULL,'send_otp','api/send-otp','POST','127.0.0.1','{\"user_id\":\"5\",\"method\":\"whatsapp\"}','200','151','2025-12-13 14:45:40','2025-12-13 14:45:40');
INSERT INTO `activity_logs` VALUES ('78',NULL,'send_otp','api/verify-otp','POST','127.0.0.1','{\"user_id\":5,\"code\":\"639844\"}','200','190','2025-12-13 14:45:51','2025-12-13 14:45:51');
INSERT INTO `activity_logs` VALUES ('79',NULL,'login','api/login','POST','127.0.0.1','{\"phone\":\"20\"}','200','469','2025-12-13 14:46:01','2025-12-13 14:46:01');
INSERT INTO `activity_logs` VALUES ('80','5','create_complaint','api/complaints','POST','127.0.0.1','{\"title\":\"\\u0627\\u0646\\u0642\\u0637\\u0627\\u0639 \\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0641\\u064a \\u0627\\u0644\\u062d\\u064a\",\"description\":\"\\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0645\\u0642\\u0637\\u0648\\u0639\\u0629 \\u0645\\u0646\\u0630 \\u064a\\u0648\\u0645\\u064a\\u0646 \\u0641\\u064a \\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f\",\"department_id\":\"1\",\"location\":\"\\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f - \\u062f\\u0645\\u0634\\u0642\",\"attachments\":[{},{}],\"user_id\":5,\"reference_no\":\"CMP-20251213-0001\",\"status\":\"new\"}','200',NULL,'2025-12-13 14:46:51','2025-12-13 14:46:51');
INSERT INTO `activity_logs` VALUES ('81',NULL,'create','api/complaints','POST','127.0.0.1','{\"title\":\"\\u0627\\u0646\\u0642\\u0637\\u0627\\u0639 \\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0641\\u064a \\u0627\\u0644\\u062d\\u064a\",\"description\":\"\\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0645\\u0642\\u0637\\u0648\\u0639\\u0629 \\u0645\\u0646\\u0630 \\u064a\\u0648\\u0645\\u064a\\u0646 \\u0641\\u064a \\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f\",\"department_id\":\"1\",\"location\":\"\\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f - \\u062f\\u0645\\u0634\\u0642\"}','201','2015','2025-12-13 14:46:51','2025-12-13 14:46:51');
INSERT INTO `activity_logs` VALUES ('82','5','create_complaint','api/complaints','POST','127.0.0.1','{\"title\":\"\\u0627\\u0646\\u0642\\u0637\\u0627\\u0639 \\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0641\\u064a \\u0627\\u0644\\u062d\\u064a\",\"description\":\"\\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0645\\u0642\\u0637\\u0648\\u0639\\u0629 \\u0645\\u0646\\u0630 \\u064a\\u0648\\u0645\\u064a\\u0646 \\u0641\\u064a \\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f\",\"department_id\":\"1\",\"location\":\"\\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f - \\u062f\\u0645\\u0634\\u0642\",\"attachments\":[{}],\"user_id\":5,\"reference_no\":\"CMP-20251213-0002\",\"status\":\"new\"}','200',NULL,'2025-12-13 14:50:33','2025-12-13 14:50:33');
INSERT INTO `activity_logs` VALUES ('83',NULL,'create','api/complaints','POST','127.0.0.1','{\"title\":\"\\u0627\\u0646\\u0642\\u0637\\u0627\\u0639 \\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0641\\u064a \\u0627\\u0644\\u062d\\u064a\",\"description\":\"\\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0645\\u0642\\u0637\\u0648\\u0639\\u0629 \\u0645\\u0646\\u0630 \\u064a\\u0648\\u0645\\u064a\\u0646 \\u0641\\u064a \\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f\",\"department_id\":\"1\",\"location\":\"\\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f - \\u062f\\u0645\\u0634\\u0642\"}','201','813','2025-12-13 14:50:34','2025-12-13 14:50:34');
INSERT INTO `activity_logs` VALUES ('84',NULL,'login','api/login','POST','127.0.0.1','{\"phone\":\"0933596060\"}','200','503','2025-12-13 14:53:21','2025-12-13 14:53:21');
INSERT INTO `activity_logs` VALUES ('85',NULL,'export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','200',NULL,'2025-12-13 14:53:39','2025-12-13 14:53:39');
INSERT INTO `activity_logs` VALUES ('86',NULL,'get_api_admin_export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','500','495','2025-12-13 14:53:39','2025-12-13 14:53:39');
INSERT INTO `activity_logs` VALUES ('87',NULL,'export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','200',NULL,'2025-12-13 14:57:31','2025-12-13 14:57:31');
INSERT INTO `activity_logs` VALUES ('88',NULL,'get_api_admin_export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','500','263','2025-12-13 14:57:31','2025-12-13 14:57:31');
INSERT INTO `activity_logs` VALUES ('89',NULL,'export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','200',NULL,'2025-12-13 14:57:33','2025-12-13 14:57:33');
INSERT INTO `activity_logs` VALUES ('90',NULL,'get_api_admin_export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','500','531','2025-12-13 14:57:34','2025-12-13 14:57:34');
INSERT INTO `activity_logs` VALUES ('91',NULL,'export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','200',NULL,'2025-12-13 14:58:05','2025-12-13 14:58:05');
INSERT INTO `activity_logs` VALUES ('92',NULL,'get_api_admin_export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','500','268','2025-12-13 14:58:05','2025-12-13 14:58:05');
INSERT INTO `activity_logs` VALUES ('93',NULL,'export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','200',NULL,'2025-12-13 14:58:59','2025-12-13 14:58:59');
INSERT INTO `activity_logs` VALUES ('94',NULL,'get_api_admin_export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','500','375','2025-12-13 14:58:59','2025-12-13 14:58:59');
INSERT INTO `activity_logs` VALUES ('95',NULL,'export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','200',NULL,'2025-12-13 14:59:02','2025-12-13 14:59:02');
INSERT INTO `activity_logs` VALUES ('96',NULL,'get_api_admin_export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','500','246','2025-12-13 14:59:02','2025-12-13 14:59:02');
INSERT INTO `activity_logs` VALUES ('97',NULL,'export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','200',NULL,'2025-12-13 15:01:33','2025-12-13 15:01:33');
INSERT INTO `activity_logs` VALUES ('98',NULL,'get_api_admin_export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','500','210','2025-12-13 15:01:33','2025-12-13 15:01:33');
INSERT INTO `activity_logs` VALUES ('99','5','create_complaint','api/complaints','POST','127.0.0.1','{\"title\":\"\\u0627\\u0646\\u0642\\u0637\\u0627\\u0639 \\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0641\\u064a \\u0627\\u0644\\u062d\\u064a\",\"description\":\"\\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0645\\u0642\\u0637\\u0648\\u0639\\u0629 \\u0645\\u0646\\u0630 \\u064a\\u0648\\u0645\\u064a\\u0646 \\u0641\\u064a \\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f\",\"department_id\":\"1\",\"location\":\"\\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f - \\u062f\\u0645\\u0634\\u0642\",\"attachments\":[{}],\"user_id\":5,\"reference_no\":\"CMP-20251213-0003\",\"status\":\"new\"}','200',NULL,'2025-12-13 15:05:18','2025-12-13 15:05:18');
INSERT INTO `activity_logs` VALUES ('100',NULL,'create','api/complaints','POST','127.0.0.1','{\"title\":\"\\u0627\\u0646\\u0642\\u0637\\u0627\\u0639 \\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0641\\u064a \\u0627\\u0644\\u062d\\u064a\",\"description\":\"\\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0645\\u0642\\u0637\\u0648\\u0639\\u0629 \\u0645\\u0646\\u0630 \\u064a\\u0648\\u0645\\u064a\\u0646 \\u0641\\u064a \\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f\",\"department_id\":\"1\",\"location\":\"\\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f - \\u062f\\u0645\\u0634\\u0642\"}','201','473','2025-12-13 15:05:18','2025-12-13 15:05:18');
INSERT INTO `activity_logs` VALUES ('101','5','create_complaint','api/complaints','POST','127.0.0.1','{\"title\":\"\\u0627\\u0646\\u0642\\u0637\\u0627\\u0639 \\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0641\\u064a \\u0627\\u0644\\u062d\\u064a\",\"description\":\"\\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0645\\u0642\\u0637\\u0648\\u0639\\u0629 \\u0645\\u0646\\u0630 \\u064a\\u0648\\u0645\\u064a\\u0646 \\u0641\\u064a \\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f\",\"department_id\":\"1\",\"location\":\"\\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f - \\u062f\\u0645\\u0634\\u0642\",\"attachments\":[{}],\"user_id\":5,\"reference_no\":\"CMP-20251213-0004\",\"status\":\"new\"}','200',NULL,'2025-12-13 15:05:43','2025-12-13 15:05:43');
INSERT INTO `activity_logs` VALUES ('102',NULL,'create','api/complaints','POST','127.0.0.1','{\"title\":\"\\u0627\\u0646\\u0642\\u0637\\u0627\\u0639 \\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0641\\u064a \\u0627\\u0644\\u062d\\u064a\",\"description\":\"\\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0645\\u0642\\u0637\\u0648\\u0639\\u0629 \\u0645\\u0646\\u0630 \\u064a\\u0648\\u0645\\u064a\\u0646 \\u0641\\u064a \\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f\",\"department_id\":\"1\",\"location\":\"\\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f - \\u062f\\u0645\\u0634\\u0642\"}','201','462','2025-12-13 15:05:43','2025-12-13 15:05:43');
INSERT INTO `activity_logs` VALUES ('103','5','create_complaint','api/complaints','POST','127.0.0.1','{\"title\":\"\\u0627\\u0646\\u0642\\u0637\\u0627\\u0639 \\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0641\\u064a \\u0627\\u0644\\u062d\\u064a\",\"description\":\"\\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0645\\u0642\\u0637\\u0648\\u0639\\u0629 \\u0645\\u0646\\u0630 \\u064a\\u0648\\u0645\\u064a\\u0646 \\u0641\\u064a \\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f\",\"department_id\":\"1\",\"location\":\"\\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f - \\u062f\\u0645\\u0634\\u0642\",\"attachments\":[{},{}],\"user_id\":5,\"reference_no\":\"CMP-20251213-0005\",\"status\":\"new\"}','200',NULL,'2025-12-13 15:05:59','2025-12-13 15:05:59');
INSERT INTO `activity_logs` VALUES ('104',NULL,'create','api/complaints','POST','127.0.0.1','{\"title\":\"\\u0627\\u0646\\u0642\\u0637\\u0627\\u0639 \\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0641\\u064a \\u0627\\u0644\\u062d\\u064a\",\"description\":\"\\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0645\\u0642\\u0637\\u0648\\u0639\\u0629 \\u0645\\u0646\\u0630 \\u064a\\u0648\\u0645\\u064a\\u0646 \\u0641\\u064a \\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f\",\"department_id\":\"1\",\"location\":\"\\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f - \\u062f\\u0645\\u0634\\u0642\"}','201','541','2025-12-13 15:05:59','2025-12-13 15:05:59');
INSERT INTO `activity_logs` VALUES ('105',NULL,'export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','200',NULL,'2025-12-13 15:06:52','2025-12-13 15:06:52');
INSERT INTO `activity_logs` VALUES ('106',NULL,'get_api_admin_export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','500','272','2025-12-13 15:06:52','2025-12-13 15:06:52');
INSERT INTO `activity_logs` VALUES ('107',NULL,'export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','200',NULL,'2025-12-13 15:08:34','2025-12-13 15:08:34');
INSERT INTO `activity_logs` VALUES ('108',NULL,'get_api_admin_export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','500','204','2025-12-13 15:08:34','2025-12-13 15:08:34');
INSERT INTO `activity_logs` VALUES ('109',NULL,'create','api/complaints/1/reply','POST','127.0.0.1','{\"message\":\"aaa\"}','403','160','2025-12-13 15:10:59','2025-12-13 15:10:59');
INSERT INTO `activity_logs` VALUES ('110',NULL,'create','api/complaints/1/request-info','POST','127.0.0.1','{\"message\":\"jjjjjj\"}','403','113','2025-12-13 15:11:22','2025-12-13 15:11:22');
INSERT INTO `activity_logs` VALUES ('111',NULL,'export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','200',NULL,'2025-12-13 15:13:13','2025-12-13 15:13:13');
INSERT INTO `activity_logs` VALUES ('112',NULL,'get_api_admin_export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','500','241','2025-12-13 15:13:13','2025-12-13 15:13:13');
INSERT INTO `activity_logs` VALUES ('113',NULL,'export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','200',NULL,'2025-12-13 15:13:14','2025-12-13 15:13:14');
INSERT INTO `activity_logs` VALUES ('114',NULL,'get_api_admin_export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','500','269','2025-12-13 15:13:15','2025-12-13 15:13:15');
INSERT INTO `activity_logs` VALUES ('115',NULL,'export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','200',NULL,'2025-12-13 15:17:35','2025-12-13 15:17:35');
INSERT INTO `activity_logs` VALUES ('116',NULL,'get_api_admin_export_pdf','api/admin/export/pdf','GET','127.0.0.1','{\"type\":\"users\"}','200','1022','2025-12-13 15:17:36','2025-12-13 15:17:36');
INSERT INTO `activity_logs` VALUES ('117',NULL,'create','api/complaints/1/reply','POST','127.0.0.1','{\"message\":\"aaa\"}','403','181','2025-12-13 15:18:08','2025-12-13 15:18:08');
INSERT INTO `activity_logs` VALUES ('118',NULL,'login','api/login','POST','127.0.0.1','{\"phone\":\"0\"}','200','1401','2025-12-29 14:42:33','2025-12-29 14:42:33');
INSERT INTO `activity_logs` VALUES ('119','3','create_complaint','api/complaints','POST','127.0.0.1','{\"title\":\"\\u0627\\u0646\\u0642\\u0637\\u0627\\u0639 \\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0641\\u064a \\u0627\\u0644\\u062d\\u064a\",\"description\":\"\\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0645\\u0642\\u0637\\u0648\\u0639\\u0629 \\u0645\\u0646\\u0630 \\u064a\\u0648\\u0645\\u064a\\u0646 \\u0641\\u064a \\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f\",\"department_id\":\"1\",\"location\":\"\\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f - \\u062f\\u0645\\u0634\\u0642\",\"user_id\":3,\"reference_no\":\"CMP-20251229-0001\",\"status\":\"new\"}','200',NULL,'2025-12-29 14:42:55','2025-12-29 14:42:55');
INSERT INTO `activity_logs` VALUES ('120',NULL,'create','api/complaints','POST','127.0.0.1','{\"title\":\"\\u0627\\u0646\\u0642\\u0637\\u0627\\u0639 \\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0641\\u064a \\u0627\\u0644\\u062d\\u064a\",\"description\":\"\\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0645\\u0642\\u0637\\u0648\\u0639\\u0629 \\u0645\\u0646\\u0630 \\u064a\\u0648\\u0645\\u064a\\u0646 \\u0641\\u064a \\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f\",\"department_id\":\"1\",\"location\":\"\\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f - \\u062f\\u0645\\u0634\\u0642\"}','201','605','2025-12-29 14:42:55','2025-12-29 14:42:55');
INSERT INTO `activity_logs` VALUES ('121',NULL,'login','api/login','POST','127.0.0.1','{\"phone\":\"4\"}','200','427','2025-12-29 14:43:09','2025-12-29 14:43:09');
INSERT INTO `activity_logs` VALUES ('122','2','employee_request_more_info','api/complaints/8/request-info','POST','127.0.0.1','{\"complaint_id\":8,\"message\":\"jjjjjj\"}','200',NULL,'2025-12-29 14:44:15','2025-12-29 14:44:15');
INSERT INTO `activity_logs` VALUES ('123',NULL,'create','api/complaints/8/request-info','POST','127.0.0.1','{\"message\":\"jjjjjj\"}','200','393','2025-12-29 14:44:15','2025-12-29 14:44:15');
INSERT INTO `activity_logs` VALUES ('124','2','employee_request_more_info','api/complaints/8/request-info','POST','127.0.0.1','{\"complaint_id\":8,\"message\":\"jjjjjj\"}','200',NULL,'2025-12-29 14:45:24','2025-12-29 14:45:24');
INSERT INTO `activity_logs` VALUES ('125',NULL,'create','api/complaints/8/request-info','POST','127.0.0.1','{\"message\":\"jjjjjj\"}','200','1146','2025-12-29 14:45:24','2025-12-29 14:45:24');
INSERT INTO `activity_logs` VALUES ('126',NULL,'get_api_complaints_1_messages','api/complaints/1/messages','GET','127.0.0.1','[]','200','142','2025-12-29 14:51:29','2025-12-29 14:51:29');
INSERT INTO `activity_logs` VALUES ('127',NULL,'get_api_complaints_8_messages','api/complaints/8/messages','GET','127.0.0.1','[]','200','120','2025-12-29 14:51:35','2025-12-29 14:51:35');
INSERT INTO `activity_logs` VALUES ('128','3','citizen_reply','api/complaints/8/reply','POST','127.0.0.1','{\"complaint_id\":8,\"message\":\"aaa\"}','200',NULL,'2025-12-29 14:52:11','2025-12-29 14:52:11');
INSERT INTO `activity_logs` VALUES ('129',NULL,'create','api/complaints/8/reply','POST','127.0.0.1','{\"message\":\"aaa\"}','200','272','2025-12-29 14:52:11','2025-12-29 14:52:11');
INSERT INTO `activity_logs` VALUES ('130',NULL,'get_api_complaints_8_messages','api/complaints/8/messages','GET','127.0.0.1','[]','200','120','2025-12-29 14:52:22','2025-12-29 14:52:22');
INSERT INTO `activity_logs` VALUES ('131',NULL,'get_api_complaints_8_messages','api/complaints/8/messages','GET','127.0.0.1','[]','200','139','2025-12-29 14:52:33','2025-12-29 14:52:33');
INSERT INTO `activity_logs` VALUES ('132','2','employee_request_more_info','api/complaints/8/request-info','POST','127.0.0.1','{\"complaint_id\":8,\"message\":\"jjjjjj\"}','200',NULL,'2025-12-29 14:54:17','2025-12-29 14:54:17');
INSERT INTO `activity_logs` VALUES ('133',NULL,'create','api/complaints/8/request-info','POST','127.0.0.1','{\"message\":\"jjjjjj\"}','200','569','2025-12-29 14:54:17','2025-12-29 14:54:17');
INSERT INTO `activity_logs` VALUES ('134',NULL,'get_api_notifications','api/notifications','GET','127.0.0.1','[]','200','143','2025-12-29 14:55:18','2025-12-29 14:55:18');
INSERT INTO `activity_logs` VALUES ('135',NULL,'get_api_notifications_unread-count','api/notifications/unread-count','GET','127.0.0.1','[]','200','127','2025-12-29 14:56:37','2025-12-29 14:56:37');
INSERT INTO `activity_logs` VALUES ('136',NULL,'update','api/notifications/1/read','PATCH','127.0.0.1','[]','200','170','2025-12-29 14:56:53','2025-12-29 14:56:53');
INSERT INTO `activity_logs` VALUES ('137',NULL,'update','api/notifications/6/read','PATCH','127.0.0.1','[]','200','145','2025-12-29 14:57:04','2025-12-29 14:57:04');
INSERT INTO `activity_logs` VALUES ('138','2','update_complaint_status','api/updateStatus/8','PATCH','127.0.0.1','{\"complaint_id\":8,\"from\":\"new\",\"to\":\"in_progress\"}','200',NULL,'2025-12-29 14:57:40','2025-12-29 14:57:40');
INSERT INTO `activity_logs` VALUES ('139',NULL,'update','api/updateStatus/8','PATCH','127.0.0.1','{\"status\":\"in_progress\",\"note\":\"jjjjj\"}','200','646','2025-12-29 14:57:40','2025-12-29 14:57:40');
INSERT INTO `activity_logs` VALUES ('140',NULL,'get_api_notifications','api/notifications','GET','127.0.0.1','[]','200','127','2025-12-29 14:57:48','2025-12-29 14:57:48');
INSERT INTO `activity_logs` VALUES ('141',NULL,'register','api/register','POST','127.0.0.1','{\"name\":\"admin\",\"email\":\"hhamosde053@gmail.kcom\",\"phone\":\"20\",\"role\":\"citizen\"}','422','376','2025-12-29 15:18:51','2025-12-29 15:18:51');
INSERT INTO `activity_logs` VALUES ('142',NULL,'register','api/register','POST','127.0.0.1','{\"name\":\"admin\",\"email\":\"hhamosde053@gmail.scom\",\"phone\":\"10\",\"role\":\"citizen\"}','201','463','2025-12-29 15:19:26','2025-12-29 15:19:26');
INSERT INTO `activity_logs` VALUES ('143',NULL,'otp','api/send-otp','POST','127.0.0.1','{\"user_id\":\"6\",\"method\":\"whatsapp\"}','200','187','2025-12-29 15:19:42','2025-12-29 15:19:42');
INSERT INTO `activity_logs` VALUES ('144',NULL,'otp','api/verify-otp','POST','127.0.0.1','{\"user_id\":6,\"code\":\"496075\"}','200','206','2025-12-29 15:19:58','2025-12-29 15:19:58');
INSERT INTO `activity_logs` VALUES ('145',NULL,'login','api/login','POST','127.0.0.1','{\"phone\":\"10\"}','200','477','2025-12-29 15:20:07','2025-12-29 15:20:07');
INSERT INTO `activity_logs` VALUES ('146',NULL,'read','api/notifications','GET','127.0.0.1','[]','200','147','2025-12-29 15:21:25','2025-12-29 15:21:25');
INSERT INTO `activity_logs` VALUES ('147','3','create_complaint','api/complaints','POST','127.0.0.1','{\"title\":\"\\u0627\\u0646\\u0642\\u0637\\u0627\\u0639 \\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0641\\u064a \\u0627\\u0644\\u062d\\u064a\",\"description\":\"\\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0645\\u0642\\u0637\\u0648\\u0639\\u0629 \\u0645\\u0646\\u0630 \\u064a\\u0648\\u0645\\u064a\\u0646 \\u0641\\u064a \\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f\",\"department_id\":\"1\",\"location\":\"\\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f - \\u062f\\u0645\\u0634\\u0642\",\"user_id\":3,\"reference_no\":\"CMP-20251229-0002\",\"status\":\"new\"}','200',NULL,'2025-12-29 15:21:43','2025-12-29 15:21:43');
INSERT INTO `activity_logs` VALUES ('148',NULL,'create','api/complaints','POST','127.0.0.1','{\"title\":\"\\u0627\\u0646\\u0642\\u0637\\u0627\\u0639 \\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0641\\u064a \\u0627\\u0644\\u062d\\u064a\",\"description\":\"\\u0627\\u0644\\u0643\\u0647\\u0631\\u0628\\u0627\\u0621 \\u0645\\u0642\\u0637\\u0648\\u0639\\u0629 \\u0645\\u0646\\u0630 \\u064a\\u0648\\u0645\\u064a\\u0646 \\u0641\\u064a \\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f\",\"department_id\":\"1\",\"location\":\"\\u062d\\u064a \\u0627\\u0644\\u0648\\u0631\\u0648\\u062f - \\u062f\\u0645\\u0634\\u0642\"}','201','431','2025-12-29 15:21:44','2025-12-29 15:21:44');


DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



DROP TABLE IF EXISTS `complaint_attachments`;
CREATE TABLE `complaint_attachments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `complaint_id` bigint(20) unsigned NOT NULL,
  `storage_path` varchar(255) NOT NULL,
  `original_name` varchar(255) DEFAULT NULL,
  `mime_type` varchar(255) DEFAULT NULL,
  `size` bigint(20) DEFAULT NULL,
  `uploaded_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `complaint_attachments_complaint_id_foreign` (`complaint_id`),
  KEY `complaint_attachments_uploaded_by_foreign` (`uploaded_by`),
  CONSTRAINT `complaint_attachments_complaint_id_foreign` FOREIGN KEY (`complaint_id`) REFERENCES `complaints` (`id`) ON DELETE CASCADE,
  CONSTRAINT `complaint_attachments_uploaded_by_foreign` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `complaint_attachments` VALUES ('1','1','complaint_attachments/XoTwDbi6iiSUkXl5Bsg0IGZ9Z1qgKcMO9yAC5u49.png','allfile.png','image/png','1484270','3','2025-11-27 19:22:37','2025-11-27 19:22:37');
INSERT INTO `complaint_attachments` VALUES ('2','1','complaint_attachments/YzMuWcQNw0IXalIsVrz2gMS6XFhJKKn2pZf1BLOA.png','decsymkey.png','image/png','1232300','3','2025-11-27 19:22:37','2025-11-27 19:22:37');
INSERT INTO `complaint_attachments` VALUES ('3','2','complaint_attachments/KszfEUiV3wnuIr5I9rRSZRX7OYDFToYsaqYdxgYI.png','allfile.png','image/png','1484270','3','2025-11-27 19:24:42','2025-11-27 19:24:42');
INSERT INTO `complaint_attachments` VALUES ('4','2','complaint_attachments/rOH5hzAYFlq6ENG4CgDXiF9WEfQk7GdSu2ESBW3m.png','decsymkey.png','image/png','1232300','3','2025-11-27 19:24:42','2025-11-27 19:24:42');
INSERT INTO `complaint_attachments` VALUES ('5','3','complaint_attachments/4RzGO4qcnJM1rt00ZnI7CIhuTicbC2FknTKmlbCg.png','decsymkey.png','image/png','1232300','5','2025-12-13 14:46:50','2025-12-13 14:46:50');
INSERT INTO `complaint_attachments` VALUES ('6','3','complaint_attachments/RS1SbFdB4doiXgpAB3PS36dwgVGFdIBKyJ5QvUEu.png','enckey.png','image/png','1328161','5','2025-12-13 14:46:50','2025-12-13 14:46:50');
INSERT INTO `complaint_attachments` VALUES ('7','4','complaint_attachments/xFISVymO6hoVrvbaEqT3LnsT7iew1VCPXCtrP2Dw.png','enckey.png','image/png','1328161','5','2025-12-13 14:50:33','2025-12-13 14:50:33');
INSERT INTO `complaint_attachments` VALUES ('8','5','complaint_attachments/ka2Qbrf6vCCUw4PkKAkB7BfpYv0TIghig8MDUjDd.png','enckey.png','image/png','1328161','5','2025-12-13 15:05:18','2025-12-13 15:05:18');
INSERT INTO `complaint_attachments` VALUES ('9','6','complaint_attachments/ZSvnHgZ2P8gB5ZWLvkoEwuokIutG6TenoNYwrYwx.png','enckey.png','image/png','1328161','5','2025-12-13 15:05:43','2025-12-13 15:05:43');
INSERT INTO `complaint_attachments` VALUES ('10','7','complaint_attachments/UqO0i3SpT0S79MP79eNKUZaEwDo5mm5cH4fKdfzJ.png','enckey.png','image/png','1328161','5','2025-12-13 15:05:59','2025-12-13 15:05:59');
INSERT INTO `complaint_attachments` VALUES ('11','7','complaint_attachments/mBEzHRDRymRrX0hsbOmuaK6PdE21UBnMm5HA8mpc.png','encthemessage.png','image/png','1403075','5','2025-12-13 15:05:59','2025-12-13 15:05:59');


DROP TABLE IF EXISTS `complaint_messages`;
CREATE TABLE `complaint_messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `complaint_id` bigint(20) unsigned NOT NULL,
  `sender_id` bigint(20) unsigned NOT NULL,
  `message` text DEFAULT NULL,
  `attachment_path` varchar(255) DEFAULT NULL,
  `attachment_name` varchar(255) DEFAULT NULL,
  `type` enum('employee_request','citizen_reply') NOT NULL DEFAULT 'employee_request',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `complaint_messages_complaint_id_foreign` (`complaint_id`),
  KEY `complaint_messages_sender_id_foreign` (`sender_id`),
  CONSTRAINT `complaint_messages_complaint_id_foreign` FOREIGN KEY (`complaint_id`) REFERENCES `complaints` (`id`) ON DELETE CASCADE,
  CONSTRAINT `complaint_messages_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `complaint_messages` VALUES ('1','8','2','jjjjjj',NULL,NULL,'employee_request','2025-12-29 14:44:15','2025-12-29 14:44:15');
INSERT INTO `complaint_messages` VALUES ('2','8','2','jjjjjj','complaint_messages/6Acx4ZB207wlKCQKtDYObLKtoNQvaWAq7LFgp6Df.png','createkeyforbob.png','employee_request','2025-12-29 14:45:24','2025-12-29 14:45:24');
INSERT INTO `complaint_messages` VALUES ('3','8','3','aaa','complaint_messages/fpSw9L49DW7lUEvksTnYGrK416gy6Ouamv1sKI7P.png','enckey.png','citizen_reply','2025-12-29 14:52:11','2025-12-29 14:52:11');
INSERT INTO `complaint_messages` VALUES ('4','8','2','jjjjjj','complaint_messages/ESm4lbM2miYSsvjbUjErjfU1V3zUy6hzpGlO0Ohg.png','createkeyforbob.png','employee_request','2025-12-29 14:54:17','2025-12-29 14:54:17');


DROP TABLE IF EXISTS `complaint_status_histories`;
CREATE TABLE `complaint_status_histories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `complaint_id` bigint(20) unsigned NOT NULL,
  `from_status` varchar(255) DEFAULT NULL,
  `to_status` varchar(255) NOT NULL,
  `changed_by` bigint(20) unsigned DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `complaint_status_histories_complaint_id_foreign` (`complaint_id`),
  KEY `complaint_status_histories_changed_by_foreign` (`changed_by`),
  CONSTRAINT `complaint_status_histories_changed_by_foreign` FOREIGN KEY (`changed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `complaint_status_histories_complaint_id_foreign` FOREIGN KEY (`complaint_id`) REFERENCES `complaints` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `complaint_status_histories` VALUES ('1','1','new','in_progress','2','jjjjj','2025-11-27 19:27:43','2025-11-27 19:27:43');
INSERT INTO `complaint_status_histories` VALUES ('2','1','in_progress','in_progress','2','jjjjj','2025-11-27 19:28:12','2025-11-27 19:28:12');
INSERT INTO `complaint_status_histories` VALUES ('3','1','in_progress','in_progress','4','jjjjj','2025-11-27 19:37:56','2025-11-27 19:37:56');
INSERT INTO `complaint_status_histories` VALUES ('4','8','new','in_progress','2','jjjjj','2025-12-29 14:57:39','2025-12-29 14:57:39');


DROP TABLE IF EXISTS `complaints`;
CREATE TABLE `complaints` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `department_id` bigint(20) unsigned DEFAULT NULL,
  `assigned_to` bigint(20) unsigned DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `status` enum('new','in_progress','resolved','rejected','closed') NOT NULL DEFAULT 'new',
  `locked_by` bigint(20) unsigned DEFAULT NULL,
  `locked_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `complaints_reference_no_unique` (`reference_no`),
  KEY `complaints_user_id_foreign` (`user_id`),
  KEY `complaints_department_id_foreign` (`department_id`),
  KEY `complaints_assigned_to_foreign` (`assigned_to`),
  CONSTRAINT `complaints_assigned_to_foreign` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `complaints_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL,
  CONSTRAINT `complaints_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `complaints` VALUES ('1','CMP-20251127-0001','3','1',NULL,'انقطاع الكهرباء في الحي','الكهرباء مقطوعة منذ يومين في حي الورود','حي الورود - دمشق','in_progress','4','2025-11-27 19:37:56','2025-11-27 19:22:36','2025-11-27 19:37:56',NULL);
INSERT INTO `complaints` VALUES ('2','CMP-20251127-0002','3','1',NULL,'انقطاع الكهرباء في الحي','الكهرباء مقطوعة منذ يومين في حي الورود','حي الورود - دمشق','new',NULL,NULL,'2025-11-27 19:24:42','2025-11-27 19:24:42',NULL);
INSERT INTO `complaints` VALUES ('3','CMP-20251213-0001','5','1',NULL,'انقطاع الكهرباء في الحي','الكهرباء مقطوعة منذ يومين في حي الورود','حي الورود - دمشق','new',NULL,NULL,'2025-12-13 14:46:49','2025-12-13 14:46:49',NULL);
INSERT INTO `complaints` VALUES ('4','CMP-20251213-0002','5','1',NULL,'انقطاع الكهرباء في الحي','الكهرباء مقطوعة منذ يومين في حي الورود','حي الورود - دمشق','new',NULL,NULL,'2025-12-13 14:50:33','2025-12-13 14:50:33',NULL);
INSERT INTO `complaints` VALUES ('5','CMP-20251213-0003','5','1',NULL,'انقطاع الكهرباء في الحي','الكهرباء مقطوعة منذ يومين في حي الورود','حي الورود - دمشق','new',NULL,NULL,'2025-12-13 15:05:18','2025-12-13 15:05:18',NULL);
INSERT INTO `complaints` VALUES ('6','CMP-20251213-0004','5','1',NULL,'انقطاع الكهرباء في الحي','الكهرباء مقطوعة منذ يومين في حي الورود','حي الورود - دمشق','new',NULL,NULL,'2025-12-13 15:05:43','2025-12-13 15:05:43',NULL);
INSERT INTO `complaints` VALUES ('7','CMP-20251213-0005','5','1',NULL,'انقطاع الكهرباء في الحي','الكهرباء مقطوعة منذ يومين في حي الورود','حي الورود - دمشق','new',NULL,NULL,'2025-12-13 15:05:59','2025-12-13 15:05:59',NULL);
INSERT INTO `complaints` VALUES ('8','CMP-20251229-0001','3','1',NULL,'انقطاع الكهرباء في الحي','الكهرباء مقطوعة منذ يومين في حي الورود','حي الورود - دمشق','in_progress','2','2025-12-29 14:57:39','2025-12-29 14:42:55','2025-12-29 14:57:39',NULL);
INSERT INTO `complaints` VALUES ('9','CMP-20251229-0002','3','1',NULL,'انقطاع الكهرباء في الحي','الكهرباء مقطوعة منذ يومين في حي الورود','حي الورود - دمشق','new',NULL,NULL,'2025-12-29 15:21:43','2025-12-29 15:21:43',NULL);


DROP TABLE IF EXISTS `database_backups`;
CREATE TABLE `database_backups` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `status` enum('success','failed') NOT NULL,
  `error` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `database_backups` VALUES ('1','backup_2025_12_29_154639.sql','backups/backup_2025_12_29_154639.sql','failed','Backup failed','2025-12-29 15:46:39','2025-12-29 15:46:39');
INSERT INTO `database_backups` VALUES ('2','backup_2025_12_29_154817.sql','backups/backup_2025_12_29_154817.sql','failed','Backup failed','2025-12-29 15:48:17','2025-12-29 15:48:17');
INSERT INTO `database_backups` VALUES ('3','backup_2025_12_29_154837.sql','backups/backup_2025_12_29_154837.sql','failed','Backup failed','2025-12-29 15:48:37','2025-12-29 15:48:37');
INSERT INTO `database_backups` VALUES ('4','backup_2025_12_29_154914.sql','backups/backup_2025_12_29_154914.sql','failed','Backup failed','2025-12-29 15:49:14','2025-12-29 15:49:14');
INSERT INTO `database_backups` VALUES ('5','backup_2025_12_29_155346.sql','backups/backup_2025_12_29_155346.sql','failed','Backup failed','2025-12-29 15:53:46','2025-12-29 15:53:46');
INSERT INTO `database_backups` VALUES ('6','backup_2025_12_29_155544.sql','backups/backup_2025_12_29_155544.sql','failed','Backup failed','2025-12-29 15:55:44','2025-12-29 15:55:44');
INSERT INTO `database_backups` VALUES ('7','backup_2025_12_29_155548.sql','backups/backup_2025_12_29_155548.sql','failed','Backup failed','2025-12-29 15:55:48','2025-12-29 15:55:48');
INSERT INTO `database_backups` VALUES ('8','backup_2025_12_29_160121.sql','backups/backup_2025_12_29_160121.sql','failed','Backup failed','2025-12-29 16:01:21','2025-12-29 16:01:21');
INSERT INTO `database_backups` VALUES ('9','backup_2025_12_29_160141.sql','backups/backup_2025_12_29_160141.sql','failed','Backup failed','2025-12-29 16:01:41','2025-12-29 16:01:41');
INSERT INTO `database_backups` VALUES ('10','backup_2025_12_29_160246.sql','backups/backup_2025_12_29_160246.sql','failed','Backup failed','2025-12-29 16:02:46','2025-12-29 16:02:46');
INSERT INTO `database_backups` VALUES ('11','backup_2025_12_29_162927.sql','backups/backup_2025_12_29_162927.sql','failed','Backup failed','2025-12-29 16:29:27','2025-12-29 16:29:27');
INSERT INTO `database_backups` VALUES ('12','backup_2025_12_29_163407.sql','backups/backup_2025_12_29_163407.sql','success',NULL,'2025-12-29 16:34:08','2025-12-29 16:34:08');


DROP TABLE IF EXISTS `departments`;
CREATE TABLE `departments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `departments` VALUES ('1','مؤسسة المياه','WATE','المؤسسة العامة للمياه في دمشق','2025-11-27 19:16:43','2025-11-27 19:16:43');


DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `migrations` VALUES ('1','0001_01_00_000000_create_departments_table','1');
INSERT INTO `migrations` VALUES ('2','0001_01_01_000000_create_users_table','1');
INSERT INTO `migrations` VALUES ('3','0001_01_01_000001_create_cache_table','1');
INSERT INTO `migrations` VALUES ('4','0001_01_01_000002_create_jobs_table','1');
INSERT INTO `migrations` VALUES ('5','2025_11_08_164805_create_personal_access_tokens_table','1');
INSERT INTO `migrations` VALUES ('6','2025_11_08_164913_create_complaints_table','1');
INSERT INTO `migrations` VALUES ('7','2025_11_08_164919_create_complaint_attachments_table','1');
INSERT INTO `migrations` VALUES ('8','2025_11_08_164927_create_complaint_status_histories_table','1');
INSERT INTO `migrations` VALUES ('9','2025_11_08_164933_create_otp_codes_table','1');
INSERT INTO `migrations` VALUES ('10','2025_11_08_170002_create_activity_logs_table','1');
INSERT INTO `migrations` VALUES ('11','2025_11_10_200729_create_complaint_messages_table','1');
INSERT INTO `migrations` VALUES ('12','2025_11_22_170733_create_notifications_table','1');
INSERT INTO `migrations` VALUES ('13','2025_12_29_153013_create_database_backups_table','2');


DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` text DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `related_model` varchar(255) DEFAULT NULL,
  `related_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_user_id_foreign` (`user_id`),
  CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `notifications` VALUES ('1','3','تغيير حالة الشكوى','تم تغيير حالة شكواك رقم CMP-20251127-0001 إلى in_progress','1','App\\Models\\Complaint','1','2025-11-27 19:27:43','2025-12-29 14:56:53');
INSERT INTO `notifications` VALUES ('2','3','تغيير حالة الشكوى','تم تغيير حالة شكواك رقم CMP-20251127-0001 إلى in_progress','0','App\\Models\\Complaint','1','2025-11-27 19:28:12','2025-11-27 19:28:12');
INSERT INTO `notifications` VALUES ('3','3','تغيير حالة الشكوى','تم تغيير حالة شكواك رقم CMP-20251127-0001 إلى in_progress','0','App\\Models\\Complaint','1','2025-11-27 19:37:56','2025-11-27 19:37:56');
INSERT INTO `notifications` VALUES ('4','3','طلب معلومات إضافية','يرجى تزويدنا بمعلومات إضافية للشكوى رقم CMP-20251229-0001','0','App\\Models\\Complaint','8','2025-12-29 14:44:15','2025-12-29 14:44:15');
INSERT INTO `notifications` VALUES ('5','3','طلب معلومات إضافية','يرجى تزويدنا بمعلومات إضافية للشكوى رقم CMP-20251229-0001','0','App\\Models\\Complaint','8','2025-12-29 14:45:24','2025-12-29 14:45:24');
INSERT INTO `notifications` VALUES ('6','3','طلب معلومات إضافية','يرجى تزويدنا بمعلومات إضافية للشكوى رقم CMP-20251229-0001','1','App\\Models\\Complaint','8','2025-12-29 14:54:17','2025-12-29 14:57:04');
INSERT INTO `notifications` VALUES ('7','3','تغيير حالة الشكوى','تم تغيير حالة شكواك رقم CMP-20251229-0001 إلى in_progress','0','App\\Models\\Complaint','8','2025-12-29 14:57:40','2025-12-29 14:57:40');


DROP TABLE IF EXISTS `otp_codes`;
CREATE TABLE `otp_codes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `contact` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `attempts` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `otp_codes_user_id_foreign` (`user_id`),
  CONSTRAINT `otp_codes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `personal_access_tokens` VALUES ('1','App\\Models\\User','1','api_token','dd130d3260c0c1f4f6c1d270b9a931ae570feb07c17abf55aea3f81e5a4091a9','[\"*\"]','2025-11-27 19:44:10',NULL,'2025-11-27 19:16:12','2025-11-27 19:44:10');
INSERT INTO `personal_access_tokens` VALUES ('2','App\\Models\\User','2','api_token','f41ecd2e6ec6e24261796b79272e99b87da1990ac45801ed9c0de6f0276fa386','[\"*\"]','2025-11-27 19:28:12',NULL,'2025-11-27 19:19:48','2025-11-27 19:28:12');
INSERT INTO `personal_access_tokens` VALUES ('3','App\\Models\\User','3','api_token','56a939dcf337f97b77a6702383da6cd32af1c2d4a18b5c222fc07dacc1a7109d','[\"*\"]','2025-11-27 19:36:56',NULL,'2025-11-27 19:21:22','2025-11-27 19:36:56');
INSERT INTO `personal_access_tokens` VALUES ('4','App\\Models\\User','3','api_token','3e6538b6b25d48ff20d03727d38ec04c74616db2fc624a2eebe56bd3faa969c6','[\"*\"]','2025-11-27 19:37:25',NULL,'2025-11-27 19:37:11','2025-11-27 19:37:25');
INSERT INTO `personal_access_tokens` VALUES ('5','App\\Models\\User','4','api_token','fc8a51103362d3c6993b7ed13866c7a97dd94c4211ef6c3846a76bb1b6b78618','[\"*\"]','2025-11-27 19:37:56',NULL,'2025-11-27 19:37:41','2025-11-27 19:37:56');
INSERT INTO `personal_access_tokens` VALUES ('6','App\\Models\\User','3','api_token','0de5ee8b835fd0c4471d8a8d2307caa99129582a67a772ae4be3df47e7d9815c','[\"*\"]',NULL,NULL,'2025-11-27 19:38:20','2025-11-27 19:38:20');
INSERT INTO `personal_access_tokens` VALUES ('7','App\\Models\\User','2','api_token','87d5e49eb01ff96157d932cb142d0253ab54b0e5f77ef4167cf39dffa0412561','[\"*\"]','2025-11-27 19:38:44',NULL,'2025-11-27 19:38:31','2025-11-27 19:38:44');
INSERT INTO `personal_access_tokens` VALUES ('8','App\\Models\\User','5','api_token','4e7017bca5e1efb2774a3486eef8cbe7e38858fda89216c8e94504ddae8205a3','[\"*\"]','2025-12-13 15:18:08',NULL,'2025-12-13 14:46:01','2025-12-13 15:18:08');
INSERT INTO `personal_access_tokens` VALUES ('9','App\\Models\\User','1','api_token','22d4961f0ce0cc52b13fbbb94ff53f63121589d23ebbdda97d1da452dcad6aca','[\"*\"]','2025-12-13 15:17:35',NULL,'2025-12-13 14:53:21','2025-12-13 15:17:35');
INSERT INTO `personal_access_tokens` VALUES ('10','App\\Models\\User','3','api_token','c9b6b68a6162f5d492d6519b219028d4c9d5a3c4aed2aa7f4b42adefdc45b56b','[\"*\"]','2025-12-29 15:21:43',NULL,'2025-12-29 14:42:33','2025-12-29 15:21:43');
INSERT INTO `personal_access_tokens` VALUES ('11','App\\Models\\User','2','api_token','af7b411794ca49839094d497dbee8aead3311688961325e53c60b7c77aa878c8','[\"*\"]','2025-12-29 14:57:39',NULL,'2025-12-29 14:43:09','2025-12-29 14:57:39');
INSERT INTO `personal_access_tokens` VALUES ('12','App\\Models\\User','6','api_token','c4a1567f12a8d6470a78396ee1ca287ae7d9b4b87d298576a178535d39499ee2','[\"*\"]','2025-12-29 15:21:24',NULL,'2025-12-29 15:20:06','2025-12-29 15:21:24');


DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('citizen','employee','admin') NOT NULL DEFAULT 'citizen',
  `department_id` bigint(20) unsigned DEFAULT NULL,
  `phone_verified_at` timestamp NULL DEFAULT NULL,
  `failed_attempts` int(11) NOT NULL DEFAULT 0,
  `locked_until` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_phone_unique` (`phone`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_department_id_foreign` (`department_id`),
  CONSTRAINT `users_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` VALUES ('1','admin','hhamode053@gmail.com','0933596060','$2y$12$TMWxdAfS95HoqPqoSlB6JeIvlG/o40OhdfEuJuma1kBo66o86M4f6','admin',NULL,'2025-11-27 19:04:19','0',NULL,NULL,'2025-11-27 19:03:27','2025-11-27 19:16:12');
INSERT INTO `users` VALUES ('2','ahmad','ahdmdad5@edxample.com','4','$2y$12$kmqzgdOit.499.5YdwNBYuqhJNXt9b5.2UZD1bC858dJpVOidKBkK','employee','1','2025-11-27 19:18:51','0',NULL,NULL,'2025-11-27 19:17:54','2025-11-27 19:18:51');
INSERT INTO `users` VALUES ('3','admin','hhamode053@gmail.kcom','0','$2y$12$N97A.zogCVjhHCD/mfdstOiQsNFjupOTc0tvbRoTwrWgQAxzyGoYy','citizen',NULL,'2025-11-27 19:21:14','0',NULL,NULL,'2025-11-27 19:20:47','2025-11-27 19:21:14');
INSERT INTO `users` VALUES ('4','ahmad','ahdmdasd5@edxample.com','44','$2y$12$X8qc0js9I/Z3sQVehCmpE.dCbhlQZsJoqVHJ/EErEHZIjF3VeTBx6','employee','1','2025-11-27 19:36:29','0',NULL,NULL,'2025-11-27 19:28:30','2025-11-27 19:36:29');
INSERT INTO `users` VALUES ('5','admin','hhamosde053@gmail.kcom','20','$2y$12$KqNzEugndoPmmja8R2LTHugJ4I0e2RixAIOr1IWoD8NWuUVeaSPm.','citizen',NULL,'2025-12-13 14:45:51','0',NULL,NULL,'2025-12-13 14:45:12','2025-12-13 14:45:51');
INSERT INTO `users` VALUES ('6','admin','hhamosde053@gmail.scom','10','$2y$12$Z5hXKl.NkjYGzaSx3GPJ6.UKh2s.IXIq/847EQLa5C584raDY6Xwu','citizen',NULL,'2025-12-29 15:19:58','0',NULL,NULL,'2025-12-29 15:19:26','2025-12-29 15:19:58');

SET FOREIGN_KEY_CHECKS=1;
