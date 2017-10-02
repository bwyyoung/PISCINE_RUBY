# README

####ERROR WITH rails 4.2.7
https://stackoverflow.com/questions/41504106/ruby-2-4-and-rails-4-stack-level-too-deep-systemstackerror

Rails 4.2.7 has a severe error with active_support:
```
   bin/rails server
=> Booting WEBrick
=> Rails 4.2.7 application starting in development on http://localhost:3000
=> Run `rails server -h` for more startup options
=> Ctrl-C to shutdown server
/Users/bwyyoung/.rvm/gems/ruby-2.4.2@global/gems/activesupport-4.2.7/lib/active_support/core_ext/numeric/conversions.rb:121: warning: constant ::Fixnum is deprecated
/Users/bwyyoung/.rvm/gems/ruby-2.4.2@global/gems/activesupport-4.2.7/lib/active_support/core_ext/numeric/conversions.rb:121: warning: constant ::Bignum is deprecated
Exiting
/Users/bwyyoung/.rvm/gems/ruby-2.4.2@global/gems/activesupport-4.2.7/lib/active_support/core_ext/numeric/conversions.rb:124:in `block (2 levels) in <class:Numeric>': stack level too deep (SystemStackError)
        from /Users/bwyyoung/.rvm/gems/ruby-2.4.2@global/gems/activesupport-4.2.7/lib/active_support/core_ext/numeric/conversions.rb:131:in `block (2 levels) in <class:Numeric>'
        from /Users/bwyyoung/.rvm/gems/ruby-2.4.2@global/gems/activesupport-4.2.7/lib/active_support/core_ext/numeric/conversions.rb:131:in `block (2 levels) in <class:Numeric>'
        from /Users/bwyyoung/.rvm/gems/ruby-2.4.2@global/gems/activesupport-4.2.7/lib/active_support/core_ext/numeric/conversions.rb:131:in `block (2 levels) in <class:Numeric>'
        from /Users/bwyyoung/.rvm/gems/ruby-2.4.2@global/gems/activesupport-4.2.7/lib/active_support/core_ext/numeric/conversions.rb:131:in `block (2 levels) in <class:Numeric>'
        from /Users/bwyyoung/.rvm/gems/ruby-2.4.2@global/gems/activesupport-4.2.7/lib/active_support/core_ext/numeric/conversions.rb:131:in `block (2 levels) in <class:Numeric>'
        from /Users/bwyyoung/.rvm/gems/ruby-2.4.2@global/gems/activesupport-4.2.7/lib/active_support/core_ext/numeric/conversions.rb:131:in `block (2 levels) in <class:Numeric>'
        from /Users/bwyyoung/.rvm/gems/ruby-2.4.2@global/gems/activesupport-4.2.7/lib/active_support/core_ext/numeric/conversions.rb:131:in `block (2 levels) in <class:Numeric>'
        from /Users/bwyyoung/.rvm/gems/ruby-2.4.2@global/gems/activesupport-4.2.7/lib/active_support/core_ext/numeric/conversions.rb:131:in `block (2 levels) in <class:Numeric>'
         ... 1396 levels...
        from /Users/bwyyoung/.rvm/rubies/ruby-2.4.2/lib/ruby/site_ruby/2.4.0/rubygems/core_ext/kernel_require.rb:68:in `require'
        from /Volumes/SD_CACHE/dropbox_gmail/Dropbox/42_LOCAL/Documents/ANNEE_3/PISCINE_RUBY/d03/ex03/HelloWorld/HelloWorld/bin/spring:15:in `<top (required)>'
        from bin/rails:3:in `load'
        from bin/rails:3:in `<main>'
```
Therefore, use latest rails above version 5.

## ETC
This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
