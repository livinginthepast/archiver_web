module Serializers
  class AWS::S3::PresignedUrl < Base
    serialize_for :presigned_url

    def to_hash
      {
        presigned_url: presigned_url.url
      }
    end
  end
end
