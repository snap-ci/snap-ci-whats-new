require 'json'

class Processor
  def run(from_dir, to_dir)
    changelog_data = Rollin::Blog.new(articles_folder: from_dir).articles.map do |changelog|
      { date: changelog.date, body: changelog.body }
    end

    File.open(File.join(to_dir, 'changelog.json'), 'w') { |f| f.write({ changelog: changelog_data }.to_json) }
    File.open(File.join(to_dir, 'latest_changes.json'), 'w') { |f| f.write({ changelog: [changelog_data.first].compact }.to_json) }
  end
end
