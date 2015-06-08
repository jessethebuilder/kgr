10.times do
  d = Dj.new :name => Faker::Name.name, :email => Faker::Internet.email, :tag_line => Faker::Company.catch_phrase,
             :twitter_url => 'xxx@twitter.com', facebook_url: 'xxx@facebook.com',
             short_bio: Faker::Lorem.sentences(sentence_count = Random.rand(1..3)).join('. '),
             bio: Faker::Lorem.paragraphs(paragraph_count = Random.rand(1..20)).join('<br>')

  fn = File.join(Rails.root, 'app/assets/images/demo', "user_sample#{Random.rand(1..2)}.jpg")
  d.head_shot = File.new(fn)

  d.show = Show.new :name => Faker::Company.catch_phrase.titlecase, :description => Faker::Lorem.sentences(sentence_count = Random.rand(1..10)).join('. ')

  d.save!
end

20.times do
  e = Event.new :name => Faker::Name.name, start_time: Time.now + Random.rand(1..2000).hours,
                description: Faker::Lorem.paragraphs(paragraph_count = Random.rand(1..20)).join('<br>')
  fn = File.join(Rails.root, 'app/assets/images/demo', "user_sample#{Random.rand(1..2)}.jpg")
  e.main_image = File.new(fn)

  dj_ids = Dj.all.collect{ |dj| dj.to_param }


  Random.rand(0..(dj_ids.count - 1)).times do
    dj_ids.delete(dj_ids.sample)
  end

  dj_ids.each{ |d| e.djs_attending << d }

  e.save!
end