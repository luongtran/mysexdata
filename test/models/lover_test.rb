require 'test_helper'

class LoverTest < ActiveSupport::TestCase
    test "should not save lover without all attributes" do
    lover = Lover.new
    assert !lover.save, "Saved the lover without attributes"
  end

  test "should save lover with all attributes" do
    lover = Lover.new
    user.name = "Foo"
    user.email = "foo@bar.com"
    user.password = "1234"
    user.facebook_id = "face1234"
    user.status = 1
    user.main_photo_url = "http://foobar.jpg"
    user.photo_num = 1
    user.age = 24
    user.startday = "10/11/2013"
    user.eye_color = 2
    user.hair_color = 1
    user.hairdressing = 2
    user.job = 2
    user.height = 1
    user.sex_interest = 1
    user.sex_gender = 1
    user.preferences =[1,2,3,4,5,6]

    assert lover.save, "Saved the lover with attributes"
  end
end
