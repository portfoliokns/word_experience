class GoodReputation < ApplicationRecord
  belongs_to :user
  belongs_to :word
  belongs_to :exchanged_word
end
