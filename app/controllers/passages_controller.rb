class PassagesController < ApplicationController

  def new
    @passage = Passage.new
  end

  def index
    @passages = Passage.all
  end

  def show
    @passage = Passage.find(params[:id])
    @highlight_url = url_for(:only_path => false) + "/highlights"
  end

  def create
    @passage = Passage.new(passage_params)

    if @passage.save
      #TODO Now we need to create the words that will each get put in the data model.
      split_text = @passage.content.split(' ')
      
      split_text.each_with_index { |w, index| 
#        binding.pry
        word = Word.new(word: w,
                        index: index,
                        passage_id: @passage.id)
        word.save
      }

      
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
