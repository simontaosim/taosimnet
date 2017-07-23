puts 'seeds begin'
require 'digest/md5'

if User.where(name: "simontaosim").size() > 0
  puts "simontaosim已经存在"
  puts User.first.to_json;
else
  user = User.new;
  user.name = "simontaosim"
  user.pass = Digest::MD5.hexdigest "7686043104Xsq@519"
  admin_role = Role.where(name: "admin").first
  if admin_role.nil?
    admin_role = Role.new
    admin_role.name = "admin"
    admin_role.save!
  end
  user.role = admin_role
  user.save!

  puts user.to_json
end
