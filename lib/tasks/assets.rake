# frozen_string_literal: true

namespace :assets do
  desc 'Precompile assets for Heroku'
  task :precompile do
    Rake::Task['assets:precompile'].invoke
  end
end
