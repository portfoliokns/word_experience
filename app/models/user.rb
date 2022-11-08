class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :words

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  VALID_NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  VALID_KANA_REGEX = /\A[ァ-ヶ]+\z/

  validates :nickname, presence: true
  validates :password,
            format: { with: VALID_PASSWORD_REGEX, message: 'is invalid. Include both letters and numbers', allow_blank: true }
  with_options presence: true,
               format: { with: VALID_NAME_REGEX, message: 'is invalid. Input full-width characters',
                         allow_blank: true } do
    validates :first_name
    validates :last_name
  end
  with_options presence: true,
               format: { with: VALID_KANA_REGEX, message: 'is invalid. Input full-width katakana characters',
                         allow_blank: true } do
    validates :first_name_kana, presence: true
    validates :last_name_kana, presence: true
  end
  validates :birth_date, presence: true
end
