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


/**
 *  this class defines the individual media item that you want to show in the gallery view.
 */
@interface SHMediaItem : NSObject

/**
 *  the caption of the item
 */
@property (nonatomic) NSString *captionTitle;

/**
 *  the detail of the item (this is not displayed in the gallery)
 */
@property (nonatomic, strong) NSString *captionDetail;

/**
 *  the type of the media, currently supported values are Image or Video.
 */
@property (nonatomic) kMediaType mediaType;

/**
 *  the url of the resource.
 */
@property (nonatomic, strong) NSString *resourcePath;

/**
 *  this is a the path of the thumbnail image incase of video
 */
@property (nonatomic, strong) NSString *mediaThumbnailImagePath;


/**
 *  initializer for `SHMediaItem`
 *
 *  @param mediaType    type of the media (kMediaType)
 *  @param resourcePath url path of the media
 *
 *  @return returns the newly created object
 */
- (instancetype)initWithMediaType:(kMediaType)mediaType
                          andPath:(NSString *)resourcePath;

/**
 *  static initializer for `SHMediaItem`
 *
 *  @param mediaType    type of the media (kMediaType)
 *  @param resourcePath url path of the media
 *
 *  @return returns the newly created object
 */
+ (instancetype)mediaItemWithMediaType:(kMediaType)mediaType
                          andPath:(NSString *)resourcePath;


@end
