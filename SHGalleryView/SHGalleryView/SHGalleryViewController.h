//
//  SHGalleryViewController.h
//  SHGalleryView
//
//  Created by SHAN UL HAQ on 8/4/14.
//  Copyright (c) 2014 com.grevolution.shgalleryview. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHMediaItem;
@protocol SHGalleryViewControllerDataSource;
@protocol SHGalleryViewControllerDelegate;
@class SHGalleryViewTheme;


static NSString * const kNotificationMediaPlay = @"kNotificationMediaPlay";
static NSString * const kNotificationMediaPause = @"kNotificationMediaPause";
static NSString * const kNotificationMediaStop = @"kNotificationMediaStop";
static NSString * const kNotificationMediaSliderValueChanged = @"kNotificationMediaSliderValueChanged";
static NSString * const kNotificationMediaDone = @"kNotificationMediaDone";

/**
 *  `SHGalleryViewController` shows image and videos in a `UIPageViewController` based horizontal scroll
 *  fashion. You can customize the the control using `SHGalleryViewTheme` very easily.
 */
@interface SHGalleryViewController : UIViewController

/**
 *  data source for `SHGalleryViewController`
 */
@property (nonatomic, assign) id<SHGalleryViewControllerDataSource>dataSource;

/**
 *  delegate for `SHGalleryViewController`
 */
@property (nonatomic, assign) id<SHGalleryViewControllerDelegate>delegate;

/**
 *  theme for `SHGalleryViewController`.
 */
@property (nonatomic, strong) SHGalleryViewTheme *theme;

/**
 *  set this property if you want to show the UIPageControl at the bottom of your gallery view (overlayed).
 *  if this property is true, the caption bar of the gallery will be hidden.
 */
@property (nonatomic) BOOL showPageControl;

/**
 *  set this property to enable/disable the pinch/zoom functionality on images in the gallery view. by default NO.
 */
@property (nonatomic) BOOL disablePinchAndZoomOnImages;


/**
 *  call this method to reload your data source
 */
- (void)reloadData;

/**
 *  scrolls to a specific item specified
 *
 *  @param index the index to which you want to scroll.
 */
- (void)scrollToItemAtIndex:(int)index;

@end


/**
 *  implement this data source to provide data to the gallery view.
 */
@protocol SHGalleryViewControllerDataSource <NSObject>

@required

/**
 *  returns the number of items in the gallery
 *
 *  @return number of items
 */
- (CGFloat)numberOfItems;

/**
 *  create and return the `SHMediaItem` for the specified index
 *
 *  @param index the index for which the media item is needed to be created.
 *
 *  @return the media item
 */
- (SHMediaItem *)mediaItemIndex:(NSInteger)index;

@end


/**
 *  implement `SHGalleryViewControllerDelegate` to interact with gallery view events.
 */
@protocol SHGalleryViewControllerDelegate <NSObject>

/**
 *  Gallery view support any orientation. implement this method and return the supported `UIInterfaceOrientationMask` 
 *  that you want for the gallery view. by default is `UIInterfaceOrientationMaskLandscape`.
 *
 *  @return the `UIInterfaceOrientationMask`
 */
- (NSInteger)supportedOrientations;

/**
 *  this method will be called right before the item is going to be displayed.
 *
 *  @param galleryView the gallery view object
 *  @param index       the index at which items is going to be displayed
 */
- (void)galleryView:(SHGalleryViewController *)galleryView willDisplayItemAtIndex:(int)index;

/**
 *  this method is called right after the item is going to be displayed.
 *
 *  @param galleryView the gallery view object
 *  @param index       the index at which items was displayed
 */
- (void)galleryView:(SHGalleryViewController *)galleryView didDisplayItemAtIndex:(int)index;

/**
 *  gallery view fires this method when user clicks on the `Done` button. when the Gallery view is embedded
 *  in another view rather then being shown modally, the `Done` button will be hidden.
 */
- (void)doneClicked;

@end

@protocol SHGalleryViewControllerChild <NSObject>

@property (nonatomic, strong) SHMediaItem *mediaItem;
@property (nonatomic) NSInteger pageIndex;

@end