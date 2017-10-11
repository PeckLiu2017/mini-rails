module ActionController
  class Base < Metal
    include Callbacks
    # include 会得到模块或类中的一些方法
    include RequestForgeryProtection
  end
end

# 为什么 class Base < Metal ？
# 过程在中间
# 结果在最后
# class Parent
#   def say
#     puts "In Parent"
#   end
# end
#
# module A
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

# 如果 class 与 module 的关系是这种情况：
# class Parent
#   include A
#   include B
# end
#
# puts Parent.ancestors #=>
# Parent
# B
# A
# Object
# Kernel
# BasicObject
#
# 如果 class 与 module 的关系是这种情况：
# class Parent
#   include A, B
# end
#
# puts Parent.ancestors #=>
# Parent
# A
# B
# Object
# Kernel
# BasicObject
#
# 如果 class 与 module 的关系是这种情况：
# class Parent
#   prepend A, B
# end
#
# puts Parent.ancestors #=>
# A
# B
# Parent
# Object
# Kernel
# BasicObject
#
# 如果 class 与 module 的关系是这种情况：
# class Parent
#   prepend A
#   prepend B
# end
#
# puts Parent.ancestors #=>
# B
# A
# Parent
# Object
# Kernel
# BasicObject
#
# 如果 class 与 module 的关系是这种情况：
# class Child < Parent
#   include A
#   include B
# end
#
# puts Child.new.say #=>
# In B
# In A
# In Parent
# 如果 class 与 module 的关系是这种情况：
# class Base < Metal
#   include A
#   include B
# end
#
# puts Base.new.say #=>
# In B
# In A
# In Parent
