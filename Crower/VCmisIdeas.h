//  VCmisIdeas.h
//  Crower
//  Created by Carolina Delgado on 3/07/16.
//  Copyright © 2016 Carolina Delgado. All rights reserved.

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface VCmisIdeas : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
{
    AVPlayer * miplayer;
    AVPlayerViewController * vcplayer;
}
@property (weak, nonatomic) IBOutlet UICollectionView *tablaIdeas;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Loading;



@end
