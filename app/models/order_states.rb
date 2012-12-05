class OrderStates < StateManager::Base
  
  state :approval_pending do    
    event :approve, :transitions_to => 'approved.to_assign'    
    def enter
      puts "INIT ORDER"
      order.ship_qty = -1
      order.customer = "Unknown"
    end    
  end
  
  state :approved do
    
    state :to_assign do
      event :assign
      event :step_back, :transitions_to => 'approval_pending'
      def enter
        order.set_id = nil
        order.store_worker = nil
      end
    end

    state :assigned do
      event :prepare 
      event :step_back, :transitions_to => 'approved.to_assign'
      def enter
        order.store_worker = nil
      end
    end
        
    def enter
      order.ship_qty = 0
    end
  end
  
  state :ready_for_shipping do
    event :step_back, :transitions_to => 'approved.assigned'
  end

  state :delivered do
  end
  
  state :returned do
  end
  
  state :closed do
  end
  
  state :cancelled do
  end
  
  state :skipped do
  end
  
  
  
  class Approved
    class ToAssign      
      def assign(set_id)
        return false unless set_id
        order.set_id = set_id
        order.state_manager.transition_to('approved.assigned')
        true
      end
    end
    
    class Assigned
      def prepare(worker)
        return false unless worker
        order.store_worker = worker
        order.state_manager.transition_to('ready_for_shipping')
        true
      end
    end
  end
  
  
      #   def prepare(ship_qty)
      #   #return false unless valid_parameters_for_prepare?
      #   return false unless ship_qty > 5
      #   order.ship_qty = order.qty + 10
      #   order.state_manager.transition_to('ready_for_shipping')
      #   true
      # end

  
end