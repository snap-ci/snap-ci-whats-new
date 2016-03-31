require 'json'

class Processor
  def run(from_dir, to_dir)
    @from_dir = from_dir
    @to_dir = to_dir

    changelog_data = generate_changelog_data
    File.open(File.join(@to_dir, 'changelog.json'), 'w') { |f| f.write({ changelog: changelog_data }.to_json) }
    File.open(File.join(@to_dir, 'latest_changes.json'), 'w') { |f| f.write({ changelog: [changelog_data.first].compact }.to_json) }

    unless ENV['SNAP_CI']
      File.open(File.join(@to_dir, 'changelog.html'), 'w') do |f|
        changelog_data.each { |changeset| render_preview(f, changeset) }
      end

      File.open(File.join(@to_dir, 'latest_changes.html'), 'w') do |f|
        render_preview(f, changelog_data.first)
      end
    end
  end

  def generate_changelog_data
    Dir.glob(File.join(@from_dir, "*")).sort.reverse.map do |article|
      {
        :date => date(article),
        :body => body(article)
      }
    end.first(10)
  end

  def date(article)
    article_file_name = File.basename(article)
    y, m, d = article_file_name.split('_')[0..2].map(&:to_i)
    Date.new(y, m, d)
  end

  def body(article)
    html_renderer_options = { hard_wrap: false }
    parser_options = { autolink: true,
                       space_after_headers: true,
                       fenced_code_blocks: true,
                       disable_indented_code_blocks: true }
    render = Redcarpet::Render::HTML.new(html_renderer_options)
    redcarpet = Redcarpet::Markdown.new(render, parser_options)
    redcarpet.render(File.read(article))
  end

  def render_preview(file, changeset)
    return unless changeset
    file.puts "<article>"
    file.puts "<h1>#{changeset[:date]}</h1>"
    file.puts changeset[:body]
    file.puts "</article>"
  end
end
