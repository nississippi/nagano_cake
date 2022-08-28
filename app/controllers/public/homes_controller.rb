class Public::HomesController < ApplicationController
  def top
    @item = Item.last(4)
  end

  def about
  end
end
