require_relative 'spec_helper'

RSpec.describe "ActionControllerTest" do
  class TestController < ActionController::Base
    before_action :callback, only: [:show]
    after_action :callback_after, only: [:show]
    def index
      response << "index"
    end

    def show
      response << "show"
    end

    private
      def callback
        response << "callback"
      end

      def callback_after
        response << "callback_after"
      end
  end

  it "test_calls_index" do
    controller = TestController.new
    controller.response = []
    controller.process :index
    expect(controller.response).to eq(["index"])
  end

  it "test_callbacks" do
    controller = TestController.new
    controller.response = []
    controller.process :show
    expect(controller.response).to eq(["callback", "show", "callback_after"])
  end

  class Request
    def params
      { 'id' => 1 }
    end
  end

  it "test_real_controller" do
    controller = PostsController.new
    controller.request = Request.new
    controller.process :show
  end
end