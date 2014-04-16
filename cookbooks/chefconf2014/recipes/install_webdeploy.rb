windows_package "Microsoft Web Deploy 2.0" do
	source node.default['package_sources']['web_deploy']
	action :install
	options " /qn /norestart /L c:\\chef\\log\\web_deploy_install.log"
	installer_type :msi
end
