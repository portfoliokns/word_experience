class ExchangedWordsController < ApplicationController
  include SetCategory
  before_action :authenticate_user!
  include CheckRedirector
  before_action :check_user_id, only: [:index,:new, :create, :show]
  before_action :check_exchanged_word_id, only: [:show]
  before_action :set_exchanged_word, only: [:show]
  before_action :set_category, only: [:index, :show]
  include PointMethod
  before_action :check_requested_point, only:[:create]

  def index
    @exchanged_words = ExchangedWord.where(user_id: current_user.id).order('created_at DESC')
  end

  def new
  end

  def create
    words = Word.where.not(user_id: current_user.id).order("RAND()").limit(3)
    if save_exchanged_word_or_exchanged_words(words)
      requested_point = ENV["WORD_POINT_EXCHANGE"].to_i
      decrease_point(requested_point)
      redirect_to user_exchanged_words_path(current_user.id)
    else
      render :new
    end
  end

  def show
  end

  private
  def save_exchanged_word_or_exchanged_words(words)
    is_success = true
    ActiveRecord::Base.transaction do
      words.each do |word|
        exchanged_word = ExchangedWord.new()
        exchanged_word.user_id = params[:user_id]
        exchanged_word.word_id = word.id
        is_success = false unless exchanged_word.save
      end
      raise ActiveRecord::RollBack unless is_success
    end
  rescue
    p 'transaction error'
  ensure
    return is_success
  end

  def set_exchanged_word
    @exchanged_word = ExchangedWord.find_by(user_id: params[:user_id], id: params[:id])
  end

  def check_requested_point
    requested_point = ENV["WORD_POINT_EXCHANGE"].to_i
    render :new if have_decrease_error?(requested_point)
  end
end
