require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザーの登録' do
    context 'ユーザーの情報が登録できる場合' do
      it 'ニックネーム、メールアドレス、パスワード、パスワード（再度確認）、名前、名前（カナ）、生年月日が正しく存在する' do
      end
    end

    context "登録できない場合" do
      it 'ニックネームが空である' do
      end
      it 'メールアドレスが空である' do
      end
      it 'メールアドレスに@が含まれない' do
      end
      it 'メールアドレスが既に登録されている' do
      end
      it 'パスワードが空である' do
      end
      it 'パスワードが数字だけである' do
      end
      it 'パスワードが英字だけである' do
      end
      it 'パスワードが5文字以下である' do
      end
      it 'パスワードが129文字以上である' do
      end
      it 'パスワードが全角文字である' do
      end
      it 'パスワード（再度確認）が空である' do
      end
      it 'パスワード（再度確認）とパスワードが一致しない' do
      end
      it '名前（全角）（姓）が空である' do
      end
      it '名前（全角）（名）が空である' do
      end
      it '名前（カナ）（姓）が空である' do
      end
      it '名前（カナ）（名）が空である' do
      end
      it '名前（全角）（姓）が全角以外である' do
      end
      it '名前（全角）（名）が全角以外である' do
      end
      it '名前（カナ）（姓）がカナ以外である' do
      end
      it '名前（カナ）（名）がカナ以外である' do
      end
      it '生年月日（年）が空である' do
      end
      it '生年月日（月）が空である' do
      end
      it '生年月日（日）が空である' do
      end
    end
  end
end
