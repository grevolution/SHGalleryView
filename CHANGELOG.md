## 0.0.8 (Feb 28, 2015)


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
