module ErrorMessageFlash
  extend ActiveSupport::Concern

  def reset_flash
    flash[:alert] = ''
  end

  def get_point_message(requested_point,action_name)
    text = "ワードポイントが#{requested_point - @word_point}ポイント足りません。#{action_name}には#{requested_point}ポイントが必要です。"
    return text
  end

  def get_word_message(action_name)
    text = "ワードの#{action_name}に失敗しました。"
    return text
  end

  def get_word_message_incident(action_name)
    text = "ワードの#{action_name}に失敗しました。管理者にお問合せください。"
    return text
  end

  def get_no_word_message()
    text ='交換するワードがありません。他のユーザーがワードを登録するのをお待ちください。'
    return text
  end

end



