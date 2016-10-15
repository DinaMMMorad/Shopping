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


  permit_params :title, :description, :is_new, :picture, :category_id, :price, product_images_attributes: [:picture, :picture_file_name, :picture_content_type, :picture_file_size, :picture_updated_at, :_destroy, :id]
  # [:id, :picture, :_destroy]

  form :html => { :multipart => true } do |f|
    f.inputs 'Product Details' do
      f.input :title
      f.input :description
      f.input :price
      f.input :is_new
      f.inputs 'Product images' do
        f.has_many :product_images, allow_destroy: true, new_record: true do |p|
          if p.object.new_record?
            p.input :picture, :as => :file, :label => 'Image',:hint => p.object.picture.nil? ? p.template.content_tag(:span, "No Image Yet") : p.template.image_tag(p.object.picture.url)
          else
            p.input :picture, :as => :file, :label => 'Image',:hint => p.object.picture.nil? ? p.template.content_tag(:span, "No Image Yet") : p.template.image_tag(p.object.picture.url), :input_html => { :class => 'disabled_img', :disabled => true }
          end
        end
      end
      f.input :category_id, :as => :select, :collection => Category.all.map { |u| [u.title, u.id] }, :include_blank => false
    end
    f.actions
  end

  show do |product|
    attributes_table do
      row :title
      row :description
      row :price
      row :category_id
      product.product_images.each do |product_image|
        row :images do
          image_tag(product_image.picture.url) #(:thumb))
        end
      end
      # row :picture do
      #   image_tag(product.picture.url) #(:thumb))
      # end
    end
  end


end
