# frozen_string_literal: true

require 'rails_helper'

describe 'Codebase', codebase: true do
  it 'does not offend Rubocop' do
    expect(`rubocop --parallel --format simple`).to include 'no offenses detected'
  end

  it 'satisfies Brakeman' do
    expect(`brakeman -w2`).not_to include '+SECURITY WARNINGS+'
  end

  it 'does NOT break zeitwerk loading' do
    expect(`bundle exec rake zeitwerk:check`).to include 'All is good!'
  end

  it 'does not offend engine prefix name' do
    engine_paths = Dir[File.expand_path(Rails.root.join('engines', '*'))]
                   .select { |f| File.directory? f }
                   .map { |path| path.split('/').last }
    invalid_engine_paths = engine_paths.reject { |path| path.start_with?('google_search_ic_') }

    expect(invalid_engine_paths).to be_empty
  end

  it 'does not contain respond_to blocks' do
    find_results = `grep -r 'respond_to do' app/`
    expect(find_results).to be_empty
  end

  it 'does not contain format blocks' do
    find_results = `grep -r 'format.json' app/`
    expect(find_results).to be_empty
  end

  # rubocop:disable RSpec/ExampleLength
  it 'does not offend PhraseApp Pull configuration' do
    locale_tags = Dir[File.expand_path(Rails.root.join('config', 'locales', '*.yml'))]
                  .map { |path| path.split('/').last } # ["campaign.en.yml", "article.en.yml", "campaign.th.yml"]
                  .map { |path| path.split('.').first } # ["campaign", "article", "campaign"]
                  .uniq # ["campaign", "article"]
                  .sort # ["article", "campaign"]
    phrase_app_pull_tags = YAML
                           .load_file(Rails.root.join('.phraseapp.yml'))
                           .dig('phraseapp', 'pull', 'targets')
                           .map { |target| target.dig('params', 'tags') }
                           .sort

    expect(phrase_app_pull_tags).to eq locale_tags
  end
  # rubocop:enable RSpec/ExampleLength

  it 'does not offend scss-lint' do
    expect(`scss-lint`).to be_empty
  end

  it 'does not offend eslint' do
    expect(`yarn run eslint ./`).to include 'Done'
  end
end
