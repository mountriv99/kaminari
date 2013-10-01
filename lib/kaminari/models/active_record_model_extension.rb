require 'kaminari/models/active_record_relation_methods'

module Kaminari
  module ActiveRecordModelExtension
    extend ActiveSupport::Concern

    included do
      self.send(:include, Kaminari::ConfigurationMethods)

      # Fetch the values at the specified page number
      #   Model.page(5)
      self.scope Kaminari.config.page_method_name, Proc.new {|num, options = {}|
        r = limit(default_per_page).offset(default_per_page * ([num.to_i, 1].max - 1))
        r.instance_variable_set(:@total_count, options[:total_count]) if options[:total_count]
        r
      } do
        include Kaminari::ActiveRecordRelationMethods
        include Kaminari::PageScopeMethods
      end
    end
  end
end
