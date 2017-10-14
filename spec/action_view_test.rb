require_relative 'spec_helper'

RSpec.describe 'ActionViewTest' do
  it "test_render_template" do
    # 新建 template，传入 html 代码和 method_name
    template = ActionView::Template.new("<p>Hello</p>", "test_render_template")
    # 新建 context
    context = ActionView::Base.new
    # 测试
    expect(template.render(context)).to eq('<p>Hello</p>')
  end

  it "test_render_with_vars" do
    #     template = ActionView::Template.new("<p><%= @var %></p>", "test_render_with_vars")
    #
    #     context = ActionView::Base.new var: "var value"
    #     expect(template.render(context)).to eq("<p>var value</p>")
  end

  it "test_render_with_yield" do
    #     template = ActionView::Template.new("<p><%= yield %></p>",
    #       "test_render_with_yield")
    #
    #     context = ActionView::Base.new
    #     expect(template.render(context) { "yielded content" }).to eq("<p>yielded content</p>")
  end

  it "test_render_with_helper" do
    #     template = ActionView::Template.new("<%= link_to 'title', '/url' %>",
    #       "test_render_with_helper")
    #
    #     context = ActionView::Base.new
    #     expect(template.render(context)).to eq("<a href=\"/url\">title</a>")
  end
end
