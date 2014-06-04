# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.box = "precise64"

	config.vm.synced_folder ".", "/home/vagrant/.dotfiles"

	config.vm.provider :virtualbox do |v|
		v.name = "callum_dotfiles_test"
	end
end
