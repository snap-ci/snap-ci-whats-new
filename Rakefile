require_relative 'env'
require 'json'

OUTPUT_PATH = 'output'

desc "Process changelogs and creates .json files in output folder"
task :process do
  bucket_content_local_path = 'changelog'

  sh("mkdir -p #{OUTPUT_PATH}")
  sh("rm -rf #{OUTPUT_PATH}/*")

  puts "Processing files from #{bucket_content_local_path} to #{OUTPUT_PATH}"

  Processor.new.run(bucket_content_local_path, OUTPUT_PATH)
end

desc "Uploads content of output folder to S3"
task :upload, [:s3_bucket] => :process do |_, params|
  s3_bucket = params[:s3_bucket]

  if s3_bucket.nil?
    puts 'Usage: rake upload[S3_BUCKET]'
  else
    begin
      sh("aws s3 mb s3://#{s3_bucket}")
      sh(%Q{aws s3api put-bucket-acl --bucket #{s3_bucket} --grant-full-control 'emailaddress="snap-ci@thoughtworks.com"' --grant-read 'uri="http://acs.amazonaws.com/groups/global/AllUsers"'})
      cors_config = {
        "CORSRules" => [
          {
            "AllowedMethods" => ["GET"],
            "AllowedOrigins" => ["*"]
          }
        ]
      }

      sh("aws s3api put-bucket-cors --bucket #{s3_bucket} --cors-configuration '#{cors_config.to_json}'")
    rescue => e
      puts "Failed to setup bucket: #{e.message}"
      puts ""
    end
  end

  puts "Uploading files from #{OUTPUT_PATH} to S3 bucket #{s3_bucket}"
  sh("aws s3 sync --delete --storage-class REDUCED_REDUNDANCY #{OUTPUT_PATH} s3://#{s3_bucket}/ --grants 'read=uri=http://acs.amazonaws.com/groups/global/AllUsers' 'full=emailaddress=snap-ci@thoughtworks.com'")
end
