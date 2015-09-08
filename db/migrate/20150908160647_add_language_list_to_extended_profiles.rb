class AddLanguageListToExtendedProfiles < ActiveRecord::Migration
  def change
    add_column :extended_profiles, :language_list, :text
  end
end
