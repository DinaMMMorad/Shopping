class AddRowsInCategories < ActiveRecord::Migration
  def self.up
    Category.create :title => 'Mobiles', :index => 1
    Category.create :title => 'Fashion', :index => 2
    Category.create :title => 'Health & Beauty', :index => 3
    Category.create :title => 'Watches & Jewelery', :index => 4
    Category.create :title => 'Home & Decor', :index => 5
    Category.create :title => 'Kitchen & Dining', :index => 6
    Category.create :title => 'Computers & Software', :index => 7
    Category.create :title => 'Electronics', :index => 8
    Category.create :title => 'Sport & Fitness', :index => 9
    Category.create :title => 'Sunglasses', :index => 10
    Category.create :title => 'Baby & Toys', :index => 11
    Category.create :title => 'Shoes & Bags', :index => 12
    Category.create :title => 'Books', :index => 13
  end

  def self.down
    Category.delete_all
  end
end
