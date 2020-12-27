//
//  asobikata.m
//  yokeru
//
//  Created by yusk on 2014/08/25.
//  Copyright (c) 2014年 myname. All rights reserved.
//

#import "asobikata.h"

@interface asobikata ()

@end

@implementation asobikata



NSString *str[] = {@"こんにちは", @"今からこのゲームの遊び方を" @"説明します！", @"画面左をタップすると、", @"プレーヤーが左に動きます！", @"画面右をタップすると、", @"プレーヤーが右に動きます！", @"画面真ん中をたっぷすると、", @"強攻撃することができます！", @"これでチュートリアルは終わりです。", @"がんばって高いスコアを目指してください！", @""};
const int strSize = sizeof(str) / sizeof(str[0]);//12


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
    [self allHidden];
    [BGM stop];
    [playgame invalidate];
    time = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.5
                                             target:self
                                           selector:@selector(talk)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)allHidden{
    //clearBtn[1].frame = CGRectMake(100, 0, 120, 320);
    for (int i=32; i<48; i++) {
        for (int j=12; j<20; j++) {
            clearBtn[i][j].hidden = YES;
        }
    }
    score.hidden = YES;
    HP.hidden = YES;
    for (int i=0; i<8; i++) {
        for (int j=0; j<4; j++) {
            background[i][j].hidden = YES;
        }
    }
}

- (void)talk{
    
    label.adjustsFontSizeToFitWidth = YES;
    if (time%2==0) {
        label.hidden = NO;
        label.text = str[time/2];
    } else {
        label.hidden = YES;
    }
    time++;
    if (time == strSize*2) {
        [timer invalidate];
        [self performSegueWithIdentifier:@"modoru" sender:self];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
