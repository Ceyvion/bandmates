users = [
  {email: "BigDog23@gmail.com", password_digest: "HotDog4Cats", username: "DogEatDog"},
  {email: "KellyK@yahoo.com", password_digest: "Yoyoyoyoy123", username: "KellyAma"}
]

users.each do |u|
  User.create(u)
end
