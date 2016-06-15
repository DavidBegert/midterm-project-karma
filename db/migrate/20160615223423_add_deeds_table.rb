class AddDeedsTable < ActiveRecord::Migration

  def change
    create_table :deeds do |t|
      t.references :user
      t.string :summary
      t.timestamps
    end
  end

end