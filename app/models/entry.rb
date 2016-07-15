class Entry < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc)}
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140}
  def index
  	@entry = Entry.all
  end
end
