class AddGuest < ActiveRecord::Migration
  def change
    User.new({:user_id => 1, :name => "Guest", :email => "luongtranduc@gmail.com", :facebook_id => "100000389198768", :status => 1, :facebook_photo => "avatar.png", :profile_photo => 1, :photo_num => 1, :age => 28, :birthday => "1985-11-10 00:00:00", :startday => "2013-09-01 05:00:00", :eye_color=>1, :hair_color => 1,:job => 1, :height => 1, :sex_interest => 1, :sex_gender => 0, :hairdressing => 1, :password => '1234', :password_confirmation => '1234',:preferences => 0, :premium => 0}).save
  end
end
