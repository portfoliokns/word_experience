class GoodReputationsController < ApplicationController
  include SetCategory
  before_action :authenticate_user!
  include CheckRedirector
  before_action :check_user_id, only: [:create]
  before_action :check_exchanged_word_id_for_reputation, only: [:create]
  include ErrorMessageFlash
  before_action :reset_flash, only: [:create]

  def create
    insert_or_change_good_reputation
    if @good_reputation.save
      redirect_to user_exchanged_words_path(current_user.id)
    else
      @exchanged_words = ExchangedWord.where(user_id: current_user.id).order('created_at DESC')
      set_category
      flash.now[:alert] = get_reputation_message_incident
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
      change_reputation
    end
  end

  def made_good_reputation
    exchanged_word = ExchangedWord.find_by(user_id: params[:user_id], id: params[:exchanged_word_id])
    @good_reputation.user_id = current_user.id
    @good_reputation.word_id = exchanged_word.word_id
    @good_reputation.exchanged_word_id = exchanged_word.id
    @good_reputation.star_flag = true
  end

  def change_reputation
    if @good_reputation.star_flag == true
      @good_reputation.star_flag = false
    else
      @good_reputation.star_flag = true
    end
  end

end
