---
title: "Redundancy in Amazon EC2"
date: 2014-09-03 09:00:00
layout: post
tags:
- AWS
- High Availability
lang: us
draft: 1
---

_This article deals with redundancy in multi-AZ setup on EC2. Probably applicable to many others deployment styles._

---- 

Amazon Web Service, the part of the company selling books that only geeks know, also known as **AWS**, is one of the leader in the Cloud providing universe. They allow the creation of Virtual Machines in [many regions of the World][1], and in each of these region, they provide several **availability zones**. Each of these zones are supposed to be isolated from the others, in the same region, while providing very high speed connectivity with them.

Because their hardware depends on the zone and region (mostly because some regions were installed earlier and thus have older hardware), and also because they don’t want all their customers to use the most modern hardware available, the availability zones (aka **AZ**) are randomized for each customer and named : *a*, *b*, *c*,… For a given customer *a* will be in fact *c* for another and so on.

Some clever and possibly mad people managed to [identify the AZs across several AWS accounts][2], but it is not very useful to be able to do so. One the thing you really want to know is how _healthy_ a given zone is.

For example, if AWS decides to shutdown a given AZ because its hardware is now old and dying, you’d like to know that quite before deploying some important stuff on it. Even if you should be provisioning your instance using Chef or one of its cousins, it might be the zone where your Chef server is running, or your monitoring tools, and then you need to move quickly.

Not doing that in a timely fashion may result in weird stuff such as having your monitoring failing regularly without any error on your platform because the underlying AWS network is not performing at 100%. Because it can take some time for you to find out the actual origin of this issue, it is something that would be *nice to have*.

In regular usage, this AZ stuff is not really important: The connectivity between each AZ of a given region is very good and the latency looks like you’re on the same subnet. For most of your work, you don’t really care.

However, there is a situation during which you care about that more than **anything**.

### AWS outages (_dramatic music ensues_) !

There are all sorts of AWS outages. Because this system is using tens of different technologies, there are a lot of places to crash, burn, lose power or connectivity.

In this article, I’ll focus on the loss of an AZ. This is something that happens. That’s quite rare but when [it does you better be ready for some mayhem][3]. Losing an AZ is very annoying if all your servers are in the same AZ, and this is one is not working correctly. Huge performance degradations, missing servers and broken network links will be one the symptoms. Sometimes, this is more subtle and a slower disk will make your database much slower and your website unreachable, and diagnosing the issue can take a lot of time.

For the sake of this article, we’ll suppose we want to be able to address a disappearing AZ. Or several.

## Vertical AZ stacking
In order to be resilient in case of a missing zone, redundancy must organized between zones. In a given zone, you must be able to run your application inside the zone. With no interaction with the outside world. Or as least as possible.

This implies several things :

- your frontend should be using an external load-balancer OR an ELB (Elastic Load Balancer, provided by AWS). Using the ELB ties you even more to AWS (and some think this is a [bad thing][4]), but its usefulness is quite high as we will see later
- Every database should be reachable from the given zone and be hosted in this zone.

If you deploy a simple service without paying attention to this, you can end up in this configuration: everything in a single zone, with no dependency on the outside world.

## Cross-AZ databasing

Then, if you deploy everything on another zone, you have two identical services on two zones, but with **two** distinct databases. And this is probably not what you want.

So you have to replicate your database in each zone, and possibly setup some complex failover schemes. At fotopedia, we were using Multi-AZ RDS instances and a replicated MongoDB cluster.

Multi-AZ RDS instances are MySQL servers running in pair, one master and one slave, on two distinct AZs. This way, if one AZ becomes unreachable, the slave can become master quite enough for your service to be still available. The switch is performed by AWS when it detects a failure, and takes  few minutes. Over the course of more than 4 years of usage in production, we had issues once with a slow switch between the master and the slave. And never when the rest of AWS zones were broken (the EBS episode)

Our MongoDB cluster was a « simple » tri-replicated cluster. Because we had some sharded tables, we had also config servers and supervisors on the grid. The MongoDB recommendation regarding config server is to have either 1 of 3. Conveniently, we were using 3 zones on AWS and we had one config server in each zone.

If one or two config servers become unavailable, the cluster’s metadata becomes read only and you cannot move data between the servers. If all three config servers are unavailable, you can still use the cluster if you do not restart the mongos supervisor. This is what’s written in the official [MongoDB documentation][5].

The use of supervisor and 3 replicates meant that our data were propagated on the three zones we were using and if a master would disappear, another master would quickly take the relay. A nice thing with the mongos is that you don’t really have to know who is the master to talk to him or to one of the slave. All the communications goes through the mongos itself.

One you have performed this step, you have a setup that allows you to have the same service running on different zones, while sharing the same database.

Some other stuff need to be taken in account if your application is a website: sessions should be persisted in a shared database, uploaded assets must be sent on a CDN to be available from anywhere…

## Cross-AZ Networking

describe monitoring/ haproxy probing / hashring for varnish / leastconn to backends / ELB
 






[1]:	http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html
[2]:	http://alestic.com/2009/07/ec2-availability-zones
[3]:	http://aws.amazon.com/fr/message/67457/
[4]:	http://www.rightscale.com/blog/cloud-management-best-practices/aws-outage-lessons-learned-if-netflix-can-suffer-so-can-you
[5]:	http://docs.mongodb.org/manual/core/sharded-cluster-config-servers/