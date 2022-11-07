class WordsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_word, only: [:index, :new]
  # before_action :move_to_toppage, only: [:index, :new]


  def index
    @user = User.find(params[:user_id])
    @words = Word.where(user_id: current_user.id).order('created_at DESC')
  end

  def new
    @word = Word.new
  end

  private
  # def set_word
  #   binding.pry
  #   @word = Word.find(params[:item_id])
  # end

  # def move_to_toppage
  #   binding.pry
  #   redirect_to root_path if @word.user_id == current_user.id
  # end

end

# @words = Word.where(user_id: current_user.id)
    # binding.pry
    # user = User.find(current_user.id)
    # @words = Word.includes(:user)
    # @user = User.where('id = ?',current_user.id)
    # @words = Word.all.order('created_at DESC')