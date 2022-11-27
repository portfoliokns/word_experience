class ExchangedWord < ApplicationRecord
  belongs_to :user
  belongs_to :word
  has_many :reputations, dependent: :destroy
end
