# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
User.create(:email => 'stefan.haslinger@mittenin.at', 
            :hashed_password => '3da5ec55ff6f0a132828b8c4e2d0667c16b8f758', 
            :salt => '972816400.5714992328217361', 
            :admin => true,
            :height => '193',
            :invitation_limit => '10')
