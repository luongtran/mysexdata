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
end

controller do
    #...
    def permitted_params
      params.permit(:user => [:name, :email, :remember_token, :password_digest, :password, :status, :main_photo_url, :photo_num, :lovers_num, :job, :age, :startday, :eye_color, :hair_color, :height, :hairdressing, :sex_intereset, :sex_gender, :preferences, :admin ])
    end
  end
end
