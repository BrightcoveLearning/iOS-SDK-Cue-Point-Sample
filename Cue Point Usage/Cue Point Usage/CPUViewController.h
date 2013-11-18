//
//  CPUViewController.h
//  Cue Point Usage
//
//  Created by Robert Crooks on 11/14/13.
//  Copyright (c) 2013 Robert Crooks. All rights reserved.
//

#import <UIKit/UIKit.h>
// import the SDK master header
#import <BCOVPlayerSDK.h>


// forward reference for the catalog service class
@class BCOVCatalogService;
// forward reference for the media request factory
// allows access to Catalog for Japan accounts
// and via proxy
@class BCOVMediaRequestFactory;


@interface CPUViewController : UIViewController <BCOVPlaybackFacadeDelegate>

// declare the facade, catalog, and media request factory properties
@property (strong, nonatomic) id<BCOVPlaybackFacade> facade;
@property (strong, nonatomic) BCOVCatalogService *catalog;
// declare property for the media request factory
@property (strong, nonatomic) BCOVMediaRequestFactory *mediaRequestFactory;

@end
