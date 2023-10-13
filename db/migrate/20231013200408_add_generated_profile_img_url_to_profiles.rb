class AddGeneratedProfileImgUrlToProfiles < ActiveRecord::Migration[7.0]

  def up
    add_column :profiles, :generated_profile_img_url, :string

    Profile.destroy_all
  end

  def down
    remove_column :profiles, :generated_profile_img_url
  end

end
