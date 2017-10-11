module ActionController
  module Callbacks
    class Callback
      def initialize(method, options)
        @method = method
        @options = options
      end

      def match?(action)
        if @options[:only]
          @options[:only].include? action.to_sym
        else
          true
        end
      end

      def call(controller)
        controller.send @method
      end
    end
    # def self.before_action(_method); end
    # 换一种写法
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      # 在 include Callbacks 时
      # Base 自动 extend ClassMethods
      # before_action 自动调用 before_actions 方法
      def before_action(method, options={})
        before_actions << Callback.new(method, options)
      end

      def before_actions
        @before_action ||= []
      end

      def after_action(method, options={})
        after_actions << Callback.new(method, options)
      end

      def after_actions
        @after_action ||= []
      end
    end

    def process(action)
      # 这里的 process 覆盖了父类中的方法 process
      # p self.class.before_actions #=>
      # [#<ActionController::Callbacks::Callback:0x007f80f603e548 @method=:callback, @options={:only=>[:show]}>]
      self.class.before_actions.each do |callback|
        # p callback #=>
        # #<ActionController::Callbacks::Callback:0x007f80f603e548 @method=:callback, @options={:only=>[:show]}>
        if callback.match?(action)
          callback.call(self)
        end
      end

      # super 执行父类中的方法 process
      super

      self.class.after_actions.each do |callback|
        if callback.match?(action)
          callback.call(self)
        end
      end
    end
  end
end
