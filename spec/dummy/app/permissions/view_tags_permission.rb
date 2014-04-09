class ViewTagsPermission < Portier::ViewTagsPermission
  def granted_response
    options[:show]
  end
end
