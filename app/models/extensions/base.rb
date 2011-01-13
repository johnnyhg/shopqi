module Extensions
  module Base
    extend ActiveSupport::Concern

    module InstanceMethods

      # Examples:
      #   o = Order.new    # id = 111
      #   o.view_id        # get "order_111"
      def view_id
        "#{view_name}_#{id}"
      end

      def view_name
        self.class.name.downcase
      end

    end
  end
end

