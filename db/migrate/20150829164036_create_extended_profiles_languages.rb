class CreateExtendedProfilesLanguages < ActiveRecord::Migration
  def change
    create_table :extended_profiles_languages do |t|
      t.integer :extended_profile_id
      t.integer :language_id
    end
  end
end