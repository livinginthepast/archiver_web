class CreateThings < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'uuid-ossp'

    reversible do |dir|
      dir.up {
        execute %{
          CREATE TYPE oauth_provider AS ENUM (
            'google',
            'developer'
          )
        }
      }

      dir.down {
        execute 'DROP TYPE oauth_provider'
      }
    end

    create_table :profiles, id: :uuid do |t|
      t.string :username, null: false

      t.timestamps null: false
    end

    create_table :omniauths, id: :uuid do |t|
      t.references :profile, type: :uuid, null: false

      t.string :uid, null: false
      t.string :email, null: false
      t.string :name, null: false
      t.column :provider, :oauth_provider, null: false

      t.timestamps null: false
    end

    create_table :things, id: :uuid do |t|
      t.references :profile, type: :uuid, null: false
      t.string :name, null: false

      t.timestamps null: false
    end

    create_table :assets, id: :uuid do |t|
      t.references :thing, type: :uuid, null: false
      t.string :path, null: false

      t.timestamps null: false
      t.datetime :deleted_at
    end

    reversible do |dir|
      dir.up {
        execute 'create index index_omniauths_on_email on omniauths(lower(email))'
      }

      dir.down {}
    end
  end
end
