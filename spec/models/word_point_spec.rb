require 'rails_helper'

RSpec.describe WordPoint, type: :model do
  before do
    @word_point = FactoryBot.build(:word_point)
    sleep 0.01
  end

  describe 'ワードポイントの登録' do
    context '情報が登録できる場合' do
      it 'ワードポイント(整数)が正しく登録できる' do
        # expect(@word_point).to be_valid
      end
    end

    context "登録できない場合" do
      it 'ワードポイントが空である' do
        # @word_point.name = ''
        # @word_point.valid?
        # expect(@word_point.errors.full_messages).to include("Name can't be blank")
      end

      it 'ワードポイントが整数でない' do
        
      end

      it 'ワードポイントが0より小さい数字である(-1以下の整数)' do
        
      end

      it 'ワードポイントが999,999,999より大きい数字である(1,000,000,000以上の整数)' do
        
      end

      it 'ユーザーIDが空である' do
        
      end
    end
  end
end
