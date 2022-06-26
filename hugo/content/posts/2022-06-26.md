---
title: 🏢 Hiring at Datadog
date: 2022-06-26
lang: en
draft: false
summary: Hiring is tough. This article describes my interviewer's experience at Datadog.
---

_This article describes my interviewer experience at Datadog. It explains the process that was in place at that time, how this was done, and some of its limitations. It's a memory dump after I've left for one year, so things may not be exactly like this today!_

I stayed 4 years at Datadog, which in dog's years, represents almost 30 years. I joined in mid-June 2017 and left Paris for Bordeaux to become a full-remote late august. Soon after that, I started doing interviews for the company. At that time, we were around 300 people and we were hiring like crazy. I left in mid-2021 and **Datadog was a solid 2500+** good little puppies.

So there was a lot of need for hiring interviewers. Although being more senior than most of my colleagues, I was hired only as a Software Engineer (not Senior) in the company but I had some previous experience in hiring and I was soon asked to help with recruiting. I started doing two kinds of interviews for the company: the Technical Phone Screen and the Take Home review. During my tenure, I did more than **62 Technical Phone Screen Interviews and 68 Take Home reviews**. Contrary to what I had expected, doing these interviews was not mandatory for all the most-senior engineers and absolutely no career bonus or advantage was given to the people doing a lot of interviews. Only the recruiting staff was appreciative of our time. Another surprising way for the company to take care of its interviewers.

Datadog has a long and complicated hiring process which can sometimes be felt as being a bit slow. It usually starts with a call with a recruiter that's going to try and frame your skills and your asks (particularly the financial one, heh) and unless you are not fit for the job, you'll be invited to the Technical Phone Screen.

After the Technical Phone Screen, you are given a Take Home test to do on your own. This is your occasion to shine by producing something you should be proud of. When I did the Take Home to get hired, I did a Rust application and spent nearly 12 hours writing the code, benchmarking the solution, and producing a PDF for my reviewer to be amazed.

After the Take Home, passing candidates were asked to come to an office and have a few more interviews with members of the teams and managers about various specific topics (design, system, ...), have lunch with the potential future team, and a final interview with the hiring manager.

I was sent to New York for that and lived 3 wonderful days there. I met with Seth Rosenblum, Andrew Glenn Young, Chris Hoey for the interviews, and finally Alexis. We did the last interview in French and this was both exciting and disturbing after several hours of English-speaking interviews!

## ☎️ The Technical Phone Screen

This second interview lasts at most one hour and is a series of simple exercises to perform over a web editor (https:/coderpad.io/). The interview starts with a few minutes of introduction from the interviewer and the interviewee and then both dig into some achievements the interviewee wants to share. This is the occasion for the interviewer to assess the depth and breadth of the candidate, and see if other skills are also part of the candidate's strengths. 

There was never any formal way to evaluate this "achievement", as we were only asked to decide if this was a small/large/huge achievement. Needless to say, the evaluation between interviewers were varying a lot from one to another for the same achievement. Many candidates either brought their pet projects which usually were pretty small or a particular result of their work which too commonly involved only themselves across a period of a few weeks. For me, the main objective of this introduction was to frame the candidate's overall technical skills and see evaluate his seniority level. Also, this was a good moment to let the candidate feel more at ease and be more ready for the next part.

