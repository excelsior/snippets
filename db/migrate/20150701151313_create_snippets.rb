class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :body, limit: 8192, null: false

      t.datetime :created_at, null: false
    end
  end
end
