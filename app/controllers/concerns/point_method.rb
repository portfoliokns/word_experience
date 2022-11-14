module PointMethod
  extend ActiveSupport::Concern

  def set_word_point_display
    if !user_signed_in?
      @word_point = '未登録'
    elsif WordPoint.exists?(user_id: current_user.id)
      @word_point = WordPoint.find_by(user_id: current_user.id).point
    else
      @word_point = '---'
    end
  end

  def create_point
    word_point = WordPoint.new
    word_point.point = ENV["WORD_POINT_CREATE"].to_i
    word_point.user_id = current_user.id
    word_point.save
  end

  def add_point(number_of_point)
    set_word_point
    @word_point.point += number_of_point
    @word_point.save
  end

  def decrease_point(number_of_point)
    set_word_point
    @word_point.point -= number_of_point
    @word_point.save
  end

  private
  def set_word_point
    @word_point = WordPoint.find_by(user_id: current_user.id)
  end

end