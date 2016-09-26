ActiveAdmin.register Product, :as => 'New Arrivals' do
  config.clear_action_items!
  actions :index
  config.batch_actions = false

  member_action :mark_new_arrival, method: :put do
    if params && params['flag']
      resource.update(:is_new => params['flag'])
    end
    redirect_to :action => :index
  end

  filter :is_new

  index do
    column :title
    column :is_new do |p|
      link_to (check_box_tag 'is_new', :is_new, p.is_new, class: 'is_new'), mark_new_arrival_admin_new_arrival_path(:id => p.id, :flag => !p.is_new), method: :put
    end
  end
end
