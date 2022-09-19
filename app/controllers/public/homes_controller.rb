class Public::HomesController < ApplicationController
  def top
    #.orderと.firstの記述順が逆だとうまくいかない
    @items = Item.where(is_active: true).order(id: "DESC").first(4)
  end

  def about
  end
end
