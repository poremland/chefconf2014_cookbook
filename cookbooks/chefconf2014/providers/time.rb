require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut

action :set_timezone do
	new_timezone = "#{@new_resource.new_timezone}"
	set_timezone_command = "tzutil /s \"#{new_timezone}\""
	execute "Setting timezone to #{new_timezone}" do
		command set_timezone_command
		action :run
	end
end

action :set_hourly_sync do
  windows_registry 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\W32Time\TimeProviders\NtpClient' do
    type :dword
    values 'SpecialPollInterval' => 3600
  end

  windows_registry 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Config' do
    type :dword
    values 'UpdateInterval' => 3600
  end
end

action :sync do
	sync_command = "w32tm /resync"
	execute "Syncing Windows time" do
		command sync_command
		action :run
	end
end

action :start do
  cmd = shell_out("net start w32time", { :returns => [0,1] })
  if (cmd.stderr.empty? && (cmd.stdout =~ /^.*The requested service has already been started.*$/i))
    Chef::Log("w32time has already been started")
  end
end
