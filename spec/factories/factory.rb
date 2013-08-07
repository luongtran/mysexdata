require 'factory_girl'
require 'ffaker'



FactoryGirl.define do
  factory :user do
    name {Faker::Name.name}
    email  {Faker::Internet.email}
    facebook_id {Faker::Lorem.words(1)[0]}
    password "1234"
    status "1"
    main_photo_url {Faker::Internet.user_name}
    photo_num "2"
    age "23"
    birthday "11/11/1111"
    startday "11/11/1111"
    eye_color "1"
    hair_color "2"
    hairdressing "1"
    job "1"
    height "1"
    sex_interest "1"
    sex_gender "1"
    preferences [1,2,3,4,5,6]
    admin true
  end
end
