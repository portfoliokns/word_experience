require 'rails_helper'

RSpec.describe GoodReputation, type: :model do
  before do
    @good_reputation = FactoryBot.build(:good_reputation)
    sleep 0.01
  end

  describe '評価の登録' do
    context '評価が登録できる場合' do
      it 'star_flagがTrueまたはFalseで登録できる' do
        expect(@good_reputation).to be_valid
      end
    end

    context "登録できない場合" do
      it 'star_flagがTrue、Falseでない' do
        @good_reputation.star_flag = ''
        @good_reputation.valid?
        expect(@good_reputation.errors.full_messages).to include("Star flag is not included in the list")
      end
    end
  end


end
