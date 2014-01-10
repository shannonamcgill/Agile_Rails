class StoreController < ApplicationController
  def index
@products = Product.order(:title) 
# .order(:title) displays the products in alphabetic order
  end

end
