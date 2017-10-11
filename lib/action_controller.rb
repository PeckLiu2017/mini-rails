module ActionController
  autoload :Base, "action_controller/base"
  autoload :Callbacks, "action_controller/callbacks"
  autoload :Metal, "action_controller/metal"
  autoload :Redirecting, "action_controller/redirecting"
  # 没有 autoload 或 require 会提示常量未定义
  autoload :RequestForgeryProtection, "action_controller/request_forgery_protection"
end
