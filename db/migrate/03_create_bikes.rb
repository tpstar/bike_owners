class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.belongs_to :brand, index: true
      t.belongs_to :owner, index: true
      t.string :name
      t.decimal :price
      t.text :review
    end
  end
end
