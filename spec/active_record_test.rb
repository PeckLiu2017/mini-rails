require_relative 'spec_helper'
require 'active_record'
require_relative 'muffin_blog/app/models/application_record'
require_relative 'muffin_blog/app/models/post'
# class Module
#   # 方法缺失用 method_missing
#   # 或者 define_method
#   # 常量缺失用 const_missing
#   # 将在 active_support 中重构常量加载
#   def const_missing(name)
#     puts "try to load #{name}"
#   end
# end

RSpec.describe "ActiveRecordTest" do
  it "setup" do
    Post.establish_connection(
      database: "#{__dir__}/muffin_blog/db/development.sqlite3"
    )
  end

  it "test_initialize" do
    post = Post.new(:id => 1, :title => "test")
    expect(post.id).to eq(1)
    expect(post.title).to eq("test")
  end

  it "test_find" do
    post = Post.find(1)
    expect(post).to be_a(Post)
  end

  it "test_all" do
    post = Post.all.first
    expect(post).to be_a(Post)
    expect(post.id).to eq(1)
    expect(post.title).to eq("find work")
  end

  it "test_execute_sql" do
    rows = Post.connection.execute("SELECT * FROM posts")
    expect(rows).to be_a(Array)
    row = rows.first
    expect(row).to be_a(Hash)
    expect(row.keys).to eq([:id,:title,:body,:created_at,:updated_at])
  end

  it "test_where" do
    relation = Post.where("id = 2").where("title IS NOT NULL")
    expect(relation.to_sql).to eq("SELECT * FROM posts WHERE id = 2 AND title IS NOT NULL")
    post = relation.first
    expect(post.id).to eq(2)
  end
end
