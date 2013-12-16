class PassagesController < ApplicationController

  def new
    @passage = Passage.new
  end

  def index
    @passages = Passage.all
  end

  def show
    @passage = Passage.find(params[:id])
  end

  def create
    @passage = Passage.new(passage_params)

    if @passage.save
      redirect_to @passage
    else
      render 'new'
    end
  end
  
  private
  def passage_params
    params.require(:passage).permit(:prompt, :content)
  end

end
