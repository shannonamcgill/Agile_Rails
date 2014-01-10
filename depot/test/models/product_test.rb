require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

test  "product attributes must not be empty" do 
 product = Product.new
 assert product.invalid?
 assert product.errors[ :title ] .any?
 assert product.errors[ :description ] .any?
 assert product.errors[ :price ] .any?
 assert product.errors[ :image_url ] .any?
end 
end
test "product price must be positive" do 
  product = Product.new(title:       "My Book TItle",
                        description: "yyy",
                        image_url:   "zzz.jpg"
                        )
  product.price =-1 
  assert product.invalid?
  assert_equal ["must be greater than or equal to 0.01"],
    product.errors[:price]
    
  product.price = 0
  assert product.invalid?
  assert_equal ["must be greater than or equal to 0.01"],
    product.errors[:price]
  
  product.price =1 
  assert product.valid?
end

def new_product(image_url)
 product = Product.new(title:       "My Book Title",
                       description: "yyy",
                       price:       1,
                       image_url:   "zzz.jpg")
end
test "image url" do
  ok = %w{ fred.gif, fred,jpg, fred.png, FRED.JPG, FRED.Jpg
    http://a.b.c/x/y/z/freg.gif}
  bad = %w{fred.doc, fred.gif/more fred.gif.more}
  ok.each do |name|
    assert new_product(name).valid?, "#{name} should be valid"
  end 
  bad.each do |name|
  assert new_product(name).invalid?, "#{name} shouldn't be valid" 
  end   
end 

                  
test "product is not valid without a unique title - il8n" do 
  product =  Product.new(title:        products(:ruby).title,
                         description:  "yyy" ,
                         price:        1,
                         image_url:    "fred.gif")
  assert product.invalid? 
  assert product_equal [Il8n.translate('errors.message.taken')], 
                       product.errors[:title]                       
end        