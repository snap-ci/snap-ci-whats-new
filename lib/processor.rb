require 'json'

class Processor
  def run(from_dir, to_dir)
    changelog_data = Rollin::Blog.new(articles_folder: from_dir).articles.map do |changelog|
      { date: changelog.date, body: changelog.body }
    end

    File.open(File.join(to_dir, 'changelog.json'), 'w') { |f| f.write({ changelog: changelog_data }.to_json) }
    File.open(File.join(to_dir, 'latest_changes.json'), 'w') { |f| f.write({ changelog: [changelog_data.first].compact }.to_json) }

    unless ENV['SNAP_CI']
      File.open(File.join(to_dir, 'changelog.html'), 'w') do |f|
        changelog_data.each { |changeset| render_preview(f, changeset) }
      end

      File.open(File.join(to_dir, 'latest_changes.html'), 'w') do |f|
        render_preview(f, changelog_data.first)
      end
    end
  end

  def render_preview(file, changeset)
    return unless changeset
    file.puts "<article>"
    file.puts "<h1>#{changeset[:date]}</h1>"
    file.puts changeset[:body]
    file.puts "</article>"
  end
end
