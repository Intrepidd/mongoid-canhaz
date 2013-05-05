mongoid-canhaz [![Build Status](https://travis-ci.org/Intrepidd/mongoid-canhaz.png?branch=master)](https://travis-ci.org/Intrepidd/mongoid-canhaz)
====================

A mongoid port of the permissions gem for active record : [rails-canhaz](https://github.com/Intrepidd/rails-canhaz)

This gem is a simple mongoid extention that allows any application using mongoid to manage permissions based roles.

## Installation

Standard gem installation :

```
gem install mongoid-canhaz
```

Or in your Gemfile if you use bundler

```ruby
gem 'mongoid-canhaz'
```

## How to use it ?

The mongoid-canhaz gem defines two static functions for mongoid documents which allow them to act as a subject or an object.

In order to use these functions, you need to include ``Canhaz::Mongoid::Document`` inside your class.

A subject has roles on objects.

Here is an example

```ruby
class User
  include Mongoid::Document
  include Canhaz::Mongoid::Document

  acts_as_canhaz_subject
end

class Article
  include Mongoid::Document
  include Canhaz::Mongoid::Document

  acts_as_canhaz_object
end
```

Now our models are marked as canhaz subjects and objects, we have access to some handy functions :


```ruby
user = User.first
article = Article.first

user.can?(:read, article) # Can the user read this article? false for now

user.can!(:read, article) # Ok, so the user can read this article
user.can!(:edit, article) # He can edit it as well

user.can?(:read, article) # Will be true

user.objects_with_permission(Article, :read) # Will return all the articles w/ read permissions for this user

article.subjects_with_permission(User, :read) # Will return all the users hat are able to read this article

#You can also remove permissions

user.cannot!(:read, article)

# global permissions :

user.can?(:haz_cheezburgers) # false

user.can!(:haz_cheezburgers)

user.can?(:haz_cheezburgers) # true

```

## Changelog
* 1.0.0 : First release
