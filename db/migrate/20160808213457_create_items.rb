class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.references :bucketlist
      t.boolean :done, default: false

      t.timestamps
    end
  end
end
