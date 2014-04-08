#*************************************************************************************
# Insert methods in the Action Controller of a Rails project.
#*************************************************************************************
module Portier::Implants::ActionControllerImplant
  extend ActiveSupport::Concern

  included do
    helper_method :can?, :can_view?

    rescue_from Portier::AccessDenied, with: :render_access_denied
  end

  def can?(action, object, options={})
    @portier.can? action, object, options
  end

  def can_view?(tag, options={})
    @portier.can_view? tag, options
  end

  def permitted_params
    @portier.permitted_params
  end

  def protect_app
    @portier = Portier::Base.new(self, current_user)
    @portier.authorize_action
  end

  def render_access_denied
    render text: "access_denied", status: 401
  end
end
