module SunspotAdmin #:nodoc:
  module Routing #:nodoc:
    module MapperExtensions
      def sunspot_admin
        @set.add_route("/sunspot_admin", {:controller => "sunspot_admin", :action => "index"})
        @set.add_route("/search", {:controller => "search", :action => "index"})
      end
    end
  end
end

ActionController::Routing::RouteSet::Mapper.send :include, SunspotAdmin::Routing::MapperExtensions