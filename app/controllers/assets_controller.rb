class AssetsController < ApplicationController
  def index
  end
  
  def show
    @asset = Asset.first(conditions: {sha256: params[:id]})
    send_file @asset.asset.path, :filename => File.basename(@asset.asset.to_s), :type => 'application/octet-stream', :disposition => 'attachment'
  end
  
  def create
    @asset = Asset.new(params[:asset])
    if @asset.save
      respond_to do |format|
        format.html {
          render :json => [@asset.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json {
          render :json => [@asset.to_jq_upload].to_json
        }
      end
    else
      render :json => [{:error => 'custom_failure'}], :status => 304
    end
  end
  
  def destroy
    @asset = Asset.first(conditions: {sha256: params[:id]})
    @asset.destroy
    render :json => true
  end
  
end
