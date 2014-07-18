#!/usr/bin/env rake

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require "styled/engine"

begin
  require 'rdoc/task'
rescue LoadError
  require 'rdoc/rdoc'
  require 'rake/rdoctask'
  RDoc::Task = Rake::RDocTask
end

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Styled'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Bundler::GemHelper.install_tasks

namespace :bootstrap do
  tmp   = "tmp/bootstrap"
  dir   = Styled::Engine.root

  fonts = "app/assets/fonts/twitter/bootstrap"
  css   = "app/assets/stylesheets/twitter/bootstrap"
  js    = "app/assets/javascripts/twitter/bootstrap"
  docs  = "app/views/styled/docs"

  tag = "v3.1.1"

  task :update do
    sh "git clone git@github.com:twbs/bootstrap.git #{tmp}" unless File.exist?(tmp)

    Dir.chdir tmp do
      sh "git fetch"
      sh "git checkout tags/#{tag}"
      sh "git reset --hard"
    end
  end

  task :upgrade => [:distclean, :update] do
    FileUtils.mkdir_p [css, js, fonts]

    sh "cp #{tmp}/fonts/*     #{fonts}"
    sh "cp #{tmp}/less/*.less #{css}"
    sh "cp #{tmp}/js/*.js     #{js}"

    Dir.chdir tmp do
      files = "package.json docs/*.html docs/_layouts/*.html docs/_includes/*.html docs/examples/*/index.html"

      sh %Q[sed -i '' -f #{dir}/script/sed/bootstrap.clean.sed #{files}]

      # Remove tracking scripts
      sh %q[sed -i '' -e '/^<script>/,/^<\/script>/d' docs/_includes/*.html]

      sh "npm install"
      sh "grunt"

      sed = "sed -i '' -f #{dir}/script/sed/bootstrap.erbify.sed"

      sh "find ./_gh_pages -type f -name *.html -exec #{sed} '{}' \\;"
      sh "find ./_gh_pages -type f -name *.html -exec mv '{}' '{}'.erb \\;"
    end

    FileUtils.cp_r "#{tmp}/_gh_pages", docs
    FileUtils.mv   "#{docs}/assets", "#{dir}/app/assets/vendor/bootstrap"
    FileUtils.mv   "#{docs}/examples/screenshots", "#{dir}/app/assets/vendor/bootstrap/img/screenshots"
  end

  task :distclean do
    sh "rm -rf #{fonts}"
    sh "rm -rf #{css}"
    sh "rm -rf #{js}"
    sh "rm -rf #{docs}"
    sh "rm -rf #{dir}/app/assets/vendor/bootstrap"
  end

  task :clean => :distclean do
    sh "rm -rf #{tmp}"
  end
end

namespace :fontawesome do
  tmp   = "tmp/fontawesome"
  dir   = Styled::Engine.root

  fonts = "app/assets/fonts/font-awesome"
  css   = "app/assets/stylesheets/font-awesome"

  tag = "v4.1.0"

  task :update do
    sh "git clone git@github.com:FortAwesome/Font-Awesome.git #{tmp}" unless File.exist?(tmp)

    Dir.chdir tmp do
      sh "git fetch"
      sh "git checkout tags/#{tag}"
    end
  end

  task :upgrade => :update do
    FileUtils.mkdir_p [css, fonts]

    sh "cp #{tmp}/fonts/*     #{fonts}"
    sh "cp #{tmp}/less/*.less #{css}"
  end

  task :clean do
    sh "rm -rf #{tmp}"
    sh "rm -rf #{css}"
  end
end

desc "Remove vendored libraries"
task :clean   => %w[bootstrap:clean   fontawesome:clean]

desc "Update vendored libraries"
task :update  => %w[bootstrap:update  fontawesome:update]

desc "Upgrade vendored libraries"
task :upgrade => %w[bootstrap:upgrade fontawesome:upgrade]
