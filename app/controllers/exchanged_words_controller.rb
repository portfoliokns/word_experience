class ExchangedWordsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_and_set_user, only: [:index,:new, :create]
  before_action :set_exchanged_words, only: [:index]

  def index
    @exchanged_words = ExchangedWord.where(user_id: current_user.id).order('created_at DESC')
    @main_category = MainCategory.all
    @service_category = ServiceCategory.all
  end

  def new
    
  end

  def create
    words = Word.where.not(user_id: current_user.id).order("RAND()").limit(5)
    if save_exchanged_word_or_exchanged_words(words)
      redirect_to user_exchanged_words_path(current_user.id)
    else
      render :new
    end
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

  def check_and_set_user
    if User.exists?(params[:user_id])
      @user = User.find(params[:user_id])
      redirect_to root_path if @user.id != current_user.id
    else
      redirect_to root_path
    end
  end

  def set_exchanged_words
    @exchanged_words = Word.find_by(user_id: params[:user_id],id: params[:id])
  end
end
