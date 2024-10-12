User.create!(email: 'admin@admin.com', password: 'Password1234', password_confirmation: 'Password1234')

30.times do
  Course.create!([ {
    title: Faker::Educator.course_name,
    description: Faker::TvShows::GameOfThrones.quote,
    user_id: User.first.id
  } ])
end
