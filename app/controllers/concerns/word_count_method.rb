module WordCountMethod
  extend ActiveSupport::Concern

  def get_word_count(user_id)
    return Word.where(user_id: user_id).count
  end

  def get_exchanged_word_count(user_id)
    return ExchangedWord.where(user_id: user_id).count
  end
end