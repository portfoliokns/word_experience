class ExchangedWord < ApplicationRecord
  belongs_to :user
  belongs_to :word
  has_many :good_reputations, dependent: :destroy
  has_many :bad_reputations, dependent: :destroy
end
