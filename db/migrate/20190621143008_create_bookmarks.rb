class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp'
    enable_extension 'pgcrypto'

    create_table :bookmarks, id: :uuid do |t|
      t.text :city_name

      t.belongs_to :user, foreign_key: true
    end

    add_index(:bookmarks, :city_name)
  end
end
