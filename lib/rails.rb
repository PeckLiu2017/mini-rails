module Rails
  autoload :Application, "rails/application"
  def self.env
    ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'
  end

  def self.groups
    # bundle 默认加载 gemfile 中的所有 gem
    # env 代表开发测试或者生产环境下的
    [:default, env]
  end

  def self.application
    Application.instance
  end

  def self.root
    application.root
  end
end
