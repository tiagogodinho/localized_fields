class Post
  include Mongoid::Document

  field :title, localize: true
end
