class AddAccessoriesToCategories < ActiveRecord::Migration
  def self.up
    Category.create :title => 'Accessories', :index => 14
  end

  def self.down
    Category.where(:index => 14).destroy_all
  end
end
