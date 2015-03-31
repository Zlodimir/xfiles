require 'rails_helper'

describe XfilePolicy do

  let(:user) { User.new }

  subject { XfilePolicy }

  context ".scope" do
    subject { Pundit.policy_scope(user, Xfile) }
    let!(:xfile) { FactoryGirl.create :xfile }
    let!(:user) { FactoryGirl.create :user }

    it "returns nothing for anonymous users" do
      expect(Pundit.policy_scope(nil, Xfile)).to be_empty
    end

    it "includes xfiles a user is allowed to view" do
      assign_role!(user, :viewer, xfile)
      expect(subject).to include(xfile)
    end

    it "doesn't include xfiles a user is not allowed to view" do
      expect(subject).to be_empty
    end

    it "returns all xfiles for admin" do
      user.admin = true
      expect(subject).to include(xfile)
    end
  end

  permissions :show? do
    let(:user) { FactoryGirl.create :user }
    let(:xfile) {FactoryGirl.create :xfile }

    it "blocks anonymous users" do
      expect(subject).not_to permit(nil, xfile)
    end

    it "allows viewers of the xfile" do
      assign_role!(user, :viewer, xfile)
      expect(subject).to permit(user, xfile)
    end

    it "allows editors of the xfile" do
      assign_role!(user, :editor, xfile)
      expect(subject).to permit(user, xfile)
    end

    it "allows managers of the xfile" do
      assign_role!(user, :manager, xfile)
      expect(subject).to permit(user, xfile)
    end

    it "allows administrators" do
      admin = FactoryGirl.create :user, :admin
      expect(subject).to permit(admin, xfile)
    end

    it "doesn't allow users assigned to other xfiles" do
      other_xfile = FactoryGirl.create :xfile
      assign_role!(user, :manager, other_xfile)
      expect(subject).not_to permit(user, xfile)
    end
  end

end
