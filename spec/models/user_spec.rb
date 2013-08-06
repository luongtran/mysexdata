require 'spec_helper'

describe User do

  before { @user = User.new(name: "sex", email: "sex@sex.com", age: 30, startday: "02/02/1975", eye_color: 0, hair_color: 0, height: 50, photo_num: 0, sex_interest: 0, sex_gender: 0,  facebook_id: "000", password: "1234", sex_geo_id: 0, hairdressing: 0 ) }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:facebook_id) }
  it { should respond_to(:sex_geo_id) }
  it { should respond_to(:photo_num) }
  it { should respond_to(:age) }
  it { should respond_to(:startday) }
  it { should respond_to(:eye_color) }
  it { should respond_to(:hair_color) }
  it { should respond_to(:height) }
  it { should respond_to(:sex_interest) }
  it { should respond_to(:sex_gender) }
  it { should respond_to(:hairdressing) }
  it { should respond_to(:password) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }

  it { should be_valid }


  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eql(found_user.authenticate(@user.password)) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eql(user_for_invalid_password) }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

end
