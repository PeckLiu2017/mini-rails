module ActionDispatch
  module Routing
    class Mapper
      def initialize(route_set)
        @route_set = route_set
      end

      # 解析生成路径
      # 并加入路径列表中
      # 一开始把 as赋值为 nil
      def get(path, to:, as: nil)
        # to => "controller#index"
        # 这里的 to 是键值对的 key
        # 直接取它的 value
        controller, action = to.split('#')
        @route_set.add_route('GET', path, controller, action, as)
        # p "====="
        # p @route_set
      end

      def root(to:)
        get '/', to: to, as: 'root'
      end

      # 解析路径
      # 并通过 get 方法将路径加入 @route_set 路径列表中
      def resources(plural_name)
        get "/#{plural_name}", to: "#{plural_name}#index", as: plural_name.to_s
        get "/#{plural_name}/new", to: "#{plural_name}#new",
                                   as: 'new_' + plural_name.to_s.singularize
        get "/#{plural_name}/show", to: "#{plural_name}#show",
                                    as: plural_name.to_s.singularize
      end
    end
  end
end
