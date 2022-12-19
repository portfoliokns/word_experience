class ProfilesController < ApplicationController
  before_action :authenticate_user!
  include CheckRedirector
  before_action :check_profile, only: [:index]
  include WordCountMethod
  include ReputationMethod

  def index
    if current_user.id == params[:user_id].to_i
      @login_users_profile = true
    else
      @login_users_profile = false
    end
    @nickname = User.find_by(id: params[:user_id]).nickname
    @word_count = get_word_count(params[:user_id])
    @exchanged_word_count = get_exchanged_word_count(params[:user_id])

    @good_reputation_count = get_good_reputation_count_per_user(params[:user_id])
    @bad_reputation_count = get_bad_reputation_count_per_user(params[:user_id])
    sum_reputation = @good_reputation_count + @bad_reputation_count
    if sum_reputation == 0
      @rate = '---'
    else
      result = (@good_reputation_count.quo(sum_reputation)).to_f * 100
      @rate = result.round(1)
    end

    @good_reputation_count_by_myself = get_good_reputation_count_by_myself(params[:user_id])
    @bad_reputation_count_by_myself = get_bad_reputation_count_by_myself(params[:user_id])
    sum_count_by_myself = @good_reputation_count_by_myself + @bad_reputation_count_by_myself
    if @exchanged_word_count == 0
      @count_rate = '---'
    else
      result = (sum_count_by_myself.quo(@exchanged_word_count)).to_f * 100
      
      @count_rate = result.round(1)
    end

  end
end
