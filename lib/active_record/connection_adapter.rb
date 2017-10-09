module ActiveRecord
  module ConnectionAdapter
    class SqliteAdapter
      def initialize(file)
        require "sqlite3"
        @db = SQLite3::Database.new(file.to_s, results_as_hash: true)
        # p @db
        # #<SQLite3::Database:0x007fa1c7b6afb0 @tracefunc=nil,
        # @authorizer=nil, @encoding=nil, @busy_handler=nil,
        # @collations={}, @functions={}, @results_as_hash=true,
        # @type_translation=nil, @readonly=false>
      end

      # Execute an SQL query and return the results as an array of hashes.
      # Eg.:
      #
      #   > adapter.execute "SELECT * FROM users"
      #   => [
      #     { id: 1, name: "Marc" },
      #     { id: 2, name: "Bob" }
      #   ]
      #
      def execute(sql)
        @db.execute(sql).each do |row|
          # row 是一个散列
          # 比如：
          # {"id"=>1, "title"=>"find work",
          # "body"=>nil, "created_at"=>"2017-10-09 13:38:27.225123",
          # "updated_at"=>"2017-10-09 13:38:27.225123", 0=>1, 1=>"find work",
          # 2=>nil, 3=>"2017-10-09 13:38:27.225123", 4=>"2017-10-09 13:38:27.225123"}
          row.keys.each do |key|
            value = row.delete(key)
            # Only keep string keys (ignores index-based key, 0, 1, ...)
            if key.is_a? String
              row[key.to_sym] = value
            end
          end
        end
      end

      # Return the column names of a table.
      def columns(table_name)
        @db.table_info(table_name).map { |info| info["name"].to_sym }
      end
    end

    # We could implement another adapter to support other DB engines.
    #
    # class MysqlAdapter
    #   def execute(sql)
    #     # Here we'd implement executing the query in MySQL.
    #   end
    # end
  end
end
