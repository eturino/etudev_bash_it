#
# Cookbook Name:: etudev_bash_it
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

users = node[:etudev_bash_it][:users].to_a.uniq

repository = node[:etudev_bash_it][:repository]

users.each do |u|

  if !node['etc'].nil? && !node['etc']['passwd'].nil? && !node['etc']['passwd'][u].nil? && !node['etc']['passwd'][u]['dir'].nil?
    home_dir = node['etc']['passwd'][u]['dir']
  elsif !node['rbenv']['user_home_root'].nil?
    home_dir = ::File.join(node['rbenv']['user_home_root'], u)
  else
    home_dir = ::File.join(node['user']['home_root'], u)
  end

  home_folder = home_dir
  bashit_folder = "#{home_folder}/.bash_it"
  bash_profile_path = "#{home_folder}/.bash_profile"

  bashit_folderpath = Pathname.new bashit_folder
  git_revision_filename = bashit_folderpath.join '.git_revision'
  installed_revision_filename = bashit_folderpath.join '.installed_revision'

  # GIT
  git bashit_folder do
    repository repository
    reference "master"
    action :sync
  end

  # update the REVISION file
  bash "update_bashit_revision" do
    cwd bashit_folder
    code "git rev-parse HEAD > #{git_revision_filename.to_s}"
  end
  
  bash "install_bashit" do
    cwd bashit_folder
    code <<-EOH
    sudo #{bashit_folder}/auto_install_small.sh #{home_folder} ;

    sudo chown -R #{u} #{bashit_folder} ;
    sudo chown #{u} #{bash_profile_path} ;
    
    cp #{git_revision_filename} #{installed_revision_filename} ;
    EOH

    not_if do 
      ::File.exists?(installed_revision_filename) && ::File.read(git_revision_filename) == ::File.read(installed_revision_filename)
    end

  end
end

