class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name
    end
    create_join_table :extended_profile, :language do |t|
      t.index :extended_profile_id
      t.index :language_id
    end
  end
end
