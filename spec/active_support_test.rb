require_relative 'spec_helper'
# autoload 仅作用于应用中
# mini-rails 的 active_record 文件还是要 require 加载
require 'active_record'
require 'active_support'

RSpec.describe "ActiveSupportTest" do
  it "setup" do
    # 返回从家目录开始的到 app 目录下所有子文件夹的绝对路径
    # 比如 /Users/peckliu/Ruby_project/mini-rails/spec/muffin_blog/app/assets
    # /Users/peckliu/Ruby_project/mini-rails/spec/muffin_blog/app/channels 等
    ActiveSupport::Dependencies.autoload_paths = Dir["#{__dir__}/muffin_blog/app/*"]
  end

  it "test_search_for_file" do
    file = ActiveSupport::Dependencies.search_for_file("application_controller")
    expect(file).to eq("#{__dir__}/muffin_blog/app/controllers/application_controller.rb")
    file = ActiveSupport::Dependencies.search_for_file("unknown")
    expect(file).to eq(nil)
  end

  it "test_case_name" do
    expect(:Post.to_s.underscore).to eq("post")
    expect(:ApplicationController.to_s.underscore).to eq("application_controller")
  end

  it "test_load_missing_constants" do
    Post
  end
end
