class Passage < ActiveRecord::Base
  has_many :words
  validates :content, presence: true, length: {minimum: 20}
end
