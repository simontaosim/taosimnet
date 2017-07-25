class Version
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # field <name>, :type => <type>, :default => <value>
  field :name, :type => String
  field :basic_post, :type => String
  field :status, :type => String
  field :number, :type => Integer
  field :promotion, :type => Boolean
  field :support, :type => Integer
  belongs_to :post


  # You can define indexes on documents using the index macro:
  # index :field <, :unique => true>

  # You can create a composite key in mongoid to replace the default id using the key macro:
  # key :field <, :another_field, :one_more ....>
end
