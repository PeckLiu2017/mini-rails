class String
  # 关于 gsub 方法
  # 如果替换为字符串，则将替换匹配的文本。
  # b = "date"
  # b.gsub('d', '*')
  # => "*ate"
  # 如果正则表达式元字符以String形式给出
  # 那他们将被按照字面意思解释，例如'\\ d'将匹配后面跟着的'd'而不是一个数字。
  # c = "\\date"
  # c.gsub('\d', '*')
  # => "*ate"
  # 它可能包含对模式的形式\\ d的捕获组的反向引用，其中d是组号，或\\ k <n>，其中n是组名称。
  # 如果它是一个双引号字符串，则两个引号前面都必须带有一个额外的反斜杠
  # a = "hello"
  # a.gsub(/e/, "\"\"")
  # => 'h""llo'
  # 特殊匹配变量（如$＆）不能替换
  # d = "h$&ello"
  # d.gsub(/($&)/, '<\1>')
  # => "h$&ello"
  # 如果第二个参数是哈希，匹配的文本是其中的一个键，键所对应的值就是替换字符串
  # 'hello'.gsub(/[eo]/, 'e' => 3, 'o' => '*')
  # => "h3ll*"
  # 当不提供块和第二个参数时，都会返回枚举器
  # "hello".gsub(/[aeiou]/)
  # => #<Enumerator: "hello":gsub(/[aeiou]/)>
  # 在块形式中，当前匹配字符串作为参数传入，并且将设置诸如$1，$2，$`，$＆和$'的变量。块返回的值将替代符合匹配条件的部分
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
  # 正则表达式的一些补充知识
  # $〜相当于:: last_match
  # $＆包含完整的匹配文本
  # $`包含匹配前的字符串
  # $'包含匹配后的字符串
  # $ 1，$ 2等等包含文本匹配组中的第一，第二个等元素
  # m = /s(\w{2}).*(c)/.match('haystack')
  # => #<MatchData "stac" 1:"ta" 2:"c">
  # $1 #=> "ta"
  # $ +包含最后一个匹配组
  # 不知道它的意图
  # 就不用在这上面浪费太多时间
  def classify
    to_s.gsub(/\/(.?)/) { "::#{Regexp.last_match(1).upcase}" }.gsub(/(?:^|_)(.)/) { Regexp.last_match(1).upcase }
  end

  # 将上面 classify 的结果转化为常量
  def constantize
    names = split('::')
    # p names
    # => ["PostsController"]
    names.shift if names.empty? || names.first.empty?

    constant = Object
    names.each do |name|
      # p constant.const_missing(name)
      # => PostsController
      constant = constant.const_get(name, false) || constant.const_missing(name)
    end
    constant
  end
end
