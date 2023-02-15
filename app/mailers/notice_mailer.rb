class NoticeMailer < ApplicationMailer
  def send_admin(inquiry)
    @Inquiry = inquiry
    mail to: ENV['GMAIL_ADMIN_ADDRESS'],
      subject: "【Word Experience】利用者からお問い合わせがありました"
  end

  def send_user(inquiry)
    @Inquiry = inquiry
    mail to: @Inquiry.email,
      subject: "【Word Experience】お問い合わせを受け付けました"
  end
end
