class AddClothesToCategories < ActiveRecord::Migration
  def self.up
    Category.create :title => 'Clothes', :index => 15
  end

  def self.down
    Category.where(:index => 15).destroy_all
  end
end
