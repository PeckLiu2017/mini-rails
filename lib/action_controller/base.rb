module ActionController
  class Base < Metal
    include Callbacks
    # include 会得到模块或类中的一些方法
    include RequestForgeryProtection
  end
end
