require 'rails_helper'

RSpec.describe WordPoint, type: :model do
  before do
    @word_point = FactoryBot.build(:word_point)
    sleep 0.01
  end

  describe 'ワードポイントの登録' do
    context '情報が登録できる場合' do
      it 'ワードポイント(整数)が正しく登録できる' do
        expect(@word_point).to be_valid
      end
    end

    context "登録できない場合" do
      it 'ワードポイントが空である' do
        @word_point.point = ''
        @word_point.valid?
        expect(@word_point.errors.full_messages).to include("Point can't be blank")
      end

      it 'ワードポイントが整数でない' do
        @word_point.point = '@'
        @word_point.valid?
        expect(@word_point.errors.full_messages).to include("Point is not a number")
      end

      it 'ワードポイントが0より小さい数字である(-1以下の整数)' do
        @word_point.point = -1
        @word_point.valid?
        expect(@word_point.errors.full_messages).to include("Point must be greater than or equal to 0")
      end

      it 'ワードポイントが999,999,999より大きい数字である(1,000,000,000以上の整数)' do
        @word_point.point = 1000000000
        @word_point.valid?
        expect(@word_point.errors.full_messages).to include("Point must be less than or equal to 999999999")
      end

    end
  end
end
