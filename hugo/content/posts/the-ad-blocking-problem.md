---
title: 🚮 The Ad Blocking Problem
date: 2022-01-23
---

# How I'm currently blocking Ads at home, and why?

In this article, I'm writing about the various solutions I've recently explored to block ads and I also describe the solution I'm currently using!

# Pi-hole

[Pi-hole](https://pi-hole.net/) is a cool open source project to block ads on your whole network. You set this up on a small Raspberry Pi (hence the name, heh), and then reconfigure your internet to use the pi-hole as your primary DNS, it will then nuke carefully all DNS requests sent to this tracking and ads endpoint. Make sure you whitelist your company corporate domain names or else working will get a little more complicated.

This failed for me because it requires a running Pi somewhere and I did not had the space and time to set that up (akin to setting up a Unifi controller on a dedicate Pi, but this is another story). I trie to setup the app on a Synology, with the Docker bridging, port-forwarding annoying setup and the fact that my Orange box does not provide network wide DNS override, probably because they don't want us to access [the Pirate Bay](https://thepiratebay.org/index.html) made the setup clunky. I also encountered slow response times, which are when you want to reach a site, extremely annoying. So this is a NO ⛔.

# Adlock

It's one of these services that remains on sale forever, and makes you immediately suspicious of it. I bought a 5 years/5 devices licence to them for a very cheap price (around 50€). Adlock comes with an nice-ish iOS application. In some places, the 🇫🇷 translation is slightly broken and often, it just feels like you're staring at an embedded WebView.
They implement the standard filtering mechanism available on iOS and this works well. For laptops and if you want the _advanced_  protection they also provide a VPN that is used to tunnel, I think, all the traffic from your device to the internet.

That's a working way to filter all ads system-wide but it comes with some horrible privacy and performance concerns that quickly made the use of this product very difficult for me. The performance hit, although it seems that the VPN is just going to localhost was atrocious, so I quickly stopped using the tool. ⛔


# NextDNS

This tool arrived in my Twitter stream and I was immediately interested. This is a 3rd party DNS, which is certainly a bit annoying on the privacy standpoint, but certainly not really worse than using Orange's DNS.

NextDNS setup is very easy on a macOS laptop as they provide a dedicate App that will use a VPN profile to setup their custom DNS configuration.

If you don't want to use the, and if you have ipv6. You can start using them without any account by just going to their [setup page](https://my.nextdns.io/start). They'll give you ipv6 DNS server names you can add to your network panel in a few clicks and keys and off you go! The UI will immediately refresh to indicate you are using the correct Setup. The same also exists with ipv4 and DNS over HTTP. In all cases, their documentation is extensive and pretty good.

After that, they provide a nice view of your blocked traffic with many statistics directly on their website.

{{< figure title="The reporting UI" src="/Screenshot%202022-01-23%20at%2023.16.56.png" >}}

On iOS, they also provide a DNS provider app that will allow you to enable NextDNS globally.

They offer a generous quota of 300k requests per month and their paid plans seem reasonable. If you ever want to try it, this [affiliated link](https://nextdns.io/?from=eutth2v5) might or might not be useful.

So far, this is a yes! ✅
