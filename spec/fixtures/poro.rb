class Model
  def initialize(hash={})
    @attributes = hash
  end

  def read_attribute_for_serialization(name)
    if name == :id || name == 'id'
      id
    else
      @attributes[name]
    end
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

Post = Class.new(Model)
Comment = Class.new(Model)

PostDrop = Class.new(Liquid::Rails::Drop) do
  attributes :title, :body, :id
  has_many :comments
end

CommentDrop = Class.new(Liquid::Rails::Drop) do
  attributes :id, :body
  belongs_to :post
end

module BSON
  class Id
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def to_s
      @id.to_s
    end
  end
end