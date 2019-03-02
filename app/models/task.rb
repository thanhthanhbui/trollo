class Task < ApplicationRecord
  belongs_to :list

  def self.single_task(list_id, task_id)
    Task.find_by_sql([
      "SELECT *
      FROM tasks t
      WHERE t.id = ?",
      task_id]).first
  end

  def self.create_task(p, id)
    Task.find_by_sql([
      "INSERT INTO tasks (title, description, label, due_date, list_id, created_at, updated_at)
      VALUES (:title, :description, :label, :due_date, :list_id, :created_at, :updated_at)",
      {
        title: p[:title],
        description: p[:description],
        label: p[:label],
        due_date: p[:due_date],
        list_id: id,
        created_at: DateTime.now,
        updated_at: DateTime.now
      }])
  end

  def self.update_task(p, task_id)
    Task.find_by_sql([
      "UPDATE tasks l
      SET title = ?, description = ?, label = ?, due_date = ?, updated_at = ?
      WHERE l.id = ?",
      p[:title], p[:description], p[:label], p[:due_date], DateTime.now, task_id])
  end

  def self.delete_task(task_id)
    Task.find_by_sql([
      "DELETE FROM tasks l
      WHERE l.id = ?",
      task_id])
  end
end
