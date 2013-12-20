ActiveRecord::Migration.create_table :users do |t|
  t.boolean :married
  t.string :name
  t.integer :age
  t.date :birthday
  t.integer :city_id
  # TODO: add amount (money)
  t.string :gender
  t.timestamps
end
