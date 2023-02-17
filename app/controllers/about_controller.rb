class AboutController < ApplicationController
  def index
    @user_num = User.count
    @word_num = Word.count
    @exchanged_word_num = ExchangedWord.count
  end
end
