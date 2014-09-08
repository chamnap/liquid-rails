require 'spec_helper'

module Liquid
  module Rails
    describe Drop do
      let(:model)         { ::Model.new }
      let(:profile)       { Profile.new(name: 'Name 1', description: 'Description 1', comments: 'Comments 1') }
      let(:profile_drop)  { ProfileDrop.new(profile) }

      context 'attributes' do
        it '_attributes' do
          expect(profile_drop.class._attributes).to eq([:id, :name, :description])
        end

        it '#id as integer' do
          profile      = Profile.new(id: 22234555, name: 'Name 1')
          profile_drop = ProfileDrop.new(profile)

          expect(profile_drop.id).to eq(22234555)
        end

        it '#id as string' do
          profile      = Profile.new(id: '22234555', name: 'Name 1')
          profile_drop = ProfileDrop.new(profile)

          expect(profile_drop.id).to eq('22234555')
        end

        it '#id as string when it\'s not integer or string' do
          profile      = Profile.new(id: BSON::Id.new(22234555), name: 'Name 1')
          profile_drop = ProfileDrop.new(profile)

          expect(profile_drop.id).to eq('22234555')
          expect(profile_drop.id).to be_instance_of(String)
        end

        it '#name and #description' do
          expect(profile_drop.name).to eq('Name 1')
          expect(profile_drop.description).to eq('Description 1')
        end

        it '#before_method' do
          expect(profile_drop.before_method(:id)).to eq(profile_drop.id)
          expect(profile_drop.before_method(:name)).to eq(profile_drop.name)
          expect(profile_drop.before_method(:description)).to eq(profile_drop.description)
        end
      end

      context '#drop_for' do
        it 'existing drop' do
          drop_class = Liquid::Rails::Drop.drop_for(profile)

          expect(drop_class).to eq(profile_drop.class)
        end

        it 'not-existing drop' do
          drop_class = Liquid::Rails::Drop.drop_for(model)

          expect(drop_class).to eq(nil)
        end

        it 'array drop' do
          array = [1, 2, 3]

          expect(Liquid::Rails::Drop.drop_for(array)).to eq(Liquid::Rails::CollectionDrop)
        end
      end

      context 'association' do
        before(:each) do
          @post           = ::Post.new({ title: 'New Post', body: 'Body' })
          @comment        = ::Comment.new({ id: 1, body: 'ZOMG A COMMENT' })
          @post.comments  = [@comment]
          @comment.post   = @post

          @post_drop      = ::PostDrop.new(@post)
          @comment_drop   = ::CommentDrop.new(@comment)
        end

        context 'has_many' do
          it '#has_many' do
            expect(@post_drop.class._associations).to eq({:comments=>{:type=>:has_many, :options=>{}}})
          end

          it 'returns as CollectionDrop object' do
            expect(@post_drop.comments).to be_instance_of(Liquid::Rails::CollectionDrop)
          end
        end

        context 'belongs_to' do
          it '#belongs_to' do
            expect(@comment_drop.class._associations).to eq({:post=>{:type=>:belongs_to, :options=>{}}})
          end

          it 'returns as PostDrop object' do
            expect(@comment_drop.post).to be_instance_of(::PostDrop)
          end
        end
      end
    end
  end
end