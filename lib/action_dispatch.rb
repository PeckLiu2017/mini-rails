module ActionDispatch
  module Routing
    # autoload 的路径载入好像和正常 rails 文件路径一样了
    # 优点不同于 require 路径的写法
    autoload :RouteSet, 'action_dispatch/routing/route_set'
    autoload :Mapper, 'action_dispatch/routing/mapper'
  end
end
