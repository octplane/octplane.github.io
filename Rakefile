require "rubygems"

desc "Deploy to Github Pages"
task :deploy do
  puts "## Deploying to Github Pages"

  puts "## Generating site"
  system "jekyll build"

  cd "_site" do
    system "rsync -az --exclude='.git/' . oct@zoy.org:/var/www/org/zoy/oct/htdocs/"

    message = "Site updated at #{Time.now.utc}"
  end
end
