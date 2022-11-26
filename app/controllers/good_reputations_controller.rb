class GoodReputationsController < ApplicationController
  include SetCategory
  before_action :authenticate_user!
  include CheckRedirector
  before_action :check_user_id, only: [:create]
  before_action :check_exchanged_word_id_for_reputation, only: [:create]
  include ErrorMessageFlash
  before_action :reset_flash, only: [:create]

  def create
    is_success = true
    ActiveRecord::Base.transaction do
      insert_or_change_good_reputation
      insert_or_change_bad_reputation
      is_success = false unless @good_reputation.save
      if @bad_reputation != nil
        is_success = false unless @bad_reputation.save
      end
      if is_success
        redirect_to user_exchanged_words_path(current_user.id)
      else
        raise ActiveRecord::Rollback
        @exchanged_words = ExchangedWord.where(user_id: current_user.id).order('created_at DESC')
        set_category
        flash.now[:alert] = get_reputation_message_incident
        render 'exchanged_words/index'
      end
    end
  end

  private

  def insert_or_change_good_reputation
    good_reputation_saved_count = GoodReputation.where(user_id: params[:user_id],
                                                       exchanged_word_id: params[:exchanged_word_id]).count
    if good_reputation_saved_count == 0
      @good_reputation = GoodReputation.new
      made_good_reputation
    else
      @good_reputation = GoodReputation.find_by(user_id: params[:user_id], exchanged_word_id: params[:exchanged_word_id])
      change_star_flag
    end
  end

  def made_good_reputation
    exchanged_word = ExchangedWord.find_by(user_id: params[:user_id], id: params[:exchanged_word_id])
    @good_reputation.user_id = current_user.id
    @good_reputation.word_id = exchanged_word.word_id
    @good_reputation.exchanged_word_id = exchanged_word.id
    @good_reputation.star_flag = true
  end

  def change_star_flag
    @good_reputation.star_flag = !(@good_reputation.star_flag == true)
  end

  def insert_or_change_bad_reputation
    bad_reputation_saved_count = BadReputation.where(user_id: params[:user_id],
                                                       exchanged_word_id: params[:exchanged_word_id]).count
    if bad_reputation_saved_count == 0
      @bad_reputation = BadReputation.new
      made_bad_reputation
    elsif @good_reputation.star_flag == true
      @bad_reputation = BadReputation.find_by(user_id: params[:user_id], exchanged_word_id: params[:exchanged_word_id])
      change_bad_flag
    end
  end

  def made_bad_reputation
    exchanged_word = ExchangedWord.find_by(user_id: params[:user_id], id: params[:exchanged_word_id])
    @bad_reputation.user_id = current_user.id
    @bad_reputation.word_id = exchanged_word.word_id
    @bad_reputation.exchanged_word_id = exchanged_word.id
    @bad_reputation.bad_flag = false
  end

  def change_bad_flag
    @bad_reputation.bad_flag = false
  end
end
