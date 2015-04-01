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

  context "permissions" do
    subject { XfilePolicy.new(user, xfile) }
    let!(:user) { FactoryGirl.create(:user) }
    let!(:xfile) { FactoryGirl.create(:xfile) }

    context "for anonymous users" do
      let(:user) { nil }

      it { should_not permit_action :show }
      it { should_not permit_action :update }
    end

    context "for viewers of the xfile" do
      before { assign_role!(user, :viewer, xfile) }

      it { should permit_action :show }
      it { should_not permit_action :update }
    end

    context "for editors of the xfile" do
      before { assign_role!(user, :editor, xfile) }

      it { should permit_action :show }
      it { should_not permit_action :update }
    end

    context "for managers of the xfile" do
      before { assign_role!(user, :manager, xfile) }

      it { should permit_action :show }
      it { should permit_action :update }
    end

    context "for managers of the other xfile" do
      before { assign_role!(user, :manager, FactoryGirl.create(:xfile)) }

      it { should_not permit_action :show }
      it { should_not permit_action :update }
    end

    context "for administrators" do
      let(:user) { FactoryGirl.create :user, :admin }

      it { should permit_action :show }
      it { should permit_action :update }
    end

  end

end
