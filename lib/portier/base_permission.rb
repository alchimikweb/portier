#*************************************************************************************
# Basic Permission object to cut some duplication.
# ApplicationPermission and ViewTagsPermission inherit from it
#*************************************************************************************
class Portier::BasePermission
  attr_reader :application_controller, :current_user

  delegate :params, to: :application_controller
  delegate :request, to: :application_controller

  def initialize(application_controller, current_user)
    @application_controller = application_controller
    @current_user = current_user
  end

  private

  def controller
    @application_controller
  end

  def controller_name
    request[:controller]
  end

  def options
    @options
  end
end
