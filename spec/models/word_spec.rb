require 'rails_helper'

RSpec.describe Word, type: :model do
  describe 'ワードの登録' do
    context 'ワードの情報が登録できる場合' do
      it '名称、メインカテゴリー、サービスカテゴリーが正しく入力できる' do
        # expect(@word).to be_valid
      end
      it '別ユーザーが先に名称を登録した状態でも、同じ名称を入力できる' do
      end
    end

    context "登録できない場合" do
      it '名称が空である' do
        # @word.nickname = ''
        # @word.valid?
        # expect(@word.errors.full_messages).to include("Nickname can't be blank")
      end

      it '名称が3文字以下である' do
      end

      it '名称が31文字以上である' do
      end

      it 'ユーザーが先に名称を登録していて、同じ名称である' do
      end

      it 'メインカテゴリーが空(---)である' do
      end

      it 'サービスカテゴリーが空(---)である' do
      end
    end
  end
end
