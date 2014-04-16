fx_path = "C:\\Windows\\Microsoft.NET\\Framework\\v4.0.30319"
regiis_exe = "aspnet_regiis.exe"

execute "Register ASP.NET MVC" do
	command "#{fx_path}\\#{regiis_exe} -iru"
	action :run
end