After this nice and easy 20 minutes introduction, the candidate was thrown into Coderpad and had 2 problems to solve, one slightly easier than the second. Both usually involved some kind of data structure manipulation and were relatively easy. Top performers were able to finish each exercise in less than 5 minutes, from start to finish, including the optional and weird question about the Complexity and sub-par candidates who struggled to finish the first one in the remaining 40 minutes. Each exercise could usually be solved with less than 10 lines of any reasonable language for that kind of test (scripting languages were probably a better fit, although I've seen Rust and Haskell candidates just breezing through these). For every exercise, we were encouraged to let the candidate try to find his way and then nudge him in the right direction, should she be lost or going in the wrong direction. This part was usually pretty easy to judge from an interviewer's point of view. Most candidates were more stressed than usual and this led to lower performance than usual if you were taking this for granted, it was relatively easy to see if a candidate was going to nail it or fail after only a few minutes.

After the second exercise, the candidate had all the opportunity to ask any question about anything. This part was usually the one that also provided solid intel about the readiness of the candidate: motivated candidates had usually at least one question at that point. If you are not even able to ask your interviewer what's his typical day to have an idea of how people work in the company you're applying to, you're probably too lazy (for me).

We then had to wrap up and close the call on the dot, meaning that slow-performing candidates were not allowed to ask questions and the final part of the interview could sometimes feel a bit quick. After that, we had to debrief the interview in Greenhouse so that the recruiter could decide whether to follow up or not with the candidate with the Take Home Test.

## 👩🏼‍💻 The Take Home Test

One unfair and complicated test.

Recruiters were giving a problem for the candidate to solve. For example, write some code that will ingest some HTTP logs in real-time and alert when there are more than `x` error requests/second and recovers when this number goes below. The problem was usually a bit vaguely framed and contained a lot of room for interpretation. 

Then, depending on the recruiter, the emphasis was put on the fact that the candidate could ask questions before jumping into the code, or on the fact that this should be done in less than 4-6 hours of work (a jokingly short amount of time). This meant that every candidate had a different set of constraints and this gave a very large set of results.

Some sent a single python script, others a full JHipster application with its HTTP frontend, some deployed Kafka for the processing, and others went for a pure Rust version. I saw everything.

As an evaluator, these lead to several problems:
- Would this code be runnable on your work laptop (we started asking/recommending for Docker-based setup, but this never became mandatory and always caused issues with _inotify_ based code for Linux on macOS...)?
- Had the candidate provided a README that explained how he thought about the issue and how he fixed that and its prototype limitation?
- Would I be able to read the code, understand it and evaluate it against the validation grid that was provided by Recruiting?

The worst in this is that it was not expected/possible for us to be able to reach out to the candidate to ask explanation/look at the code together. So the evaluation was mostly based on the 10 checkboxes that Recruiting has written and our gut feeling on the candidate's ability to write code.

Candidates who were strictly honoring the 4-6 hours duration were handicapped compared to the candidates who were spending 10h+ on the same problem. There were PDFs, diagrams, and videos included in some of these...

## ⛈️ More issues in the back

As an interviewer, we faced many issues to build the correct judgment for a given candidate:

- We never had any feedback on our evaluation, even when a shadow interviewer was interviewing with you. This meant that there was no possible way for us to improve our evaluation techniques. Was I too gentle with the candidates, or was I on the contrary too demanding? I never knew. Did this mean that the Recruiting team was pondering our evaluations to remove the bias in our evaluations?
- We never had any knowledge of whether our evaluation led the candidate to the next step or not. Sometimes, we were saying NO to a  candidate for some reason, other times, they were pushed to the next step of the hiring process. The permissions in Greenhouse were tight and we had almost no view of the candidate's path and data.
- Some recruiters were careful and attentive to the candidates and others were not. This sometimes lead to surprising interviews, such as the time when the candidate told me after the intro phase that he was not able to write a single line of code for the interview.
- Feedback to the candidate was usually done the American Way, ie don't say too much to avoid a trial and this was damaging the Company's reputation, especially when rejected candidates had to ask several times to get feedback from the Recruiting Team. As interviewers, we were never in a position to directly exchange with a candidate. This was a measure of protection to prevent candidates from reaching out to us but I also felt this was diminishing the quality of our reviews.

Because of Datadog's structure, there was no real way to make some actionable feedback to the Recruiting team and in the 4 years I stayed in the company, I never really see an improvement in the way Interviewers were trained. Even though I asked pretty early about being able to have some feedback, only for me, I was never granted this.

When you read the [orange site](https://news.ycombinator.com/), you can see many stories of how these technical interviews are done the wrong way and I have to agree. The range of the questions that are asked are not fit for the work we do in these companies, and this seems to be very similar to the French High School selection mechanism where you have to jump through a series of hoops, and once you succeed, you can forget all this hoops-jumping knowledge as it will never be useful for 90% of it.

My overall experience with recruiting at Datadog was however very positive, even if it was sometimes a bit overwhelming: a large variety of candidates, with many personalities to get to know. In insight, it would have been amazing if the whole process had been a bit more transparent...


And in your company, how is the hiring process working? Are you interviewing?

