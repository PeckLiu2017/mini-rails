module ActionController
  class Metal
    attr_accessor :request, :response

    def process(action)
      send action
    end

    def params
      # 在这里解析请求参数
      # p request.params #=> {"id"=>"1"}
      request.params.symbolize_keys
    end
  end
end
