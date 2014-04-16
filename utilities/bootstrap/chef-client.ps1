Function DownloadFileFromWeb($url, $file)
{
	Write-Host "Downloading $file..."
	if(-not (Test-Path $file))
	{
		[Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
		(New-Object System.Net.WebClient).DownloadFile($url,$file)
	}
}

Function InstallChefClient($installer)
{
	Write-Host "Installing Chef Client..."
	Start-Process -FilePath msiexec -ArgumentList /i, $installer, '/L c:\chef\log\install.log', /quiet -Wait
}

Function CreateClientFile($chefDirectory)
{
	Write-Host "Creating $chefDirectory/client.rb..."
	$clientRB = @"
node_name		"YOUR_NODE_NAME"`r`n
log_level		:info`r`n
verbose_logging		true`r`n
log_location		"c:/chef/log/chef-client.log"`r`n
file_cache_path		"c:/chef/cache"`r`n
file_backup_path	"c:/chef/backup"`r`n
cache_options		({:path => "c:/chef/cache/checksums", :skip_expires => true})`r`n
chef_server_url		"http://XXX.XXX.XXX.XXX"`r`n
validation_client_name	"validator"`r`n
validation_key		"c:/chef/validator.pem"`r`n
client_key		"c:/chef/client.pem"`r`n
data_bag_decrypt_minimum_version 2`r`n
"@
	$file = "$chefDirectory/client.rb"
	if((Test-Path $file))
	{
		Clear-Content "$file"
	}
	Add-Content "$chefDirectory/client.rb" "$clientRB"
}

Function RunChefClient
{
	Write-Host "Running chef client for the first time..."
	Start-Process -FilePath C:/opscode/chef/bin/chef-client -ArgumentList "-o role[SERVER_ROLE] -E ENVIRONMENT_FILE" -Wait
}

if(!(Test-Path -Path "c:/chef"))
{
	New-Item -ItemType directory -Path "c:/chef"
}


$chefDirectory = 'c:/chef'
$chefLogDirectory = 'c:/chef/log'
if(-not (Test-Path $chefDirectory)) { New-Item -ItemType directory -Path $chefDirectory }
if(-not (Test-Path $chefLogDirectory)) { New-Item -ItemType directory -Path $chefLogDirectory }

$server = 'http://YYY.YYY.YYY.YYY'

DownloadFileFromWeb "https://www.opscode.com/chef/install.msi" "c:/chef/chef-client-install.msi"
InstallChefClient("c:\chef\chef-client-install.msi")
DownloadFileFromWeb "$server/encrypted_data_bag_key.txt" "$chefDirectory/encrypted_data_bag_key"
DownloadFileFromWeb "$server/validator.pem" "$chefDirectory/validator.pem"
CreateClientFile "$chefDirectory"
RunChefClient  
