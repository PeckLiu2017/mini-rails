require_relative 'spec_helper'

RSpec.describe "ActionControllerTest" do
  class TestController < ActionController::Base
    before_action :callback, only: [:show]

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
    expect(controller.response).to eq(["callback", "show"])
  end
end
