---
title: Seeing the hidden digitakt II splash screens
date: 2026-09-26
---

The other day, I had a few LLM tokens to spare and I wanted to see how complicated was the Digitakt Firmware. So I run my favorite model at it and we started digging into the guts of this nice software.

After some exploration, I decided to see if I would be able to change the splash screen for something else (when I was younger, my first ever act of modifying an Atari ST game had been to update the strings directly with a disk editor and it had kinda worked...).

I started digging into the bitmap assets, until I realized that the splash screens were animated, so probably not available entirely as images (I was in the train, away from the machine). I pointed the model at the initial startup sequence, after the boot and we quickly found a section that looked like it was calling a function to display the splash screen. But then, something weird surfaced: there were not one, but FIVE draw routine, and a random number generator picking one of them at each startup.

But the probabilities were, oh my, not well balanced:

- The one we all know: 99.902% of change to show up
- B: 1 chance out of 2048
- C:  1 chance out of 4096
- D: 1 chance out of 32772
- E: 1 change out of 4680

Armed with this knowledge, I un-syxed the ROM, unpacked it and we carefully modified a few bytes in the ROM to balance the probabilities.

I rebuilt the syx using tools you can find on the internet and updated my machine.
I had a new splash screen (this is E if you want to know):

![](/2026-09-26/IMG_3417.jpg)

But reboot after reboot, the same screen was coming again. I poked the code again and the hypothesis was that the LCG (Linear Congruent Generator) was not properly seeded:

```C
seed = seed * 1103515245 + 12345      (mod 2^32, via 32-bit overflow)
return (seed >> 16) & 0x7FFF          (top bits, masked to 0..32767)
The implementation was always returning the same value, because it was never seeded.
```
The next step was to update this small generator to seed it with something coming from the hardware:

```C
seed = seed * 1103515245 + <LIVE COUNTER>
```

With the agent, we picked `0xFC07000C`. the counter register of DMA Timer 0 on the ColdFire MCF54415.

We repacked the firmware, rebuilt the syx file, reflashed and... we HAVE THE FIVE SPLASH SCREENS OF THE DIGITAKT II!
(it's probably trivial to update the one that use a static image, but for now, I'll just enjoy the random splash screen at each startup <3

![](/2026-09-26/IMG_3417.jpg)
![](/2026-09-26/IMG_3414.jpg)
![](/2026-09-26/IMG_3415.jpg)
![](/2026-09-26/IMG_3416.jpg)
![](/2026-09-26/IMG_3412.jpg)

Go further:
- https://github.com/octplane/digitakt-ii-splash-screens
- https://github.com/mischa85/elektron-firmware-tool
