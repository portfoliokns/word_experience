class BadReputationsController < ApplicationController
  include SetCategory
  before_action :authenticate_user!
  include CheckRedirector
  before_action :check_user_id, only: [:create]
  before_action :check_exchanged_word_id_for_reputation, only: [:create]
  include ErrorMessageFlash
  before_action :reset_flash, only: [:create]

  def create
    insert_or_change_bad_reputation
    if @bad_reputation.save
      redirect_to user_exchanged_words_path(current_user.id)
    else
      @exchanged_words = ExchangedWord.where(user_id: current_user.id).order('created_at DESC')
      set_category
      flash.now[:alert] = get_reputation_message_incident
      render 'exchanged_words/index'
    end
  end

  private

  def insert_or_change_bad_reputation
    bad_reputation_saved_count = BadReputation.where(user_id: params[:user_id],
                                                       exchanged_word_id: params[:exchanged_word_id]).count
    if bad_reputation_saved_count == 0
      @bad_reputation = BadReputation.new
      made_bad_reputation
    else
      @bad_reputation = BadReputation.find_by(user_id: params[:user_id], exchanged_word_id: params[:exchanged_word_id])
      change_bad_flag
    end
  end

  def made_bad_reputation
    exchanged_word = ExchangedWord.find_by(user_id: params[:user_id], id: params[:exchanged_word_id])
    @bad_reputation.user_id = current_user.id
    @bad_reputation.word_id = exchanged_word.word_id
    @bad_reputation.exchanged_word_id = exchanged_word.id
    @bad_reputation.bad_flag = true
  end

  def change_bad_flag
    @bad_reputation.bad_flag = !(@bad_reputation.bad_flag == true)
  end

end
