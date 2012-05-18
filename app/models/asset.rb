class Asset < ActiveRecord::Base
  mount_uploader :asset, AssetUploader
  attr_accessible :name, :asset
end
