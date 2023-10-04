class CreateProfiles < ActiveRecord::Migration[7.0]
  def up
    create_table :profiles do |t|
      t.string :first_name, null: false, default: ""
      t.string :last_name, null: false, default: ""
      t.string :occupation, null: false, default: ""
      t.string :email, null: false, default: ""
      t.string :age, null: false, default: ""
      t.string :profile_image
      t.string :question_1, null: false, default: "yes"
      t.string :question_2, null: false, default: "introvert"
      t.string :question_3, null: false, default: "maybe"
      t.string :question_4, null: false, default: "money"
      t.timestamps
    end
  end

  def down
    drop_table :profiles
  end
end
