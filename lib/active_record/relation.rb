module ActiveRecord
  class Relation
    def initialize(klass)
      @klass = klass
      @where_values = []
    end

    def where!(condition)
      @where_values += [condition]
      # self = #<ActiveRecord::Relation:0x007fdab624f610 @klass=Post, @where_values=["id = 2"]>
      self
    end

    def where(condition)
      # 对象 clone 会改变原来的对象
      # 数组 clone 不会改变原来的数组
      # 这里不知为什么这样写
      clone.where!(condition)
    end

    def to_sql
      # @klass 写在初始化方法中，是可以被其它方法访问到的
        sql = "SELECT * FROM #{@klass.table_name}"
        # any 判断数组是否为空
        if @where_values.any?
          sql += " WHERE " + @where_values.join(" AND ")
        end
        sql
      end
    def records
      # 不仅是防止空指针，也是防止重复
      @records ||= @klass.find_by_sql(to_sql)
    end

    def first
      # 直接调用方法而不是使用@records变量就可以穿越作用域了
      records.first
    end

    # 不懂这个 each 方法是做什么的
    def each(&block)
      records.each(&block)
    end
  end
end
