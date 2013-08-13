class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences, :primary_key => :experience_id do |t|
      t.datetime :date
      t.integer :moment, default: 0
      t.string :location
      t.integer :place, default: 0
      t.integer :detail_one, default: 0
      t.integer :detail_two, default: 0
      t.integer :detail_three, default: 0
      t.integer :hairdressing, default: 0
      t.integer :kiss, default: 0
      t.integer :oral_sex, default: 0
      t.integer :intercourse, default: 0
      t.integer :caresses, default: 0
      t.integer :anal_sex, default: 0
      t.integer :post_intercourse, default: 0
      t.integer :repeat, default: 0
      t.integer :visibility, default: 0
      t.integer :times, default: 0
      t.integer :personal_score, default: 0
      t.integer :msd_score, default: 0
      t.integer :final_score, default: 0

      t.timestamps
    end


    create_table :lover_experiences do |t|
      t.belongs_to :lover
      t.belongs_to :experience
    end

    add_index :lover_experiences, [:lover_id, :experience_id], :unique => true
  end
end
