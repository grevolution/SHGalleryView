SHGalleryView
=============

This is a Page View Controller based Gallery for Images and Videos which you can use to showcase your media items. Images support zoom/pinch and you can play videos in the same window with custom theme for video controls.

[![Build Status](https://travis-ci.org/grevolution/SHGalleryView?branch=master)](https://travis-ci.org/grevolution/SHGalleryView)

##Changelog

###0.0.8 (Feb 28, 2015)

Features:

- Added support for portrait orientations. now the gallery will work with any device orientation.
- Added background color property in `SHGalleryViewTheme`
- Updated the example to show how to added `SHGalleryViewController` as embedded view.
- Added `UIPageControl` support (now you can either show item captions or page control)
- Added support for disabling pinch/zoom on Images in gallery.


Changes:

- Fixed implict warnings for NSInteger.
- renamed `SHMediaControlTheme` to `SHGalleryViewTheme` (code breaking change, please update your code)
- caption title and time label theme properties are now deprecated. new properties have been added for NSAttributedString support.
- the library is properly documented now for public interfaces. plesae check the docs at : [http://cocoadocs.org/docsets/SHGalleryView/](http://cocoadocs.org/docsets/SHGalleryView/)
- Example code has been updated.



////////////////////////////////

##SHGalleryView

- Video in Gallery
![image-1](https://raw.github.com/grevolution/SHGalleryView/master/wiki-images/1.png)

- Video Paused in Gallery
![image-2](https://raw.github.com/grevolution/SHGalleryView/master/wiki-images/2.png)

- Image in Gallery
![image-3](https://raw.github.com/grevolution/SHGalleryView/master/wiki-images/3.png)

##Contact Me

Shan Ul Haq (http://grevolution.me)

- g@grevolution.me

- http://sg.linkedin.com/in/grevolution/

- http://twitter.com/gfg5tek

##License

`SHGalleryView` is available under the MIT license. See the LICENSE file for more info.