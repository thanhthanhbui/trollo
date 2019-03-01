class List < ApplicationRecord
  belongs_to :board, dependent: :destroy
  has_many :tasks

  def self.all_lists(id)
    List.find_by_sql(
      "SELECT *
      FROM lists l
      WHERE l.board_id = #{id}
      ORDER BY l.title"
    )
  end

  def self.single_list(board_id, list_id)
    List.find_by_sql([
      "SELECT *
      FROM lists l
      WHERE l.id = ?",
      list_id]).first
  end

  def self.create_list(p, id)
    List.find_by_sql([
      "INSERT INTO lists (title, description, board_id, created_at, updated_at)
      VALUES (:title, :description, :board_id, :created_at, :updated_at)",
      {
        title: p[:title],
        description: p[:description],
        board_id: id,
        created_at: DateTime.now,
        updated_at: DateTime.now
      }])
  end

  def self.update_list(p, list_id)
    List.find_by_sql([
      "UPDATE lists l
      SET title = ?, description = ?, updated_at = ?
      WHERE l.id = ?",
      p[:title], p[:description], DateTime.now, list_id])
  end

  def self.delete_list(list_id)
    List.find_by_sql([
      "DELETE FROM lists l
      WHERE l.id = ?",
      list_id])
  end
end
