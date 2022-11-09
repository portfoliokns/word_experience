class Word < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :main_category
  belongs_to :service_category

  validates :name, presence: true,
            uniqueness: { scope: :user },
            length: { minimum: 4, maximum: 30 }
  validates :main_category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :service_category_id, numericality: { other_than: 1, message: "can't be blank" }
end
