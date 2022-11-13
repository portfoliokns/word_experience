class ExchangedWordsController < ApplicationController
  def index
    @words = Word.where(user_id: current_user.id).order('updated_at DESC')
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
        exchanged_word.user_id = word.user_id
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
end
