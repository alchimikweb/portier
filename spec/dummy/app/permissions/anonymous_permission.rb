class AnonymousPermission < Portier::ApplicationPermission
  def default
    true
  end

  def index
    true
  end

  def create
    true
  end

  def modify
    false
  end

  def permitted_params
    [:name, :email]
  end
end
