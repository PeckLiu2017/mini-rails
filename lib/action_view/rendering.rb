module ActionView
  module Rendering
    def render(action)
      context = Base.new(view_assigns)
    end

    def view_assigns
      assigns = {}
      instance_variables.each do |name|
        # "@var"[1..-1] #=> "var" 
        assigns[name[1..-1]] = instance_variable_get(name)
      end
      assigns
    end
  end
end
