# -*- coding: utf-8 -*-
require 'bitly'

class PassagesController < ApplicationController

  def new
    @passage = Passage.new
  end

  def index
    @passages = Passage.all


  end

  def show
    @passage = Passage.find(params[:id])

    @words = Word.where(passage_id: @passage.id).order("id")
    gon.numWords = @words.length    
    
    #How many students have done any highlights for this passage?

#
    if Rails.env.development?

      long_url = "http://127.0.0.1:3000/passages/"+ @passage.id.to_s + "/highlights"
    else 
      long_url = url_for(:only_path => false) + "/highlights"
    end

#    buffer = open(bitly_url, "UserAgent" => "Ruby-ExpandLink").read
 #   result = JSON.parse(buffer)

   @highlight_url = Bitly.shorten(long_url)


    #Code for highlighting
    @heatmap_colors = ["#95A3B5", "#41b6c4", "#7fcdbb", "#c7e9b4", "#edf8b1", "#ffffd9"]
    max_i_colors = (@heatmap_colors.count * 1.0) - 1

    #This is a really inefficient way to get the highest highlighted value.
    w_ids = []
    n_hl = []
    @words.each do |w| 
      #TODO I think there is a better way to do this by cutting down what is selected in the first place perhaps then using the hash values?
      w_ids << w.id
      n_hl << w.highlights.count

    end
 

    #s_hl is the sessions that have highlighted this passage.
    #n_hl is the number of times each word has been highlighted.
    s_hl= Highlight.where(:word_id => w_ids).group("session_id").count
    @num_students = s_hl.length
    @max_hl = n_hl.max
    min_hl = n_hl.min
    @spread = @max_hl - min_hl
    
     
    if @max_hl >= 1 
      #Now lets loop through the whole thing again and set up the colors.
        @text_map = @words.inject([]) do |result, w|
          #Divide the words into 9 bins. In this case by length but eventually by the number of people who highligted it.
        if w.highlights.count == 1
          #even if there are many highlights we want to show that one person highlighted the word.
          level = 1
        else
          level = (((w.highlights.count - min_hl.to_f) / @spread) * max_i_colors).floor
        end
        color = @heatmap_colors[level]
          #What I really want to do here is create a data structure where I can use the name rather then remembering which order the elements are in. But that just isn't working for me right now.

          result << [w.word, color]
        end
      else
        @text_map = @words.inject([]) do |result, w|
        #no highlighting yet.
        color = @heatmap_colors[0]
          #What I really want to do here is create a data structure where I can use the name rather then remembering which order the elements are in. But that just isn't working for me right now.
          result << [w.word, color]
        end
      end
 #     binding.pry
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
