module PointMethod
  extend ActiveSupport::Concern

  def have_decrease_error?(requested_point)
    if WordPoint.exists?(user_id: current_user.id)
      now_point = WordPoint.find_by(user_id: current_user.id).point
      check = false if now_point >= requested_point
    end
    return check
  end

  def set_word_point_display
    if !user_signed_in?
      @word_point = ''
    elsif WordPoint.exists?(user_id: current_user.id)
      @word_point = WordPoint.find_by(user_id: current_user.id).point
    else
      @word_point = '0'
    end
  end

  def create_point
    word_point = WordPoint.new
    word_point.point = ENV["WORD_POINT_CREATE"].to_i
    word_point.user_id = current_user.id
    word_point.save
  end

  def add_point(get_point)
    set_word_point
    @word_point.point += get_point
    @word_point.save
  end

  def decrease_point(get_point)
    set_word_point
    @word_point.point -= get_point
    @word_point.save
  end

  private
  def set_word_point
    @word_point = WordPoint.find_by(user_id: current_user.id)
  end

end