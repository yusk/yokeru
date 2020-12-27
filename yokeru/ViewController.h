//
//  ViewController.h
//  yokeru
//
//  Created by yusk on 2014/08/25.
//  Copyright (c) 2014年 myname. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    //UIButton *clearBtn[3];
    UIButton *clearBtn[48][32];
    UILabel *playerLabel;
    UILabel *enemyLabel[12][50];
    UILabel *bulletLabel[3][10];
    UILabel *enemyBulletLabel[1][150];
    NSInteger enemySize;
    NSInteger bulletSize;
    NSInteger enemyBulletSize;
    NSTimer *playgame;
    UILabel *HP;
    UILabel *score;
    NSInteger HP_num;
    NSInteger score_num;
    NSInteger time;
    AVAudioPlayer *BGM;
    SystemSoundID explosion[3], move, shot[2];
    NSString *BGM_path, *explosion_path[3], *move_path, *shot_path[2];
    NSUserDefaults *user;
    UIImageView *background[12][4];
}

@end
