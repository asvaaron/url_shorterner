# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Create initial values for the url data
# Add google web page
Url.create(
    url:'http://google.com',
)
# Add github

Url.create(
    url:'http://github.com',
    )
## Add