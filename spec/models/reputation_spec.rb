require 'rails_helper'

RSpec.describe Reputation, type: :model do
  before do
    @reputation = FactoryBot.build(:reputation)
    sleep 0.01
  end

  describe '評価の登録' do
    context '評価が登録できる場合' do
      it 'star_flagがTrueまたはFalseで登録できる' do
        expect(@reputation).to be_valid
      end
    end

    context '登録できない場合' do
      it 'star_flagがTrue、Falseでない' do
        @reputation.star_flag = ''
        @reputation.valid?
        expect(@reputation.errors.full_messages).to include('Star flag is not included in the list')
      end

      it 'bad_flagがTrue、Falseでない' do
        @reputation.bad_flag = ''
        @reputation.valid?
        expect(@reputation.errors.full_messages).to include('Bad flag is not included in the list')
      end
    end
  end
end
