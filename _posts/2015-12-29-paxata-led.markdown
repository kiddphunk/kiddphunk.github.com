---
published: true
title: making blinky things
layout: project
category: projects
tags:
    - blog
    - code
    - life
    - pixels
tools: [Custom software, Hand-crafted cabinet, FadeCandy controller, NeoPixel LEDs]
bgcolor: ca1cf7
iid: paxataled
image: /images/projects/paxled/detail.jpg
parallaximage: /images/projects/paxled/paxled_parallax.png
parallaxoffset: 0
parallaxduration: 800
parallaxpercent: 50
bottomimage: /images/projects/paxled/detail2.jpg
shoutout: "Finite Shapes ⤳ Finite LEDs ⤳ Infinite Patterns"
fbcomments: true
share: true
---

<style>
.parallax-window {
    min-height: 400px;
    background: transparent;
    display: inline-block;
    height: 400px;
    width: 700px;  
    margin-left:-250px;
}
.parallax-mirror {
    z-index: 1!important;
}
.fullbox.last img {
    margin-left: -20%;
}
</style>

<p>I wanted to play around with the latest LED and microcontroller tech, so I decided to make a little decoration for my desk at work. 
</p>
<p>
Our company's logo was a perfect shape and complexity for a first-project, and the shape could offer myriad light-animation possibilities for my coding creativity:
</p>

<img src="/images/projects/paxled/paxata_logo.png"/>

<b>TL;DR final result</b>

<div class='topnote'>
    <img style='transform:rotate(180deg);background-size: cover; width: 702px;margin-left: -252px;'  src="/images/projects/paxled/process/Untitled3.gif"/>
    <p>My desk is now officially ready for parties! </p>
</div>

<b>Here is a quick glimpse into the creation process</b>

<p>
I settled upon one-light-per-circle in the outer circles, with a dense <a href='https://en.wikipedia.org/wiki/Phyllotaxis'>phyllotaxis</a> pattern in the center (a la sunflowers):
</p>

<img src="/images/projects/paxled/phyllotaxis.png"/>



<!-- <img style='margin-left:-30px;background-size: cover;width: 100%;' src="/images/projects/paxled/process/collage1.png"/> -->


<div id='img2' class="parallax-window" data-parallax="scroll" data-image-src="/images/projects/paxled/process/ejRc6.jpeg"></div>

<div class='topnote'>
    <p>I found reflective steel containers online in the correct diameters and drilled holes in them for each single LED.</p>
</div>

<div id='img11' class="parallax-window" data-parallax="scroll" data-image-src="/images/projects/paxled/process/IMG_4454.JPG"></div>


<div id='img6' class="parallax-window" data-parallax="scroll" data-image-src="/images/projects/paxled/process/IMG_3409.JPG"></div>

<!-- <img style='background-size: cover; width: 702px;margin-left: -252px;' src="/images/projects/paxled/process/rpbCi.jpeg"/> -->

<div id='img26' class="parallax-window" data-parallax="scroll" data-image-src="/images/projects/paxled/process/rpbCi.jpeg"></div>
<div class='topnote'>
    <p>Envisioning the ultimate layout.</p>
</div>


<div id='img3' class="parallax-window" data-parallax="scroll" data-image-src="/images/projects/paxled/process/IMG_3395.JPG"></div>

<div class='topnote'>
    <p>Testing the capabilities of the FadeCandy controller.</p>
</div>


<div id='img4' class="parallax-window" data-parallax="scroll" data-image-src="/images/projects/paxled/process/IMG_3396.JPG"></div>

<div class='topnote'>
    <p>Checking the optics and light-transmission properties of Tyvek.</p>
</div>
I tested various materials for the front covers before choosing a double-layer of a plastic sheet from a huge roll that I previously found at a thrift-store. 

I used my <a href='http://cricut.com'>Cricut</a> cutting machine for the perfect -and numerous- circles necessary.

<div id='img10' class="parallax-window" data-parallax="scroll" data-image-src="/images/projects/paxled/process/IMG_3458.JPG"></div>
<div class='topnote'>
    <p>Circles cut, ready for eventual superglue.</p>
</div>



<div id='img7' class="parallax-window" data-parallax="scroll" data-image-src="/images/projects/paxled/process/IMG_3440.JPG"></div>
<div class='topnote'>
    <p>Drilling these 60+ holes was the least fun part of this whole project.</p>
</div>

