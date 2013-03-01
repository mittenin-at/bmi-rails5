This file is currently work in progress...

## Welcome to BMI

BMI is a body mass index tracker application written in Ruby on Rails.
It is licenced under the GPLv3. See licence File provided in the same directory for details.


## Prerequisites

* A working SMTP server

## Getting Started

1. Copy `config/database.yml.orig`  to `config/database.yml` and modify it according to your settings.
2. `bundle install` and `rake db:migrate` as usual.
2. Modify `config/environment.rb` and set the name of you SMTP-Server.
3. Start the application and register your admin's email address.
4. An email will be sent to this address, click on link and register yourself.
5. The first (and only the first) user created will have admin privileges automatically.
6. Have fun!

## Libraries used 

The gems used can be found in the Gemfile, but I want to thank the current project leads for maintaining them explicitely:
* [rails](https://github.com/rails/rails), thanks to [all Rails developers](https://github.com/rails)
* [mysql2](https://github.com/brianmario/mysql2), thanks to [Brtian Lopez](https://github.com/brianmario)
* [kaminari](https://github.com/amatsuda/kaminari), thanks to [Akira Matsuda](https://github.com/amatsuda)
* [nokogiri](https://github.com/sparklemotion/nokogiri), thanks to [Sparkle Motion](https://github.com/sparklemotion)
* [jquery-rails](https://github.com/rails/jquery-rails), thanks to [all Rails developers](https://github.com/rails)
* [less-rails](https://github.com/metaskills/less-rails), thanks to [Ken Collins](https://github.com/metaskills)
* [twitter-bootstrap-rails](https://github.com/seyhunak/twitter-bootstrap-rails), thanks to [Seyhun Akyürek](https://github.com/seyhunak)
* [jquery-datatables-rails](https://github.com/rweng/jquery-datatables-rails), thanks to [Robin Wenglewski](https://github.com/rweng)
* [therubyracer](https://github.com/cowboyd/therubyracer), thanks to [Charles Lowell](https://github.com/cowboyd)
* [debugger](https://github.com/mark-moseley/ruby-debug), thanks to [Mark Moseley](https://github.com/mark-moseley)

* [nvd3](http://nvd3.org/), thanks to [Novus](https://github.com/novus) for the pretty Javascript graphing library based on [D3.js](http://d3js.org/)