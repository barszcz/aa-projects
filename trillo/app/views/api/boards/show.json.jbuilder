# write some jbuilder to return some json about a board
# it should include the board
#  - its lists
#    - the cards for each list

json.(@board, :id, :title)

json.lists do
  json.array! @board.lists do |list|
     json.(list, :id, :title, :ord)
     json.cards do
       json.array! list.cards do |card|
         json.(card, :id, :title, :description, :ord, :list_id)
       end
     end
  end
end
