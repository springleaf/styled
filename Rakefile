#!/usr/bin/env rake

begin
  require 'bundler/setup'
rescue LoadError
  puts "You must `gem install bundler` and `bundle install` to run rake tasks"
end

require "colorize"

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

  docs  = "app/views/styled/bootstrap"

  task :checkout, :tag do |t, args|
    abort "\nNo tag specified: e.g. rake bootstrap:checkout[v3.3.1]".red unless tag = args[:tag]

    sh "git clone git@github.com:twbs/bootstrap.git #{tmp}" unless File.exist?(tmp)

    Dir.chdir tmp do
      sh "git reset --hard"
      sh "git fetch"
      sh "git checkout tags/#{tag}"
    end

    puts "\nBootstrap: updated to tags/#{tag}".green
  end

  task :install, [:tag] => [:distclean, :checkout] do |t, args|
    abort "\nNo tag specified: e.g. rake bootstrap:install[v3.3.1]".red unless tag = args[:tag]

    dist = "app/assets/styled/bootstrap/#{tag}"

    FileUtils.mkdir_p %W[#{dist}/fonts #{dist}/js #{dist}/less]

    sh "cp -r #{tmp}/fonts/ #{dist}/fonts"
    sh "cp -r #{tmp}/js/    #{dist}/js"
    sh "cp -r #{tmp}/less/  #{dist}/less"

    sh "rm -rf #{dist}/js/tests"

    sh %Q[echo '@import "bootstrap/#{tag}/less/bootstrap";' > #{dist}.less]

    Dir.chdir tmp do
      files = "package.json docs/*.html docs/_layouts/*.html docs/_includes/*.html docs/examples/*/index.html"

      sh %Q[sed -i '' -f #{dir}/script/sed/bootstrap.clean.sed #{files}]

      # Remove tracking scripts
      sh %q[sed -i '' -e '/^<script>/,/^<\/script>/d' docs/_includes/*.html]

      sh "rm -rf node_modules"
      sh "npm install"
      sh "grunt"

      sed = "sed -i '' -f #{dir}/script/sed/bootstrap.erbify.sed"

      sh "find ./_gh_pages -type f -name *.html -exec #{sed} '{}' \\;"
      sh "find ./_gh_pages -type f -name *.html -exec mv '{}' '{}'.erb \\;"
    end

    FileUtils.mkdir_p "#{dir}/app/assets/vendor/bootstrap/#{tag}"
    FileUtils.mkdir_p "#{docs}/#{tag}"

    sh "cp -r #{tmp}/_gh_pages/ #{docs}/#{tag}"
    sh "mv #{docs}/#{tag}/assets               app/assets/vendor/bootstrap/#{tag}"
    sh "mv #{docs}/#{tag}/examples/screenshots app/assets/vendor/bootstrap/#{tag}/img/"
  end

  task :distclean, :tag do |t, args|
    abort "\nNo tag specified: e.g. rake bootstrap:distclean[v3.3.1]".red unless tag = args[:tag]

    dist = "app/assets/styled/bootstrap/#{tag}"

    sh "rm -rf #{dist}"
    sh "rm -rf #{dist}.less"
    sh "rm -rf #{dist}.coffee"

    sh "rm -rf app/views/styled/bootstrap/#{tag}"
    sh "rm -rf app/assets/vendor/bootstrap/#{tag}"
  end

  task :clean do
    sh "rm -rf #{tmp}"
  end
end

namespace :fontawesome do
  tmp   = "tmp/fontawesome"
  dir   = Styled::Engine.root

  fonts = "app/assets/fonts/font-awesome"
  css   = "app/assets/stylesheets/font-awesome"

  tag = "v4.5.0"

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
