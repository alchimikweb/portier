class ProductsPermission < Portier::ApplicationPermission
  def default
    false
  end

  def add
    true
  end
end
