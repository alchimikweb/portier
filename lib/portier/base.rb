#*************************************************************************************
# Check if the access is granted or refused depending on the permission
# setted in the permission files.
#*************************************************************************************
class Portier::Base
  attr_reader :application_controller, :current_user

  delegate :request, to: :application_controller

  def initialize(application_controller, current_user)
    @application_controller = application_controller
    @current_user = current_user
  end

  def authorize_action
    raise Portier::AccessDenied if not permission.granted? action
  end

  def can?(action, object, options={})
    permission.can? action, object, options
  end

  def can_view?(tag, options={})
    view_permission.can_view? tag, options
  end

  def permitted_params
    permission.build_permitted_params if permission.respond_to? :permitted_params
  end

  private

  def action
    request[:action]
  end

  def controller
    request[:controller]
  end

  def permission
    if not @permission_object
      begin
        @permission_object = "#{controller.camelize}Permission".constantize.new(application_controller, current_user)
      rescue
        raise "Portier says: You must define #{controller.camelize}Permission in app/permissions/#{controller}_permission.rb. See documentation for more details."
      end
    end

    @permission_object
  end

  def view_permission
    if not @view_permission_object
      begin
        @view_permission_object = "ViewTagsPermission".constantize.new(application_controller, current_user)
      rescue
        raise "Portier says: You must define ViewTagsPermission in app/permissions/view_tags_permission.rb in order to use view permission. See documentation for more details."
      end
    end

    @view_permission_object
  end

end
