# Script that add different elements in each table when is called rake db:populate
require 'ffaker'

namespace :db do
  desc "Fill database with sample data"
  task admin: :environment do
    make_admin
  end
  task populate: :environment do
    make_admin
    make_users
    make_lovers
    make_experiences
    make_friendships
    send_messages
    make_photos
    make_geosexes
  end
  task remigrate: :environment do
      Rake::Task['db:drop'].invoke
      Rake::Task['db:create'].invoke
      Rake::Task['db:migrate'].invoke
  end
  task repopulate: :environment do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:populate'].invoke
end
end

def make_admin
  admin = User.create!(name: "Admin",
               email: ADMIN_USER,
               password: ADMIN_PASS,
               facebook_id: "-1",
               status: 0,
               main_photo_url: "http://url.jpg",
               photo_num: 0,
               job: 0,
               age: 0,
               birthday: "11/11/1111",
               startday: "11/11/1111",
               eye_color: 0,
               hair_color: 0,
               height: 0,
               hairdressing: 0,
               sex_interest: 0,
               sex_gender: 0,
               preferences: [1,2,3,4,5,6])

  admin.toggle!(:admin)
end

def make_users
  age = 20
  startday = Date.new(1111,11,11)
  50.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "1234"
    facebook_id = "face#{n+1}"
    main_photo_url ="http://url.jpg"
    photo_num = 0
    age = 30
    startday = Date.new(1111,11,11)
    birthday = Date.new(1111,11,11)
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
                 facebook_id: facebook_id,
                 status: 0,
                 main_photo_url: main_photo_url,
                 photo_num: photo_num,
                 age: age,
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
  49.times do |n|
    name  = Faker::Name.name
    email = "example-#{100-n+1}@railstutorial.org"
    password  = "1234"
    facebook_id = Faker::Internet.user_name
    main_photo_url ="http://url.jpg"
    photo_num = 0
    age = 30
    startday = Date.new(1111,11,11)
    birthday = Date.new(1111,11,11)
    job = 0
    eye_color = 0
    hair_color = 0
    height = 2
    hairdressing = 1
    sex_interest = 0
    sex_gender = 0
    User.create!(name: name,
                 email: email,
                 password: password,
                 facebook_id: facebook_id,
                 status: 0,
                 main_photo_url: main_photo_url,
                 photo_num: photo_num,
                 age: age,
                 birthday: birthday,
                 startday: startday,
                 job: job,
                 eye_color: eye_color,
                 hair_color: hair_color,
                 height: height,
                 hairdressing: hairdressing,
                 sex_interest: sex_interest,
                 sex_gender: sex_gender,
                 preferences: [2,4,3,5,1,6])
  end
end

def make_lovers
  users = User.all(limit:5)
  public_lovers = Array.new
  secret_lovers = Array.new
  5.times do |n|
    name = Faker::Name.name
    name2 = Faker::Name.name
    url = "http://#{name}.jpg"
    url2 = "http://#{name2}.jpg"
    public_lover = Lover.create!(name: name,facebook_id: Faker::Internet.user_name, photo_url: url)
    secret_lover = Lover.create!(name: name2,facebook_id: Faker::Internet.user_name, photo_url: url2)
    public_lovers.push(public_lover)
    secret_lovers.push(secret_lover)
  end
  users.each { |user| public_lovers.each { |lover| user.user_lovers.create(:lover => lover, visibility: 1)}}
  users.each { |user| secret_lovers.each { |lover| user.user_lovers.create(:lover => lover, visibility: 0)}}
end

def make_experiences
  lovers = Lover.all(limit:6)
  experiences = Array.new
  5.times do |n|
    experience = Experience.create!(date: "11/11/1111", location: rand(0...3), personal_score: rand(0...10), msd_score: rand(0...10), final_score: rand(0...10))
    experiences.push(experience)
  end
  lovers.each {|lover| lover.experiences = experiences}


end

def make_friendships
  users = User.all
  user  = users.first
  followed_users = users[2..8]
  followers      = users[3..7]
  followed_users.each { |friend_id| user.invite_friend!(friend_id) }
  followers.each      { |user_id| user_id.accept_friend!(user) }
end

def send_messages
  users = User.all
  user = users.first
  senders_users = users[0..19]
  senders_users.each { |sender_id| user.receive_message!(sender_id,"hola")}
end

def make_photos
  users = User.all(limit:6)
  photos = Array.new
  5.times do |n|
    name="picture#{n+1}.jpeg"
    photo = Photo.create!(name: name)
    photos.push(photo)
  end
  users.each { |user| user.photos = photos}
end

def make_geosexes
  users = User.all(limit:6)
  n = 0
  lat = 41.10
  lng = 2.01
  users.each do |user|
    lat = lat + 0.1
    lng = lng + 0.1
    if n % 2 == 0
      geosex = user.create_geosex(lat: lat, lng: lng, access: 1)
    else
      geosex = user.create_geosex(lat: lat, lng: lng, access: 0)
    end
    geosex.save
    n +=1
  end
end
