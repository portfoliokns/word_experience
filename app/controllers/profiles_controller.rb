class ProfilesController < ApplicationController
  include ReputationMethod
  before_action :authenticate_user!
  include CheckRedirector
  before_action :check_profile, only: [:index]

  def index
    @nickname = User.find_by(id: params[:user_id]).nickname
    @good_reputation_count = get_good_reputation_count_per_user(params[:user_id])
    @bad_reputation_count = get_bad_reputation_count_per_user(params[:user_id])
    sum_reputation = @good_reputation_count + @bad_reputation_count
    if sum_reputation == 0
      @rate = '---'
    else
      result = (@good_reputation_count.quo(sum_reputation)).to_f * 100
      @rate = result.round(1)
    end
  end
end
