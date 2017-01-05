class Integrations::S3::ImagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def presign
    render json: Serializers::AWS::S3::PresignedUrl.new(presigned_url)
  end

  private

  def presigned_url
    Integrations::AWS::S3::PresignedUrl.new(params[:key])
  end
end

