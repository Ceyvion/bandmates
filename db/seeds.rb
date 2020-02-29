users = [
  {email: "BigDog23@gmail.com", password: "HotDog4Cats", username: "DogEatDog"},
  {email: "KellyK@yahoo.com", password: "Yoyoyoyoy123", username: "KellyAma"}
]

@users.each do |u|
  u.create(u)
end
