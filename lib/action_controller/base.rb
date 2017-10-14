module ActionController
  class Base < Metal
    include Callbacks
    # include 会得到模块或类中的一些方法
    include RequestForgeryProtection
    include Redirecting
    include ActionView::Rendering
    include ImplicitRender
  end
end

# 为什么 class Base < Metal ？
# 因为这样会先执行 Base 中的 process
# class Parent
#   def say
#     puts "In Parent"
#   end
# end
#
# module A
#   def self.included(base)
#     base.extend self
#   end
#
#   def say
#     puts "In A"
#     super
#   end
# end
#
# module B
#   def say
#     puts "In B"
#     super
#   end
# end
#
# class Child < Parent
#   include A
#   include B
# end

# puts Child.ancestors
# Child
# B
# A
# Parent
# Object
# Kernel
# BasicObject

# puts Child.new.say #=>
# In B
# In A
# In Parent
# 先触发B中的 say
# 然后B的 super 触发A中的 say
# 最后A的 super 触发Parent中的 say
