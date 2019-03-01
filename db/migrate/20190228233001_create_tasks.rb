class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :label
      t.date :due_date
      t.belongs_to :list, foreign_key: true

      t.timestamps
    end
  end
end
