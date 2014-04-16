actions :sync

attribute :package, :kind_of => String, :name_attribute => true
attribute :destination, :kind_of => String, :default => "auto"
attribute :parameters, :kind_of => Hash

def initialize(name, run_context=nil)
  super
  @action = :sync
end
