class ToysController < ApplicationController
  def new
    @toy = Toy.new
  end

  def show
    @toy = Toy.find(params[:id])
  end

  def create
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
