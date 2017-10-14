module ActionController
  class Metal
    attr_accessor :request, :response

    def process(action)
      # process 第三步在 callbacks 中
      # 第四步这里
      # 然后回到 lib/action_controller/implicit_render.rb 中
      # 做判断是否 render action
      send action
    end

    def params
      # 在这里解析请求参数
      # p request.params #=> {"id"=>"1"}
      request.params.symbolize_keys
    end
  end
end
