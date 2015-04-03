require 'rails_helper'

RSpec.describe AssetPolicy do

  context "permissions" do
    subject { AssetPolicy.new(user, asset) }

    let(:user) { FactoryGirl.create(:user) }
    let(:xfile) { FactoryGirl.create(:xfile) }
    let(:note) { FactoryGirl.create(:note, xfile: xfile, author: user) }
    let(:asset) { FactoryGirl.create(:asset, note: note) }

    context "for anonymous user" do
      let(:user) { nil }
      it { should_not permit_action :show }
    end

    context "for viewers of the xfile" do
      before { assign_role!(user, :viewer, xfile) }
      it { should permit_action :show }
    end

    context "for editors of the xfile" do
      before { assign_role!(user, :editor, xfile)}
      it { should permit_action :show }
    end

    context "for managers of the xfile" do
      before { assign_role!(user, :manager, xfile)}
      it { should permit_action :show }
    end

    context "for managers of other the xfile" do
      before { assign_role!(user, :editor, FactoryGirl.create(:xfile))}
      it { should_not permit_action :show }
    end

    context "for administrators" do
      let(:user) {FactoryGirl.create(:user, :admin)}
      it { should permit_action :show }
    end
  end
end
