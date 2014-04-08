module Portier
  #*************************************************************************************
  # Error that will be raised if access to the action is denied
  #*************************************************************************************
  class AccessDenied < StandardError
  end

  #*************************************************************************************
  # Error that will be raised if the permission isn't initialized
  #*************************************************************************************
  class Uninitalized < StandardError
  end
end
