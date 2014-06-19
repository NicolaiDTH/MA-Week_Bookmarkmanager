class Link

  include DataMapper::Resource

  has n, :tag, :through => Resource

  property :id, Serial
  property :title, String
  property :url, String

end