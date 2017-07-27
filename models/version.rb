class Version
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # field <name>, :type => <type>, :default => <value>
  field :name, :type => String
  field :basic_post, :type => String
  field :status, :type => String
  field :count, :type => Integer
  field :promotion, :type => Boolean
  field :wish_write, :type => Integer
  belongs_to :post

  def self.support(id, finger)
    version = Version.find(id)
    wish_write = version.wish_write
    if wish_write.nil?
      wish_write = 0
      version.wish_write = 0
    end
    device = Device.where(finger: finger).first
    if device.nil?
      device = Device.new
      device.finger = finger
      device.save
      version.wish_write = wish_write+1
      version.save
    else
      return "already"
    end
    version.wish_write.to_s
  end


  # You can define indexes on documents using the index macro:
  # index :field <, :unique => true>

  # You can create a composite key in mongoid to replace the default id using the key macro:
  # key :field <, :another_field, :one_more ....>
end
