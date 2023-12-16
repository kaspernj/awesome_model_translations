class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects, &:timestamps
  end
end
