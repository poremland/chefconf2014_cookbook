require 'chef/mixin/shell_out'

include Chef::Mixin::ShellOut

action :add do
	if @new_resource.created
		Chef::Log.info "#{@new_resource.rule_name} is already created"
	else
		cmd = "netsh advfirewall firewall add rule Name=\"#{@new_resource.rule_name}\""
		cmd << " Dir=\"#{@new_resource.direction.to_s}\""
		cmd << " Action=\"#{@new_resource.firewall_action.to_s}\""
		cmd << " Protocol=\"#{@new_resource.protocol.to_s}\""
		cmd << " Localport="
		cmd << @new_resource.ports.join(",")

		Chef::Log.debug(cmd)
		shell_out!(cmd)
	end
end

def load_current_resource
	show_rule_cmd = "netsh advfirewall firewall show rule Name=\"#{@new_resource.rule_name}\""
	cmd = shell_out("#{show_rule_cmd}", { :returns => [0] })
	if (cmd.stderr.empty? && (cmd.stdout =~ /^.*Rule Name.*$/i))
		@new_resource.created = true
	end
end
