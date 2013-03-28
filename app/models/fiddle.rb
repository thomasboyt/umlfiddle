class Fiddle
  include Mongoid::Document
  
  field :num_revisions, type: Integer, default: 1
  embeds_many :revisions
  index "revisions.num" => 1

end

class Revision
  include Mongoid::Document

  field :num, type: Integer
  field :content, type: String
  embedded_in :fiddle

  validates :content, presence: true
end
