---
title: "Redundancy in Amazon EC2"
type: blog
date: 2014-09-15 09:00:00
layout: post
tags:
- AWS
- HA
taxonomy:
    tag: [backup]
lang: us
---

*This article deals with redundancy in multi-AZ setup on EC2. Deal efficiently with AZs outages. Applicable to many others deployment styles.*

----
<center markdown='1'>
![][image-1]
</center>

AWS is the branch of a company everybody knows.

Amazon, not only selling books, DVDs and shoes has also one of the greatest numbers of virtual servers to rent in the world. Some say that the name Cloud has been invented because of AWS. Their servers are located all [around the world][1]. In each region, they own several data-centers connected together by high speed links, and to the internet via different peers. Their electric connectivity is also different and AWS calls that **availability zones**. A given zone can communicate with its neighbors, but Amazon guarantees you that no two zones should break at the same time (although such issue has already arrived in the past).

Because each zone contains vastly different hardware depending on the time they were built, Amazon cloaks the zone names and gives to the customer only a single letter to identify it: for example, in *US-EAST1*, you have *a*, *b*, *c*, *d* and *e*. These letters are  randomized for each customer so that *a* might be *d* for another, in order to prevent you from trying to abuse the AZ that contains the most recent hardware.

Some [mad people have managed][2] to identify the zones uniquely, but this is usually useless. What really matters is: how **healthy** is a given zone ?

When a representative sends you an email informing you that a some zone is about to close, you sometimes wish you’d known that earlier so that you started abandonning the zone before it started creating problems in your monitoring or something else. Apart from the dying hardware, dying zones can mess your connectivity, DNS, and other curious stuff. So if you see something curious, ask the support, or your representative, it can save hours of headaches…

However, these stories about broken underlying infrastructure are not really important on a day-to-day basis. Usually, traffice between the AZ is smooth and fast and everything.

Except when there is…

### an AWS outage !
<center markdown='1'>
![][image-2]
</center>

There are all sorts of AWS outages. Because this system is using hundreds of different technologies, there are a lot of places to crash, burn, lose power or connectivity.

Sometimes a thunderstorm will knock out an AZ, or a flood, or some catastrophic failure somewhere in the virtual disk routing and your servers (or other’s servers) that will inevitably strike your servers out after a while.
You [can know when this happens][3], because Netflix, Pinterest and others big players break badly and all the press cries *OMG ! Why is Amazon selling servers although its core business is to sell books !!!!*.

If you are lucky, you can escape these nasty consequences.

## Vertical AZ stacking

<center markdown='1'>
![][image-3]
</br>
_my stack looks nicer._
</center>

In order to be resilient in case of a missing zone, redundancy must be organized between each of these. In a given zone, you must be able to run your application inside the zone. With no interaction with the outside world.

This implies several things :

- your frontend should be using an external load-balancer or an ELB (Elastic Load Balancer, provided by AWS). Using the ELB ties you even more to AWS (and some think this is a [bad thing][4]), but its usefulness is quite high as we will see later
- Every database should be reachable from the given zone and be hosted in this zone.

If you deploy a simple service without paying attention to this, you can end up in this configuration: everything in a **single zone**, with no dependency on the outside world. If the zone breaks, your application will **stop working**.

## Cross-AZ databases

<center markdown='1'>
![][image-4]
</br>
_ Old-school database._
</center>


If you manage to deploy everything in another zone, you have two identical services on two zones, but with **two** distinct databases. And this is probably not what you want.

So you have to replicate your database in each zone, and possibly setup some complex failover schemes. At fotopedia, we were using **Multi-AZ RDS** instances and a **replicated MongoDB** cluster.

### MySQL

Multi-AZ RDS instances are MySQL servers running in pair, one master and one slave, on two distinct AZs. This way, if one AZ becomes unreachable, the slave can become master quickly enough for your service to be still available. The switch is performed by AWS when it detects a failure, and takes  few minutes. Over the course of more than 4 years of usage in production, we had issues once with a slow switch between the master and the slave. And never when the rest of AWS zones was broken (**the EBS episode** didn’t affect them for example)

### MongoDB

Our MongoDB cluster was a « simple » tri-replicated cluster. Because we had some sharded tables, we had also config servers and supervisors on the grid. The MongoDB recommendation regarding config server is to have either 1 of 3. Conveniently, we were using 3 zones on AWS and we had one config server in each zone.

