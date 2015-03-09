//
//  SHGalleryViewControllerChild.h
//  SHGalleryView
//
//  Created by Shan Ul Haq on 9/3/15.
//  Copyright (c) 2015 com.grevolution.shgalleryview. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SHGalleryViewControllerChild <NSObject>

@property (nonatomic, strong) SHMediaItem *mediaItem;
@property (nonatomic) NSInteger pageIndex;

@end
