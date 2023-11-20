FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.last_name}
    email                 {Faker::Internet.email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    lastname              {'太郎'}
    firstname             {'山田'}
    lastname_kana         {'ヤマダ'}
    firstname_kana        {'タロウ'}
    birthdate              {Faker::Date.between(from: '1930-01-01', to: '2018-12-31')}
  end
end