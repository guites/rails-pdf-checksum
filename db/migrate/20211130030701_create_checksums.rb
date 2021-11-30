class CreateChecksums < ActiveRecord::Migration
  def change
    create_table :checksums do |t|
      t.string :md5, limit: 32
      t.string :sha1, limit: 64
      t.string :sha256, limit: 128
      t.string :sha512, limit: 256
      t.references :article, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
