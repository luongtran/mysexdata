json.(@user, :user_id)
json.(@lover, :lover_id)
json.experiences (@experiences) do |json, experience|
    json.extract! experience,  :experience_id, :date,:moment, :location, :place, :detail_one, :detail_two, :detail_three, :hairdressing, :kiss, :oral_sex, :intercourse, :caresses, :anal_sex, :post_intercourse, :visibility, :times, :personal_score, :repeat, :msd_score, :final_score
end
