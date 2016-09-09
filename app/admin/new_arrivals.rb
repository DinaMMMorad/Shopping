ActiveAdmin.register Product, :as => 'New Arrivals' do
  config.clear_action_items!
  actions :index

  member_action :mark_new_arrival, method: :get do
    if params && params['flag']
      resource.update(:is_new => params['flag'])
    end
    redirect_to :action => :index
  end

  index do
    column :title
    column :is_new do |p|
      link_to (check_box_tag 'is_new', :is_new, p.is_new, class: 'is_new'), "new_arrivals/#{p.id}/mark_new_arrival?flag=#{!p.is_new}"
    end
  end
end
