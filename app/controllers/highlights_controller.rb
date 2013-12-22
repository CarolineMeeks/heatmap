class HighlightsController < ApplicationController
  def index

    @passage = Passage.find(params[:passage_id])

    @words = Word.where(passage_id: @passage.id).order("id")
    gon.numWords = @words.length
#    binding.pry
  end

  def create
    #I have an index column in word. But I wonder if I really need it or not, I probably could have used id and just sorted by id order. The advantage of index is that I don't have to pass a starting value around to all the different files....

    #This is called by the javascript and expects the word index and a boolean for highlighted.
    #First we need to get the word_id from the index of the word. I suspect there is a better way to do do this as I mentioned above.
    word = Word.find_by(passage_id: params[:passage_id], index: params[:i])

    Highlight.where(word_id: word.id, session_id: session[:session_id]).first_or_create.update_attributes(highlighted: params[:highlighted], word_id: word.id, session_id: session[:session_id]) 
    render :nothing => true

  end

end
