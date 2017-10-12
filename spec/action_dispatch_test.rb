require_relative 'spec_helper'

RSpec.describe 'ActionDispatchTest' do
  # 测试能不能解析自己增加的路径
  it 'test_add_route' do
    routes = ActionDispatch::Routing::RouteSet.new
    route = routes.add_route 'GET', '/posts', 'posts', 'index'
    expect(route.controller).to eq('posts')
    expect(route.action).to eq('index')
  end
  #
  it "test_find_route" do
    routes = ActionDispatch::Routing::RouteSet.new
    route = routes.add_route "GET", "/posts", "posts", "index"
    route = routes.add_route "POST", "/posts", "posts", "create"
    request = Rack::Request.new(
      "REQUEST_METHOD" => "POST",
      "PATH_INFO" => "/posts"
    )
    route = routes.find_route(request)
    expect(route.controller).to eq('posts')
    expect(route.action).to eq('create')
  end
end
