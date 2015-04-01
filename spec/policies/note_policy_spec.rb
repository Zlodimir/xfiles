require 'rails_helper'

RSpec.describe NotePolicy do

  subject { NotePolicy }

  context "permissions" do
    subject { NotePolicy.new(user, note) }

    let(:user) { FactoryGirl.create(:user) }
    let(:xfile) { FactoryGirl.create(:xfile) }
    let(:note){ FactoryGirl.create(:note, xfile: xfile) }

    context "for anonymous users" do
      let(:user) { nil }

      it { should_not permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
    end

    context "for viewers of the xfile" do
      before { assign_role!(user, :viewer, xfile) }

      it { should permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
    end

    context "for editors of the xfile" do
      before { assign_role!(user, :editor, xfile) }

      it { should permit_action :show }
      it { should permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }

      context "when the editor created the note" do
        before { note.author = user }

        it { should permit_action :update }
      end
    end

    context "for managers of the xfile" do
      before { assign_role!(user, :manager, xfile) }

      it { should permit_action :show }
      it { should permit_action :create }
      it { should permit_action :update }
      it { should permit_action :destroy }
    end

    context "for managers of the other xfile" do
      before { assign_role!(user, :manager, FactoryGirl.create(:xfile)) }

      it { should_not permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
    end

    context "for administrators" do
      let(:user) { FactoryGirl.create :user, :admin }

      it { should permit_action :show }
      it { should permit_action :create }
      it { should permit_action :update }
      it { should permit_action :destroy }
    end

  end
end
