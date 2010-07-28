# encoding: utf-8
module Mongoid
  module Sortable
    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def sortable(*children_names)
        children_names.each do |children_name|
          #parent
          parent_name = self.name.singularize
          embeds_many children_name

          define_method "sorted_#{children_name}" do
            send(children_name).sort {|x, y| x.pos <=> y.pos}
          end

          #child
          #child = Kernel.const_get(children_name.to_s.singularize.camelize)
          child = children_name.to_s.singularize.camelize.constantize
          child.send :include, ActsAsList::Mongoid

          child.class_eval do
            define_method :init_pos do
              send(parent_name).send(children_name).init_list!
              if direct
                move(direct.to_sym => send(parent_name).send(children_name).find(neighbor))
                send(parent_name).save
              end
            end

            #排序
            field :pos, :type => Integer
            acts_as_list :column => :pos
            #页面传递的参数，用于新增时指明其所在的参照数哪个位置(前或后)
            attr_accessor :neighbor, :direct

            embedded_in parent_name, :inverse_of => children_name

            #一定要初始化pos
            after_create :init_pos
          end
        end
      end
    end

  end
end
