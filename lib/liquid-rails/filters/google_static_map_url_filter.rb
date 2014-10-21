module Liquid
  module Rails
    module GoogleStaticMapUrlFilter

      # size:     '600x300'
      #
      # Available keys inside options
      # center:   '40.714728,-73.998672'
      # zoom:     13
      # maptype:  'roadmap', 'satellite', 'terrain', or 'hybrid'
      # markers:  an array of this 'color:blue|label:S|40.702147,-74.015794'
      #           or string with semicolon
      def google_static_map_url(size, options={})
        markers = options.delete('markers')
        markers = if markers
          markers = markers.split(';') if markers.is_a?(String)
          markers.map { |marker| { markers: marker }.to_query }
        else
          ''
        end
        options = options.merge('size' => size)
        querystring = [options.to_query, markers].delete_if { |value| value.blank? }.join('&')

        "https://maps.googleapis.com/maps/api/staticmap?#{querystring}"
      end
    end
  end
end

Liquid::Template.register_filter(Liquid::Rails::GoogleStaticMapUrlFilter)