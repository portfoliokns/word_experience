class BadReputationsController < ApplicationController
  include SetCategory
  before_action :authenticate_user!
  include CheckRedirector
  before_action :check_user_id, only: [:create]
  before_action :check_exchanged_word_id_for_reputation, only: [:create]
  include ErrorMessageFlash
  before_action :reset_flash, only: [:create]

  def create
    binding.pry
    insert_or_change_bad_reputation
    binding.pry
    if @bad_reputation.save
      binding.pry
      redirect_to user_exchanged_words_path(current_user.id)
      binding.pry
    else
      binding.pry
      @exchanged_words = ExchangedWord.where(user_id: current_user.id).order('created_at DESC')
      binding.pry
      set_category
      binding.pry
      flash.now[:alert] = get_reputation_message_incident
      binding.pry
      render 'exchanged_words/index'
      binding.pry
    end
  end

  private

  def insert_or_change_bad_reputation
    binding.pry
    bad_reputation_saved_count = BadReputation.where(user_id: params[:user_id],
                                                       exchanged_word_id: params[:exchanged_word_id]).count
    binding.pry
    if bad_reputation_saved_count == 0
      binding.pry
      @bad_reputation = BadReputation.new
      binding.pry
      made_bad_reputation
    else
      binding.pry
      @bad_reputation = BadReputation.find_by(user_id: params[:user_id], exchanged_word_id: params[:exchanged_word_id])
      binding.pry
      change_reputation
      binding.pry
    end
  end

  def made_bad_reputation
    exchanged_word = ExchangedWord.find_by(user_id: params[:user_id], id: params[:exchanged_word_id])
    @bad_reputation.user_id = current_user.id
    @bad_reputation.word_id = exchanged_word.word_id
    @bad_reputation.exchanged_word_id = exchanged_word.id
    @bad_reputation.star_flag = true
    binding.pry
  end

  def change_reputation
    @bad_reputation.star_flag = !(@bad_reputation.star_flag == true)
    binding.pry
  end

end
