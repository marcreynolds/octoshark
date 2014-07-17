require "octoshark/version"
require 'active_record'

module Octoshark
  autoload :ConnectionManager, 'octoshark/connection_manager'

  class NotConfiguredError < RuntimeError; end

  def self.setup(configs)
    @connection_manager = ConnectionManager.new(configs)
  end

  def self.reset!
    @connection_manager = nil
  end

  def self.connection_manager
    if @connection_manager
      @connection_manager
    else
      raise NotConfiguredError, "Octoshark is not setup. Setup connections with Octoshark.setup(configs)"
    end
  end
end
