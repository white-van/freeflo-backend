class ImagesController < ApplicationController

  # GET /presigned_url
  def get_presigned_url  
    signature = S3_BUCKET.presigned_post(
      key: "#{SecureRandom.uuid}_${filename}",
      success_action_status: '201',
      signature_expiration: (Time.now.utc + 15.minutes),
      acl: 'public-read'
    )
  
    render json: signature, status: :ok
  end


  private

    def get_presigned_url
      presigned_url = S3_BUCKET.presigned_post(
      key: "#{SecureRandom.uuid}_${filename}",
      success_action_status: '201',
      signature_expiration: (Time.now.utc + 15.minutes),
      acl: 'public-read'
    )
    { url: presigned_url.url, url_fields: presigned_url.fields }
    end

end
