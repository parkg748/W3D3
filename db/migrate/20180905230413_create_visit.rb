class CreateVisit < ActiveRecord::Migration[5.1]
  def change
    create_table :visits do |t|
      t.integer :user_id
      t.integer :shortened_url_id
      t.timestamps
    end
    add_index :visits, :shortened_url_id, unique: true
    add_index :visits, :user_id, unique: true
  end
end
