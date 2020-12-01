def register_renderers
  ActiveSupport.on_load(:action_controller) do
    ::ActionController::Renderers.add(:jsonapi) do |resources, opts|
      serializer = opts.delete(:serializer)
      options = clear_options(opts)
      serializer.new(resources, options)
    end
  end
end

def clear_options(opts)
  if opts[:params]&.is_a?(ApplicationController::Parameters)
    opts.except(:status, :params, :content_type)
  else
    opts.except(:status, :content_type)
  end
end
