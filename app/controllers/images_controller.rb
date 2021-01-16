class ImagesController < ApplicationController
  
  # GET /presigned_urls
  def get_presigned_urls
    if !params[:count] && !params[:count].is_a?(Integer)
      head :bad_request
    end
  
    signatures = []
    params[:count].to_i.times do
      data = get_presigned_url
      signatures << data
    end
  
    render json: signatures, status: :ok
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
