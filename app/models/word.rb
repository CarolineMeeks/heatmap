class Word < ActiveRecord::Base
  belongs_to :passage
  has_many :highlights
end
