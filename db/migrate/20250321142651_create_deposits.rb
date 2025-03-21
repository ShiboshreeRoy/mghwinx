class CreateDeposits < ActiveRecord::Migration[7.2]
  def change
    create_table :deposits do |t|
      t.string :transaction_id
      t.decimal :amount
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
