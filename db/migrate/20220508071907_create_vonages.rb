class CreateVonages < ActiveRecord::Migration[6.1]
  def change
    create_table :vonages do |t|

      t.timestamps
    end
  end
end
