require_relative 'spec_helper'
require 'active_record'
require_relative 'muffin_blog/app/models/application_record'
require_relative 'muffin_blog/app/models/post'

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
    p post
    expect(post).to be_a(Post)
  end

  it "test_execute_sql" do
    rows = Post.connection.execute("SELECT * FROM posts")
    expect(rows).to be_a(Array)
    row = rows.first
    expect(row).to be_a(Hash)
    expect(row.keys).to eq([:id,:title,:body,:created_at,:updated_at])
  end
end
