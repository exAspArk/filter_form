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
  <%= f.filter_input :married   # boolean    %>
  <%= f.filter_input :name      # string     %>
  <%= f.filter_input :age       # integer    %>
  <%= f.filter_input :birthday  # date       %>
  <%= f.filter_input :city      # belongs_to %>
  <%= f.filter_input :parents   # has_many   %>
  <%= f.filter_input :amount    # money      %>
  <%= f.button :submit %>
<% end %>
```

### Available types

     Mapping         | Database Column Type                            | Default predicate     | Generated HTML Element    |
     --------------- |:------------------------------------------------|:----------------------|:--------------------------|
     `boolean`       | `boolean`                                       | `true`                | `input[type="checkbox"]`  |
     `string`        | `string`                                        | `cont`                | `input[type="text"]`      |
     `text`          | `text`                                          | `cont`                | `input[type="text"]`      |
     `integer`       | `integer`                                       | `eq`                  | `input[type="number"]`    |
     `float`         | `float`                                         | `eq`                  | `input[type="number"]`    |
     `decimal`       | `decimal`                                       | `eq`                  | `input[type="number"]`    |
     `date`          | `date`                                          | `eq`                  | `input[type="text"]`      |
     `datetime`      | `datetime`                                      | `eq`                  | `input[type="text"]`      |
     `select`        | `belongs_to`/`has_many`/`has_and_belongs_to_many` associations | `eq`   | `select`                  |
     `money`         | `money` [monetized](https://github.com/RubyMoney/money-rails) attribute | `eq` | `input[type="number"]` |

### Customization

#### Custom predicate

```erb
<%= filter_form_for @q do |f| %>
  <%= f.filter_input :year, as: :select, collection: (2000..2013).to_a, predicate: :not_eq %>
  <%= f.button :submit %>
<% end %>
```

#### Predicate selector

You can show predicate selector:

```erb
<%= filter_form_for @q do |f| %>
  <%= f.filter_input :id, predicate_selector: [['=', 'eq'], ['>', 'gt'], ['<', 'lt']] %>
  <%= f.button :submit %>
<% end %>
```

#### Money

To filter by monetized attribute please add to your controller:

```ruby
class ApplicationController < ActionController::Base
  include FilterForm::MoneyConverter
  ...
end
```

#### Select2

You can wrap your select in `select2`:

```erb
<%= filter_form_for @q do |f| %>
  <%= f.filter_input :title, as: :select, in: :select2 %>
  <%= f.button :submit %>
<% end %>
```

#### Assets

If you want to use predicate selector, jQuery [Datepicker](http://jqueryui.com/datepicker/) for `date` and `datetime` automatically or [Select2](http://ivaynberg.github.io/select2/), add to your application.js file:

```js
//= require jquery
//= require jquery.ui.datepicker

//= require select2

//= require filter_form
```

And application.css:

```css
*= require jquery.ui.datepicker

*= require select2

*= require filter_form
```

### Other sources

For more information about predicates visit [ransack](https://github.com/ernie/ransack).

If you want to customize your form visit [simple_form](https://github.com/plataformatec/simple_form).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
