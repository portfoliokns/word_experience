# Preview all emails at http://localhost:3000/rails/mailers/notice
class NoticePreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notice/greeting
  def greeting
    NoticeMailer.greeting
  end

end
