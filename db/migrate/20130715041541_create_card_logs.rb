class CreateCardLogs < ActiveRecord::Migration
  def change
    create_table :card_logs do |t|
      t.string :host
      t.string :brower
      t.belongs_to :card
      t.timestamps
    end
  end
end
