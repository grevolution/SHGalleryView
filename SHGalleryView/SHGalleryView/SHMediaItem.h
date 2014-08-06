//
//  SHMediaItem.h
//  SHGalleryView
//
//  Created by SHAN UL HAQ on 8/5/14.
//  Copyright (c) 2014 com.grevolution.shgalleryview. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, kMediaType) {
    kMediaTypeImage = 0,
    kMediaTypeVideo = 1
};

@interface SHMediaItem : NSObject

@property (nonatomic) NSString *captionTitle;
@property (nonatomic, strong) NSString *captionDetail;
@property (nonatomic) kMediaType mediaType;
@property (nonatomic, strong) NSString *resourcePath;

/**
 *  this is a tha path of the thumbnail image incase of video
 */
@property (nonatomic, strong) NSString *mediaThumbnailImagePath;

- (instancetype)initWithMediaType:(kMediaType)mediaType
                          andPath:(NSString *)resourcePath;

+ (instancetype)mediaItemWithMediaType:(kMediaType)mediaType
                          andPath:(NSString *)resourcePath;


@end
