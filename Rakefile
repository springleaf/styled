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

      files = "docs/*.html docs/_includes/*.html docs/examples/*/index.html"

      sh %q[sed -i '' -e 's|"grunt": "~0.4.2"|"grunt": "0.4.2"|g' package.json]

      sh %Q[sed -i '' -f #{dir}/script/sed/bootstrap.clean.sed #{files}]
      # sh %Q[sed -i '' -e 's|href=".*/dist/css/bootstrap.min.css"|href="//assets/themes/leafy.css?body=1"|g' #{files}]
      # sh %Q[sed -i '' -e 's|href=".*/dist/js/bootstrap.min.js"|href="//assets/themes/leafy.js?body=1"|g'    #{files}]
      # sh %Q[sed -i '' -e '/jquery.min.js/d'                                                                 #{files}]
      # sh %Q[sed -i '' -e '/ads.html/d'                                                                      #{files}]

      # # Fix asset paths in docs
      # sh %Q[sed -i '' -e 's|href="../assets/|href="/assets/bootstrap/|g' #{files}]
      # sh %Q[sed -i '' -e 's|src="../assets/|src="/assets/bootstrap/|g'   #{files}]
      # sh %Q[sed -i '' -e 's|src="assets/|src="/assets/bootstrap/|g'      #{files}]

      sh "npm install"
      sh "grunt"
    end

    FileUtils.cp_r "#{tmp}/_gh_pages", docs
    FileUtils.mv   "#{docs}/assets", "#{dir}/app/assets/vendor/bootstrap"
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
