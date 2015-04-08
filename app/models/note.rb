class Note < ActiveRecord::Base
  before_create :assign_default_state
  after_create :author_watches_me

  belongs_to :xfile
  belongs_to :author, class_name: "User"
  belongs_to :state
  has_many :assets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags, uniq: true
  has_and_belongs_to_many :watchers, join_table: "note_watchers", class_name: "User", uniq: true
  attr_accessor :tag_names

  searcher do
    label :tag, from: :tags, field: "name"
    label :state, from: :state, field: "name"
  end

  validates :title, presence: true
  validates :description, presence: true, length: {minimum: 10}

  accepts_nested_attributes_for :assets, reject_if: :all_blank

  def tag_names=(names)
    @tag_names = names
    names.split(",").each do | name|
      self.tags << Tag.find_or_initialize_by(name: name)
    end
  end

  private

  def assign_default_state
  	self.state ||= State.default
  end

  def author_watches_me
    if author.present? && !self.watchers.include?(author)
      self.watchers << author
    end
  end
end
