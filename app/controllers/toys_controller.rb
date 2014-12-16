class ToysController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @toy = Toy.new
  end

  def index
    @toys = Toy.all
  end

  def show
    @toy = Toy.find(params[:id])
    @user = User.find(@toy.user_id)
  end

  def create
    @toy = Toy.create(title: params[:toy][:title], url: params[:toy][:url], user_id: current_user.id)
    if @toy.save
      redirect_to toy_path(@toy)
    else
      render new_toy_path
    end
  end

  private
end
