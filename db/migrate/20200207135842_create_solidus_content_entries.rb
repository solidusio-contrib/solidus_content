class CreateSolidusContentEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :solidus_content_entries do |t|
      t.references :entry_type, null: false
      t.json :options, default: {}, null: false
      t.string :slug, null: false, default: :default

      t.timestamps
    end
  end
end
