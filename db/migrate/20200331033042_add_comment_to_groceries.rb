class AddCommentToGroceries < ActiveRecord::Migration
    def change
      add_column :groceries, :comment, :string
    end
end

