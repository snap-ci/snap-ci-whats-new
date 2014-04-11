require_relative '../env'
require 'tmpdir'
require 'json'

describe Renderer do
  it 'renderes changelogs to output folder' do
    inputdir = Dir.mktmpdir
    outputdir = Dir.mktmpdir

    File.open(File.join(inputdir, '2010_01_01_Whats_new.mk'), 'w') do |f|
      f.write('Content 1')
    end

    File.open(File.join(inputdir, '2010_01_02_Whats_new.mk'), 'w') do |f|
      f.write('Content 2')
    end

    Renderer.new.render(inputdir, outputdir)

    changelog_data = {
      changelog: [
        { date: '2010-01-02', body: "<p>Content 2</p>\n" },
        { date: '2010-01-01', body: "<p>Content 1</p>\n" }
      ]
    }

    JSON.parse(File.read(File.join(outputdir, 'changelog.json')), symbolize_names: true).should == changelog_data
    JSON.parse(File.read(File.join(outputdir, 'latest_changes.json')), symbolize_names: true).should == { changelog: [changelog_data[:changelog].first] }
  end
end
