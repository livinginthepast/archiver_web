namespace :reset do
  desc 'Copy sample .envrc file'
  task envrc: %w(
    ./.envrc
  )

  file './.envrc' do
    next unless Rails.env.development?
    sh 'cp -v ./.envrc.sample ./.envrc'
    STDERR.puts 'Please configure .envrc with correct development values'
    STDERR.puts 'and allow it from direnv'
    STDERR.puts '  continue? [Y/n]'
    continue = STDIN.gets
    if continue.start_with?('n')
      exit 1
    end
  end
end

task reset: 'reset:envrc'

