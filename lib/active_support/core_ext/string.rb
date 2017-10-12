class String
  # 关于 gsub 方法
  # 如果第二个参数是哈希，匹配的文本是其中的一个键，相应的值就是替换字符串
  # 'hello'.gsub(/[eo]/, 'e' => 3, 'o' => '*')
  # 当不提供块和第二个参数时，都会返回枚举器
  # "hello".gsub(/[aeiou]/)
  # => #<Enumerator: "hello":gsub(/[aeiou]/)>
  # 在块形式中，当前匹配字符串作为参数传入，并且将适当地设置诸如$ 1，$ 2，$`，$＆和$'的变量。块返回的值将替代每次调用的匹配
  # "hello".gsub(/./) {|s| s.ord.to_s + ' '}      #=> "104 101 108 108 111 "
  # "hello".gsub(/l/) {|s| s.ord.to_s + ' '}      #=> "he108 108 o" 

  def underscore
    # 关于正则表达式
    # () 里面的正则表达式的内容要全部匹配
    # + ……重复 1 次以上
    # tr 方法把字符串中的某部分转换成另一部分
    to_s.gsub(/::/, '/')
        .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
        .gsub(/([a-z\d])([A-Z])/, '\1_\2')
        .tr('-', '_')
        .downcase
  end

  def pluralize
    self + 's'
  end

  def singularize
    chomp 's'
  end

  # 将 controller 转化为 string
  def classify
    to_s.gsub(/\/(.?)/) { "::#{Regexp.last_match(1).upcase}" }.gsub(/(?:^|_)(.)/) { Regexp.last_match(1).upcase }
  end

  # 将上面 classify 的结果转化为常量
  def constantize
    names = split('::')
    names.shift if names.empty? || names.first.empty?

    constant = Object
    names.each do |name|
      constant = constant.const_get(name, false) || constant.const_missing(name)
    end
    constant
  end
end
