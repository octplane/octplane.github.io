require "rubygems"

desc "Deploy to Zoy"
task :deploy do

  puts "## Generating site"
  system "jekyll build"

  cd "_site" do
    system "rsync -az --exclude='.git/' . oct@zoy.org:/var/www/org/zoy/oct/htdocs/"
    system "ssh oct@zoy.org -C 'chmod -R +r /var/www/org/zoy/oct/htdocs/'"

    message = "Site updated at #{Time.now.utc}"
  end
end
