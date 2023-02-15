class Inquiry < ApplicationRecord
  validates :name, presence: true,
                   length: { minimum: 1, maximum: 100, allow_blank: true }
  validates :email, presence: true,
                   length: { minimum: 1, maximum: 100, allow_blank: true }
  validates :detail, presence: true,
                   length: { minimum: 1, maximum: 1000, allow_blank: true }
end
