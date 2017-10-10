# 这里不能用 autoload
# 因为 string 常量已经在 string 类中 load 过了
# autoload 只能加载一次
# 生效一次
# 所以要 require
# 才能再加载一次 string
# 从而加载自己写的类库文件
# 也就是 active_support/core_ext/string.rb
require 'active_support/core_ext/string'

module ActiveSupport
  autoload :Dependencies, "active_support/dependencies"
end
