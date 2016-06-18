class AddPaymentsTable < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :user
      t.integer :payment
      t.timestamps
    end
  end
end
