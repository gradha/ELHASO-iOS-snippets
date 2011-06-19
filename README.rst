=========================================
Electric Hands Software iOS code snippets
=========================================

:author: Grzegorz Adam Hankiewicz <gradha@argon.sabren.com>

.. contents::

.. section-numbering::

.. raw:: pdf

   PageBreak oneColumn

General
=======

It is inevitable to repeat pieces of code when you write multiple applications.
While general libs are good, there will always be snippets of code which don't
have place in a full fledged library and just end up being copied and pasted
everywhere. Then you improve some code and begin hunting all the places were
you need to replace it. Inevitably you will end up with mixed versions
everywhere and no end to the search and replace task.

This problem is even bigger in the iOS world. Due to objective C categories
(http://en.wikipedia.org/wiki/Objective-C#Categories) being similar in spirit
to header macros, at some point you will definitely say to yourself "*Damn, I
hate how NSArray doesn't have a method to get objects without throwing out of
bounds exceptions*" and write a short helper which now you are copying to every
one of your projects.

I've been there, and found that most of the time you get attached to *your*
helpers/categories/macros but it's a pain to either set up or copy everything
everywhere. Since most of my code lives now in a github repository, I've
decided to put all my little snippets of wisdom/stupidity in a single place
so I can easily update them. Using git submodules I can bring my code up to
date everywhere I use it.

Feel free to grab stuff from here into your project, or improve on it. Even if
nothing from here is useful to you, maybe the idea prompts you to make your own
repository and in the process save yourself some future pain. That's still a
win!


Installation
------------

Blah blah blah.


Documentation
-------------

At the moment the documentation is embedded in comments in the source code. I
will provide doxygen docs at some point.


License
-------

Unless otherwise stated, all the source code in this repository is available
under the MIT license (http://www.opensource.org/licenses/mit-license.php)
meaning that you can take what you want and not give back. However, you might
want to thank me buying some comercial program I wrote, and who knows, you
might even like it! You can visit Electric Hands Software at http://elhaso.com/
or the app store at
http://itunes.apple.com/es/artist/electric-hands-software/id325946567.

Here's the license template applied to the source code:

Copyright (c) 2011, Grzegorz Adam Hankiewicz.
All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
