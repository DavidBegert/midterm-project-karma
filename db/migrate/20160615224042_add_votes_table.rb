class AddVotesTable  < ActiveRecord::Migration

  def change
    create_table :votes do |t|
      t.references :deed
      t.integer :value
      t.timestamps
    end
  end
  
end