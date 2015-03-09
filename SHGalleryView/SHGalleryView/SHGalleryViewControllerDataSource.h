//
//  SHGalleryViewControllerDataSource.h
//  SHGalleryView
//
//  Created by Shan Ul Haq on 9/3/15.
//  Copyright (c) 2015 com.grevolution.shgalleryview. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SHMediaItem;

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
