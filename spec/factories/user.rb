FactoryBot.define do
  factory(:user) do
    name {'admin'}
    email { "jane.doe@hey.com" }
    password { "SecretPassword123" }
    role { 'admin' }

  end
end