class String
  def underscore
    # 关于正则表达式
    # () 里面的正则表达式的内容要全部匹配
    # + ……重复 1 次以上
    # tr 方法把字符串中的某部分转换成另一部分
    self.to_s.gsub(/::/,'/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-","_").
      downcase
  end
end
