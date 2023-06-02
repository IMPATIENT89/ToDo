class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.datetime :task_start_time
      t.datetime :task_end_time
      t.timestamps
    end
  end
end
