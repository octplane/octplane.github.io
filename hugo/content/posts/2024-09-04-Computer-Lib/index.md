---
title: 📙 Rebuilding Computer Lib
date: 2024-09-04
lang: en
ShowReadingTime: true
---

[Computer Lib - Dream Machines](https://archive.org/details/computer-lib-dream-machines/mode/1up) is a book by [Ted Nelson](https://en.wikipedia.org/wiki/Ted_Nelson).

After I was introduced to the book, I became obsessed by the amazing layout and style of the book, that reminded me a bit of the style of [why the lucky stiff](https://en.wikipedia.org/wiki/Why_the_lucky_stiff)'s [Poignant Guide](http://poignant.guide).

I have pulled the PDF, reordered it to have its two parts correctly. Then I extracted all text with a simple OCR engine. 

{{< figure src="text-sample.png#center" title="A Scanned text sample">}}

Bad scanned text can be rebuilt using ChatGPT before final proofing:

> ‘The above seams silly, but It ie no lees silly
than talking about “computer predictions" and
"computer atudies” of things. The mere fact that
computer ie involved in something hae no bearin
on its character of validity. The way things are
done with computers affects their character and
validity, Just like the way things are done without
computers. (Indeed, merely using a computer
often hag no bearing on the way things are done.)


Becomes:

> ‘The above seems silly, but it is no less silly than talking about “computer predictions” and “computer studies” of things. The mere fact that a computer is involved in something has no bearing on its character of validity. The way things are done with computers affects their character and validity, just like the way things are done without computers. (Indeed, merely using a computer often has no bearing on the way things are done.)’

The result is pretty good.

Next, I'm working to find a way to extract all images and headings (all hand drawn) and vectorize them. Inkscape seems to be the solution for simple objects. But it takes some time. Here an unfinished sample of the Book Cover.

{{< figure src="before.png#center" title="the original PDF Cover">}}

{{< figure src="after.png#center" title="the quickly rebuilt Cover">}}

The next steps involve:
- Finding the correct fonts
- Extracting all headers and figures
- Rebuilding all text-box, headers and figure coordinates
- Refilling everything

More to come...

