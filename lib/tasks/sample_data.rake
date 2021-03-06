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
   task populate_production: :environment do
    make_admin
    make_users
    make_lovers
    make_experiences
    make_friendships
    send_messages
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
 task repopulate_production: :environment do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:populate_production'].invoke
end
end

def make_admin
  admin = User.create!(name: "Admin",
               email: ADMIN_USER,
               password: ADMIN_PASS,
               password_confirmation: ADMIN_PASS,
               facebook_id: "-1",
               status: 0,
               facebook_photo: "http://url.jpg",
               profile_photo: -1,
               photo_num: 1,
               job: 0,
               birthday: "11/11/1991",
               startday: "11/11/1992",
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
  4.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "1234"
    facebook_id = "face#{n+1}"
    facebook_photo ="http://url.jpg"
    profile_photo = -1
    photo_num = 1
    startday = "11/11/1992"
    birthday = "11/11/1991"
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
                 status: 0,
                 facebook_photo: facebook_photo,
                 profile_photo: profile_photo,
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
  users = User.all(limit:5)
  users = users[1..5]
  public_lovers = Array.new
  secret_lovers = Array.new
  2.times do |n|
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
  lovers = Lover.all(limit:2)
  experiences = Array.new
  3.times do |n|
    experience = Experience.create!(date: "11/02/2013", location: rand(0...3), personal_score: rand(0...10), msd_score: rand(0...10), final_score: rand(0...10))
    experiences.push(experience)
  end
    2.times do |n|
    experience_month = Experience.create!(date: "11/08/2013", location: rand(0...3), personal_score: rand(0...10), msd_score: rand(0...10), final_score: rand(0...10))
    experiences.push(experience_month)
  end
  lovers.each {|lover| lover.experiences = experiences}


end

def make_friendships
  user2 = User.find_by_user_id(2);
  user3 = User.find_by_user_id(3);
  user4 = User.find_by_user_id(4);

  user2.invite_friend!(user3)
  user2.invite_friend!(user4)

  user3.invite_email_friend!("test@gmail.com")

  user3.accept_friend!(user2)
end

def send_messages
  users = User.all
  user = User.find_by_user_id(2)
  senders_users = users[3..5]
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
