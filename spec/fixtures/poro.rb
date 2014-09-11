class Model
  include Liquid::Rails::Droppable

  def initialize(hash={})
    @attributes = hash
  end

  def id
    @attributes[:id] || @attributes['id'] || object_id
  end

  def method_missing(meth, *args)
    if meth.to_s =~ /^(.*)=$/
      @attributes[$1.to_sym] = args[0]
    elsif @attributes.key?(meth)
      @attributes[meth]
    else
      super
    end
  end
end

class Profile < Model
end

class ProfileDrop < Liquid::Rails::Drop
  attributes :name, :description
end

Post    = Class.new(Model)
Comment = Class.new(Model)

PostDrop = Class.new(Liquid::Rails::Drop) do
  attributes :title, :body, :id
  has_many :comments
  has_many :recomments, with: 'ReCommentDrop', class_name: 'CommentsDrop'
end

CommentDrop = Class.new(Liquid::Rails::Drop) do
  attributes :id, :body
  belongs_to :post
  belongs_to :repost, class_name: 'RePostDrop'
end

RePostDrop    = Class.new(Liquid::Rails::Drop)
ReCommentDrop = Class.new(Liquid::Rails::Drop)
CommentsDrop  = Class.new(Liquid::Rails::CollectionDrop)