#Workstation

##OS X

	$ export SERVERIP="$(ifconfig en1 | grep inet | grep -v inet6 | awk '{print $2}')"
	$ mkdir -p /tmp/chefconf_bootstrap
	$ cat ~/Downloads/chefconf_2014/utilities/bootstrap/chef-client.ps1 | sed "s/XXX\.XXX\.XXX\.XXX/$SERVERIP:4000/" | sed "s/YYY\.YYY\.YYY\.YYY/$SERVERIP:8888/" | sed "s/encrypted_data_bag_key.txt/validator.pem/g" | sed "s/encrypted_data_bag_key/client.pem/" | sed "s/SERVER_ROLE/chefconf2014_role/g" | sed "s/\ -E\ ENVIRONMENT_FILE//" > /tmp/chefconf_bootstrap/chef-client.ps1
	$ cp ~/Downloads/chefconf_2014/.chef/validator.pem /tmp/chefconf_bootstrap/
	$ cd /tmp/chefconf_bootstrap
	$ python -mSimpleHTTPServer 8888 &
	$ cd ~/Downloads/chefconf_2014
	$ chef-zero -H $SERVERIP -p 4000 --no-generate-keys &
	$ knife cookbook upload --include-dependencies chefconf2014
	$ knife role create chefconf2014_role

	{
	  "name": "chefconf2014_role",
	  "description": "",
	  "json_class": "Chef::Role",
	  "default_attributes": {
	  },
	  "override_attributes": {
	  },
	  "chef_type": "role",
	  "run_list": [
		"recipe[chefconf2014]"
	  ],
	  "env_run_lists": {
	  }
	}

	$ echo "powershell -NoProfile -ExecutionPolicy unrestricted -Command \"[Net.ServicePointManager]::ServerCertificateValidationCallback = {$true};iex ((new-object net.webclient).DownloadString('http://$SERVERIP:8888/chef-client.ps1'))\""

#Client

##Windows Server 2008 R2

* Run `cmd.exe` as administrator
	* `Start->All Programs->Accessories`
	* Right-click on `Command Prompt` and select `Run as administrator`
* paste powershell command echo'd out above
