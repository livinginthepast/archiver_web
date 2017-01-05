class Integrations::AWS::S3::PresignedUrl
  attr_reader :key

  def initialize(key)
    @key = key
  end

  def url
    object.presigned_url(:put)
  end

  private

  def object
    s3.bucket(ENV['AWS_UPLOADS_BUCKET']).object(key)
  end

  def s3
    Aws::S3::Resource.new(
      client: Aws::S3::Client.new(
        credentials: credentials,
        region: ENV['AWS_REGION'],
      )
    )
  end

  def credentials
    Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_KEY'])
  end

end
