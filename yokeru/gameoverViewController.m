//
//  gameoverViewController.m
//  yokeru
//
//  Created by yusk on 2014/08/25.
//  Copyright (c) 2014年 myname. All rights reserved.
//

#import "gameoverViewController.h"

@interface gameoverViewController ()

@end

@implementation gameoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    finalScore = [user integerForKey:@"score"];
    highscore_num = [user integerForKey:@"highscore"];
    resultScore.text = [NSString stringWithFormat:@"score:%d",finalScore];
    highscore.text = [NSString stringWithFormat:@"highscore:%d",highscore_num];
    [self allHidden];
    [BGM stop];
    [playgame invalidate];
}

- (void)allHidden{
    /*
    for (int i=0; i<3; i++) {
        clearBtn[i].hidden =YES;
    }
     */
    for (int i=0; i<48; i++) {
        for (int j=0; j<32; j++) {
            clearBtn[i][j].hidden = YES;
        }
    }
    playerLabel.hidden = YES;
    score.hidden = YES;
    HP.hidden = YES;
    for (int i=0; i<12; i++) {
        for (int j=0; j<4; j++) {
            background[i][j].hidden = YES;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
