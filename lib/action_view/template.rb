require 'erb'

module ActionView
  class Template
    def initialize(source,name)
      @source = source
      @name = name
      @compile = false
    end

    def render(context)
      compile
      context.send(method_name, &block)
    end

    # 将非数字字母的内容换成 '_'
    def method_name
      @name.gsub(/[^\w]/,'_')
    end

    def compile
      # 如果已经编译过，就不用重复编译
      return if @compiled
      # src 方法编译传进来的 ruby 代码
      code = ERB.new(@source).src
      # CompiledTemplates 里面执行代码
      CompiledTemplates.module_eval <<-CODE
        def #{method_name}
          #{code}
        end
      CODE
      # 编译之后将 @compiled 设置为 true
      @compiled = true
    end
  end
end
