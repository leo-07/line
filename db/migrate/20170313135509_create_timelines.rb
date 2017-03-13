class CreateTimelines < ActiveRecord::Migration
  def change
    create_table :timelines do |t|
    	t.integer	:user_id
    	t.text		:text
      t.timestamps
    end
  end
end
