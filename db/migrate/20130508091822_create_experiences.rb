class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences, :primary_key => :experience_id do |t|
      t.datetime :date
      t.integer :moment
      t.string :location
      t.integer :place
      t.integer :detail_one
      t.integer :detail_two
      t.integer :detail_three
      t.integer :hairdressing
      t.integer :kiss
      t.integer :oral_sex
      t.integer :intercourse
      t.integer :caresses
      t.integer :anal_sex
      t.integer :post_intercourse
      t.integer :personal_score
      t.integer :repeat
      t.float :msd_score
      t.integer :bad_lover
      t.integer :final_score

      t.timestamps
    end


    create_table :lover_experiences do |t|
      t.belongs_to :lover
      t.belongs_to :experience
    end

    add_index :lover_experiences, [:lover_id, :experience_id], :unique => true
  end
end
