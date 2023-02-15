class InquiriesController < ApplicationController
  def new
    @Inquiry = Inquiry.new
  end

  def confirm
    @Inquiry = Inquiry.new(inquiry_params)
    if @Inquiry.invalid?
      render :new
    end
  end

  def create
    @Inquiry = Inquiry.new(inquiry_params)
    # NoticeMailer.send_admin(@Inquiry).deliver_now
    # NoticeMailer.send_user(@Inquiry).deliver_now
    redirect_to send_inquiry_path
  end

  def back
    @Inquiry = Inquiry.new(inquiry_params)
    render :new
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name,:email,:detail)
  end
end
