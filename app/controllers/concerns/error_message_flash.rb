module ErrorMessageFlash
  extend ActiveSupport::Concern

  def reset_flash
    flash[:alert] = ''
  end

  def get_recaptcha_message
    "reCAPTCHA認証をしてください。"
  end

  def get_point_message(requested_point, action_name)
    "ワードポイントが#{requested_point - @word_point}ポイント足りません。#{action_name}には#{requested_point}ポイントが必要です。"
  end

  def get_word_message(action_name)
    "ワードの#{action_name}に失敗しました。入力に誤りがあります。"
  end

  def get_word_message_incident(action_name)
    "ワードの#{action_name}に失敗しました。管理者にお問合せください。"
  end

  def get_no_word_message
    '交換するワードがありません。他のユーザーがワードを登録するのをお待ちください。'
  end

  def get_reputation_message_incident
    '評価登録の処理に失敗しました。管理者にお問合せください。'
  end
end
