class CreateProfiles < ActiveRecord::Migration[7.0]
  def up
    create_table :profiles do |t|
      t.string :first_name, null: false, default: ""
      t.string :last_name, null: false, default: ""
      t.string :occupation, null: false, default: ""
      t.string :email, null: false, default: ""
      t.string :age, null: false, default: ""
      t.string :profile_image
      t.boolean :question_1, default: true
      t.boolean :question_2, default: true
      t.timestamps
    end
  end

  def down
    drop_table :profiles
  end
end
