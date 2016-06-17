# migrations are used to change the structure of a database
# create tables
# adding colums to tables
# removing colums from tables
# adding indexes
# removing indexes

class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :body

      t.timestamps null: false
    end
  end
end
