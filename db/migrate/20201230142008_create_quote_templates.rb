class CreateQuoteTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :quote_templates do |t|
      t.string :title
      t.text :markdown_content
      t.timestamps
    end
  end
end
