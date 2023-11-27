class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string     :postalcode,   null: false
      t.integer    :prefecture,   null: false
      t.string     :city,         null: false
      t.string     :housenumber,  null: false
      t.string     :building
      t.string     :phone,        null: false
      t.references :order,        null: false, foreign_key: true
      t.timestamps
    end
  end
end
