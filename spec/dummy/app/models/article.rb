class Article < ActiveRecord::Base

  validates :title, presence: true

  def to_s
    title
  end

end
