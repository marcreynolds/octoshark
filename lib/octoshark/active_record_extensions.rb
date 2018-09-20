module Octoshark
  module ConnectionHandler
    def establish_connection(*args)
      Octoshark::ConnectionPoolsManager.reset_connection_managers!
      super(*args)
    end
  end

  module ActiveRecordAbstractAdapter
    attr_accessor :connection_name, :database_name
  end
end

if defined?(ActiveRecord::ConnectionAdapters::ConnectionHandler)
  # Rails 3.2, 4.0, 4.1, 4.2, 5.0
  ActiveRecord::ConnectionAdapters::ConnectionHandler.send(:prepend, Octoshark::ConnectionHandler)
else
  # Rails 3.0 and 3.1 does not lazy load
  require 'active_record/connection_adapters/abstract_adapter'
  ActiveRecord::ConnectionAdapters::ConnectionHandler.send(:prepend, Octoshark::ConnectionHandler)
end

ActiveRecord::ConnectionAdapters::AbstractAdapter.send(:prepend, Octoshark::ActiveRecordAbstractAdapter)
