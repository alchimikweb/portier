#*************************************************************************************
# Control the access using a tag.
#*************************************************************************************
class Portier::ViewTagsPermission < Portier::BasePermission
  def can_view?(tag, options={})
    if self.respond_to? tag.to_sym
      @options = options

      self.send(tag.to_sym)
    else
      raise "Portier says: You must define the method \"#{tag}\" in the view tags file (app/permissions/view_tags_permission.rb). See documentation for more details."
    end
  end
end
