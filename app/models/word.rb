class Word < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { minimum: 3, maximum: 30 }
  validates :main_category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :service_category_id, numericality: { other_than: 1, message: "can't be blank" }
end
