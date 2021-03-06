module Coloration

  class Style
    attr_accessor :foreground, :background, :bold, :italic, :underline, :strike, :inverse, :comment

    def initialize(obj=nil, bg=nil)
      if obj
        case obj
        when String
          initialize_from_hash({ :foreground => obj }, bg)
        when Hash
          initialize_from_hash(obj, bg)
        end
      end
    end

    def initialize_from_hash(h, bg=nil)
      h.each do |key, value|
        if key == :fg
          key = :foreground
        end
        if key == :bg
          key = :background
        end
        if ["foreground", "background"].include?(key.to_s) && value.is_a?(String)
          value = Color::RGBA.from_html(value, bg)
        end
        send("#{key}=", value)
      end
    end

    def blank?
      foreground.nil? && background.nil?
    end
  end

end
