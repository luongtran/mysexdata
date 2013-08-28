json.user_id @user.user_id
json.statistics do
  json.days_without_sex @days
  json.month_lover do
    json.extract! @m_lover, :lover_id, :name, :photo_url
  end
  json.year_lover do
    json.extract! @y_lover, :lover_id, :name, :photo_url
  end
  json.month_activity  @month_activity
  json.year_activity  @year_activity
end
