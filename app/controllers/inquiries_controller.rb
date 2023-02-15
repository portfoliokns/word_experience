class InquiriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_inquiry, only: [:confirm, :create, :back]

  def new
    @Inquiry = Inquiry.new
    @User = User.find_by(id: current_user.id)
    @Inquiry.name = @User.last_name + "　" + @User.first_name
    @Inquiry.email = @User.email
  end

  def confirm
    if @Inquiry.invalid?
      render :new
    end
  end

  def create
    if @Inquiry.valid?
      # NoticeMailer.send_admin(@Inquiry).deliver_now
      # NoticeMailer.send_user(@Inquiry).deliver_now
      redirect_to send_inquiry_path
    else
      render :new
    end
  end

  def back
    render :new
  end

  private
  
  def set_inquiry
    @Inquiry = Inquiry.new(inquiry_params)
  end

  def inquiry_params
    params.require(:inquiry).permit(:name,:email,:detail)
  end
end
