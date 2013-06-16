#
# Cookbook Name:: clojure
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file "/usr/local/bin/lein" do
  source "https://raw.github.com/technomancy/leiningen/stable/bin/lein"
  mode "755"
  owner "root"
  group "root"
  backup false
end
