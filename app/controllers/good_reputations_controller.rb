class GoodReputationsController < ApplicationController
  include SetCategory

  def create
    exchanged_word = ExchangedWord.find_by(user_id: params[:user_id], word_id: params[:exchanged_word_id])
    binding.pry
    good_reputaion = GoodReputation.new(good_reputaion_params)
    binding.pry
    good_reputaion.user_id = current_user.id
    good_reputaion.word_id = exchanged_word.word_id
    good_reputaion.exchanged_word_id = exchanged_word.id
    if good_reputaion.save
      redirect_to user_exchanged_words_path(current_user.id)
    else
      @exchanged_words = ExchangedWord.where(user_id: current_user.id).order('created_at DESC')
      set_category
      render 'exchanged_words/index'
    end
  end

  private
  def good_reputaion_params
    # binding.pry
    # params.require(:good_reputation).permit(:word_id, :exchanged_word_id).merge(user_id: current_user.id)
    # binding.pry
  end

end
