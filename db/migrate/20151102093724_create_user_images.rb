class CreateUserImages < ActiveRecord::Migration
  def change
    create_table :user_images do |t|
      t.references :user, foreign_key: true
      t.binary :data
      t.string :content_type

      t.timestamps null: false
    end
    
    add_index :user_images, :user_id
  end
end
