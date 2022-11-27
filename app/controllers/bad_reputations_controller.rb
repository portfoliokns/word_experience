class BadReputationsController < ApplicationController
  include SetCategory
  before_action :authenticate_user!
  include CheckRedirector
  before_action :check_user_id, only: [:create]
  before_action :check_exchanged_word_id_for_reputation, only: [:create]
  include ErrorMessageFlash
  before_action :reset_flash, only: [:create]
  include ReputationMethod

  def create
    insert_or_change_reputation
    if @reputation.save
      redirect_to user_exchanged_words_path(current_user.id)
    else
      @exchanged_words = ExchangedWord.where(user_id: current_user.id).order('created_at DESC')
      set_category
      flash.now[:alert] = get_reputation_message_incident
      render 'exchanged_words/index'
    end
  end

  private

  def insert_or_change_reputation
    if get_reputation_count == 0
      star_flag = false
      bad_flag = true
      @reputation = set_new_reputation(star_flag, bad_flag)
    else
      @reputation = change_bad_flag_and_get_reputation
    end
  end

end