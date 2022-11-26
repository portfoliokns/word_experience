class BadReputation < ApplicationRecord
  belongs_to :user
  belongs_to :word
  belongs_to :exchanged_word
  validates :bad_flag, inclusion: { in: [true, false] }
end
