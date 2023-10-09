class UpdateAndAddQuestionsToProfiles < ActiveRecord::Migration[7.0]
  def up
    change_column :profiles, :question_1, :string, default: "netflix"
    add_column :profiles, :question_5, :string, null: false, default: "physical_touch"
  end

  def down
    change_column :profiles, :question_1, :string, default: "yes"
    remove_column :profiles, :question_5
  end
end