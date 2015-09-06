class CreateExtendedProfiles < ActiveRecord::Migration
  def change
    create_table :extended_profiles do |t|
      t.text :skill_level
      t.text :special_interests
      t.text :availability
      t.text :time_zone
      t.text :notes
      t.boolean :is_mentor
      t.boolean :is_pair_partner
      t.references :user
      t.timestamps
    end
  end
end
