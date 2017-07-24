class Event
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # field <name>, :type => <type>, :default => <value>
  field :name, :type => String
  field :brf, :type => String
  field :type, :type => String
  field :description, :type => String
  field :has_rule, :type => Boolean
  belongs_to :rule

  def self.pureHappen(type, name, brf, description)
    event = Event.new
    event.type = type
    event.name = name
    event.brf = brf
    event.description = description
    event.has_rule = false
    rule = Rule.where(name: "none").first
    if rule.nil?
      rule = Rule.new
      rule.name = "none"
      rule.type = "none"
      rule.save!
    end
    event.rule = self.empty_rule
    event.save!
    event
  end

  def self.draftHappen(brf, description)
    event = Event.new
    event.type = "post"
    event.name = "post-draft-save"
    event.brf = brf
    event.description = description
    event.has_rule = false


    event.rule = self.empty_rule
    event.save!
    event
  end

  private

  def self.empty_rule
    rule = Rule.where(name: "none").first
    if rule.nil?
      rule = Rule.new
      rule.name = "none"
      rule.type = "none"
      rule.save!
    end
    rule
  end

  

  # You can define indexes on documents using the index macro:
  # index :field <, :unique => true>

  # You can create a composite key in mongoid to replace the default id using the key macro:
  # key :field <, :another_field, :one_more ....>
end
