class Word < ApplicationRecord
  belongs_to :user
  has_many :exchanged_words, dependent: :destroy
  has_many :reputations, dependent: :destroy
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :main_category
  belongs_to :service_category

  validates :name, presence: true,
                   uniqueness: { scope: :user, case_sensitive: true },
                   length: { minimum: 4, maximum: 30, allow_blank: true }
  validates :main_category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :service_category_id, numericality: { other_than: 1, message: "can't be blank" }

  def self.per_page
    8
  end
end
