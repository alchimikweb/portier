require 'spec_helper'

describe Portier::ApplicationPermission do
  describe "#build_permitted_params" do
    pending
  end

  describe "#can?" do
    pending
  end

  describe "#default" do
    it "should be protected by default" do
      permission = Portier::ApplicationPermission.new(double(:app), double(:user)).default
      expect(permission).to be_falsey
    end
  end

  describe "#granted?" do
    pending
  end
end

require 'spec_helper'
