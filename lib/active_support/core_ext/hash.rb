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
      # delete 会返回被删除的值
      # self = {"id"=>1} 的情况下
      # 下面的程序输出
      # self[id] = 1
      # 同时散列中的 :id => 1 键值对被删除
      self[(begin
              key.to_sym
            rescue
              key
            end) || key] = delete(key)
    end
    self
  end
end
