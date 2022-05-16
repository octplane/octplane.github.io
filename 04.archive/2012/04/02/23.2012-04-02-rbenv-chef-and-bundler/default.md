---
title: "Rbenv, chef and bundler"
layout: "post"
permalink: "/2012/04/rbenv-chef-and-bundler.html"
uuid: "7203413174712314813"
guid: "tag:blogger.com,1999:blog-5365176712784435549.post-7203413174712314813"
date: "2012-04-02 16:03:00"
updated: "2012-04-02 16:03:51"
tags:
- ruby
taxonomy:
    tag: [backup]
lang: us
---

#### What we aim
We're trying to use <code>rbenv</code> in our infrastructure in order to achieve the following multiple goals:

- Use the latest REE ruby runtime
- Switch to Ruby 1.9 for chef
- Prepare the migration to rails 3 and Ruby 1.9 for the main web application

So far, I've managed to install rbenv system wide on the servers using <a href="https://github.com/RiotGames/rbenv-cookbook">Riot Games excellent cookbook</a>. A simple:

```
require_recipe "rbenv"
# Setup the rubies
PICOR_RUBY="ree-1.8.7-2012.02"
CHEF_RUBY="1.9.2-p318"
OPINL_RUBY="1.9.2-p318"

rbenv_ruby PICOR_RUBY
rbenv_ruby CHEF_RUBY
```

in a chef cookbook, automatically download and install these versions of Ruby in the system wide rbenv. Because I'm not ready to switch, I'm not yet setting up automatic rbenv switching:

```
# File "/home/apps/.rbenv-version" do
#   owner "apps"
#   group "apps"
#   backup false
#   content PICOR_RUBY
# end

# File "/root/.rbenv-version" do
#   owner "root"
#   group "root"
#   backup false
#   content CHEF_RUBY
# end
```

But this should go in action as soon as things works ok.

#### Next step, Gems
Because <code>Bundle</code> has some <a href="http://gembundler.com/man/bundle-install.1.html">kind of memory</a>, you should not use it to <code>deploy</code> gems from a given user if you plan to deploy another gemset in another environement with the <b>SAME</b> user later.

At fotopedia, we use `GEM_HOME` and `GEM_PATH` to change gemset because it works and it's really simple (for binaries, we use a combination of symlinks in `/usr/local/bin` and `alternative` selection provided by our Debian OS). So we actually install several gemset with the same user. The workaround to have bundler work correctly is to change its HOME when running. Ugly, but efficient:

```
script "Bundle picor gems" do
  interpreter "bash"
  user "root"
  cwd  "/tmp/"
  environment rbenv_as_hash
  code <<-EOS
# Discard previous forced state
rm -rf .bundle
export HOME=$PWD
export RBENV_VERSION=ree-1.8.7-2012.02
rbenv exec gem list bundler | grep 'bundler' || gem install bundler
cd /etc/bundler
rbenv exec bundle install --shebang ruby-local-exec --binstubs /usr/local/picorstubs
EOS
  action :nothing
end
```

This script is run when the Gemfile changes in <code>/etc/bundler</code> (our current location for the Picor gems).
the gems chefs are installed almost the same way:


```
script "Bundle chef gems" do
  interpreter "bash"
  user "root"
  cwd "/root/"
  environment rbenv_as_hash
  code &lt;&lt;-EOS
export RBENV_VERSION=ree-1.8.7-2012.02
rbenv execgem list bundler | grep 'bundler' || rbenv exec  gem install bundler
# Use this because bundle in path is 1.8 bundle
rbenv exec bundle install --deployment --shebang ruby-local-exec --binstubs /usr/local/chefstubs
EOS
  action :nothing
end
```

Once this has run, <code>/usr/local/picotstubs</code> contains the picor binary stubs ready to be used and the <code>chefstubs</code> the one for chef.

Next Step. Rewiring daemons to use one gemset according to what I need. Once the stubs are there, this might be straighforward...
