ActiveAdmin.register Order do

  index do
    column 'Product' do |i|
      i.product.title
    end
    column 'User Email' do |i|
      i.user.email
    end
    column 'User Name', :full_name
    column :identity
    column :phone
    column :alternative_phone
    column :country
    column :address
  end
end
