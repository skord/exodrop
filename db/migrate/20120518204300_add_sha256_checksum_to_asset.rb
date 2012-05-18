class AddSha256ChecksumToAsset < ActiveRecord::Migration
  def change
    add_column :assets, :sha256, :string
  end
end
