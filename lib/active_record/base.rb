module ActiveRecord
  class Base
    def initialize(attributes = {})
      @attributes = attributes
    end

    # def id
    #   @attributes[:id]
    # end
    #
    # def title
    #   @attributes[:title]
    # end
    # 将之重构为 method_missing 方法
    def method_missing(name, *args)
      columns = self.class.connection.columns(self.class.table_name)

      if columns.include?(name)
        @attributes[name]
      else
        super
      end
    end

    def self.table_name
      name.downcase + "s"
    end

    def self.abstract_class=(value)
      # Not implemented
    end

    def self.find(id)
      # connection.execute("SELECT * FROM posts WHERE id = #{id.to_i}").first
      # 加上 first 返回形式从数组变成散列
      find_by_sql("SELECT * FROM #{table_name} WHERE id = #{id.to_i}").first
    end

    def self.all
      Relation.new(self)
    end

    def self.where(*args)
      all.where(*args)
    end

    def self.first
      all.first
    end

    def self.order(*args)
      all.order(*args)
    end

    def self.find_by_sql(sql)
      connection.execute(sql).map do |attributes|
        new(attributes)
      end
    end

    def self.establish_connection(options)
      # @@类变量
      @@connection = ConnectionAdapter::SqliteAdapter.new(options[:database])
    end

    def self.connection
      @@connection
    end
  end
end
