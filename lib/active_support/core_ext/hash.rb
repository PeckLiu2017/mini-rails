class Hash
  # 为什么要用 dup 呢?
  # 可能今后其它方法也要用到这个散列
  # 所以为了不改变原散列吧
  def symbolize_keys
    dup.symbolize_keys!
  end

  # 这个方法把散列的所有 key 变成符号
  def symbolize_keys!
    keys.each do |key|
      # nil.to_sym rescue nil
      # => nil
      # self = {"id"=>1} 的情况下
      # 下面的程序输出
      # self[id] = 1
      self[(begin
              key.to_sym
            rescue
              key
            end) || key] = delete(key)
    end
    self
  end
end
