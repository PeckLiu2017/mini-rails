module Rails
  class Application
    # 一旦 self 被 klass 继承
    # 就会新建一个 klass 的实例
    def self.inherited(klass)
      super
      @instance = klass.new
    end

    def self.instance
      @instance
    end

    def routes
      @routes ||= ActionDispatch::Routing::RouteSet.new
    end

    def initialize!
      # 返回从家目录开始的到 app 目录下所有子文件夹的绝对路径
      # 比如 /Users/peckliu/Ruby_project/mini-rails/spec/muffin_blog/app/assets
      # /Users/peckliu/Ruby_project/mini-rails/spec/muffin_blog/app/channels 等
      config_environment_path = caller.first
      # p config_environment_path
      # => /Users/peckliu/Ruby_project/mini-rails/spec/muffin_blog/config/environment.rb
      # File.expand_path("../..", config_environment_path)
      # 以 config_environment_path 为起点,向上两个目录层级
      # File.expand_path 返回的是字符串
      # 所以用 Pathname.new 把它转化成路径
      @root = Pathname.new(File.expand_path("../..", config_environment_path))
      # p @root #=> /Users/peckliu/Ruby_project/mini-rails/spec/muffin_blog
      ActiveSupport::Dependencies.autoload_paths = Dir["#{@root}/app/*"]
      ActiveRecord::Base.establish_connection(
        database: "#{@root}/db/#{Rails.env}.sqlite3"
      )
      load @root.join("config/routes.rb")
    end

    def root
      @root
    end
  end
end
