require 'spec_helper'

describe Portier::ViewTagsPermission do
  describe "#can_view?" do
    context "with a view_tags permission" do
      before { @permission = Portier::ViewTagsPermission.new double(:app), double(:user) }

      context "with the undefined tag show_admin_link" do
        context "when checking if the user can view the show_admin_link" do
          specify { expect { @permission.can_view?(:show_admin_link) }.to raise_error }
        end
      end

      context "with the tag show_admin_link restricting access to the user" do
        before { @permission.stub(:show_admin_link).and_return false }

        context "when checking if the user can view the show_admin_link" do
          specify { @permission.can_view?(:show_admin_link).should be_false }
        end
      end

      context "with the tag show_admin_link allowing access to the user" do
        before { @permission.stub(:show_admin_link).and_return true }

        context "when checking if the user can view the show_admin_link" do
          specify { @permission.can_view?(:show_admin_link).should be_true }
        end
      end
    end
  end
end
