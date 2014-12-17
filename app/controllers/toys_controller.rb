class ToysController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

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
    if @toy.user.id == current_user.id
      if @toy.save
        flash[:notice] = 'App edited successfully'
        redirect_to toy_path(@toy)
      else
        render "edit"
      end
    else
      flash[:notice] = "You don't have permission to do that"
      render "show"
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

  def destroy
    @toy = Toy.find(params[:id])
    if current_user.id == @toy.user.id
      Toy.destroy(@toy.id)
      redirect_to toys_path
    else
      flash[:notice] = "You don't have permission to do that"
      render "show"
    end
  end

  private

  def toy_params
    params.require(:toy).permit(:title, :url, :creator)
  end
end
