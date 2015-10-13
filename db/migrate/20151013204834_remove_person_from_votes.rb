class RemovePersonFromVotes < ActiveRecord::Migration
  def change
    remove_column :votes, :person, :string
  end
end
