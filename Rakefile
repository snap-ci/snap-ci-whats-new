require_relative 'env'

$PROJECT_ROOT = Dir.pwd

desc "Uploads changelogs to S3"
task :upload, :s3_bucket do |_, params|
  s3_bucket = params[:s3_bucket]
  if s3_bucket.nil?
    puts 'Usage: rake upload[S3_BUCKET]'
  else
    begin
      sh("aws s3 mb s3://#{s3_bucket}")
      sh(%Q{aws s3api put-bucket-acl --bucket #{s3_bucket} --grant-full-control 'emailaddress="snap-ci@thoughtworks.com"' --grant-read 'uri="http://acs.amazonaws.com/groups/global/AllUsers"'})
    rescue => e
      puts "Failed to setup bucket: #{e.message}"
      puts ""
    end

    sh("aws s3 sync --storage-class REDUCED_REDUNDANCY changelog s3://#{s3_bucket}/ --grants 'read=uri=http://acs.amazonaws.com/groups/global/AllUsers' 'full=emailaddress=snap-ci@thoughtworks.com'")
  end
end
