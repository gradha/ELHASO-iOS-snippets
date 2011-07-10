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

The files
*********

For the purpose of tracking external source code, I recommend you to create an
``external`` subdirectory at the root of your own project. Then, you can either
download and copy this repository there under the name ``ELHASO-iOS-snippets``,
or you can checkout a submodule. For the git submodule you would do::

    cd Your-project
    mkdir external
    git submodule init
    git submodule add \
        git://github.com/gradha/ELHASO-iOS-snippets.git \
        external/ELHASO-iOS-snippets

These commands would create an ``external`` directory and populate it with the
source code. For the github url of the repo you could use my repo, or you could
fork it and use your own. This is recommended: if I removed my repo, yours
would still live, and it is also more obvious to watch/track different changes
among repositories.

If you are *not* using git, I recommend you to modify the ``README.rst`` file
and make it contain a timestamp, date, or github checkout sha-1 so that in the
future you know if new versions have been released by comparing this mark.


Your Xcode project settings
***************************

Now that the files somehow live inside your project, you have to tell Xcode to
find them. For testing reasons, add the following line to one of your **.m**
files::

    #include "ELHASO.h"

After this change your project should not build due to errors. Open the
project's information, and in the **Build** tab find the **Header Search
Paths** setting. Add to this value (if you already have other settings) the
following line::

    external/ELHASO-iOS-snippets/src

After this change your project should build again. However, this will only work
for the header files, since the source code is still not being linked by Xcode,
and therefore using any of the categories will fail during the link phase.
Create in your project's file tree a new **external** group. Then, right
clicking on the group select "**Add/Existing files...**". Navigate and add the
``src`` subdirectory. You don't want to include anything else like this README
or the example directory.

Now using a category in your project should work.  However, the project outline
looks weird with this **external/src** branch.  Rename the **src** part to
**ELHASO-iOS-snippets** (or something shorter) so you can recognise it more
easily. This will not affect your build, since Xcode groups don't necessarily
match directories and/or files.  Now you can include any other file like
``NSArray+ELHASO.h`` in your source code and use their code.

One last step would be to define custom macros for your project, since there
are some preprocessor tricks used by this code. In your project's build
settings look for the gcc option "**Preprocessor Macros**". Before changing
anything, verify that instead of "**All configurations**" selected in the
listbox you are on either **Debug** or **Release**. Define the following
macros:

* For Debug settings: **DEBUG**
* For Release settings: **NDEBUG**, **NS_BLOCK_ASSERTIONS** and **RELEASE**

If you don't define these preprocessor macros for your projects handy macros
like DLOG or RASSERT may not do what you expect them to do. Feel free to leave
other of your macros or add your own.


Framework dependencies
**********************

Your application needs to link against the UIKit framework (which probably
already does). If you want to use the CLLocation categories, you will have to
also link against the CoreLocation framework, or you will get link errors. If
you don't want to use CoreLocation, simply uncheck in XCode the inclusion of
the ``CLLocation+ELHASO.*`` files for your target build target.


Documentation
-------------

At the moment the documentation is embedded in comments in the source code. I
will provide doxygen docs at some point. Included in the source code tree there
is an example which tests all the functions provided by the numerous categories
included. You can treat this as working documentation. Check the
``run_*_tests`` methods of ``example/src/View_controller.m`` and the output
they generate in the debug log.


License
-------

The file Base64+ELHASO.m and it's header file were taken from
http://www.cocoadev.com/index.pl?BaseSixtyFour and are copyrighted by
cyrus.najmabadi@gmail.com who put them in the public domain. The file is
included for the get_image* methods from NSDictionary+ELHASO.m. You can remove
this method and the Base64 code if you need to.

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
