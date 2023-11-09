# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# will add fake data later - Brandon
users = [{:email => "johnjones@gmail.com", :password_digest => "$2a$12$86inXQAxCAq5UzGWSPJKGuRBeXRqKdxqrPTFMxIixu1stfHR0XTEC", :first_name => "John", :last_name => "Jones", :address => "7486 West Blackburn Court Cheshire CT 06410"},
         {:email => "iankuk@yahoo.com", :password_digest => "$2a$12$TT3ZOAMu.PDPQQQNrX6VqeuIU9zDj5NPORGyvgBXhUbY6oqRK5..S", :first_name => "Ian", :last_name => "Kuk", :address => "70 Meadowbrook Street Ashburn VA 20147"},
         {:email => "brandoncano@hotmail.com", :password_digest => "$2a$12$lSIV164uVNbxx6niQhGve.wl6NnNN1Iti.M4fll0ne19XJgFXzsB.", :first_name => "Brandon", :last_name => "Cano", :address => "101 Valley Farms Avenue New Bern NC 28560"},
         {:email => "angelozamba@aol.com", :password_digest => "$2a$12$OD5qvyvKLk/3JpvShA5eDebhnQ10fOqVM9USH5vDC/D2HcAwKFC3.", :first_name => "Angelo", :last_name => "Zamba", :address => "1  Pilgrim Lane Ringgold GA 30736"},
         {:email => "brendansuttor@yahoo.com", :password_digest => "$2a$12$EFCOwFO1N530z55J1nguhOtPBXXCPEQ9u6qpYkkb/ooy9EBEHuZGC", :first_name => "Brendan", :last_name => "Suttor", :address => "56 Atlantic Street Muncie IN 47302"},
         {:email => "kaileymackin@gmail.com", :password_digest => "$2a$12$2kr/B4mpopTF8eRyp8/np.7tDKp4CicRSttLhuWKeSWGJK/bDMx1a", :first_name => "Kailey", :last_name => "Mackin", :address => "879 East Ryan Court Nashville TN 37205"},
         {:email => "megantaylor@yahoo.com", :password_digest => "$2a$12$eFYoJEDSDeKQ/N09NRPevOOwhnenydnx1xmleAbxDs8Z7JDYbo5kG", :first_name => :"Megan", :last_name => "Taylor", :address => "797 Plymouth Drive Yonkers NY 10701"},
         {:email => "jennamarbles@hotmail.com", :password_digest => "$2a$12$Nk.RBlk3lLA3bIuxhcL0zuztUS8e0kZJparQcBVMJyyy2.ZSiImy2", :first_name => "Jenna", :last_name => "Marbles", :address => "998 Marconi Court Spring Valley NY 10977"}]
products = [{:product_id => 0, :name => "", :category => "", :description => "", :price => "", :location => "", :is_sold? => true}]