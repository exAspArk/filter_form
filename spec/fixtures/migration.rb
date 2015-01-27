ActiveRecord::Migration.create_table :users do |t|
  t.boolean :married
  t.string  :name
  t.text    :about
  t.integer :amount_cents, default: 0
  t.string  :amount_currency, default: 'USD'
  t.integer :age
  t.date    :birthday
  t.integer :city_id
  t.string  :gender
end

ActiveRecord::Migration.create_table :dog do |t|
  t.string  :name
  t.integer :user_id
end
