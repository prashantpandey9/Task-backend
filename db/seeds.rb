10.times do
    Advertisement.create({
        title: Faker::Game.title,
        body: Faker::Lorem.sentence
    })
end

5.times do
    User.create({
        email: Faker::Internet.email,
        password_digest: "abc@1234567",
        password_confirmation: "abc@1234567",

    })
end