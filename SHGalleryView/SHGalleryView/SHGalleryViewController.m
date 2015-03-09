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

- (void)viewWillAppear:(BOOL)animated {
    SHGalleryView *galleryView = (SHGalleryView *)self.view;
    galleryView.isDoneButtonForcedHidden = ![self isModal];
}

#pragma mark - Helper methods

- (BOOL)isModal {
    return self.presentingViewController.presentedViewController == self || (self.navigationController.presentingViewController.presentedViewController != nil && self.navigationController != nil && self.navigationController.presentingViewController.presentedViewController == self.navigationController) || [self.tabBarController.presentingViewController isKindOfClass:[UITabBarController class]];
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
