class WordsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_and_set_user, only: [:index,:new, :create]
  before_action :move_to_toppage, only: [:index, :new, :create]
  before_action :set_word_collection, only: [:new, :create]


  def index
    @words = Word.where(user_id: current_user.id).order('created_at DESC')
    @main_category = MainCategory.all
    @service_category = ServiceCategory.all
  end

  def new
    @words.new_set_data
  end

  def create
    if @words.save_data(words_params)
      redirect_to user_words_path(current_user.id)
    else
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

  def check_and_set_user
    if User.exists?(params[:user_id])
      @user = User.find(params[:user_id])
    else
      redirect_to root_path
    end
  end

  def move_to_toppage
    redirect_to root_path if @user.id != current_user.id
  end

  def set_word_collection
    @words = WordCollection.new()
  end
end