If one or two config servers become unavailable, the cluster’s metadata becomes read only and you cannot move data between the servers. If all three config servers are unavailable, you can still use the cluster if you do not restart the mongos supervisor. This is what’s written in the official [MongoDB documentation][5].

The use of supervisors and 3 replicas meant that our data were propagated on the three zones we were using and if a master would disappear, another master would quickly take the relay. A _nice thing_ with the mongos is that you don’t really have to know who is the master to talk to him or to one of the slave. All the communications goes through the mongos itself.

Once you have performed this step, you have a setup that allows you to have the same service running on different zones, while sharing the same database.

Some other stuff need to be taken in account if your application is a website: sessions should be persisted in a shared database, uploaded assets must be sent on a CDN to be available from anywhere… But you probably already do that, don’t you ?

## Cross-AZ Networking

<center markdown='1'>
![][image-5]
</br>
_Network packets and cables._
</center>

In front or your frontends, you should have some kind of proxy that is very very resilient. It should be able to load-balance your traffic, deal with broken frontends automatically and be pretty much  invulnerable to most network attacks. The AWS ELBs do fulfil this quite well and its integration with the rest of the AWS services makes it a very good product. During all the outages that Fotopedia had to cope with, it was never something due to the ELBs. YMMV and you could want do run this outside EC2, but with a probable higher complexity...

Frontends must have the ability to connect to any zone and cope with local zones difficulties. For example, if your local connectivity is bad (for some reason), you might want to allow all your HTTP middleware to use alternate routes by using other zones. For example, you can configure nginx to [send errors to another proxy][6] by using **proxy\_next\_upstream\_error**.

You need to carefully configure the various connect and read timeout, but this allows you to divert requests to other zones from a fronted that’s inside a broken one.

[HAProxy][7], my favorite piece of software for the Internet will also help you spreading requests to the servers which are faster, or less busy.  You can use [Option redispatch][8], the very nice [leastconn][9] parameter and another set of timeout. Redispatch will run again requests that can be replayed (should be GETs/HEADs but no **POSTs**), while leastconn is a very efficient parameter to balance the load properly on slow backends and almost detect faulty backends naturally.

Likewise, if you use [Varnish][10], the **round-robin director** will ensure your requests are spread on all backends.

## Conclusion

The idea is to create some kind of internal mesh between your servers layers. Be it in 3 availability zones, or 3 servers, or 3 continents. The scale is up to you, and these examples are just the foundation of what could be tomorrow, your 100% uptime infrastructure. The timeout settings are very important here, because they will have a direct impact on how your infrastructure reacts in case of emergency. Low timeouts means great reactivity, but more false positives. And higher timeouts will endanger your uptime… As usual, it’s a tradeoff you’ll have to make.

## Further readings
<center markdown='1'>
![][image-6]
</center>

- The [Netflix chaos Monkey][11] is a brillant example of how to design your infrastructure and its surrounding to withstand any external issue.
- The [High Scalability blog][12] is also filled with a lot of interesting articles and techniques.



[1]:	http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html
[2]:	http://alestic.com/2009/07/ec2-availability-zones
[3]:	http://aws.amazon.com/fr/message/67457/
[4]:	http://www.rightscale.com/blog/cloud-management-best-practices/aws-outage-lessons-learned-if-netflix-can-suffer-so-can-you
[5]:	http://docs.mongodb.org/manual/core/sharded-cluster-config-servers/
[6]:	http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_next_upstream
[7]:	http://www.haproxy.org/
[8]:	http://cbonte.github.io/haproxy-dconv/configuration-1.5.html#option%20redispatch
[9]:	http://cbonte.github.io/haproxy-dconv/configuration-1.5.html#4.2-balance
[10]:	https://www.varnish-cache.org/trac/wiki/LoadBalancing
[11]:	https://github.com/Netflix/SimianArmy/wiki/Chaos-Monkey
[12]:	http://highscalability.com/

[image-1]:	http://fa.oct.zoy.org/flickr/5660237957
[image-2]:	http://fa.oct.zoy.org/flickr/747769467
[image-3]:	http://fa.oct.zoy.org/flickr/4815088397
[image-4]:	http://fa.oct.zoy.org/flickr/3019398315
[image-5]:	http://fa.oct.zoy.org/flickr/474313512
[image-6]:	http://fa.oct.zoy.org/flickr/2988029832
