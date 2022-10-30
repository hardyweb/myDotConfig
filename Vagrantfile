# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.



Vagrant.configure("2") do |config|

  config.vm.box = "debian/bullseye64"
  #buat port forward untuk guna adminer dari nginx
  config.vm.network "forwarded_port", guest: 80, host: 8080
  #buat port forward untuk guna laravel 
  #php artisan serve --host 0.0.0.0
  config.vm.network "forwarded_port", guest: 8000, host: 8002

  config.vm.provider "virtualbox" do |vb|
  #   vb.gui = true
    vb.memory = "1024"
    vb.name = "Debian 11"
    
  end
  
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.

   #if you run this vagrant behind proxy, then set proxy first,before apt update, uncomment two lines below, 
# if Vagrant.has_plugin?("vagrant-proxyconf")
#    config.proxy.http     = "http://192.168.0.1:3128/"
 #   config.proxy.https    = "http://192.168.0.1:3128/"
  #  config.proxy.no_proxy = "localhost,127.0.0.1,.example.org"
#  end
  
  config.vm.provision "shell", inline: <<-SHELL

 sudo su
      apt-get update
     apt-get install -y git lsb-release apt-transport-https ca-certificates curl
     curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg
     sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
     apt-get update

     apt install php8.1 mariadb-server nginx -y

     apt install php8.1-{bcmath,fpm,xml,mysql,zip,intl,ldap,gd,cli,bz2,curl,mbstring,pgsql,opcache,soap,cgi} -y

     wget -c https://getcomposer.org/download/latest-stable/composer.phar
     chmod +x composer.phar
     mv composer.phar /usr/local/bin/composer
   
     wget https://www.adminer.org/latest.php -O /var/www/html/adminer.php
     
    apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip doxygen -y
    git clone https://github.com/neovim/neovim
    cd neovim && make
	make install
	cd ..
	rm -rf neovim
	su vagrant && cd ~
	
	wget -c https://gitlab.com/hardyweb/vim/-/raw/master/.bashrc
	mkdir .config/nvim
	cd .config/nvim
	wget -c https://gitlab.com/hardyweb/vim/-/raw/master/init-compe.lua
  mv init-compe.lua init.lua
	cd ~
	nvim --headless +PackerInstall +qa
    SHELL
end

