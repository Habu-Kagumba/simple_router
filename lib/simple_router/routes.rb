module SimpleRouter
  class Routes < Array #:nodoc:

    # routing engine
    attr_accessor :engine

    def engine
      @engine || Engines::SimpleEngine
    end

    def add(*args, &action)
      self << Route.new(*args, &action)
    end

    def match(verb, path)
      unless self.empty?
        routes = self.select {|route| route.verb == verb }
        paths  = routes.map  {|route| route.path }

        path = self.engine.match(path, paths)
        routes.detect {|route| route.path == path }
      end
    end

    class Route < Array #:nodoc:
      attr_accessor :verb,:path,:options,:action

      def initialize(verb, path, options, &action)
        self.verb    = verb
        self.path    = path
        self.options = options
        self.action  = action
      end
    end
  end
end