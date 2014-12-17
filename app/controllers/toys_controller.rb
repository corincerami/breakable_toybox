class ToysController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

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

  def edit
    @toy = Toy.find(params[:id])
  end

  def update
    @toy = Toy.find(params[:id])
    @toy.update(toy_params)
    if @toy.save
      flash[:notice] = 'App edited successfully'
      redirect_to toy_path(@toy)
    else
      render "edit"
    end
  end

  def create
    @toy = Toy.create(title: params[:toy][:title], url: params[:toy][:url], creator: params[:toy][:creator], user_id: current_user.id)
    if @toy.save
      flash[:notice] = "App submitted successfully"
      redirect_to toy_path(@toy)
    else
      render new_toy_path
    end
  end

  private

  def toy_params
    params.require(:toy).permit(:title, :url, :creator)
  end
end
