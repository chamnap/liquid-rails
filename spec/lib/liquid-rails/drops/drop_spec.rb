require 'spec_helper'

module Liquid
  module Rails
    describe Drop, type: :request do
      let(:model)         { ::Model.new }
      let(:profile)       { Profile.new(name: 'Name 1', description: 'Description 1', comments: 'Comments 1') }
      let(:profile_drop)  { ProfileDrop.new(profile) }

      context 'attributes' do
        it '_attributes' do
          expect(profile_drop.class._attributes).to eq([:name, :description])
        end

        it '#name and #description' do
          expect(profile_drop.name).to eq('Name 1')
          expect(profile_drop.description).to eq('Description 1')
        end

        it '#before_method' do
          expect(profile_drop.before_method(:name)).to eq(profile_drop.name)
          expect(profile_drop.before_method(:description)).to eq(profile_drop.description)
        end
      end

      context '#dropify' do
        context 'single' do
          it "instantitates with its inferred drop class" do
            drop = Liquid::Rails::Drop.dropify(profile)

            expect(drop).to be_instance_of(ProfileDrop)
          end

          it "instantitates with `Liquid::Rails::Drop` when its inferred drop class doesn't exist" do
            drop = Liquid::Rails::Drop.dropify(Model.new)

            expect(drop).to be_instance_of(Liquid::Rails::Drop)
          end

          it "instantitates with the caller drop class" do
            drop = ReProfileDrop.dropify(profile)
            expect(drop).to be_instance_of(ReProfileDrop)

            drop = ProfileDrop.dropify(profile)
            expect(drop).to be_instance_of(ProfileDrop)
          end
        end

        context 'array' do
          it "instantitates with collection drop class" do
            array = [1, 2, 3]

            expect(Liquid::Rails::Drop.dropify(array)).to be_instance_of(Liquid::Rails::CollectionDrop)
          end
        end
      end

      context 'association' do
        before(:each) do
          @post           = ::Post.new({ title: 'New Post', body: 'Body' })
          @comment        = ::Comment.new({ id: 1, body: 'ZOMG A COMMENT' })
          @post.comments  = [@comment]
          @comment.post   = @post

          @post.recomments= [@comment]
          @comment.repost = @post

          @post_drop      = ::PostDrop.new(@post)
          @comment_drop   = ::CommentDrop.new(@comment)
        end

        context 'has_many' do
          it '#has_many :comments' do
            expect(@post_drop.class._associations[:comments]).to eq({:type=>:has_many, :options=>{}})
          end

          it '#comments returns as CollectionDrop object' do
            expect(@post_drop.comments).to be_instance_of(Liquid::Rails::CollectionDrop)
          end

          it '#recomments returns as CommentsDrop object' do
            expect(@post_drop.recomments).to be_instance_of(::CommentsDrop)
          end

          it '#recomments returns as ReCommentDrop object' do
            expect(@post_drop.recomments[0]).to be_instance_of(::ReCommentDrop)
          end
        end

        context 'belongs_to' do
          it '#belongs_to' do
            expect(@comment_drop.class._associations[:post]).to eq({:type=>:belongs_to, :options=>{}})
          end

          it '#post returns as PostDrop object' do
            expect(@comment_drop.post).to be_instance_of(::PostDrop)
          end

          it '#repost returns as PostDrop object' do
            expect(@comment_drop.repost).to be_instance_of(::RePostDrop)
          end

          it 'returns nil when the source object is nil' do
            @comment.post = nil
            @comment_drop = ::CommentDrop.new(@comment)

            expect(@comment_drop.post).to be_nil
          end
        end

        context '#to_json' do
          it 'returns hash of attributes' do
            expect(profile_drop.to_json).to eq(%|{"name":"Name 1","description":"Description 1"}|)
          end
        end
      end
    end
  end
end