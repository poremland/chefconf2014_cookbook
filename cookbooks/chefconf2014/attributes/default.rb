# timezone settings
default['timezone'] = "Pacific Standard Time"

# iis settings
default['iis']['features_list'] = ["IIS-WebServerRole"]
default['iis']['features_list'] << "IIS-WebServer"
default['iis']['features_list'] << "IIS-CommonHttpFeatures"
default['iis']['features_list'] << "IIS-HttpRedirect"
default['iis']['features_list'] << "IIS-ISAPIFilter"
default['iis']['features_list'] << "IIS-ISAPIExtensions"
default['iis']['features_list'] << "IIS-NetFxExtensibility"
default['iis']['features_list'] << "IIS-ASPNET"
default['iis']['features_list'] << "IIS-HostableWebCore"
default['iis']['features_list'] << "IIS-WindowsAuthentication"
default['iis']['features_list'] << "NetFx3"
default['iis']['features_list'] << "MicrosoftWindowsPowerShellISE"
default['iis']['features_list'] << "WAS-WindowsActivationService"
default['iis']['features_list'] << "WAS-ConfigurationAPI"
default['iis']['features_list'] << "WAS-NetFxEnvironment"

# .Net 4.5
default['package_sources']['dotnet_4_5'] = "http://download.microsoft.com/download/B/A/4/BA4A7E71-2906-4B2D-A0E1-80CF16844F5F/dotNetFx45_Full_setup.exe"

# Web Deploy 2.0
default['package_sources']['web_deploy'] = "http://download.microsoft.com/download/8/9/B/89B754A5-56F7-45BD-B074-8974FD2039AF/WebDeploy_2_10_amd64_en-US.msi"

# Application information
default['webapp']['name'] = "HelloIP"
default['webapp']['parameters'] = ({"IIS Web Application Name" => "#{node['webapp']['name']}"})
default['webapp']['package'] = "HelloIP.zip"
default['webapp']['local_directory'] = "c:/chef/temp"
default['webapp']['app_pool']['runtime_version'] = "4.0"
default['webapp']['site']['config']['port'] = 80

# Firewall rules
default['firewall']['rule_name'] = "Web-Server-Traffic-In"
default['firewall']['ports'] = [node['webapp']['site']['config']['port']]
