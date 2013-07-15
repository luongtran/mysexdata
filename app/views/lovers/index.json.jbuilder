json.array!(@lovers) do |lover|
  json.extract! lover, :user_id, :lover_id, :name, :photo_url, :age, :sex_gender, :job, :height, :visibility
  json.url lover_url(lover, format: :json)
end