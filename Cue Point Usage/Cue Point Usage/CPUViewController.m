//
//  CPUViewController.m
//  Cue Point Usage
//
//  Created by Robert Crooks on 11/14/13.
//  Copyright (c) 2013 Robert Crooks. All rights reserved.
//

#import "CPUViewController.h"
// import the SDK master header and RAC EXTScope header
#import "ReactiveCocoa/RACEXTScope.h"

@interface CPUViewController ()

@end

@implementation CPUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // the following line is the basic way to access the catalog for non-Japanese accounts, not using a proxy
    // self.catalog = [[BCOVCatalogService alloc] initWithToken:@"nFCuXstvl910WWpPnCeFlDTNrpXA5mXOO9GPkuTCoLKRyYpPF1ikig.."];
    
    // the following lines use the media request factory - you must use this method for Japanese accounts
    // or if you make the calls via a proxy
    // note that for accounts in Japan, the baseURLString will be "http://api.brightcove.co.jp/services/library"
    
    self.mediaRequestFactory = [[BCOVMediaRequestFactory alloc] initWithToken:@"nFCuXstvl910WWpPnCeFlDTNrpXA5mXOO9GPkuTCoLKRyYpPF1ikig.." baseURLString:@"http://api.brightcove.com/services/library"];
    
    self.catalog = [[BCOVCatalogService alloc] initWithMediaRequestFactory:self.mediaRequestFactory];
    
    self.controller = [[BCOVPlayerSDKManager sharedManager] createPlaybackControllerWithViewStrategy:nil];
    self.controller.view.frame = self.view.bounds;
    // create a playback controller delegate
    self.controller.delegate = self;
    
    self.controller.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.controller.view];
    
    //This is how you play back videos
    @weakify(self);
    // retrieve the video from Video Cloud
    [self.catalog findVideoWithReferenceID:@"lucy" parameters:nil completion:^(BCOVVideo *video, NSDictionary *jsonResponse, NSError *error) {
        
        @strongify(self);
        if(video){
            
            //Getting properties from the video, these keys can be found in BCOVCatalogConstants.h
            NSLog(@"Name: %@", video.properties[kBCOVCatalogJSONKeyName]);
            NSLog(@"Description: %@", video.properties[kBCOVCatalogJSONKeyShortDescription]);
            
            //Cue points can be iterated through if you want to understand the cuepoints before the video is played
            for(BCOVCuePoint *point in video.cuePoints){
                NSLog(@"Cue Point:%@", point);
            }

            self.controller.autoAdvance = YES;
            self.controller.autoPlay = YES;
            
            [self.controller setVideos:@[video]];
            [self.controller play];
        }
    }];
	
}

//Using the playback controller delegate, you can take action when a cuepoint is hit

- (void)playbackController:(id<BCOVPlaybackController>)controller playbackSession:(id<BCOVPlaybackSession>)session didPassCuePoints:(NSDictionary *)cuePointInfo{
    
    NSLog(@"Cuepoint hit!");
    
    BCOVCuePointCollection *collection = cuePointInfo[kBCOVPlaybackSessionEventKeyCuePoints];
    
    for(BCOVCuePoint *point in collection){
        NSLog(@"Cuepoint Type %@ with Position %f", [point type], CMTimeGetSeconds([point position]));
    }
}


@end
