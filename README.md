# Localized Fields [![Build Status](https://secure.travis-ci.org/tiagogodinho/localized_fields.png)](http://travis-ci.org/tiagogodinho/localized_fields) [![Build Status](https://gemnasium.com/tiagogodinho/localized_fields.png)](http://gemnasium.com/tiagogodinho/localized_fields) [![Gem Version](https://badge.fury.io/rb/localized_fields.png)](http://badge.fury.io/rb/localized_fields)

[![Code Climate](https://codeclimate.com/github/tiagogodinho/localized_fields.png)](https://codeclimate.com/github/tiagogodinho/localized_fields) [![Coverage Status](https://coveralls.io/repos/tiagogodinho/localized_fields/badge.png)](https://coveralls.io/r/tiagogodinho/localized_fields)

Helps you to create forms with localized fields using Mongoid.

## Installation

Add this line to your application's Gemfile:

``` ruby
gem 'localized_fields'
```

And then execute:

``` terminal
bundle
```

Or install it yourself as:

``` terminal
gem install localized_fields
```

## Usage

Localized Fields uses

`app/models/post.rb`

```ruby
class Post
  include Mongoid::Document

  field :title, localize: true
end
```
`app/controllers/posts_controller.rb`

```ruby
def new
  @post = Post.new
end
```

### Automatic

`app/view/posts/_form.html.erb`

```erb
<%= form_for @post do |f| %>
  <%= f.localized_fields do |localized_fields| %>
    <%= localized_fields.label :title %>
    <%= localized_fields.text_field :title %>
  <% end %>
<% end %>
```
### Detailed

`app/view/posts/_form.html.erb`

```erb
<%= form_for @post do |f| %>
  <%= f.localized_fields :title do |localized_fields| %>
    <%= localized_fields.label :en %>
    <%= localized_fields.text_field :en %>

    <%= localized_fields.label :pt %>
    <%= localized_fields.text_field :pt %>
  <% end %>
<% end %>
```

## Dependencies

- actionpack ~> 4.0.0
- mongoid (master)

## Compatibility

Localized Fields is tested against Ruby 1.9.3 and 2.0.0

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

MIT License. Copyright 2012 Tiago Rafael Godinho
