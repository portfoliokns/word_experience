class GoodReputationsController < ApplicationController
  include SetCategory

  def create
    insert_or_change_good_reputation
    if @good_reputation.save
      redirect_to user_exchanged_words_path(current_user.id)
    else
      @exchanged_words = ExchangedWord.where(user_id: current_user.id).order('created_at DESC')
      set_category
      render 'exchanged_words/index'
    end
  end

  private
  def insert_or_change_good_reputation
    good_reputation_saved_count = GoodReputation.where(user_id: params[:user_id], exchanged_word_id: params[:exchanged_word_id]).count
    if good_reputation_saved_count == 0
      @good_reputation = GoodReputation.new()
      made_good_reputation
    else
      @good_reputation = GoodReputation.find_by(user_id: params[:user_id], exchanged_word_id: params[:exchanged_word_id])
      change_flag
    end
  end

  def made_good_reputation
    exchanged_word = ExchangedWord.find_by(user_id: params[:user_id], id: params[:exchanged_word_id])
    @good_reputation.user_id = current_user.id
    @good_reputation.word_id = exchanged_word.word_id
    @good_reputation.exchanged_word_id = exchanged_word.id
    @good_reputation.flag = true
  end

  def change_flag
    if @good_reputation.flag == true
      @good_reputation.flag = false
    else
      @good_reputation.flag = true
    end
  end

end
