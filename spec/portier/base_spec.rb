require 'spec_helper'

describe Portier::Base do
  include ViewHelpers

  describe "#authorize_action" do
    pending
  end

  describe "#can?" do
    before { @app = app_mock }
    context "with an unexisting permission file" do
      before { @base = Portier::Base.new(@app, double(:user)) }

      context "when checking if user can edit record" do
        specify { expect { @base.can?(:edit, double(:user)) }.to raise_error(Portier::Uninitalized) }
      end
    end
  end

  describe "#can_view?" do
    pending
  end

  describe "#permitted_params" do
    pending
  end
end
