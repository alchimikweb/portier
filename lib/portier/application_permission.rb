#*************************************************************************************
# Control the access for each controller actions
#*************************************************************************************
class Portier::ApplicationPermission < Portier::BasePermission
  def self.action_tree(action)
    case action.to_s
      when 'index' then [:index, :consult, :default]
      when 'show' then [:show, :consult, :default]
      when 'new' then [:new, :add, :default]
      when 'create' then [:create, :add, :default]
      when 'edit' then [:edit, :modify, :default]
      when 'update' then [:update, :modify, :default]
      when 'destroy' then [:destroy, :default]
      else [action.to_sym, :default]
    end
  end


  def build_permitted_params
    ps = self.respond_to?(:permitted_params) ? permitted_params : []

    begin
      params.require(record_name).permit ps
    rescue
      {}
    end
  end

  def can?(action, record, options={})
    @current_record = record
    @options = options

    granted? action
  end

  def default
    false
  end

  def granted?(action)
    action_tree(action).each { |act| return self.send(act) if self.respond_to?(act) }
  end


  private


  def action_tree(action)
    Portier::ApplicationPermission.action_tree(action)
  end

  def current_record
    @current_record = find_record if not @current_record

    @current_record
  end

  def find_record
    if params[:id]
      field = model.respond_to?(:default_id) ? model.default_id : :id

      model.find_by Hash[field, params[:id]]
    else
      nil
    end
  end

  def model
    controller_name.singularize.camelize.constantize
  end

  def model_exists?
    defined? model
  end

  def record_name
    controller_name.singularize.to_sym
  end


  def method_missing(*args, &block)
    if args.first == record_name and model_exists?
      current_record
    elsif current_record.class.to_s.downcase == args.first.to_s
      current_record
    else
      raise NoMethodError.new("undefined local variable or method '#{args.first}' for #{self.class}")
    end
  end
end
