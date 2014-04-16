node.default['iis']['features_list'].each do |feature|
	windows_feature feature do
		action :install
	end
end
