class AddAvatarUrlToExtendedProfiles < ActiveRecord::Migration
  def change
    add_column :extended_profiles, :avatar_url, :string
  end
end
