class WelcomeController < ApplicationController
  def index

    #FIXME There is an ugly hack application.html.erb loading welcome.js after jquery and jquery mobile are run. I need to figure out how to change the order correctly.
    #TODO Right now you just tap words I need to figure out how to select a whole area.
    #FIXME Its not unselecting to the right background color. Or more accurately figure out where the documents background color is being set and get everything to match up.
    @text = "Title:     Magic
Author: William Butler Yeats [More Titles by Yeats]	
I

I believe in the practice and philosophy of what we have agreed to call magic, in what I must call the evocation of spirits, though I do not know what they are, in the power of creating magical illusions, in the visions of truth in the depths of the mind when the eyes are closed; and I believe in three doctrines, which have, as I think, been handed down from early times, and been the foundations of nearly all magical practices. These doctrines are--

(1) That the borders of our minds are ever shifting, and that many minds can flow into one another, as it were, and create or reveal a single mind, a single energy.

(2) That the borders of our memories are as shifting, and that our memories are a part of one great memory, the memory of Nature herself.

(3) That this great mind and great memory can be evoked by symbols.

I often think I would put this belief in magic from me if I could, for I have come to see or to imagine, in men and women, in houses, in handicrafts, in nearly all sights and sounds, a certain evil, a certain ugliness, that comes from the slow perishing through the centuries of a quality of mind that made this belief and its evidences common over the world.

"
    @heatmap_colors = ["#ffffff", "#ffffd9", "#edf8b1", "#c7e9b4", "#7fcdbb", "#41b6c4", "#1d91c0", "#225ea8", "#253494", "#081d58"]

    @split_text = @text.split(' ')
    longest_word = @split_text.group_by(&:size).max.last
    max = longest_word[0].length
    min = 1.0
    spread = max - min

    @text_map = @split_text.inject([]) do |result, word|
      #Divide the words into 9 bins. In this case by length but eventually by the number of people who highligted it.
      level = (((word.length - min) / spread) * 9.0).floor
      color = @heatmap_colors[level]
      result << [word, color]

    end
    gon.numWords = @split_text.length
    #binding pry
  end
end
