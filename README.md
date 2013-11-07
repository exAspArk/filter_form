# FilterForm

Build filter forms easily by using `ransack` and `simple_form`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'filter_form'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install filter_form

## Usage

In your contoller:

```ruby
def index
  @q = Person.search(params[:q])
  @people = @q.result
end
```

In your view file:

```erb
<%= filter_form_for @q do |f| %>
  <%= f.filter_input :name %>
  <%= f.filter_input :age %>
  <%= f.filter_input :city_id %>
  <%= f.filter_input :birthday %>
  <%= f.button :submit %>
<% end %>
```

For `string` attribute (like `name`) it will automatically create a text input with predicate `cont` (contains).

For `integer` type (`age`) it will set predicate `eq`.

For association's `foreign key` (`city_id`) it will automatically build a select tag.

For `date` and `datetime` (`birthday`) it will automatically add jQuery [datepicker](http://jqueryui.com/datepicker/) and set predicate `eq`.

If you want to use datepicker add to your application.js file:

```js
//= require jquery
//= require jquery.ui.datepicker
//= require filter_form
```

And application.css:

```css
*= require jquery.ui.datepicker
```

For more information about predicates visit [ransack](https://github.com/ernie/ransack).

If you want to customize your form visit [simple_form](https://github.com/plataformatec/simple_form).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
