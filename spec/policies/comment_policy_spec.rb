require 'rails_helper'

RSpec.describe CommentPolicy do
  context "permissions" do
    subject { CommentPolicy.new(user, comment) }

    let(:user) { FactoryGirl.create(:user) }
    let(:xfile) { FactoryGirl.create(:xfile) }
    let(:note){ FactoryGirl.create(:note, xfile: xfile) }
    let(:comment) { FactoryGirl.create(:comment, note: note)}

    context "for anonymous users" do
      let(:user) { nil }

      it { should_not permit_action :create }
    end

    context "for viewers of the xfile" do
      before { assign_role!(user, :viewer, xfile) }

      it { should_not permit_action :create }
    end

    context "for editors of the xfile" do
      before { assign_role!(user, :editor, xfile) }
      it { should permit_action :create }
    end

    context "for managers of the xfile" do
      before { assign_role!(user, :manager, xfile) }

      it { should permit_action :create }
    end

    context "for managers of the other xfile" do
      before { assign_role!(user, :manager, FactoryGirl.create(:xfile)) }

      it { should_not permit_action :create }
    end

    context "for administrators" do
      let(:user) { FactoryGirl.create :user, :admin }

      it { should permit_action :create }
    end
  end
end
