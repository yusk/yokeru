//
//  gameoverViewController.h
//  yokeru
//
//  Created by yusk on 2014/08/25.
//  Copyright (c) 2014年 myname. All rights reserved.
//

#import "ViewController.h"

@interface gameoverViewController : ViewController{
    __weak IBOutlet UILabel *resultScore;
    __weak IBOutlet UILabel *highscore;
    NSInteger finalScore;
    NSInteger highscore_num;
}

@end
