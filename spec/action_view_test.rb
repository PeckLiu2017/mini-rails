require_relative 'spec_helper'

RSpec.describe 'ActionViewTest' do
  # it "test_render_template" do
  #   # 新建 template，传入 html 代码和 name, 即后来的method_name
  #   template = ActionView::Template.new("<p>Hello</p>", "test_render_template")
  #   # 新建 context
  #   context = ActionView::Base.new
  #   # 测试
  #   expect(template.render(context)).to eq('<p>Hello</p>')
  # end
  #
  # it "test_render_with_vars" do
  #   # 新建 template，传入 html 代码和 name, 即后来的method_name
  #   template = ActionView::Template.new("<p><%= @var %></p>", "test_render_with_vars")
  #   # 新建 context,同时传入 Base initialize 用的 hash
  #   context = ActionView::Base.new var: "var value"
  #   expect(template.render(context)).to eq("<p>var value</p>")
  # end
  #
  # it "test_render_with_yield" do
  #   template = ActionView::Template.new("<p><%= yield %></p>", "test_render_with_yield")
  #   context = ActionView::Base.new
  #   # p context
  #   # #<ActionView::Base:0x007fe2128084b8>
  #   # template.render(context) { "yielded content" } 对应 render(context, &block) 传入上下文和块
  #   expect(template.render(context) { "yielded content" }).to eq("<p>yielded content</p>")
  # end
  #
  # it "test_render_with_helper" do
  #   template = ActionView::Template.new("<%= link_to 'title', '/url' %>", "test_render_with_helper")
  #
  #   context = ActionView::Base.new
  #   expect(template.render(context)).to eq("<a href=\"/url\">title</a>")
  # end
  #
  # # 不想重新建一个实例,重载,重新定义,编译
  # # 所以缓存
  # # 最后测试两个实例是否相等
  # it "test_find_template" do
  #   file = "#{__dir__}/muffin_blog/app/views/posts/index.html.erb"
  #   template1 = ActionView::Template.find(file)
  #   template2 = ActionView::Template.find(file)
  #   # p template1
  #   # #<ActionView::Template:0x007fe62554e080 @source="<h1>The Muffin Blog</h1>
  #   # \n\n<% @posts.each do |post| %>\n  <div class=\"post\">\n
  #   # <h2><%= link_to post.title, post_path(id: post.id) %></h2>\n
  #   # <p><%= post.body %></p>\n  </div>\n<% end %>\n\n<p>\n
  #   # <%= link_to 'New Post', new_post_path %>\n</p>\n",
  #   #@name="/Users/peckliu/Ruby_project/mini-rails/spec/muffin_blog/app/views/posts/index.html.erb", @compile=false>
  #   expect(template1).to eq(template2)
  # end
  #
  # class TestController < ActionController::Base
  #   def index
  #     @var = "var value"
  #   end
  # end
  #
  # it "test_view_assigns" do
  #   controller = TestController.new
  #   controller.index
  #   expect(controller.view_assigns).to eq({'var' => 'var value'})
  # end
  #
  # it "test_render" do
  #   request = Rack::MockRequest.new(Rails.application)
  #   # p request
  #   # #<Rack::MockRequest:0x007f84aeb676e8 @app=#<MuffinBlog::Application:0x007f84af1f4060 @root=#<Pathname:/Users/peckliu/Ruby_project/mini-rails/spec/muffin_blog>, @routes=#<ActionDispatch::Routing::RouteSet:0x007f84b0849270 @routes=[#<struct ActionDispatch::Routing::Route method="GET", path="/", controller="posts", action="index", name="root">, #<struct ActionDispatch::Routing::Route method="GET", path="/posts", controller="posts", action="index", name="posts">, #<struct ActionDispatch::Routing::Route method="GET", path="/posts/new", controller="posts", action="new", name="new_post">, #<struct ActionDispatch::Routing::Route method="GET", path="/posts/show", controller="posts", action="show", name="post">]
  #   # p "================="
  #   # MockRequest 调用 get 方法
  #   # 也会自动调用 mini-rails 的 call 方法
  #   response = request.get('/posts/show?id=1')
  #   # p response
  #   #<ActionView::Base:0x007fe95d293670 @request=#<Rack::Request:0x007fe95d2d0340 @params={"id"=>"1"}, @env={"rack.version"=>[1, 3], "rack.input"=>#<StringIO:0x007fe95d887d60>, "rack.errors"=>#<StringIO:0x007fe95d887dd8>, "rack.multithread"=>true, "rack.multiprocess"=>true, "rack.run_once"=>false, "REQUEST_METHOD"=>"GET", "SERVER_NAME"=>"example.org", "SERVER_PORT"=>"80", "QUERY_STRING"=>"id=1", "PATH_INFO"=>"/posts/show", "rack.url_scheme"=>"http", "HTTPS"=>"off", "SCRIPT_NAME"=>"", "CONTENT_LENGTH"=>"0", "rack.request.query_string"=>"id=1", "rack.request.query_hash"=>{"id"=>"1"}}>, @response=#<Rack::Response:0x007fe95d2a9380 @status=200, @header={}, @writer=#<Proc:0x007fe95d2a9218@/Users/peckliu/.rvm/gems/ruby-2.3.3@global/gems/rack-2.0.3/lib/rack/response.rb:32 (lambda)>, @block=nil, @length=0, @body=[]>, @post=#<Post:0x007fe95d2a12e8 @attributes={:id=>1, :title=>"title1", :body=>"body1", :created_at=>"2017-10-13 06:58:43.974730", :updated_at=>"2017-10-13 06:58:43.974730"}>>
  #   expect(response.body).to include("<h1>title1</h1>")
  #   expect(response.body).to include("<html>")
  # end

  it "test_render_index" do
    request = Rack::MockRequest.new(Rails.application)
    response = request.get("/posts")

    expect(response.body).to include("<h1>The Muffin Blog</h1>")
    expect(response.body).to include("<html>")
    # expect(response.body).to include("<a href="/posts/new">New Post</a>")
  end
end
