namespace :upload_template do
  $PROJECT_ROOT = Dir.pwd

  desc "Uploads changelogs to S3"
  task :upload do
    s3_bucket = ENV['S3_BUCKET']
    sh("aws s3 rb s3://#{s3_bucket}")
    sh("aws s3 mb s3://#{s3_bucket}")
    sh(%Q{aws s3api put-bucket-acl --bucket #{s3_bucket} --grant-read 'uri="http://acs.amazonaws.com/groups/global/AllUsers"'})
    sh("aws s3 cp --storage-class REDUCED_REDUNDANCY changelog/* s3://#{s3_bucket}/")
  end
end

