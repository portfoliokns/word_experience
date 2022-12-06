class ProfilesController < ApplicationController
  def index
    @good_reputation_total = 67
    @bad_reputation_total = 32
    result = (@good_reputation_total.quo(@good_reputation_total + @bad_reputation_total)).to_f * 100
    @rate = result.round(1)
  end
end
