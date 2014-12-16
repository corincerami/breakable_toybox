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
  end

  def create
    binding.pry
    @toy = Toy.create(toy_params)
    if @toy.save
      redirect_to toy_path(@toy)
    else
      render new_toy_path
    end
  end

  private

  def toy_params
    params.require(:toy).permit(:title, :url)
  end
end
