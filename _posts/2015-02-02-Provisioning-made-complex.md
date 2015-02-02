---
title: "Provisioning made more complex"
date: "2015-02-02 18:00:00"
layout: "post"
tags:
- code
lang: us
---
<center>
![Your favorite cookbook](http://fa.oct.zoy.org/flickr/5777089720)
</center>

Something’s going wrong. 

I, as devops, or root, or whoever is in charge of configuring these servers, have to admit that there are now a LOT of provisionning tools available for us to work. This is probably a good thing in general (although looking at the number of js frameworks and the state of js development shows that this can be a bad thing) but one can but wonder: 

**WHICH ONE AM I TO USE ?**

And the fact is that each of them has its niceties and weaknesses. Most of them are backed by more or less large companies that can deliver certifications, support and everything cash can buy. But the truth is that chosing the right framework is difficult without too much prior experience. Our choice includes:

- [cfengine][1]
- [puppet][2]
- [chef][3]
- [ansible][4]
- [salt stack][5]

Each of these tools will have you deploy daemons, clients, SSL certificates, HTTP proxies and write some code before you can decide if the framework is for you. The technological price is quite huge and next times somebody trolls you with the fact that you are using 70% of the AWS services for your infrastructure, ask this ugly person whether its provisioning infrastructure is not « vendor-locked » too. 
Your provisioning tool must have some special abilities to be useful to you:

- it should run quickly on your grid, without creating too much load on the master, is it needs a master. Most time is spend in I/O, but sometimes, synchronous starts will load the master a lot: the underliying technology can become a problem (I’m looking at you ruby).
- it should be able to run « on-demand » so that you can trigger a grid update whenever
- It should be resilient. On this point, I tend to favorize provisioning tools that are not using the same language as my main platform application, if possible. This way, when you starts messing with runtime versions, you can be sure your provisioning tools will still be running… Deploying a ruby `include` fix on 30 servers by hand is painful, especially if you don’t have any [csshx][6] configuration around.
- It should be able to do some magic for you: you want to be able to add a frontend server on your grid and have the whole cluster reconfigured to use this new server automatically. This usually requires a search-capable master server for your provisioning (incompatible with master-less tools ?)
- It should be able to generated all your monitoring configuration from its own state.
- It should converge quickly. 2 steps convergence can be a PITA when you are in a hurry (incompatible with imperative tools?)
- Its logs should be easily accessible, centralized and API-manageable so that you can build a dashboard (or have it built-in?) with the state of the runs on your grid, have the ability to restart individual runs on servers.

Last time I checked, `chef` was almost the right tool and `ansible`, very close to it. But I’m still looking for the next tool…

What’s your favorite provisioning tool? And Why?




[1]:	http://cfengine.com/
[2]:	https://puppetlabs.com/
[3]:	https://www.chef.io/chef/
[4]:	http://www.ansible.com/home
[5]:	http://saltstack.com/
[6]:	https://code.google.com/p/csshx/