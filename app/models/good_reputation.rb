class GoodReputation < ApplicationRecord
  belongs_to :user
  belongs_to :word
  belongs_to :exchanged_word
  validates :star_flag, inclusion: {in: [true, false]}
end
