require 'faker'

Photo.destroy_all
Result.destroy_all

edition = Edition.first

(1..1500).to_a.each do |i|
  index = (i % 242) + 1
  Photo.create(
    bib: i,
    direct_image_url: "https://source.unsplash.com/collection/1163637/300x200/?sig=#{index}",
    edition: edition,
  )
  
  male_first_name   = Faker::Name.male_first_name
  female_first_name = Faker::Name.female_first_name
  first_name        = index == 0 ? male_first_name : female_first_name
  last_name         = Faker::Name.last_name
  
  Result.create(
    race_detail: ['M', 'L', 'XL'].sample,
    categ:       ['A', 'B', 'C', 'D'].sample,
    bib:         i,
    sex:         ['M', 'F'][index % 2],
    first_name:  first_name,
    last_name:   last_name,
    name:        "#{first_name} #{last_name}",
    edition:     edition
  )

  puts "Photo #{i}/600 done"
end