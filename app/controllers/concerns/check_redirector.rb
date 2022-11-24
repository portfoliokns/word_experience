module CheckRedirector
  extend ActiveSupport::Concern

  def check_user_id
    if User.exists?(params[:user_id])
      user = User.find(params[:user_id])
      redirect_to root_path if user.id != current_user.id
    else
      redirect_to root_path
    end
  end

  def check_word_id
    redirect_to root_path unless Word.exists?(user_id: params[:user_id], id: params[:id])
  end

  def check_exchanged_word_id
    redirect_to root_path unless ExchangedWord.exists?(user_id: params[:user_id], id: params[:id])
  end

  def check_exchanged_word_id_for_reputation
    redirect_to root_path unless ExchangedWord.exists?(user_id: params[:user_id], id: params[:exchanged_word_id])
  end
end
