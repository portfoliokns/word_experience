class WordsController < ApplicationController
  include SetCategory
  before_action :authenticate_user!
  include CheckRedirector
  before_action :check_user_id, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :check_word_id, only: [:edit, :update, :destroy]
  before_action :set_words_collection, only: [:new, :create]
  before_action :set_word, only: [:edit, :update, :destroy]
  before_action :set_category, only: [:index, :edit]
  include PointMethod
  before_action :check_requested_point_update, only: [:update]
  before_action :check_requested_point_destroy, only: [:destroy]
  include ErrorMessageFlash
  before_action :reset_flash

  def index
    @words = Word.where(user_id: current_user.id).order('updated_at DESC').page(params[:page]).per(Word.per_page)
  end

  def new
    @words.new_set_data
  end

  def create
    save_params = words_save_params
    error_message = ""
    return render_invalid_input(error_message) unless @words.input_valid?(save_params,error_message)

    if @words.save_data(save_params)
      create_or_add_point
      redirect_to user_words_path(current_user.id)
    else
      error_message = "ワードの登録に失敗しました。管理者にお問い合わせください。"
      render_invalid_input(error_message)
    end
  end

  def edit
  end

  def update
    if @word.update(word_params)
      decrease_point(ENV['WORD_POINT_UPDATE'].to_i)
      redirect_to user_words_path(current_user.id)
    else
      set_category
      flash.now[:alert] = get_word_message('更新')
      render :edit
    end
  end

  def destroy
    if @word.destroy
      decrease_point(ENV['WORD_POINT_DESTROY'].to_i)
      redirect_to user_words_path(current_user.id)
    else
      set_category
      flash.now[:alert] = get_word_message_incident('削除')
      render :edit
    end
  end

  private

  def words_save_params
    params.require(:words).map do |word|
      word.permit(
        :name,
        :main_category_id,
        :service_category_id
      ).merge(user_id: current_user.id)
    end
  end

  def words_set_params
    params.require(:words).map do |word|
      word.permit(
        :name,
        :main_category_id,
        :service_category_id
      )
    end
  end

  def word_params
    params.require(:word)
          .permit(:name, :main_category_id, :service_category_id)
          .merge(user_id: current_user.id)
  end

  def set_words_collection
    @words = WordCollection.new
  end

  def set_word
    @word = Word.find_by(user_id: params[:user_id], id: params[:id])
  end

  def re_set_word
    writting_word = Word.new(params.require(:word).permit(:name, :main_category_id, :service_category_id))
    @word.name = writting_word.name
    @word.main_category_id = writting_word.main_category_id
    @word.service_category_id = writting_word.service_category_id
  end

  def create_or_add_point
    if WordPoint.exists?(user_id: current_user.id)
      add_point(ENV['WORD_POINT_CREATE'].to_i)
    else
      create_point
    end
  end

  def check_requested_point_update
    requested_point = ENV['WORD_POINT_UPDATE'].to_i
    return unless have_decrease_error?(requested_point)

    set_category
    re_set_word
    flash[:alert] = get_point_message(requested_point, '更新')
    render :edit
  end

  def check_requested_point_destroy
    requested_point = ENV['WORD_POINT_DESTROY'].to_i
    return unless have_decrease_error?(requested_point)

    set_category
    flash[:alert] = get_point_message(requested_point, '削除')
    render :edit
  end

  def render_invalid_input(test)
    @words.set_data(words_set_params)
    flash.now[:alert] = test
    render :new
  end
end
