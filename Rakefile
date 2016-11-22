require_relative 'env'
require 'json'

OUTPUT_PATH = 'output'

desc 'Process changelogs and creates .json files in output folder'
task :process do
  bucket_content_local_path = 'changelog'

  sh("mkdir -p #{OUTPUT_PATH}")
  sh("rm -rf #{OUTPUT_PATH}/*")

  puts "Processing files from #{bucket_content_local_path} to #{OUTPUT_PATH}"

  Processor.new.run(bucket_content_local_path, OUTPUT_PATH)

  puts "Copying assets to #{OUTPUT_PATH}"
  sh("cp -r assets #{OUTPUT_PATH}")
end

desc 'Generate colored diffs from {centos|ubuntu}.diff'
task :diff, [:file_name] do |t, args|
  file_name = args[:file_name]
  source = ""
  header = ""
  lineno = 0
  skip = true

  File.read(file_name).each_line do |line|
    if lineno == 0
      # save the header line
      header = line.match(/^#\s*(.+)\s*$/)[1]
      source << line
    end

    lineno += 1

    # after the first blank line, start adding keeping lines
    skip = false if skip && line.strip == ""
    source << line unless skip
  end

  formatter = Rouge::Formatters::HTMLPygments.new(Rouge::Formatters::HTML.new, "syntax")
  lexer = Rouge::Lexers::Diff.new

  platform = file_name.match(/(centos|ubuntu)/)[1]
  raise "don't know which OS this diff is for! please name the file either centos.diff or ubuntu.diff" unless platform

  m = header.match(/DIFF BETWEEN (\d+) AND (\d+)/)
  from, to = m[1], m[2]

  raise "Couldn't detect container versions from first line of #{file_name.inspect}" unless (from && to)
  File.open(File.join("assets", "packages", platform, "diff-#{from}-to-#{to}.html"), "w") do |f|
    f.puts "<html>"
    f.puts "<head>"
    f.puts "  <title>#{header}</title>"
    f.puts "  <link rel=\"stylesheet\" href=\"pygments.css\" />"
    f.puts "</head>"
    f.puts "<body>"
    f.puts formatter.format(lexer.lex(source))
    f.puts "</body>"
    f.puts "</html>"
  end
end

desc 'Uploads content of output folder to S3'
task :upload, [:s3_bucket] => :process do |_, params|
  s3_bucket = params[:s3_bucket]

  if s3_bucket.nil?
    puts 'Usage: rake upload[S3_BUCKET]'
  else
    begin
      sh("aws s3 mb s3://#{s3_bucket}")
      sh(%Q{AWS_ACCESS_KEY_ID=#{ENV['S3_ACCESS_KEY_ID']} AWS_SECRET_KEY_ID=#{ENV['S3_AWS_SECRET_KEY_ID']} aws s3api put-bucket-acl --bucket #{s3_bucket} --grant-full-control 'emailaddress="snap-ci@thoughtworks.com"' --grant-read 'uri="http://acs.amazonaws.com/groups/global/AllUsers"'})
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
  sh("aws s3 sync --delete --storage-class REDUCED_REDUNDANCY #{OUTPUT_PATH} s3://#{s3_bucket}/ --cache-control 'max-age=7200' --grants 'read=uri=http://acs.amazonaws.com/groups/global/AllUsers' 'full=emailaddress=snap-ci@thoughtworks.com'")
end
