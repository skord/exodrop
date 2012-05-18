class Asset < ActiveRecord::Base
  
  def to_param
    name
  end
  
  mount_uploader :asset, AssetUploader
  
  before_save :calc_checksum

  def calc_checksum
    self.sha256 = Digest::SHA256.file(self.asset.path).hexdigest
    self.name= self.sha256
  end
  
  def to_jq_upload
    {
      "name" => read_attribute(:asset),
      "SHA256" => read_attribute(:sha256),
      "size" => asset.size,
      "url" => "/assets/#{self.name}",
      "thumbnail_url" => '',
      "delete_url" => "/assets/#{self.name}",
      "delete_type" => "DELETE" 
    }
  end
  
  attr_accessible :name, :asset
end
