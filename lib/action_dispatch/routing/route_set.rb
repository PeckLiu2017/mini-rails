module ActionDispatch
  module Routing
    # Struct.new 创建一个新的 Struct子类
    # 它可以包含每个传进去的参数的值
    # 这个子类可以像任何其他类一样用于创建 Struct 的实例
    # 如果省略class_name，将创建一个匿名结构类
    # 否则，该结构体的名称将在类Struct中显示为常量
    # 因此对系统中的所有结构体必须是唯一的，并且必须以大写字母开头
    # 将一个结构类分配给一个常量也为该类提供了常量的名称
    class Route < Struct.new(:method, :path, :controller, :action, :name)
      # 匹配请求的路径参数
      # 路径符合则进行下一步处理
      def match?(request)
        # p self
        # #<struct ActionDispatch::Routing::Route method="GET", path="/posts", controller="posts", action="index", name=nil>
        # p method
        # 参数 :method 的值
        # 字符串 "GET"或 "POST"
        request.request_method == method && request.path_info == path
      end

      def controller_class
        "#{controller.classify}Controller".constantize
      end

      def dispatch(request)
        # 寻找文件
        # 寻找或新增相应 controller 常量
        # 建立 controller 的实例
        # 执行 action
        # 返回响应
        controller = controller_class.new
        controller.request = request
        controller.response = Rack::Response.new
        # p controller
        #=> #<PostsController:0x007fa6a7dbbac8
        # @request=#<Rack::Request:0x007fa6a7dc89f8 @params=nil,
        # @env={"rack.version"=>[1, 3], "rack.input"=>#<StringIO:0x007fa6a6824138>, "rack.errors"=>#<StringIO:0x007fa6a68241b0>, "rack.multithread"=>true, "rack.multiprocess"=>true, "rack.run_once"=>false, "REQUEST_METHOD"=>"GET", "SERVER_NAME"=>"example.org", "SERVER_PORT"=>"80", "QUERY_STRING"=>"id=1", "PATH_INFO"=>"/posts/show", "rack.url_scheme"=>"http", "HTTPS"=>"off", "SCRIPT_NAME"=>"", "CONTENT_LENGTH"=>"0"}>,
        # @response=#<Rack::Response:0x007fa6a7dbbaa0
        # @status=200,
        # @header={},
        # @writer=#<Proc:0x007fa6a7dbb938@/Users/peckliu/.rvm/gems/ruby-2.3.3@global/gems/rack-2.0.3/lib/rack/response.rb:32 (lambda)>, @block=nil, @length=0, @body=[]>>
        controller.process(action)
        controller.response.finish
      end
    end

    class RouteSet
      def initialize
        @routes = []
      end

      def add_route(*args)
        route = Route.new(*args)
        @routes << route
        # p route
        # =>#<struct ActionDispatch::Routing::Route method="GET", path="/posts", controller="posts", action="index">
        route
        # 解析处理路径的 *args
        # 找出 :controller.:action
        # 分配请求的 :controller,:action 路径
        # 执行代码
      end

      def find_route(request)
        @routes.detect { |route| route.match?(request) }
      end

      def draw(&block)
        # p self
        # #<ActionDispatch::Routing::RouteSet:0x007f8a15040f78 @routes=[]>
        mapper = Mapper.new(self)
        # p mapper
        # #<ActionDispatch::Routing::Mapper:0x007f8a150322e8
        # @route_set=#<ActionDispatch::Routing::RouteSet:0x007f8a15040f78 @routes=[]>>
        # 在当前 mapper 的上下文中执行程序
        # 否则会报  NoMethodError: undefined method `get'...
        mapper.instance_eval(&block)
      end

      def call(env)
        request = Rack::Request.new(env)
        # p request
        # #<Rack::Request:0x007fd65203ecd0 @params=nil, @env={"REQUEST_METHOD"=>"GET", "PATH_INFO"=>"/posts/new"}>
        if route = find_route(request)
          route.dispatch(request)
        else
          [404, { 'Content-Type' => 'text/plain' }, ['Not found']]
        end
      end
    end
  end
end
