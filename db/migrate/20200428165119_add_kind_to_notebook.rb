class AddKindToNotebook < ActiveRecord::Migration[6.0]
  def change
    add_reference :notebooks, :kind, foreign_key: true
  end
end
