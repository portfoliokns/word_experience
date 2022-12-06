class ProfilesController < ApplicationController
  include ReputationMethod

  def index
    @nickname = User.find_by(id: params[:user_id]).nickname
    @good_reputation_total = get_reputation_total_per_user(params[:user_id], true)
    @bad_reputation_total = get_reputation_total_per_user(params[:user_id],false)
    sum_reputation = @good_reputation_total + @bad_reputation_total
    if sum_reputation == 0
      @rate = 0.0
    else
      result = (@good_reputation_total.quo(sum_reputation)).to_f * 100
      @rate = result.round(1)
    end
  end
end
