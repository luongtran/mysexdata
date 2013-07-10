class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.integer :lover_id
      t.datetime :date
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
      t.decimal :msd_score
      t.integer :bad_lover
      t.integer :final_score

      t.timestamps
    end
    add_index :experiences, :lover_id
  end
end
