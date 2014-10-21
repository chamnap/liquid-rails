require 'spec_helper'

module Liquid
  module Rails
    describe GoogleStaticMapUrlFilter, type: :filter do
      it 'returns url with center' do
        expect_template_result("{{ '600x300' | google_static_map_url: center: '40.714728,-73.998672' }}", 'https://maps.googleapis.com/maps/api/staticmap?center=40.714728%2C-73.998672&size=600x300')
      end

      it 'returns url with zoom' do
        expect_template_result("{{ '600x300' | google_static_map_url: zoom: 13 }}", 'https://maps.googleapis.com/maps/api/staticmap?size=600x300&zoom=13')
      end

      it 'returns url with maptype' do
        expect_template_result("{{ '600x300' | google_static_map_url: maptype: 'hybrid' }}", 'https://maps.googleapis.com/maps/api/staticmap?maptype=hybrid&size=600x300')
      end

      it 'returns url with markers' do
        expect_template_result("{{ '600x300' | google_static_map_url: markers: 'color:blue|label:S|40.702147,-74.015794;color:green|label:G|40.711614,-74.012318' }}", 'https://maps.googleapis.com/maps/api/staticmap?size=600x300&markers=color%3Ablue%7Clabel%3AS%7C40.702147%2C-74.015794&markers=color%3Agreen%7Clabel%3AG%7C40.711614%2C-74.012318')
      end
    end
  end
end