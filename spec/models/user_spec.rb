require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
    sleep 0.01
  end

  describe 'ユーザーの登録' do
    context 'ユーザーの情報が登録できる場合' do
      it 'ニックネーム、メールアドレス、パスワード、パスワード（再度確認）、名前、名前（カナ）、生年月日が正しく存在する' do
        expect(@user).to be_valid
      end
    end

    context "登録できない場合" do
      it 'ニックネームが空である' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが空である' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスに@が含まれない' do
        @user.email = 'deweyhotmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'メールアドレスが既に登録されている' do
        @user.save
        @anothor_user = FactoryBot.build(:user)
        @anothor_user.email = @user.email
        @anothor_user.valid?
        expect(@anothor_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'パスワードが空である' do
        @user.password = ''
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードが数字だけである' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it 'パスワードが英字だけである' do
        @user.password = 'abcdef'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it 'パスワードが5文字以下である' do
        @user.password = 'ab123'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'パスワードが129文字以上である' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end
      it 'パスワードが全角文字である' do
        @user.password = 'パスワードdesu'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it 'パスワード（再度確認）とパスワードが一致しない' do
        @user.password = '123abc'
        @user.password_confirmation = '123abcd'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '名前（全角）（姓）が空である' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it '名前（全角）（名）が空である' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it '名前（カナ）（姓）が空である' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it '名前（カナ）（名）が空である' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it '名前（全角）（姓）が全角以外である' do
        @user.first_name = 'nishi'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters")
      end
      it '名前（全角）（名）が全角以外である' do
        @user.last_name = '12@'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters")
      end
      it '名前（カナ）（姓）がカナ以外である' do
        @user.first_name_kana = '西'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid. Input full-width katakana characters")
      end
      it '名前（カナ）（名）がカナ以外である' do
        @user.last_name_kana = 'にし'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")
      end
      it '生年月日（年）が空である' do
        @user.birth_date = 'Sun, 15 Jul'
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
      it '生年月日（月）が空である' do
        @user.birth_date = 'Sun, 15 2012'
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
      it '生年月日（日）が空である' do
        @user.birth_date = 'Sun, Jul 2012'
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
