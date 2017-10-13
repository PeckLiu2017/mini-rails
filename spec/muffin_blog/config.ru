# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application
# class MiniSinatra
#   class Route < Struct.new(:method, :path, :block)
#     def match?(env)
#       env['REQUEST_METHOD'] == method && env['PATH_INFO'] == path
#     end
#   end
#
#   def initialize
#     @routes = []
#   end
#
#   def add_route(_method, _path)
#     @routes << Route.new(:method, :path, :block)
#   end
#
#   def call(env)
#     # 通过枚举中的每个条目阻止。 返回块不为false的第一个。 如果没有对象匹配，则调用ifnone并在指定时返回其结果，否则返回nil
#     # 如果没有给定块，则返回枚举器
#     # (1..10).detect(ifnone = nil)
#     # => #<Enumerator: 1..10:detect(nil)>
#     if route = @routes.detect { |route| route.match?(env) }
#       body = route.block.call
#       [
#         200,
#         { 'Content-Type' => 'text/plain' },
#         [body]
#       ]
#     else
#       [
#         404,
#         { 'Content-Type' => 'text/plain' },
#         ['Not found']
#       ]
#     end
#   end
#
#   def self.application
#     @application ||= MiniSinatra.new
#   end
# end
#
# def get(path, &block)
#   MiniSinatra.application.add_route "GET", path, &block
# end
#
# get "/hello" do
#   "hello"
# end
# get "/goodbye" do
#   "goodbye"
# end
#
# run MiniSinatra.application


# 加日志
# class Logger
#   def initialize(app)
#     @app = app
#   end
#
#   def call(env)
#     method = env['REQUEST_METHOD']
#     path = env['PATH_INFO']
#     puts "#{method} #{path}"
#     @app.call(env)
#   end
# end
#
# use Logger
# run App.new

# 另一种启动方法
# app = lambda do |env|
#   raise 'hell'
#   [
#     200,
#     { 'Content-Type' => 'text/plain' },
#     ['hello from lambda!']
#   ]
# end

# 启动前显示错误信息
# use Rack::ShowExceptions
# use Rack::CommonLogger

# run app
