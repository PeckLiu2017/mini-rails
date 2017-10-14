module ActionView
  module Rendering
    def render(action)
      # 将实例变量加入上下文
      context = Base.new(view_assigns)
      # p context
      # #<ActionView::Base:0x007fc949a2f8b8 @request=#<Rack::Request:0x007fc949a44f38 @params={"id"=>"1"}, @env={"rack.version"=>[1, 3], "rack.input"=>#<StringIO:0x007fc949bc01a0>, "rack.errors"=>#<StringIO:0x007fc949bc0290>, "rack.multithread"=>true, "rack.multiprocess"=>true, "rack.run_once"=>false, "REQUEST_METHOD"=>"GET", "SERVER_NAME"=>"example.org", "SERVER_PORT"=>"80", "QUERY_STRING"=>"id=1", "PATH_INFO"=>"/posts/show", "rack.url_scheme"=>"http", "HTTPS"=>"off", "SCRIPT_NAME"=>"", "CONTENT_LENGTH"=>"0", "rack.request.query_string"=>"id=1", "rack.request.query_hash"=>{"id"=>"1"}}>, @response=#<Rack::Response:0x007fc949a37db0 @status=200, @header={}, @writer=#<Proc:0x007fc949a37ba8@/Users/peckliu/.rvm/gems/ruby-2.3.3@global/gems/rack-2.0.3/lib/rack/response.rb:32 (lambda)>, @block=nil, @length=0, @body=[]>, @post=#<Post:0x007fc949a2fa48 @attributes={:id=>1, :title=>"title1", :body=>"body1", :created_at=>"2017-10-13 06:58:43.974730", :updated_at=>"2017-10-13 06:58:43.974730"}>>
      path = template_path(action)
      # p path
      # =>"/Users/peckliu/Ruby_project/mini-rails/spec/muffin_blog/app/views/posts/show.html.erb"
      # p Template.find(path)
      # #<ActionView::Template:0x007fe22d496418
      # @source="<h1><%= @post.title %></h1>\n\n<p><%= @post.body %></p>\n\n<p><%= link_to 'Back', posts_path %></p>\n",
      # @name="/Users/peckliu/Ruby_project/mini-rails/spec/muffin_blog/app/views/posts/show.html.erb", @compile=false>
      # 在当前 Template 的上下文中
      # render 加入 Base 中设置的实例变量
      # 然后执行特定 action
      # 有了 @source 和 @name 变量
      # 就根据 @name 生成方法并生成显示代码
      content = Template.find(path).render(context)
      response.body = [content]
    end

    def view_assigns
      assigns = {}
      instance_variables.each do |name|
        # "@var"[1..-1] #=> "var"
        assigns[name[1..-1]] = instance_variable_get(name)
      end
      assigns
    end

    def template_path(action)
      "#{Rails.root}/app/views/#{controller_name}/#{action}.html.erb"
    end

    def controller_name
      self.class.name.chomp("Controller").underscore
    end
  end
end
