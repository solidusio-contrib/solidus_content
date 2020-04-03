class CreateSolidusContentEntryTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :solidus_content_entry_types do |t|
      t.string :name, null: false
      t.json :options, default: {}, null: false
      t.string :content_provider_name, null: false

      t.timestamps
    end
    add_index :solidus_content_entry_types, :name
  end
end
