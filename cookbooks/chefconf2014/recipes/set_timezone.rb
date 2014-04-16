chefconf2014_time "Setting timezone to #{node['timezone']}" do
	new_timezone "#{node['timezone']}"
	action :set_timezone
end
