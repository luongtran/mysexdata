# Script that add different elements in each table when is called rake db:populate

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_lovers
    make_friendships
    send_messages
    make_photos
  end
end

def make_users
  birthday = Date.new(1111,11,11)
  startday = Date.new(1111,11,11)
  admin = User.create!(name: "Example User",
               email: "example@railstutorial.org",
               password: "1234",
               password_confirmation: "1234",
               facebook_id: "0",
               main_photo_url: "http://url.jpg",
               photo_num: 0,
               job: 0,
               birthday: birthday,
               startday: startday,
               eye_color: 0,
               hair_color: 0,
               height: 0,
               hairdressing: 0,
               sex_interest: 0,
               sex_gender: 0,
               preferences: [1,2,3,4,5,6])

  admin.toggle!(:admin)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "1234"
    facebook_id = Faker::Lorem.characters(15)
    main_photo_url ="http://url.jpg"
    photo_num = 0
    birthday = Date.new(1111,11,11)
    startday = Date.new(1111,11,11)
    job = 0
    eye_color = 0
    hair_color = 0
    height = 0
    hairdressing = 0
    sex_interest = 0
    sex_gender = 0
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password,
                 facebook_id: facebook_id,
                 main_photo_url: main_photo_url,
                 photo_num: photo_num,
                 birthday: birthday,
                 startday: startday,
                 job: job,
                 eye_color: eye_color,
                 hair_color: hair_color,
                 height: height,
                 hairdressing: hairdressing,
                 sex_interest: sex_interest,
                 sex_gender: sex_gender,
                 preferences: [1,2,3,4,5,6])
  end
end

def make_lovers
  users = User.all(limit:6)
  5.times do |n|
    name = Faker::Name.name
    users.each { |user| user.lovers.create!(name: name, visibility: 1, lover_id: n+1, facebook_id: Faker::Lorem.characters(15))}
  end
end

def make_friendships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |friend_id| user.make_friend!(friend_id) }
  followers.each      { |user_id| user_id.make_friend!(user) }
end

def send_messages
  users = User.all
  user = users.first
  senders_users = users[0..19]
  senders_users.each { |sender_id| user.receive_message!(sender_id,"hola")}
end

def make_photos
  users = User.all(limit:6)
  5.times do |n|
    photo_id = n +1
    url="http://myurl#{n+1}"
    users.each { |user| user.photos.create!(photo_id: photo_id, photo_url: url, profile_photo: false)}
  end
end