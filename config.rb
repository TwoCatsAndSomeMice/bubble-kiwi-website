env_name = ENV['APP_ENV'] || 'development'
require "environments/#{env_name}"
require_relative './lib/build_cleaner'
###
# Page options, layouts, aliases and proxies
###


set :site_name, 'bubble.kiwi'
set :site_repo, 'bubble-kiwi-website'
set :env_name, env_name
set :font_dir, 'fonts'
set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

set :url_root, ApplicationConfig::BASE_URL

if env_name == 'development'
	set :homepage_path, '/'
	set :templates_path, '/templates/'
else
	set :homepage_path, "/#{site_repo}/"
	set :templates_path, "/#{site_repo}/templates/"
end

ignore '*/__config*'

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

data.threads.each do |thread|
	proxy "/threads/#{thread[:id]}/index.html",
				"templates/generator_thread.html",
				:locals => {
					pairs: thread[:pairs]
				},
				:ignore => true
end

# General configuration

activate :directory_indexes

sprockets.append_path File.join root, 'node_modules'
sprockets.import_asset 'jquery/dist/jquery.js'
sprockets.append_path File.join root, 'node_modules/bootstrap-sass/assets/stylesheets/'
sprockets.import_asset 'bootstrap-sass/assets/javascripts/bootstrap.js'
sprockets.import_asset 'bootstrap-sass/assets/stylesheets/_bootstrap.scss'

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

activate :autoprefixer do |config|
  config.browsers = ['last 2 versions', 'Explorer >= 9', 'Safari >= 8']
  config.cascade  = false
end

# Build-specific configuration
configure :build do

  activate :build_cleaner
  activate :relative_assets
  set :relative_links, true

  activate :gzip do |gzip|
    gzip.exts = %w(.js .css .html .htm .svg .ico)
  end
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript
  set :js_compressor, Uglifier.new()

  # Enable cache buster
  activate :asset_hash, :ignore => [/touch-icon/, /opengraph/]

  activate :minify_html do |html|
    html.remove_http_protocol    = false
    html.remove_input_attributes = false
    html.remove_quotes           = true
    html.remove_intertag_spaces  = true
  end
end

activate :deploy do |deploy|
  deploy.method = :git
  # Optional Settings
  # deploy.remote   = 'custom-remote' # remote name or git url, default: origin
  # deploy.branch   = 'custom-branch' # default: gh-pages
  # deploy.strategy = :submodule      # commit strategy: can be :force_push or :submodule, default: :force_push
  # deploy.commit_message = 'custom-message'      # commit message (can be empty), default: Automated commit at `timestamp` by middleman-deploy `version`
end
