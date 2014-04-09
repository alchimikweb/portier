class AnonymousPermission < Portier::ApplicationPermission
  def default
    false
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

  def destroy
    anonymou.open?
  end

  def permitted_params
    [:name, :email]
  end
end
