class AddUsuarioToAnamnese < ActiveRecord::Migration[6.0]
  def change
    add_reference :anamneses, :usuario, null: false, foreign_key: true
  end
end