<div id='img8' class="parallax-window" data-parallax="scroll" data-image-src="/images/projects/paxled/process/IMG_3443.JPG"></div>
<div class='topnote'>
    <p>Placing and anchoring the inner LEDs.</p>
</div>

<div class='topnote'>
<img style='background-size: cover; width: 702px;margin-left: -252px;' src="/images/projects/paxled/process/IMG_3446.gif"/>
<p>Testing the dozens of inner phyllotaxis LEDs with a simple color cycle.</p>
</div>



<!-- <div id='img12' class="parallax-window" data-parallax="scroll" data-image-src="/images/projects/paxled/process/IMG_4456.JPG"></div>
 -->


<div class='topnote'>
    <img style='background-size: cover; width: 702px;margin-left: -252px;'  src="/images/projects/paxled/process/IMG_4469.gif"/>
    <p>Testing the custom software that drives the <a href='https://www.adafruit.com/product/1689'>FadeCandy controller</a>.</p>
</div>

<div id='img14' class="parallax-window" data-parallax="scroll" data-image-src="/images/projects/paxled/process/IMG_4470.JPG"></div>

<div class='topnote'>
    <p>Wiring up the LEDs to the spiral arms. </p>
</div>

<div id='img15' class="parallax-window" data-parallax="scroll" data-image-src="/images/projects/paxled/process/IMG_4481.JPG"></div>

Everything is affixed to a clear Lucite-type plastic panel (cans on one side / wiring on other), which was an interesting look by itself, but not at all anchored solidly.


<div id='img16' class="parallax-window" data-parallax="scroll" data-image-src="/images/projects/paxled/process/IMG_4489.JPG"></div>

<div class='topnote'>
    <p>Filling in the negative space with space-filling gap-sealer. </p>
</div>

<div id='img17' class="parallax-window" data-parallax="scroll" data-image-src="/images/projects/paxled/process/IMG_4492.JPG"></div>


<div id='img18' class="parallax-window" data-parallax="scroll" data-image-src="/images/projects/paxled/process/IMG_4493.JPG"></div>

<div class='topnote'>
    <p>Prepping for painting ... </p>
</div>

<div id='img19' class="parallax-window" data-parallax="scroll" data-image-src="/images/projects/paxled/process/IMG_4494.JPG"></div>

<div class='topnote'>
    <p>... painting ... </p>
</div>

<div id='img20' class="parallax-window" data-parallax="scroll" data-image-src="/images/projects/paxled/process/IMG_4499.JPG"></div>

<div class='topnote'>
    <p>... finished painting! </p>
</div>

<div class='topnote'>
<img style='background-size: cover; width: 702px;margin-left: -252px;' src="/images/projects/paxled/process/collage1.png"/>
<p>Will have to replace some covers that were accidentally painted.</p>
</div>



<div class='topnote'>
    <div id='img21' class="parallax-window" data-parallax="scroll" data-image-src="/images/projects/paxled/process/IMG_4511.JPG"></div>
    <p>A good solution for transporting this was essential. </p>
</div>



<div class='topnote'>
    <img style='background-size: cover; width: 702px;margin-left: -252px;'  src="/images/projects/paxled/process/IMG_4725.gif"/>
    <p>It was a lot of fun to figure out an appropriate "power-on" sequence animation! </p>
</div>

<p></p>

<b>The Software</b>

* simple web-based UI written in Coffeescript, talking to a local FadeCandy server

* allows the user to assign any number of tags (<i>"arm1", "size4", "xPos", "yPos"</i>) to each LED light

* a set of lights with a given tag is a [collection]

* a set of such collection is a [collection of [collection]s]

* a [color source generator] generates a continuous stream of colors (eg rainbow cycle, fire-colors, etc)

* a [color source generator] feeds ⤳ [collection of [collection]s]

This allows me to isolate things to animate (<i>"the third arm", "all outer circles", "the 4th pixel in the phyllotaxis center"</i>) with the various color generators.

There is also a movie-playback mode where a media file can be loaded and the colors mapped onto the LED space - <i>"sunrise / sunset compilations", "psychedelic/fractal compilations", "demoscene demos"</i> can be so good!


<div class='topnote'>
    <img style='background-size: cover; width: 702px;margin-left: -252px;'  src="/images/projects/paxled/process/desk.gif"/>
    <p>Showing movie mode with an <a href='http://electricsheep.org'>Electric Sheep</a> animation. My robot army is clearly pleased.</p>
</div>
