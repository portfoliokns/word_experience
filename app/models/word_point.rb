class WordPoint < ApplicationRecord
  belongs_to :user

  VALID_NUMERIC_MIN = 0
  VALID_NUMERIC_MAX = 999_999_999
  validates :point, presence: true,
                            numericality: { greater_than_or_equal_to: VALID_NUMERIC_MIN,
                                            less_than_or_equal_to: VALID_NUMERIC_MAX,
                                            only_integer: true,
                                            allow_blank: true }
end
