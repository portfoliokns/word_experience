module ReputationMethod
  extend ActiveSupport::Concern

  def get_reputation_count
    return Reputation.where(user_id: params[:user_id],exchanged_word_id: params[:exchanged_word_id]).count
  end

  def get_reputation_total_per_user(user_id, flag)
    return Reputation.where(user_id: user_id, star_flag: flag).count
  end

  def set_new_reputation(star_flag, bad_flag)
    exchanged_word = ExchangedWord.find_by(user_id: params[:user_id], id: params[:exchanged_word_id])
    reputation = Reputation.new
    reputation.user_id = current_user.id
    reputation.word_id = exchanged_word.word_id
    reputation.exchanged_word_id = exchanged_word.id
    reputation.star_flag = star_flag
    reputation.bad_flag = bad_flag
    return reputation
  end
  
  def change_star_flag_and_get_reputation
    reputation = Reputation.find_by(user_id: params[:user_id], exchanged_word_id: params[:exchanged_word_id])
    reputation.star_flag = !(reputation.star_flag == true)
    if reputation.bad_flag == true
      reputation.bad_flag = false
    end
    return reputation
  end

  def change_bad_flag_and_get_reputation
    reputation = Reputation.find_by(user_id: params[:user_id], exchanged_word_id: params[:exchanged_word_id])
    reputation.bad_flag = !(reputation.bad_flag == true)
    if reputation.star_flag == true
      reputation.star_flag = false
    end
    return reputation
  end

end