if defined?(Spree::Promotion)
  module Spree
    class Promotion < Spree::Activator
      module Rules
        Product.class_eval do
          belongs_to :product_group
          attr_accessible :product_group_id, :products_source
          attr_accessor :products_source
          before_save :reset_product_group

          def eligible_products
            product_group ? product_group.products : products
          end

          def reset_product_group
            update_column(:product_group_id, nil) if products_source == 'manual'
          end

        end
      end
    end
  end
end
