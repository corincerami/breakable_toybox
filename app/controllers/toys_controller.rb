class ToysController < ApplicationController
  def new
    @toy = Toy.new
  end

  def show
    @toy = Toy.find(params[:id])
  end

  def create
    @toy = Toy.create(toy_params)
    redirect_to toy_path(@toy)
  end

  private

  def toy_params
    params.require(:toy).permit(:title, :url)
  end
end
