class PassagesController < ApplicationController

  def new
  end

  def create
    @passage = Passage.new(passage_params)

    @passage.save
    redirect_to @passage
  end
  
  private
  def passage_params
    params.require(:passage).permit(:prompt, :content)
  end

end
