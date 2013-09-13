# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create({:user_id => 1, :name => "Guest", :email => "info@mysexdata.com", :facebook_id => "35353", :status => 1, :facebook_photo => "test.png", 
              :profile_photo => "test.png", :age => 20, :birthday => "1993-10-10", :startday => "2013-10-09", :eye_color=>1, :hair_color => 1,
               :job => "it", :height => 1, :sex_interest => 0, :sex_gender => 1, :hairdressing => 0, :password => '1234', :password_confirmation => '1234',
               :preferences => ['test'], :premium => 1})      
