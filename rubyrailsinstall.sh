#!/bin/bash

#Rails環境構築のための準備をするシェルスクリプト

#基本的な必要ライブラリをインストール
echo "基本的な必要ライブラリをインストール中だよん"
sudo yum -y install gcc
sudo yum -y install make
sudo yum -y install gcc-c++
sudo yum -y install zlib-devel
sudo yum -y install httpd-devel
sudo yum -y install openssl-devel
sudo yum -y install curl-devel
sudo yum --enablerepo=epel,remi,rpmforge install libxml2 libxml2-devel
sudo yum --enablerepo=epel,remi,rpmforge install libxslt libxslt-devel
sudo yum update
sudo yum -y install ruby-devel

# ファイアーウォール設定
sudo chkconfig httpd on
sudo service iptables stop
sudo chkconfig iptables off

echo "mysqlをインストール中だよん"
sudo yum --enablerepo=epel,remi,rpmforge install libxml2 libxml2-devel
sudo yum --enablerepo=epel,remi,rpmforge install libxslt libxslt-devel

sudo yum install mysql-server mysql-devel
sudo service mysqld start

# nginxインストール
echo "nginxのインストール中だよん"
sudo touch /etc/yum.repos.d/nginx.repo
# このあたりは右のurlを見てね。http://webkaru.net/linux/centos-6-3-nginx-install/
# sudo touch /etc/yum.repos.d/nginx.repo の後
# sudo vi /etc/yum.repos.d/nginx.repo を実行

# その後
# [nginx]
# name=nginx repo
# baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
# gpgcheck=0
# enabled=1
# 以上をコピペでok.



# このあと以下のインストールが通るはず。

sudo yum -y install nginx
sudo /etc/init.d/nginx start
# これでnginxのインストールはうまくいったはずだワン！。

# ImageMagickインストール
echo "ImageMagickのインストール中だワン！"
sudo yum -y install libjpeg-devel libpng-devel
sudo yum -y install ImageMagick ImageMagick-devel

# CentOSに入ってるRubyはバージョンが古いのでアンインストール
sudo yum -y remove ruby

# gitをインストール
echo "gitのインストール中だよん"
sudo yum -y install git

# rbenvインストール
echo "rbenvのインストール中だよん"
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
mkdir -p ~/.rbenv/plugins
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
cd ~/.rbenv/plugins/ruby-build
sudo ./install.sh
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile

# rbenv

#Ruby 2.2.1をinstallするために足したコード
git clone https://github.com/rkh/rbenv-update.git ~/.rbenv/plugins/rbenv-update
rbenv update
sudo yum install libffi-devel

#RubyとRailsをインストールするシェルスクリプト

# Rubyのインストール
echo "Rubyのインストール中だよん"
rbenv install 2.2.2
rbenv rehash
rbenv global 2.2.2
ruby -v

#Railsインストールで詰まるので事前に回避
gem install nokogiri -- --use-system-libraries

# Railsのインストール
echo "Railsのインストール中だよん"
rbenv exec gem install rails -v 4.2.1
rbenv rehash
source ~/.bash_profile
