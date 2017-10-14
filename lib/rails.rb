module Rails
  autoload :Application, "rails/application"
  # 设置使用环境
  def self.env
    ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'
  end

  # 加载所需 gem
  def self.groups
    # bundle 默认加载 gemfile 中的所有 gem
    # env 代表开发测试或者生产环境下的
    [:default, env]
  end

  # 建立 rails 程序实例
  def self.application
    Application.instance
  end

  # 返回根目录以便调用
  def self.root
    application.root
  end
end
