class Order < ActiveRecord::Base
  attr_accessible :customer, :qty, :ship_qty, :uid, :state
  
  extend StateManager::Resource
  state_manager 

  
end
