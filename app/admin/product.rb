ActiveAdmin.register Product do

  menu priority: 1
  config.batch_actions = false

  index do
    column :title
    column :description
    column :price
    column :is_new
    column :category_id
    column :created_at
    actions
  end

  filter :title
  filter :description
  filter :price


  permit_params :title, :description, :is_new, :picture, :category_id, :price

  form do |f|
    f.inputs 'Product Details' do
      f.input :title
      f.input :description
      f.input :price
      f.input :is_new
      f.inputs 'Upload' do
        f.input :picture, required: true, as: :file
      end
      f.input :category_id, :as => :select, :collection => Category.all.map {|u| [u.title, u.id]}, :include_blank => false
    end
    f.actions
  end

  show do |product|
    attributes_table do
      row :title
      row :description
      row :price
      row :category_id
      row :picture do
        image_tag(product.picture.url) #(:thumb))
      end
    end
  end


end
