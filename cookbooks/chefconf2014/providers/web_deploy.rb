action :sync do
    msdeploy_cmd = "\"%programfiles%\\IIS\\Microsoft Web Deploy V2\\msdeploy.exe\" "
    msdeploy_cmd << "-verb:sync "
    msdeploy_cmd << "-source:package=\"#{@new_resource.package}\" " unless @new_resource.package.nil?
    msdeploy_cmd << "-dest:\"#{@new_resource.destination}\" " unless @new_resource.destination.nil?

    @new_resource.parameters.each do |name, value|
      msdeploy_cmd << "-setParam:name=\"#{name}\",value=\"#{value}\" "
    end unless @new_resource.parameters.nil?

    Chef::Log.info("MSDeploy Command: #{msdeploy_cmd}")

    execute "webdeploy" do
        command msdeploy_cmd
    end
end
