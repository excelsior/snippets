class AddPrivateAndSlugToSnippets < ActiveRecord::Migration
  def change
    add_column :snippets, :private, :boolean, default: false, null: false
    add_column :snippets, :slug, :string
  end
end
