require 'spec_helper'

module Liquid
  module Rails
    describe ContentForTag, type: :tag do
      it 'content_for and yield with non-quoted key' do
        Liquid::Template.parse(%|{% content_for not_authorized0 %}alert('You are not authorized to do that!');{% endcontent_for %}|).render(context)

        expect_template_result(%|{% yield not_authorized0 %}|, "alert('You are not authorized to do that!');")
      end

      it 'content_for and yield with quoted key' do
        Liquid::Template.parse(%|{% content_for 'not_authorized1' %}alert('You are not authorized to do that!');{% endcontent_for %}|).render(context)

        expect_template_result(%|{% yield 'not_authorized1' %}|, "alert('You are not authorized to do that!');")
      end

      it 'invokes content_for with the same identifier multiple times' do
        Liquid::Template.parse(%|{% content_for 'not_authorized2' %}alert('You are not authorized to do that 1!');{% endcontent_for %}|).render(context)
        Liquid::Template.parse(%|{% content_for 'not_authorized2' %}alert('You are not authorized to do that 2!');{% endcontent_for %}|).render(context)

        expect_template_result(%|{% yield 'not_authorized2' %}|, "alert('You are not authorized to do that 1!');alert('You are not authorized to do that 2!');")
      end

      it 'invokes content_for with the same identifier multiple times and flush' do
        Liquid::Template.parse(%|{% content_for 'not_authorized3' %}alert('You are not authorized to do that 1!');{% endcontent_for %}|).render(context)
        Liquid::Template.parse(%|{% content_for 'not_authorized3' flush true %}alert('You are not authorized to do that 2!');{% endcontent_for %}|).render(context)

        expect_template_result(%|{% yield 'not_authorized3' %}|, "alert('You are not authorized to do that 2!');")
      end
    end
  end
end