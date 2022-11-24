class ExchangedWordsController < ApplicationController
  include SetCategory
  before_action :authenticate_user!
  include CheckRedirector
  before_action :check_user_id, only: [:index, :new, :create, :show]
  before_action :check_exchanged_word_id, only: [:show]
  before_action :set_exchanged_word, only: [:show]
  before_action :set_category, only: [:index, :show]
  include PointMethod
  before_action :check_requested_point, only: [:create]
  include ErrorMessageFlash
  before_action :reset_flash
  WORD_NUM = 2
  RANDOM_SEED = 17

  def index
    @exchanged_words = ExchangedWord.where(user_id: current_user.id).order('created_at DESC')
  end

  def new
  end

  def create
    words = get_random_words
    if words.count == WORD_NUM
      if save_exchanged_word_or_exchanged_words(words)
        requested_point = ENV['WORD_POINT_EXCHANGE'].to_i
        decrease_point(requested_point)
        redirect_to user_exchanged_words_path(current_user.id)
      else
        flash.now[:alert] = get_word_message_incident(requested_point, '交換')
        render :new
      end
    else
      flash.now[:alert] = get_no_word_message
      render :new
    end
  end

  def show
  end

  private

  def get_random_words
    other_users_words = Word.where.not(user_id: current_user.id).to_a
    delete_words = Word.joins(:exchanged_words).where(exchanged_words: { user_id: current_user.id })

    delete_words.each do |delete_word|
      counter = 0
      other_users_words.each do |other_users_word|
        if other_users_word.id == delete_word.id
          other_users_words.delete_at(counter)
          break
        end
        counter += 1
      end
    end

    RANDOM_SEED.times do
      other_users_words = other_users_words.shuffle
    end

    counter = 0
    random_words = []
    WORD_NUM.times do
      random_words.push(other_users_words[counter]) unless other_users_words[counter].nil?
      counter += 1
    end
    random_words
  end

  def save_exchanged_word_or_exchanged_words(words)
    is_success = true
    ActiveRecord::Base.transaction do
      words.each do |word|
        exchanged_word = ExchangedWord.new
        exchanged_word.user_id = params[:user_id]
        exchanged_word.word_id = word.id
        is_success = false unless exchanged_word.save
      end
      raise ActiveRecord::RollBack unless is_success
    end
  rescue StandardError
    p 'transaction error'
  ensure
    return is_success
  end

  def set_exchanged_word
    @exchanged_word = ExchangedWord.find_by(user_id: params[:user_id], id: params[:id])
  end

  def check_requested_point
    requested_point = ENV['WORD_POINT_EXCHANGE'].to_i
    return unless have_decrease_error?(requested_point)

    flash.now[:alert] = get_point_message(requested_point, '交換')
    render :new
  end
end
