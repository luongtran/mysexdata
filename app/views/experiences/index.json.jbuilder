json.(@user, :user_id)
json.(@lover, :lover_id)
json.experiences (@experiences) do |json, experience|
    json.extract! experience,  :experience_id, :date, :location, :place, :detail_one, :detail_two, :detail_three, :hairdressing, :kiss, :oral_sex, :intercourse, :caresses, :anal_sex, :post_intercourse, :personal_score, :repeat, :msd_score, :bad_lover, :final_score
end
