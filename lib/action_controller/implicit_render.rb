module ActionController
  module ImplicitRender
    def process(action)
      # process 第一步在 lib/action_dispatch/routing/route_set.rb
      # 第二步在这里
      # super 表示先触发祖先链上面 Callbacks 然后 Metal 中的 process
      super
      # 最后做判断
      # 如果 response 没有返回
      # 就 render action
      render action if response.empty?
    end
  end
end
