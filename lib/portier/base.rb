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
    raise Portier::AccessDenied if not base_permission.granted? action
  end

  def can?(action, object, options={})
    object_name = if object.is_a? Symbol or object.is_a? String
      object.to_s.singularize.pluralize
    else
      object.class.name.pluralize
    end
    permission = permission_for object_name
    permission.can? action, object, options
  end

  def can_view?(tag, options={})
    view_permission.can_view? tag, options
  end

  def permitted_params
    base_permission.build_permitted_params if base_permission.respond_to? :permitted_params
  end

  private

  def action
    request[:action]
  end

  def base_permission
    @base_permission ||= permission_for controller_name
  end

  def controller_name
    request[:controller]
  end

  def permission_for(target)
    begin
      "#{target.camelize}Permission".constantize.new(application_controller, current_user)
    rescue
        raise Portier::Uninitalized, "You must define #{controller_name.camelize}Permission in app/permissions/#{controller_name}_permission.rb. See documentation for more details."
    end
  end

  def view_permission
    if not @view_permission_object
      begin
        @view_permission_object = "ViewTagsPermission".constantize.new(application_controller, current_user)
      rescue
        raise Portier::Uninitalized, "You must define ViewTagsPermission in app/permissions/view_tags_permission.rb in order to use view permission. See documentation for more details."
      end
    end

    @view_permission_object
  end

end
