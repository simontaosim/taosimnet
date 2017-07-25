class Post
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # field <name>, :type => <type>, :default => <value>
  field :title, :type => String
  field :body, :type => String
  field :max_version, :type => Integer
  has_and_belongs_to_many :tags
  has_one :version, dependent: :destroy
  belongs_to :user

  def self.publish(id, tags_arr, is_promotion, user)

    # 检查此文章是否为第一次发布，
    # 若是更新此文章的最大版本为１,
    # 否则加一
    post = Post.find(id)
    if post.max_version.nil?
      post.max_version = 1
    else
      post.max_version = post.max_version + 1
    end
    post.save
    #建立一个新的版本，版本状态为发布
    version = Version.new
    version.status = "published"
    # 新版本指向原来的文章
    version.basic_post = post.id
    # 初始版本号为ｘ
    version.number = post.max_version
    # 名称为第Ｘ版本
    version.name = "发布第"+version.number.to_s+"版"
    # 说明新版本是否推荐
    version.promotion = is_promotion

    # 新建文章，将此文章完全复制过来，并给新文章打标签

    new_post  = Post.new
    new_post.title = post.title
    new_post.body = post.body
    new_post.max_version = post.max_version
    new_post.tags = post.tags
    new_post.user = user
    tags = []
    tags_arr.each do |tag|
      puts tag
      @tag = Tag.new
      @tag.name = tag
      @tag.posts.push(new_post)
      puts @tag.to_json
      @tag.save
      tags.push(@tag)
    end
    new_post.tags = tags
    puts new_post.to_json
    new_post.save!
    # 新版本属于新文章
    version.post = new_post


    version.save!


  end


  # You can define indexes on documents using the index macro:
  # index :field <, :unique => true>

  # You can create a composite key in mongoid to replace the default id using the key macro:
  # key :field <, :another_field, :one_more ....>
end
