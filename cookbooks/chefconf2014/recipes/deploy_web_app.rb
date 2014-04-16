# create iis app pool
iis_pool node['webapp']['name'] do
  runtime_version node['webapp']['app_pool']['runtime_version']
  pipeline_mode :Integrated
  action [:add, :config, :stop]
end

# create the site directory
directory "#{node['iis']['docroot']}/#{node['webapp']['name']}" do
  recursive true
  action :create
end

# create iis site
iis_site "#{node['webapp']['name']}" do
  site_name "#{node['webapp']['name']}"
  port node['webapp']['site']['config']['port']
  path "#{node['iis']['docroot']}/#{node['webapp']['name']}"
  application_pool "#{node['webapp']['name']}"
  action [:add,:start]
end

# open firewall for app
chefconf2014_firewall node['firewall']['rule_name'] do
	action :add
	firewall_action :Allow
	direction :In
	protocol :tcp
	ports node['firewall']['ports']
end

# create the temp directory
directory "#{node['webapp']['local_directory']}" do
  recursive true
  action :create
end

# copy the web app to a temp directory
cookbook_file node['webapp']['package'] do
  path "#{node['webapp']['local_directory']}/#{node['webapp']['package']}"
  action :create
end

# deploy app
chefconf2014_web_deploy "#{node['webapp']['local_directory']}/#{node['webapp']['package']}" do
  parameters node['webapp']['parameters']
end

# start app pool
iis_pool node['webapp']['name'] do
  action :start
end
