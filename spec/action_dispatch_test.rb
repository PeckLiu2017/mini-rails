require_relative 'spec_helper'

RSpec.describe 'ActionDispatchTest' do
  # 测试能不能解析自己增加的路径
  it 'test_add_route' do
    routes = ActionDispatch::Routing::RouteSet.new
    route = routes.add_route 'GET', '/posts', 'posts', 'index'
    expect(route.controller).to eq('posts')
    expect(route.action).to eq('index')
  end
  # 测试通过 Rack::Request 增加的路径
  it 'test_find_route' do
    routes = ActionDispatch::Routing::RouteSet.new
    route = routes.add_route 'GET', '/posts', 'posts', 'index'
    route = routes.add_route 'POST', '/posts', 'posts', 'create'
    request = Rack::Request.new(
      'REQUEST_METHOD' => 'POST',
      'PATH_INFO' => '/posts'
    )
    # p request
    # #<Rack::Request:0x007fc64c18a370 @params=nil, @env={"REQUEST_METHOD"=>"POST", "PATH_INFO"=>"/posts"}>
    route = routes.find_route(request)
    expect(route.controller).to eq('posts')
    expect(route.action).to eq('create')
  end

  it 'test_draw' do
    routes = ActionDispatch::Routing::RouteSet.new
    routes.draw do
      get '/hello', to: 'hello#index'
      root to: 'posts#index'
      resources :posts
    end

    request = Rack::Request.new(
      'REQUEST_METHOD' => 'GET',
      'PATH_INFO' => '/posts/new'
    )
    # p request
    # #<Rack::Request:0x007fe397040d58 @params=nil, @env={"REQUEST_METHOD"=>"GET", "PATH_INFO"=>"/posts/new"}>
    # 从 routes 中根据 request 解析出符合条件的路径
    route = routes.find_route(request)
    # p route
    # #<struct ActionDispatch::Routing::Route method="GET",
    # path="/posts/new", controller="posts", action="new", name="new_post">
    expect(route.controller).to eq('posts')
    expect(route.action).to eq('new')
    expect(route.name).to eq('new_post') # new_post_path helper
  end

  # it 'test_call' do
  #   routes = ActionDispatch::Routing::RouteSet.new
  #   routes.draw do
  #     root to: 'posts#index'
  #     resources :posts
  #   end
  #
  #   env1 = {
  #     'REQUEST_METHOD' => 'GET',
  #     'PATH_INFO' => '/posts/new'
  #   }
  #
  #   env2 = {
  #     'REQUEST_METHOD' => 'GET',
  #     'PATH_INFO' => '/posts/show?id=1'
  #   }
  #
  #   status1, headers1, body1 = routes.call(env1)
  #   status2, headers2, body2 = routes.call(env2)
  #
  #   expect(status1).to eq(200)
  #   expect(status2).to eq(404)
  # end

  it 'test_call' do
    routes = Rails.application.routes
    # p routes
    # #<ActionDispatch::Routing::RouteSet:0x007ff282a52a90 @routes=[]>
    request = Rack::MockRequest.new(routes)
    # p request
    #<Rack::MockRequest:0x007fe9b62e9c38 @app=#<ActionDispatch::Routing::RouteSet:0x007fe9b62eb3f8
    # @routes=[#<struct ActionDispatch::Routing::Route method="GET", path="/", controller="posts", action="index", name="root">,
    # #<struct ActionDispatch::Routing::Route method="GET", path="/posts", controller="posts", action="index", name="posts">,
    # #<struct ActionDispatch::Routing::Route method="GET", path="/posts/new", controller="posts", action="new", name="new_post">,
    # #<struct ActionDispatch::Routing::Route method="GET", path="/posts/show", controller="posts", action="show", name="post">]>>
    expect(request.get("/").status).to eq(200)
    expect(request.get("/posts").status).to eq(200)
    expect(request.get("/posts/new").status).to eq(200)
    # expect(request.get("/posts/show?id=1").status).to eq(200)
    expect(request.post("/").status).to eq(404)
  end
end
