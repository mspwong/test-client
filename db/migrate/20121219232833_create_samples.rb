class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.string :name
      t.integer :product_id
      t.string :state, :nil=>false, :default=>'new'
      t.integer :price #cent
      t.timestamps
    end

    add_index :samples, :product_id
  end
end
