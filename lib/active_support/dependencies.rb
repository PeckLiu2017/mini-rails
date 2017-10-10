module ActiveSupport
  module Dependencies
    extend self

    attr_accessor :autoload_paths
    self.autoload_paths = []

    def search_for_file(name)
      autoload_paths.each do |path|
        # File.join("usr", "mail", "gumby")   #=> "usr/mail/gumby"
        file = File.join(path, "#{name}.rb")
        # 如果命名文件存在并且是常规文件，则返回true
        if File.file? file
          return file
        end
      end
      nil
    end
  end
end
