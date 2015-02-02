require 'spec_helper'

module Liquid
  module Rails
    describe PaginateTag, type: :tag do
      before(:all) do
        post           = ::Post.new(title: 'New Post', body: 'Body')
        comment1       = ::Comment.new(id: 1, body: 'COMMENT 1')
        comment2       = ::Comment.new(id: 2, body: 'COMMENT 2')
        comment3       = ::Comment.new(id: 3, body: 'COMMENT 3')
        comment4       = ::Comment.new(id: 4, body: 'COMMENT 4')
        comment5       = ::Comment.new(id: 5, body: 'COMMENT 5')
        post.comments  = [comment1, comment2, comment3, comment4, comment5]
        @post_drop     = ::PostDrop.new(post)
      end

      context 'first_page' do
        it 'returns the page size' do
          expect_template_result("{% paginate post.comments by 2 %}{{ paginate.collection | size }}{% endpaginate %}", '2', { 'post' => @post_drop })
        end

        it 'returns the comments inside the collection' do
          expect_template_result("{% paginate post.comments by 2 %}{{ paginate.collection[0].body }},{{ paginate.collection[1].body }}{% endpaginate %}", 'COMMENT 1,COMMENT 2', { 'post' => @post_drop })
        end

        it '#current_offset' do
          expect_template_result("{% paginate post.comments by 2 %}{{ paginate.current_offset }}{% endpaginate %}", '0', { 'post' => @post_drop })
        end

        it '#page_size' do
          expect_template_result("{% paginate post.comments by 2 %}{{ paginate.page_size }}{% endpaginate %}", '2', { 'post' => @post_drop })
        end

        it '#pages' do
          expect_template_result("{% paginate post.comments by 2 %}{{ paginate.pages }}{% endpaginate %}", '3', { 'post' => @post_drop })
        end

        it '#items' do
          expect_template_result("{% paginate post.comments by 2 %}{{ paginate.items }}{% endpaginate %}", '5', { 'post' => @post_drop })
        end

        it '#previous' do
          expect_template_result("{% paginate post.comments by 2 %}{{ paginate.previous }}{% endpaginate %}", '', { 'post' => @post_drop })
        end

        it '#next' do
          expect_template_result("{% paginate post.comments by 2 %}{{ paginate.next }}{% endpaginate %}", %|{"title"=>"Next &raquo;", "url"=>"/?page=2", "is_link"=>true}|, { 'post' => @post_drop })
        end

        it '#parts' do
          expect_template_result("{% paginate post.comments by 2 %}{{ paginate.parts }}{% endpaginate %}", %|{"title"=>1, "is_link"=>false, "hellip_break"=>false}{"title"=>2, "url"=>"/?page=2", "is_link"=>true}{"title"=>3, "url"=>"/?page=3", "is_link"=>true}|, { 'post' => @post_drop })
        end
      end

      context 'last_page' do
        before(:all) { controller.params[:page] = 3 }

        it 'returns the page size' do
          expect_template_result("{% paginate post.comments by 2 %}{{ paginate.collection | size }}{% endpaginate %}", '1', { 'post' => @post_drop })
        end

        it 'returns the comments inside the collection' do
          expect_template_result("{% paginate post.comments by 2 %}{{ paginate.collection[0].body }}{% endpaginate %}", 'COMMENT 5', { 'post' => @post_drop })
        end

        it '#current_offset' do
          expect_template_result("{% paginate post.comments by 2 %}{{ paginate.current_offset }}{% endpaginate %}", '4', { 'post' => @post_drop })
        end

        it '#page_size' do
          expect_template_result("{% paginate post.comments by 2 %}{{ paginate.page_size }}{% endpaginate %}", '2', { 'post' => @post_drop })
        end

        it '#pages' do
          expect_template_result("{% paginate post.comments by 2 %}{{ paginate.pages }}{% endpaginate %}", '3', { 'post' => @post_drop })
        end

        it '#items' do
          expect_template_result("{% paginate post.comments by 2 %}{{ paginate.items }}{% endpaginate %}", '5', { 'post' => @post_drop })
        end

        it '#previous' do
          expect_template_result("{% paginate post.comments by 2 %}{{ paginate.previous }}{% endpaginate %}", %|{"title"=>"&laquo; Previous", "url"=>"/?page=2", "is_link"=>true}|, { 'post' => @post_drop })
        end

        it '#next' do
          expect_template_result("{% paginate post.comments by 2 %}{{ paginate.next }}{% endpaginate %}", %||, { 'post' => @post_drop })
        end

        it '#parts' do
          expect_template_result("{% paginate post.comments by 2 %}{{ paginate.parts }}{% endpaginate %}", %|{"title"=>1, "url"=>"/?page=1", "is_link"=>true}{"title"=>2, "url"=>"/?page=2", "is_link"=>true}{"title"=>3, "is_link"=>false, "hellip_break"=>false}|, { 'post' => @post_drop })
        end
      end
    end
  end
end