require 'rails_helper'

RSpec.describe Word, type: :model do
  before do
    @word = FactoryBot.build(:word)
    sleep 0.01
  end

  describe 'ワードの登録' do
    context 'ワードの情報が登録できる場合' do
      it '名称、メインカテゴリー、サービスカテゴリーが正しく入力できる' do
        expect(@word).to be_valid
      end
      it '別ユーザーが先に名称を登録した状態でも、同じ名称を入力できる' do
        @anothor_user_word = FactoryBot.build(:word)
        @anothor_user_word.save
        @word.name = @anothor_user_word.name
        @word.save
        expect(@word).to be_valid
      end
    end

    context '登録できない場合' do
      it '名称が空である' do
        @word.name = ''
        @word.valid?
        expect(@word.errors.full_messages).to include("Name can't be blank")
      end

      it '名称が3文字以下である' do
        @word.name = 'あいう'
        @word.valid?
        expect(@word.errors.full_messages).to include('Name is too short (minimum is 4 characters)')
      end

      it '名称が31文字以上である' do
        @word.name = Faker::Lorem.characters(number: 31)
        @word.valid?
        expect(@word.errors.full_messages).to include('Name is too long (maximum is 30 characters)')
      end

      it 'ユーザーが先に名称を登録していて、同じ名称である' do
        @word.save
        @next_word = FactoryBot.build(:word)
        @next_word.user_id = @word.user_id
        @next_word.name = @word.name
        @next_word.valid?
        expect(@next_word.errors.full_messages).to include('Name has already been taken')
      end

      it 'メインカテゴリーが空(---)である' do
        @word.main_category_id = 1
        @word.valid?
        expect(@word.errors.full_messages).to include("Main category can't be blank")
      end

      it 'サービスカテゴリーが空(---)である' do
        @word.service_category_id = 1
        @word.valid?
        expect(@word.errors.full_messages).to include("Service category can't be blank")
      end
    end
  end
end
