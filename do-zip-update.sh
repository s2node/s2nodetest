#!/bin/sh
# 郵政省の公式サイトの郵便番号辞書をダウンロードしてくる
# 週に1回ダウンロードするように設定してある。
cd ~/zip
if [ -d zip_work ]; then
    rm -r zip_work
fi
mkdir zip_work
cd zip_work
wget http://www.post.japanpost.jp/zipcode/dl/kogaki/lzh/ken_all.lzh
lha x ken_all.lzh
if [ -f KEN_ALL.CSV ]; then
        nkf -O -Lu -d -S -w8 -X KEN_ALL.CSV zip.csv
fi
if [ -f ken_all.csv ]; then
        nkf -O -Lu -d -S -w8 -X ken_all.csv zip.csv
fi
# 郵便番号辞書をデータベースに格納する。
php ../zip-up.php

