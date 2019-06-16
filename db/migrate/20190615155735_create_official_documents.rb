class CreateOfficialDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :official_documents do |t|
      t.json :metadata
    end
  end
end
