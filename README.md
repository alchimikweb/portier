Portier
=======

Portier is an gem that manage permissions in a rails project. The permission rules are flexible, non-obstrusive, scalable and can be applied to the controller actions, and views.

Install
-------

In your Gemfile:

```ruby
gem 'portier'
```

Authorizing the controller requests
-----------------------------------

### Bootstrap Portier

In order to let portier control the requests to your application, you need to add the before_filter below in your application_controller.rb. You also need to define a current_user method

```ruby
  # app/controllers/application_controller.rb

  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    # This filter the requests using the permission files
    before_action :protect_app

    # You can define the current_user anyway you want as long as it return the current user record.
    def current_user
      # This is only an example of current_user method. Feel free to do it the way you want.
      begin
        @current_user ||= User.find session[:current_user]
      rescue
        @current_user = nil
      end
    end
    ...
```

### The Permission Files

Once this is done, every controller will have to be match with a permission file. So, for the ```products_controller.rb``` you'll have to create the file ```app/permissions/products_permission.rb```.


### Describing a permission file

The permission file will define the access rules to every action called on the controller.

```ruby
  # app/permissions/products_permission.rb

  class ProductsPermission < Portier::ApplicationPermission
    # User will have access to any undescribed actions
    def default
      true
    end

    # The access will only granted if the product is available.
    # product is provided by ApplicationPermission.
    # product return the current product record
    def show
      product.available?
    end

    # You can set a custom error message with the method set_access_denied_message.
    # This message will be available in the controllers and views throught the
    # method access_denied_message. If it's not set, this method will return nil.
    # set_access_denied_message always return false.
    def create
      if not current_user
        set_access_denied_message "You need to log in to create this product."
      elsif not current_user.can_create_product?
        set_access_denied_message "You don't have the right to create product."
      else
        true
      end
    end

    # The access to the edit/update actions will only be available
    # if the current user is and Administrator
    # The current_user method must be defined in your ApplicationController
    def modify
      current_user and current_user.admin?
    end

    # Revoke access to the destroy action.
    def destroy
      false
    end
  end

  # consult = index and show
  # add     = new and create
  # modify  = edit and update

  # Define the parameters that can be sent by the user.
  # In your products_controller, you can call the method permitted_params.
  # This method will be the equivalent of :
  # params.require(:product).permit(:picture, :name, :description)
  def permitted_params
    if current_user and current_user.employe?
      [:picture, :name, :description]
    elsif current_user and current_user.admin?
      [:picture, :name, :description, :price]
    else
      []
    end
  end
```

### The View Tags

In order to filter content in the views, you can add tags in the special view_tags_permission.rb.

```ruby
  # app/permissions/view_tags_permission.rb

  class ViewTagsPermission < Portier::ViewTagsPermission
    # Only accept this tag if the user is an administrator
    def show_the_admin_link
      current_user.admin?
    end
  end
```

In your views, you can then use the can_view? method to filter content.

```erb
  <%# app/views/products/show.html.erb %>

  <%= link_to 'Admin', admin_path if can_view? :show_the_admin_link %>
```

### can?

In your views, you can also use the method ```can?``` to filter content.

```erb
  <%# app/views/products/show.html.erb %>

  <%= link_to 'Edit product', edit_product_path(id: @product.id) if can? :edit, @product %>
```

Both ```can?``` and ```can_view?``` methods can take options

```erb
  <%# app/views/products/show.html.erb %>

  <%= link_to 'Admin', admin_path if can_view? :show_the_admin_link, special: true %>
```

```ruby
  # app/permissions/view_tags_permission.rb

  class ViewTagsPermission < Portier::ViewTagsPermission
    # Only accept this tag if the user is a special administrator
    def show_the_admin_link
      current_user.admin? and options[:special]
    end
  end
```

### namespace

If you are using namespacing in your controller, you can pass the namespace option.

```erb
  <%# app/views/admin/products/show.html.erb %>

  <%= link_to 'Edit product', edit_product_path(id: @product.id) if can? :edit, @product, namespace: :admin %>
```

Copyright
---------

Copyright (c) 2014 Alchimik. See LICENSE for further details.
