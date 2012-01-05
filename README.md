# Localized Fields [![Build Status](https://secure.travis-ci.org/tiagogodinho/localized_fields.png)](http://travis-ci.org/tiagogodinho/localized_fields)

Helps you to create forms with localized fields using Mongoid.

## Dependencies

- rails >= 3.1
- mongoid >= 2.4

## Installation

Add this line to your application's Gemfile:

    gem 'localized_fields'
    gem 'mongoid', git: 'git://github.com/tiagogodinho/mongoid.git', branch: 'validates_presence'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install localized_fields

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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
