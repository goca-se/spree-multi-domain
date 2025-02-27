module SpreeMultiDomain
  class Engine < Rails::Engine
    engine_name 'spree_multi_domain'

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      ['app', 'lib'].each do |dir|
        Dir.glob(File.join(File.dirname(__FILE__), "../../#{dir}/**/*_decorator*.rb")) do |c|
          Rails.application.config.cache_classes ? require(c) : load(c)
        end
      end

      Spree::Config.searcher_class = Spree::Search::MultiDomain
      ApplicationController.send :include, SpreeMultiDomain::MultiDomainHelpers
    end

    config.to_prepare &method(:activate).to_proc

    initializer "templates with dynamic layouts" do |app|
      module StoreLayoutRenderer
        def find_layout(layout, locals, *formats)
          store_layout = layout

          if @view.respond_to?(:current_store) && @view.current_store && !@view.controller.is_a?(Spree::Admin::BaseController)
            store_layout = if layout.is_a?(String)
              layout.gsub("layouts/", "layouts/#{@view.current_store.code}/")
            else
              layout.call.try(:gsub, "layouts/", "layouts/#{@view.current_store.code}/")
            end
          end

          begin
            super(store_layout, locals, *formats)
          rescue ::ActionView::MissingTemplate
            super(layout, locals, *formats)
          end
        end
      end

      ActionView::TemplateRenderer.prepend(StoreLayoutRenderer)
    end

    initializer "current order decoration" do |app|
      require 'spree/core/controller_helpers/order'
      
      module StoreDomainOrder
        def current_order(options = {})
          options[:create_order_if_necessary] ||= false
          order = super(options)

          if order && current_store && order.store_id != current_store.id
            order.update_attribute(:store_id, current_store.id)
          end

          order
        end
      end

      ::Spree::Core::ControllerHelpers::Order.prepend(StoreDomainOrder)
    end
  end
end
