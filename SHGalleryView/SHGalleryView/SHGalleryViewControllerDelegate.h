//
//  SHGalleryViewControllerDelegate.h
//  SHGalleryView
//
//  Created by Shan Ul Haq on 9/3/15.
//  Copyright (c) 2015 com.grevolution.shgalleryview. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SHGalleryView;

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
- (void)galleryView:(SHGalleryView *)galleryView willDisplayItemAtIndex:(int)index;

/**
 *  this method is called right after the item is going to be displayed.
 *
 *  @param galleryView the gallery view object
 *  @param index       the index at which items was displayed
 */
- (void)galleryView:(SHGalleryView *)galleryView didDisplayItemAtIndex:(int)index;

/**
 *  gallery view fires this method when user clicks on the `Done` button. when the Gallery view is embedded
 *  in another view rather then being shown modally, the `Done` button will be hidden.
 */
- (void)doneClicked;

@end
