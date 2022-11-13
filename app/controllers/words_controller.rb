class WordsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_and_set_user, only: [:index,:new, :create, :edit, :update, :destroy]
  before_action :set_words_collection, only: [:new, :create]
  before_action :set_word, only: [:edit, :update, :destroy]

  def index
    @words = Word.where(user_id: current_user.id).order('updated_at DESC')
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

  def edit
  end

  def update
    if @word.update(word_params)
      redirect_to user_words_path(current_user.id)
    else
      render :edit
    end
  end

  def destroy
    if @word.destroy
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
end