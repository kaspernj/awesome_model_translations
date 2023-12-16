# AwesomeModelTranslations
Short description and motivation.

## Usage

Add a translated attribute to your model:
```ruby
class Project < ApplicationRecord
  translates :name
end
```

You can set the name in the current locale like this:
```ruby
I18n.locale = :en
project.name = "English name"
project.name #=> "English name"
```

Or set the name for a specific locale like this:
```ruby
I18n.locale = :en
project.name_da = "Dansk navn"
project.name #=> "Dansk navn"
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem "awesome_model_translations"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install awesome_model_translations
```

Install the migrations and run them:
```bash
rake railties:install:migrations
rails db:migrate
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
