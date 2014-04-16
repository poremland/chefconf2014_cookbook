windows_package "Microsoft .NET Framework 4.5" do
	source node.default['package_sources']['dotnet_4_5']
	action :install
	options "/q"
	timeout 1200
	installer_type :inno
end
