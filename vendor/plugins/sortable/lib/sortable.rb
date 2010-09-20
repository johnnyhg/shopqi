# encoding: utf-8
module Mongoid
  module Sortable
    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def has_many_sortable(*args)
        args.each do |children_name|
          references_many children_name

          define_method "sorted_#{children_name}" do
            send(children_name).sort {|x, y| x.pos <=> y.pos}
          end
        end
      end

      def sortable_belong_to(*args)
        include ActsAsList::Mongoid

        #排序
        field :pos, :type => Integer
        acts_as_list :column => :pos

        referenced_in args.first, :inverse_of => collection_name
      end
    end

  end
end
