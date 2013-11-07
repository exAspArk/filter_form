# FilterForm

Build filter forms easily by using `ransack` and `simple_form`.

## Installation

Add this line to your application's Gemfile:

    gem 'filter_form'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install filter_form

## Usage

In your contoller:

```ruby
def index
  @q = Person.search(params[:person])
  @people = @q.result
end
```

In your view file:

```ruby
<%= filter_form_for @q do |f| %>
  <%= f.filter_input :name %>
  <%= f.filter_input :age %>
  <%= f.filter_input :birthday %>
  <%= f.button :submit %>
<% end %>
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
