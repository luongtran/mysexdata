json.(@lover, :lover_id, :facebook_id, :name, :photo_url, :age, :sex_gender, :job, :height)
json.experiences (@experiences) do |json, experience|
    json.extract! experience,  :date, :location, :place, :detail_one, :detail_two, :detail_three, :hairdressing, :kiss, :oral_sex, :intercourse, :caresses, :anal_sex, :post_intercourse, :personal_score, :repeat, :msd_score, :bad_lover, :final_score
end