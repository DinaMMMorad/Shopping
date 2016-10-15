class AddPictureToProductImage < ActiveRecord::Migration
  def up
    add_attachment :product_images, :picture
  end

  def down
    remove_attachment :product_images, :picture
  end
end
