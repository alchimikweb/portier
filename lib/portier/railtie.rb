module Portier
  class Railtie < Rails::Railtie
    initializer "portier" do |app|
      ActiveSupport.on_load :action_controller do
        include Portier::Implants::ActionControllerImplant
      end
    end
  end

  module Implants
  end
end

require 'portier/implants/action_controller_implant'
