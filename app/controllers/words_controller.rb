class WordsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_and_set_user, only: [:index,:new, :create, :edit, :update, :destroy]
  before_action :set_words_collection, only: [:new, :create]
  before_action :set_word, only: [:edit, :update, :destroy]
  before_action :set_category, only: [:index, :edit]
  include PointMethod
  before_action :check_requested_point_update, only:[:update]
  before_action :check_requested_point_destroy, only:[:destroy]

  def index
    @words = Word.where(user_id: current_user.id).order('updated_at DESC')
  end

  def new
    @words.new_set_data
  end

  def create
    if @words.save_data(words_params)
      create_or_add_point
      redirect_to user_words_path(current_user.id)
    else
      @words.new_set_data
      render :new
    end
  end

  def edit
  end

  def update
    if @word.update(word_params)
      decrease_point(ENV["WORD_POINT_UPDATE"].to_i)
      redirect_to user_words_path(current_user.id)
    else
      render :edit
    end
  end

  def destroy
    if @word.destroy
      decrease_point(ENV["WORD_POINT_DESTROY"].to_i)
      redirect_to user_words_path(current_user.id)
    else
      render :edit
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

  def word_params
    return params.require(:word)
      .permit(:name, :main_category_id, :service_category_id)
      .merge(user_id: current_user.id)
  end

  def check_and_set_user
    if User.exists?(params[:user_id])
      @user = User.find(params[:user_id])
      redirect_to root_path if @user.id != current_user.id
    else
      redirect_to root_path
    end
  end

  def set_words_collection
    @words = WordCollection.new()
  end

  def set_word
    @word = Word.find_by(user_id: params[:user_id],id: params[:id])
  end

  def set_category
    @main_category = MainCategory.all
    @service_category = ServiceCategory.all
  end

  def create_or_add_point
    if WordPoint.exists?(user_id: current_user.id)
      add_point(ENV["WORD_POINT_CREATE"].to_i)
    else
      create_point
    end
  end
  
  def check_requested_point_update
    requested_point = ENV["WORD_POINT_UPDATE"].to_i
    if have_decrease_error?(requested_point)
      set_category
      render :edit
    end
  end

  def check_requested_point_destroy
    requested_point = ENV["WORD_POINT_DESTROY"].to_i
    if have_decrease_error?(requested_point)
      set_category
      render :edit
    end
  end
end