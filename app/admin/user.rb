ActiveAdmin.register User do

scope :all, :default => true

scope :admin do |user|
  user.where('admin = ?', true)
end

index do
  column :name
  column :email
  column :age
  column :sex_gender
  column :admin


  default_actions
end

filter :name
filter :email
filter :age
filter :sex_gender
filter :admin

show do |ad|
      attributes_table do
        row :name
        row :email
        row :age
        row :sex_gender
        row :admin
      end
end

sidebar "Friendships", :only => :show do
  form do |f|
  table_for Friendship.where(user_id: user.user_id) do |t, f|
    t.column :friend
    t.column "Banned", :accepted  do
      form do |f|
        f.check_box("banner", "incited")
      end
    end
  end
end
button_to_function "Greeting", "alert('Hello world!')", class: "ok"
end

form do |f|
      f.inputs "User info" do
        f.input :name
        f.input :email
        f.input :age
        f.input :sex_gender
        f.input :admin
      end
      f.actions
    end

controller do
    def permitted_params
      params.permit(:user => [:name, :email, :remember_token, :password_digest, :password, :status, :main_photo_url, :photo_num, :lovers_num, :job, :age, :startday, :eye_color, :hair_color, :height, :hairdressing, :sex_intereset, :sex_gender, :preferences, :admin ])
    end
  end
end
