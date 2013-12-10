<?php
// データベース接続
do_zip_update('localhost');

function do_zip_update($server)
{
        $db2 = mysql_connect($server,'user_id','password');
        mysql_select_db('zip_cnv');
        if(function_exists(‘mysql_set_charset’))  {
                mysql_set_charset('utf8');
        } else {
                mysql_query('set names utf8');
        }

		
        $fp = fopen('zip.csv','r');
        if($fp!== FALSE) {
                $sql = "TRUNCATE TABLE `zip`";
                mysql_query($sql);
                while (($data = fgetcsv($fp, 1000)) !== FALSE) {
                        $num = count($data);
                        if($num >= 14) {
                                $sql = 'REPLACE INTO `zip` (`id`, `addr`, `comment`, `is_default`) VALUES (';
                                $sql .= " '".mysql_escape_string($data[2])."' , ";
                                $sql .= " '".mysql_escape_string($data[6].$data[7]);

                                if($data[8]==='以下に掲載がない場合') {
                                        $sql .= "', '' , '1' )";
                                } else {
                                        if($data[12] == 1) {    // 1つの〒番号で複数の町名を表す場合
                                                // 出力しない
                                                $sql .= "', '' , '0' )";
                                        } else {
                                                if(preg_match('/^(.*)（(.*)）(.*)$/',$data[8], $p)) {
                                                        $sql .= mysql_escape_string($p[1])."', '".mysql_escape_string($p[2])."' , '0' )";
                                                } else {
                                                        $sql .= mysql_escape_string($data[8])."', '' , '0' )";
                                                }
                                        }
                                }
                                mysql_query($sql);
                        }

                }
                fclose($fp);
        }

        mysql_close($db2);
}
?>
