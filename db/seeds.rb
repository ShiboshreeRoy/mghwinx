User.create!(
  email: 'manuroy169@gmail.com',
  password: 'xpose009@',          # Lowercase 'x'
  password_confirmation: 'xpose009@',  # Match lowercase 'x'
  role: 1
)

User.create!(
  email: "orgatro.it.official@gmail.com",
  password: 'orgatro009@',
  password_confirmation: 'orgatro009@',  # Already correct
  role: 1
)