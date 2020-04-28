namespace :dev do
  desc "Config enviroment developer"
  task setup: :environment do
    puts 'Register Kind Contacts'
    
    kinds = %w(Amigo Comercial Conhecido)
    
    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end
    
    puts 'Register Kinds with Contacts Success!'
    
    ############################################

    puts 'Register Contacts'

    100.times do |i|
      Notebook.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 65.years.ago, to: 18.years.ago),
        kind: Kind.all.sample
      )
    end

    puts 'Register Contacts with Success!'

    ############################################

    puts 'Register Phones'

    Notebook.all.each do |notebook|
      Random.rand(5).times do |i|
        phone = Phone.create!(number:Faker::PhoneNumber.cell_phone)
        notebook.phones << phone
        notebook.save!
      end
    end

    puts 'Register Phones with Success!'

  end
end
