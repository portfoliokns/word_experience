class WordsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_word, only: [:index, :new]
  # before_action :move_to_toppage, only: [:index, :new]


  def index
    @user = User.find(params[:user_id])
    @words = Word.where(user_id: current_user.id).order('created_at DESC')
    @main_category = MainCategory.all
    @service_category = ServiceCategory.all
  end

  def new
    @words = WordCollection.new()
    @words.new_set_data
  end

  def create
    @words = WordCollection.new()
    if @words.save_data(words_params)
      redirect_to user_words_path(current_user.id)
    else
      @words = WordCollection.new()
      @words.new_set_data
      render :new
    end
  end

  private
  def words_params
    return params.require(:words).map do |word|
      word.permit(
        :name,
        :main_category_id,
        :service_category_id
      ).merge(user_id: current_user.id)
    end
  end
end