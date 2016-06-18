class AddCommentsTable < ActiveRecord::Migration

  def change
    create_table :comments do |t|
      t.references :user
      t.references :deed
      t.string :content
      t.timestamps
    end
  end 

end