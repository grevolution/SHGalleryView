//
//  SHGalleryController.m
//  SHGalleryView
//
//  Created by Shan Ul Haq on 9/3/15.
//  Copyright (c) 2015 com.grevolution.shgalleryview. All rights reserved.
//

#import "SHGalleryViewController.h"
#import "SHGalleryView.h"

@implementation SHGalleryViewController

- (void)loadView {
    self.view = [[SHGalleryView alloc] init];
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor blueColor];

    SHGalleryView *galleryView = (SHGalleryView *)self.view;
    galleryView.delegate = _delegate;
    galleryView.dataSource = _dataSource;
    galleryView.theme = _theme;
    galleryView.showPageControl = _showPageControl;
    galleryView.disablePinchAndZoomOnImages = _disablePinchAndZoomOnImages;
    [galleryView setupGalleryView];
}

- (void)reloadData {
    SHGalleryView *galleryView = (SHGalleryView *)self.view;
    [galleryView reloadData];
}

- (void)scrollToItemAtIndex:(int)index {
    SHGalleryView *galleryView = (SHGalleryView *)self.view;
    [galleryView scrollToItemAtIndex:index];
}

#pragma mark - Orientation Methods

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    if ([_delegate respondsToSelector:@selector(supportedOrientations)]) {
        return [_delegate supportedOrientations];
    }
    return UIInterfaceOrientationMaskLandscape;
}

@end
