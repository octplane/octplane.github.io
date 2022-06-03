---
title: 🚨 Git GPG and notifications
date: 2021-03-30
---

{{% notice warning %}}
This article is pretty old, so be careful as its information could be out of date!
{{% /notice %}}

_this article is for macOS only._

If you use `git` and `gpg` to sign your commits, then you're probably used to sign you commits using a physical key that you have to insert and press with your finger when you are creating a commit.

Unfortunately, there is no visible feedback in the console when git awaits for a yubikey touch and this means that you can sometime miss these.

```
error: gpg failed to sign the data
fatal: failed to write commit object
```

To work around that, I wrote this [small Rust application](https://github.com/octplane/yubikey-gpg-watcher) that watches git invoking GPG and sends a nice notification when it's time for you to click.


{{< figure src="/CleanShot%202021-03-30%20at%2011.15.50.png" >}}

That's pretty useful, but you have to build the binary, run it and it's still a bit of a hack.

There is actually a much nicer way to do that and here is how you can do that too:

- create a small shell script somewhere in your home

```shell
#!/bin/bash

osascript -e 'display notification "Git wants to sign a commit!" with title "Click on your Yubikey"'
gpg "$@"
```

Change this script executable bit

```
chmod +x ~/bin/git-gpg.sh
```

And reconfigure git to use this script instead of gpg:

```
git config --add gpg.program /Users/$USER/bin/git-gpg.sh
```

And that's all! Next time you commit something and your key is needed, you'll see this notification pop:

{{< figure src="/CleanShot%202021-03-30%20at%2011.32.28.png" >}}

If you want to furthermore configure the icon, you can edit the script using the macOS script editor and then export the script as an application and change its icon manually. Grab the app I did myself here: [git-gpg-notification.app.zip](git-gpg-notification.app.zip).

The final version of the script:

```bash
#!/bin/bash

open ~/bin/git-gpg-notification.app
gpg "$@"
```

{{< figure src="/CleanShot%202021-03-30%20at%2011.47.06.png">}}

This is much nicer and more difficult to miss!

