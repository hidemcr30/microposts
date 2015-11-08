# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# coding: utf-8


100.times do |i|
  User.create(:name => "ユーザー#{i}", :email => "user#{i}@user.com", :profile => "私は#{i}番目のユーザーです", :password => "password#{i}", :password_confirmation => "password#{i}")
  users = User.all
  users.each do |micro|
    micropost.create(:content => "これは#{i}番目のmicropostsです" )
  end
end

  #  users = User.all
  #  k=0
  #  content = "test" + K
  #    users.each{|user| user.microposts.create!(content: content)}
  #  k=k+1
  #  end
