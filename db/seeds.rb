# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(
  :name => 'Camila',
  :email => 'badmin@gmail.com',
  :password => 'nativbegirl',
  :password_confirmation => 'nativbegirl',
) unless User.find_by_email("badmin@gmail.com")


User.create(
  :name => 'Andres',
  :email => 'andres@gmail.com',
  :password => 'nativbegirl',
  :password_confirmation => 'nativbegirl',
) unless User.find_by_email("andres@gmail.com")


User.create(
  :name => 'Bryan',
  :email => 'bryanvilla@gmail.com',
  :password => '123456',
  :password_confirmation => '123456',
) unless User.find_by_email("bryanvilla@gmail.com")
