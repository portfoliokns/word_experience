class ExchangedWordsController < ApplicationController
  def index
    @words = Word.where(user_id: current_user.id).order('updated_at DESC')
    @main_category = MainCategory.all
    @service_category = ServiceCategory.all
  end

  def new

  end

  def create

  end
end
