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
end
