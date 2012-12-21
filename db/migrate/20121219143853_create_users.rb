class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :facebook_id
      t.datetime :dob
      t.string :fact

      t.timestamps
    end
  end
end
