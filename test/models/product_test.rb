require "test_helper"

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product is not valid without a unique title" do
    product = Product.new("title"=>"MyString1", "description"=>"valid description", "image_url"=>"image.png", "price"=>100)
    assert product.invalid?
    assert product.errors[:title].any?
  end

  test "product attributes must not me empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price has to be positive" do
    product = Product.new("title"=>"valid title", "description"=>"valid description", "image_url"=>"image.png", "price"=>-1)
    assert product.invalid?
    assert product.errors[:price].any?
    product.price = 0
    assert product.invalid?
    product.price=100
    assert product.valid?
  end

  test "image has to be png, jpg or gif" do
    product = Product.new("title"=>"valid title", "description"=>"valid description", "image_url"=>"image.jpeg", "price"=>1)
    assert product.invalid?
    product.image_url = "example_without_extension"
    assert product.invalid?
    product.image_url = "example.png"
    assert product.valid?
  end
end
