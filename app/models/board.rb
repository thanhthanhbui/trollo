class Board < ApplicationRecord
  belongs_to :user
  has_many :lists, dependent: :destroy

  def self.all_boards(id)
    Board.find_by_sql(
      "SELECT *
      FROM boards b
      WHERE b.user_id = #{id}
      ORDER BY b.title"
    )
  end

  def self.single_board(user_id, board_id)
    Board.find_by_sql([
      "SELECT *
      FROM boards b
      WHERE b.id = ? AND b.user_id = ?",
      board_id, user_id]).first
  end

  def self.create_board(p, board_id)
    Board.find_by_sql([
      "INSERT INTO boards (title, description, user_id, created_at, updated_at)
      VALUES (:title, :description, :user_id, :created_at, :updated_at)",
      {
        title: p[:title],
        description: p[:description],
        user_id: board_id,
        created_at: DateTime.now,
        updated_at: DateTime.now
      }])
  end

  def self.update_board(p, board_id)
    Board.find_by_sql([
      "UPDATE boards b
      SET title = ?, description = ?, updated_at = ?
      WHERE b.id = ?",
      p[:title], p[:description], DateTime.now, board_id])
  end

  def self.delete_board(board_id)
    Board.find_by_sql([
      "DELETE FROM boards b
      WHERE b.id = ?",
      board_id])
  end
end
