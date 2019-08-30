class CreateAns < ActiveRecord::Migration[5.2]
  def change
  	create_table :ans do |t|
  		t.text		:content
  		t.timestamps
  	end
  end
end
