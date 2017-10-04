class RemovePmFromStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :pm
  end
end
