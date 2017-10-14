require 'erb'

module ActionView
  class Template
    # Template 实例没有被销毁时
    # 缓存就一直存在
    CACHE = Hash.new do |cache, file|
      cache[file] = Template.new(File.read(file), file)
    end

    def self.find(file)
      CACHE[file]
    end
    
    def initialize(source,name)
      @source = source
      @name = name
      @compile = false
    end

    def render(context, &block)
      compile
      # 执行 CompiledTemplates 里面的代码
      # &block
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
      # code 的内容:
      # p code
      # "#coding:UTF-8\n_erbout = ''; _erbout.concat \"<p>\";
      # _erbout.concat(( yield ).to_s); _erbout.concat \"</p>\";
      # _erbout.force_encoding(__ENCODING__)"
      # 将代码放进 CompiledTemplates 中
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
