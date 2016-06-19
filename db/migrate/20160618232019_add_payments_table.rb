class AddPaymentsTable < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :user
      t.integer :payment_amount
      t.timestamps
    end
  end
end
