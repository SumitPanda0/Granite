# frozen_string_literal: true

class AddForeignKeyToTask < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :tasks, :users, column: :assigned_user_id
  end
end
