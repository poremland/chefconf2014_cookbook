actions :add

attribute :rule_name, :kind_of => String, :name_attribute => true
attribute :firewall_action, :kind_of => Symbol, :default => :Allow, :equal_to => [:Allow, :Block]
attribute :direction, :kind_of => Symbol, :default => :In, :equal_to => [:In, :Out]
attribute :protocol, :kind_of => Symbol, :default => :tcp, :equal_to => [:tcp, :udp, :icmpv4, :icmpv6, :any]
attribute :ports, :kind_of => Array, :default => [80]

attr_accessor :created

def initialize(name, run_context=nil)
  super
  @action = :add
end
