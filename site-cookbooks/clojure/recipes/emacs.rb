log 'install emacs'
log node['emacs']['site_url']

# prepare
package "git"

directory node['emacs']['working_dir'] do
  action :create
end

bash 'install-emacs' do
  action :nothing
  cwd node['emacs']['working_dir']
  code <<-END
tar xzvf #{node['emacs']['file_name']}
cd #{File.basename(node['emacs']['file_name'], '.tar.gz')}
./configure --with-x-toolkit=no --with-xpm=no --with-jpeg=no --with-png=no --with-gif=no --with-tiff=no
make
make install
END
end

remote_file File.join(node['emacs']['working_dir'], node['emacs']['file_name']) do
  action :create_if_missing
  source node['emacs']['site_url'] + node['emacs']['file_name']
  notifies :run, 'bash[install-emacs]', :immediately
end

# Emacs settings
directory node['emacs']['home_dir'] do
  action :create
end

template "init.el" do
  path node['emacs']['home_dir'] + "/init.el"
  group "vagrant"
  owner "vagrant"
  source "init.el"
end  



