//
//  ViewController.m
//  yokeru
//
//  Created by yusk on 2014/08/25.
//  Copyright (c) 2014年 myname. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

typedef struct chara{
    char *str;
    int font;
    int front;
    int rear;
    int dx;
    int dy;
    int score;
    int tag;
    bool flag;
    bool positive;
    int HP_MAX;
} character;

typedef struct chara_bullet{
    char *str;
    int font;
    int front;
    int rear;
    int dx;
    int dy;
    int tag;
    bool flag;
    bool positive;
    int num;
} character_bullet;

const int N = 12;
const int I = 50;
character player = {"@", 30, 0, 0, 15, 3};
character enemy[] = {{"&", 30, 0, 0, 0, 3, 1},{"#", 40, 0, 0, 0, 5, 1},{"a", 70, 0, 0, 0, 12, 1},{"v", 20, 0, 0, 10, 4, 3, 0, YES, YES},{"x", 40, 0, 0, 5, 6, 2, 0, YES, YES}, {"s", 40, 0, 0, 20, 0, 10, 1},{"4", 40, 0, 0, 13, 6, 2, 0, YES, YES},{"j", 30, -1, 0, 5, 7, 2, 2, YES},{"9", 50, -1, 0, 7, 12, 3, 2, YES, YES},{"u", 80, 0, 0, 3, 3, 5, 3, NO, YES, 3},{"$", 60, 0, 0, 10, 2, 20, 4, YES, NO, 5},{"-",90,0,0,15,4,7,5,YES,YES}};
character_bullet bullet[] = {{"^", 20, 0, 0, 5, 5},{"I", 30, 0, 0, 5, 7},{"+", 10, 0, 0, 5, 4, 1, YES, YES, 5}};
character_bullet enemyBullet[] = {{"M", 40, 0, 0, 0, 10, 1}};
int numOfEnemyKinds;
int numOfBulletKinds;
int numOfEnemyBulletKinds;
int numOfExposion;
int waveX[N][I];
int waveY[N][I];
int hp[N][I];
bool jiwajiwa = NO;
bool muteki = NO;
bool item = NO;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBackdround];
    [self makeInvisibleBtn];
    [self initValue];
    [self initBoard];
    [self initSound];
    [self makeEnemy];
    [self makeBuleet];
    [self makePlayer];
    [self starttimer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)initValue{
    enemySize = sizeof(enemyLabel[0]) / sizeof(enemyLabel[0][0]);
    bulletSize = sizeof(bulletLabel[0]) / sizeof(bulletLabel[0][0]);
    enemyBulletSize = sizeof(enemyBulletLabel[0]) / sizeof(enemyBulletLabel[0][0]);
    numOfEnemyKinds = sizeof(enemy) / sizeof(enemy[0]);
    numOfBulletKinds = sizeof(bullet) / sizeof(bullet[0]);
    numOfEnemyBulletKinds = sizeof(enemyBullet) / sizeof(enemyBullet[0]);
    printf("%d,%d,%d,%d\n",enemySize,bulletSize,numOfEnemyKinds,numOfBulletKinds);
    if (numOfEnemyKinds != N) {
        printf("error%d,%d",numOfEnemyKinds,N);
    }
    HP_num = 1;
    if (muteki) {
        HP_num = 99999;
    }
    score_num = 0;
    time = 0;
    user = [NSUserDefaults standardUserDefaults];
    //[user setInteger:0 forKey:@"highscore"];
    for (int n=0; n<N; n++) {
        for (int i=0; i<I; i++) {
            waveX[n][i] = 0;
            waveY[n][i] = 0;
            hp[n][i] = enemy[n].HP_MAX;
            if (enemy[n].front != -1) {
                enemy[n].front = 0;
                enemy[n].rear = 0;
            }
        }
    }
    for (int n=0; n<numOfBulletKinds; n++) {
        bullet[n].front = bullet[n].rear = 0;
    }
}

- (void)initBackdround{
//    for (int i=0; i<12; i++) {
//        for (int j=0; j<4; j++) {
//            background[i][j] = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
//            background[i][j].image = [UIImage imageNamed:@"sora.jpg"];
//            background[i][j].center = CGPointMake(40+j*80, 40+i*80);
//            background[i][j].alpha = 1;
//            [self.view addSubview:background[i][j]];
//        }
//    }
    
}

- (void)initBoard{
    HP = [[UILabel alloc]init];
    HP.text = [NSString stringWithFormat:@"HP:%d",HP_num];
    HP.frame = CGRectMake(20, 20, 40, 20);
    HP.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:HP];
    score = [[UILabel alloc]init];
    score.text = [NSString stringWithFormat:@"score:%d",score_num];
    score.frame = CGRectMake(65, 20, 80, 20);
    score.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:score];
}

- (void)initSound{
//    BGM_path = [[NSBundle mainBundle] pathForResource:@"cyber09" ofType:@"mp3"];
//    explosion_path[0] = [[NSBundle mainBundle] pathForResource:@"explosion05" ofType:@"mp3"];
//    explosion_path[1] = [[NSBundle mainBundle] pathForResource:@"explosion06" ofType:@"mp3"];
//    explosion_path[2] = [[NSBundle mainBundle] pathForResource:@"explosion07" ofType:@"mp3"];
//    shot_path[0] = [[NSBundle mainBundle] pathForResource:@"gun01" ofType:@"mp3"];
//    shot_path[1] = [[NSBundle mainBundle] pathForResource:@"gun03" ofType:@"mp3"];
//    move_path = [[NSBundle mainBundle] pathForResource:@"syber01" ofType:@"mp3"];
//    NSURL *BGMURL, *explosionURL, *moveURL, *shotURL;
//    BGMURL = [NSURL fileURLWithPath:BGM_path];
//    moveURL = [NSURL fileURLWithPath:move_path];
//    BGM = [[AVAudioPlayer alloc] initWithContentsOfURL:BGMURL error:nil];
//    BGM.currentTime = 0.0;
//    BGM.volume = 1.0;
//    BGM.numberOfLoops = -1;
//    [BGM prepareToPlay];
//    numOfExposion = sizeof(explosion) / sizeof(explosion[0]);
//    int numOfShot = sizeof(shot) / sizeof(shot[0]);
//    for (int i=0; i<numOfExposion; i++) {
//        explosionURL = [NSURL fileURLWithPath:explosion_path[i]];
//        AudioServicesCreateSystemSoundID((__bridge CFURLRef)explosionURL, &explosion[i]);
//    }
//    for (int i=0; i<numOfShot; i++) {
//        shotURL = [NSURL fileURLWithPath:shot_path[i]];
//        AudioServicesCreateSystemSoundID((__bridge CFURLRef)shotURL, &shot[i]);
//    }
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)moveURL, &move);
}

/*
- (void)makeInvisibleBtn{
    float visible = 0.2;
    clearBtn[0] = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 480)];
    clearBtn[1] = [[UIButton alloc]initWithFrame:CGRectMake(100, 0, 120, 480)];
    clearBtn[2] = [[UIButton alloc]initWithFrame:CGRectMake(220, 0, 100, 480)];
    [clearBtn[0] addTarget:self action:@selector(moveleft) forControlEvents:UIControlEventTouchUpInside];
    [clearBtn[0] addTarget:self action:@selector(moveleft) forControlEvents:UIControlEventTouchDragInside];
    [clearBtn[1] addTarget:self action:@selector(movecentor) forControlEvents:UIControlEventTouchUpInside];
    //[clearBtn[1] addTarget:self action:@selector(movecentor) forControlEvents:UIControlEventTouchDragInside];
    [clearBtn[2] addTarget:self action:@selector(moveright) forControlEvents:UIControlEventTouchUpInside];
    [clearBtn[2] addTarget:self action:@selector(moveright) forControlEvents:UIControlEventTouchDragInside];
    for (int i=0; i<3; i++) {
        clearBtn[i].backgroundColor = [UIColor clearColor];//clearColor
        clearBtn[i].alpha = visible;
        [self.view addSubview:clearBtn[i]];
    }
}
 */

- (void)makeInvisibleBtn{
    float visible = 0.2;
    for (int i=0; i<48; i++) {
        for (int j=0; j<32; j++) {
            clearBtn[i][j] = [[UIButton alloc]initWithFrame:CGRectMake(j*10, i*10, 10, 10)];
            [clearBtn[i][j] addTarget:self action:@selector(pushbtn:) forControlEvents:UIControlEventTouchUpInside];
            clearBtn[i][j].backgroundColor = [UIColor clearColor];//clearColor
            clearBtn[i][j].alpha = visible;
            [self.view addSubview:clearBtn[i][j]];
        }
    }
}

- (void)makePlayer{
    playerLabel = [[UILabel alloc] init];
    playerLabel.frame = CGRectMake(0, 0, player.font, player.font);
    playerLabel.font = [UIFont systemFontOfSize:player.font - player.font/5];
    playerLabel.center = CGPointMake(160, 500);
    playerLabel.text = [NSString stringWithFormat:@"%s",player.str];
    playerLabel.textAlignment = NSTextAlignmentCenter;
    playerLabel.textColor = [UIColor redColor];
    [self.view addSubview:playerLabel];
}

- (void)makeEnemy{
    for (int n=0; n<numOfEnemyKinds; n++) {
        for (int i=0; i<enemySize; i++) {
            enemyLabel[n][i] = [[UILabel alloc] init];
            enemyLabel[n][i].frame = CGRectMake(999, 0, enemy[n].font*2/3, enemy[n].font);
            enemyLabel[n][i].font = [UIFont systemFontOfSize:enemy[n].font - enemy[n].font/5];
            enemyLabel[n][i].text = [NSString stringWithFormat:@"%s",enemy[n].str];
            enemyLabel[n][i].textAlignment = NSTextAlignmentCenter;
            enemyLabel[n][i].hidden = YES;
            if (enemy[n].tag == 1) {
                enemyLabel[n][i].textColor = [UIColor brownColor];
            } else if (enemy[n].tag == 4) {
                enemyLabel[n][i].textColor = [UIColor purpleColor];
            }
            //enemyLabel[n][i].backgroundColor = [UIColor yellowColor];
            [self.view addSubview:enemyLabel[n][i]];
        }
    }
    
    
}

- (void)makeBuleet{
    CGFloat angle = 180 * M_PI / 180;
    for (int n=0; n<numOfBulletKinds; n++) {
        for (int i=0; i<bulletSize; i++) {
            bulletLabel[n][i] = [[UILabel alloc] init];
            bulletLabel[n][i].frame = CGRectMake(0, 9999, bullet[n].font*2/3, bullet[n].font);
            bulletLabel[n][i].font = [UIFont systemFontOfSize:bullet[n].font - bullet[n].font/5];
            bulletLabel[n][i].text = [NSString stringWithFormat:@"%s",bullet[n].str];
            bulletLabel[n][i].textAlignment = NSTextAlignmentCenter;
            bulletLabel[n][i].hidden = YES;
            bulletLabel[n][i].textColor = [UIColor redColor];
            //bulletLabel[n][i].backgroundColor = [UIColor cyanColor];
            [self.view addSubview:bulletLabel[n][i]];
        }
    }
    for (int n=0; n<numOfEnemyBulletKinds; n++) {
        for (int i=0; i<enemyBulletSize; i++) {
            enemyBulletLabel[n][i] = [[UILabel alloc] init];
            enemyBulletLabel[n][i].frame = CGRectMake(0, 9999, enemyBullet[n].font*2/3, enemyBullet[n].font);
            enemyBulletLabel[n][i].font = [UIFont systemFontOfSize:enemyBullet[n].font - enemyBullet[n].font/5];
            enemyBulletLabel[n][i].text = [NSString stringWithFormat:@"%s",enemyBullet[n].str];
            enemyBulletLabel[n][i].textAlignment = NSTextAlignmentCenter;
            enemyBulletLabel[n][i].hidden = YES;
            enemyBulletLabel[n][i].textColor = [UIColor purpleColor];
            enemyBulletLabel[n][i].transform = CGAffineTransformMakeRotation(angle);
            //enemyBulletLabel[n][i].backgroundColor = [UIColor cyanColor];
            [self.view addSubview:enemyBulletLabel[n][i]];
        }
    }
}

- (void)moveleft{
    NSInteger x, y;
    x = playerLabel.center.x;
    y = playerLabel.center.y;
    x -= player.dx;
    if (x>0) {
        playerLabel.center = CGPointMake(x, y);
        AudioServicesPlaySystemSound(move);
    }
}

- (void)movecentor{
    if (numOfBulletKinds>=2) {
        if (![self bulletChkFull:1]) {
            [self appearBullet:1:bullet[1].rear];
        }
    } else if (![self bulletChkFull:0]){
        [self appearBullet:0:bullet[0].rear];
    }
}

- (void)moveright{
    NSInteger x, y;
    x = playerLabel.center.x;
    y = playerLabel.center.y;
    x += player.dx;
    if (x<320) {
        playerLabel.center = CGPointMake(x, y);
        AudioServicesPlaySystemSound(move);
    }
}

- (void)pushbtn:(UIButton *)tempBtn{
    int x, y, player_x, player_y, player_size;
    x = tempBtn.center.x;
    y = tempBtn.center.y;
    player_x = playerLabel.center.x;
    player_y = playerLabel.center.y;
    player_size = player.font;
    if (x < player_x - player_size) {
        [self moveleft];
    } else if (x > player_x + player_size){
        [self moveright];
    } else  if (y > player_y - player_size/2 && y < player_y + player_size/2 && item){
        [self twinBullet];
    } else {
        [self movecentor];
    }
}

- (void)twinBullet{
    if (![self bulletChkFull:2]) {
        [self appearBullet:2:bullet[2].rear];
    }/* else if (![self bulletChkFull:1]) {
        [self appearBullet:1:bullet[1].rear];
    }*/
}


- (void)appearEnemy:(int)n :(int)i{
    int x = arc4random() % 310 + 5;
    if (enemy[n].tag == 1) {
        enemyLabel[n][i].center = CGPointMake(0, x);
    } else if(enemy[n].tag == 4){
        enemyLabel[n][i].center = CGPointMake(x, 20);
    } else if(enemy[n].tag == 5){
        enemyLabel[n][i].center = CGPointMake(x, 250);
    } else {
        enemyLabel[n][i].center = CGPointMake(x, 10);
    }
    enemyLabel[n][i].hidden = NO;
    enemy[n].rear = [self enemyNextQueue:enemy[n].rear];
}
- (void)enemydown:(UILabel *)label :(NSInteger)i :(NSInteger)n{
    NSInteger x, y;
    x = label.center.x;
    y = label.center.y;
    if (enemy[n].tag == 1) {
        if (x<320) {
            x += enemy[n].dx;
            label.center = CGPointMake(x, y);
            [self atarihanteiOfEnemy:label :n :i];
        } else {
            label.hidden = YES;
            enemy[n].front = [self enemyNextQueue:enemy[n].front];
        }
        return;
    } else if (enemy[n].tag == 2){
        if (enemy[n].flag) {
            waveX[n][i] = arc4random() % (enemy[n].dx + 1);
            waveY[n][i] = arc4random() % (enemy[n].dy + 1);
            int randX = arc4random() % 2;
            int randY = arc4random() % 2;
            if (randX == 1) {
                waveX[n][i] *= -1;
            }
            if (randY == 1) {
                waveY[n][i] *= -1;
            }
        }
        int rand = arc4random() % 15;
        if (rand == 0) {
            enemy[n].flag = YES;
        } else {
            enemy[n].flag = NO;
        }
        x += waveX[n][i];
        y += waveY[n][i] + enemy[n].dy/2;
        label.center = CGPointMake(x, y);
        [self atarihanteiOfEnemy :label :n :i];
        //printf("error,%d,%d\n",n,i);
        return;
    } else if (enemy[n].tag == 4){
        if (enemy[n].flag) {
            waveX[n][i] = arc4random() % (enemy[n].dx + 1);
            waveY[n][i] = arc4random() % (enemy[n].dy + 1);
            //printf("(%d,%d),%d,",n,i,waveY[n][i]);
            int randX = arc4random() % 2;
            int randY = arc4random() % 2;
            if (x < 10) {
                randX = 0;
            } else if (x > 310){
                randX = 1;
            }
            if (y < 10) {
                randY = 0;
            }else if (y > 210){
                randY = 1;
            }
            if (randX == 1) {
                waveX[n][i] *= -1;
            }
            if (randY == 1) {
                waveY[n][i] *= -1;
            }
        }
        if (time%30 == 0) {
            enemy[n].flag = YES;
            printf("i=%d,",i);
        } else {
            enemy[n].flag = NO;
        }
        int rand = arc4random() % 70;
        if (rand == 0) {
            [self enemyAppearBullet:0 :enemyBullet[0].rear :x :y];
        }
        //printf("(%d,%d),%d,\n",n,i,waveY[n][i]);
        //waveY[n][i] = 0;
        x += waveX[n][i];
        y += waveY[n][i];
        label.center = CGPointMake(x, y);
        [self atarihanteiOfEnemy :label :n :i];
        if (label.center.x > 9000) {
            enemy[n].front = [self enemyNextQueue:enemy[n].front];
            label.center = CGPointMake(160, 9000);
        }
        return;
    }
    if (enemy[n].flag) {
        if (waveX[n][i] == enemy[n].dx) {
            enemy[n].positive = NO;
        } else if(waveX[n][i] == -enemy[n].dx){
            enemy[n].positive = YES;
        }
        if (enemy[n].positive) {
            waveX[n][i]++;
        } else {
            waveX[n][i]--;
        }
        x += waveX[n][i];
    }
    if (y<480) {
        y += enemy[n].dy;
        label.center = CGPointMake(x, y);
        [self atarihanteiOfEnemy :label :n :i];
    } else {
        label.hidden = YES;
        enemy[n].front = [self enemyNextQueue:enemy[n].front];
    }
}
- (NSInteger)enemyNextQueue:(int)i{
    return (i+1) % (enemySize);
}
- (BOOL)enemyChkFull:(int)n{
    return [self enemyNextQueue:enemy[0].rear] == enemy[0].front;
}
- (void)deleteEnemy:(UILabel *)label :(int)n{
    int x = label.center.x;
    int y = label.center.y;
    if (enemy[n].tag == 1) {
        label.center = CGPointMake(x, 9999);
    } else {
        label.center = CGPointMake(9999, y);
    }
}


- (void)appearBullet:(int)n :(int)i{
    NSInteger x, y;
    x = playerLabel.center.x;
    y = playerLabel.center.y;
    y -= 10;
    bulletLabel[n][i].center = CGPointMake(x, y);
    bulletLabel[n][i].hidden = NO;
    bullet[n].rear = [self bulletNextQueue:bullet[n].rear :n];
    if (n==0) {
        AudioServicesPlaySystemSound(shot[0]);
    } else {
        AudioServicesPlaySystemSound(shot[1]);
    }
    if (bullet[n].tag == 1 && i%2 == 0) {
        if (![self bulletChkFull:n]){
            [self appearBullet:n :[self bulletNextQueue:i :n]];
        }
    }
}
- (void)bulletup:(UILabel *)label :(int)n :(int)i{
    NSInteger x, y;
    x = label.center.x;
    y = label.center.y;
    if (bullet[n].tag == 1) {
        int rand = arc4random() % (bullet[n].dx + 1);
        if (bullet[n].positive) {
            x += rand;
            bullet[n].positive = NO;
        } else {
            x -= rand;
            bullet[n].positive = YES;
        }
        /*
        if (i%2 == 0) {
            if (bullet[n].positive) {
                x += rand;
                bullet[n].positive = NO;
            } else {
                x -= rand;
                bullet[n].positive = YES;
            }
        } else {
            if (bullet[n].positive) {
                x += rand;
                bullet[n].positive = NO;
            } else {
                x -= rand;
                bullet[n].positive = YES;
            }
        }
         */
    }
    if (y>0) {
        y -= bullet[n].dy;
        label.center = CGPointMake(x, y);
    } else {
        label.hidden = YES;
        bullet[n].front = [self bulletNextQueue:bullet[n].front :n];
    }
    if (bullet[n].flag) {
        CGFloat angle = arc4random() % 360 * M_PI / 180;
        label.transform = CGAffineTransformMakeRotation(angle);
    }
}
- (NSInteger)bulletNextQueue:(int)i :(int) n{
    if (bullet[n].tag == 1) {
        return (i+1) % (bullet[n].num);
    } else {
        return (i+1) % (bulletSize);
    }
}
- (BOOL)bulletChkFull:(int)n{
    return [self bulletNextQueue:bullet[n].rear :n] == bullet[n].front;
}
- (void)deleteBullet:(UILabel *)label{
    int y = label.center.y;
    label.center = CGPointMake(-9999, y);
}

- (void)enemyAppearBullet:(int)n :(int)i :(int)x :(int)y{
    y += 10;
    enemyBulletLabel[n][i].center = CGPointMake(x, y);
    enemyBulletLabel[n][i].hidden = NO;
    enemyBullet[n].rear = [self enemyBulletNextQueue:enemyBullet[n].rear];
    if (n==0) {
        AudioServicesPlaySystemSound(shot[0]);
    } else {
        AudioServicesPlaySystemSound(shot[1]);
    }
}
- (void)enemyBulletdown:(UILabel *)label :(int)n{
    NSInteger x, y;
    x = label.center.x;
    y = label.center.y;
    if (y<480) {
        y += enemyBullet[n].dy;
        label.center = CGPointMake(x, y);
        [self atarihanteiOfEnemyBullet:label :n];
    } else {
        label.hidden = YES;
        enemyBullet[n].front = [self enemyBulletNextQueue:enemyBullet[n].front];
    }
}
- (NSInteger)enemyBulletNextQueue:(int)i{
    return (i+1) % (enemyBulletSize);
}
- (BOOL)enemyBulletChkFull:(int)n{
    return [self enemyBulletNextQueue:enemyBullet[n].rear] == enemyBullet[n].front;
}
- (void)enemyDeleteBullet:(UILabel *)label{
    int y = label.center.y;
    label.center = CGPointMake(-9999, y);
}

- (void)atarihanteiOfEnemy:(UILabel *)label :(NSInteger)enemy_n :(NSInteger)enemy_i{
    int i;
    int lowX, highX, lowY, highY;
    int size;
    NSInteger x, y;
    NSInteger playerX, playerY;
    NSInteger bulletX, bulletY;
    size = enemy[enemy_n].font;
    x = label.center.x;
    y = label.center.y;
    lowX = x - size/3;
    lowY = y - size/3;
    highX = x + size/2;
    highY = y + size/2;
    playerX = playerLabel.center.x;
    playerY = playerLabel.center.y;
    if (lowX < playerX && playerX < highX && lowY < playerY && playerY < highY) {
        [self deleteEnemy:label:enemy_n];
        HP_num--;
        HP.text = [NSString stringWithFormat:@"HP:%d",HP_num];
    }
    for (int n=0; n<numOfBulletKinds; n++) {
        i = bullet[n].front;
        while (i != bullet[n].rear) {
            bulletX = bulletLabel[n][i].center.x;
            bulletY = bulletLabel[n][i].center.y;
            if (lowX < bulletX && bulletX < highX && lowY < bulletY && bulletY < highY) {
                if ((enemy[enemy_n].tag == 3 || enemy[enemy_n].tag == 4) && hp[enemy_n][enemy_i] > 1) {
                    hp[enemy_n][enemy_i]--;
                    [self deleteBullet:bulletLabel[n][i]];
                    printf("%d,",hp[enemy_n][enemy_i]);
                    if (hp[enemy_n][enemy_i] == 2) {
                        label.textColor = [UIColor greenColor];
                    } else if (hp[enemy_n][enemy_i] == 1){
                        label.textColor = [UIColor yellowColor];
                    }
                } else {
                    [self deleteEnemy:label:enemy_n];
                    [self deleteBullet:bulletLabel[n][i]];
                    score_num += enemy[enemy_n].score;
                    score.text = [NSString stringWithFormat:@"score:%d",score_num];
                    score.frame = CGRectMake(65, 20, 80, 20);
                    score.font = [UIFont systemFontOfSize:14];
                    [self.view addSubview:score];
                    if (enemy_n <numOfExposion) {
                        AudioServicesPlaySystemSound(explosion[enemy_n]);
                    } else {
                        AudioServicesPlaySystemSound(explosion[0]);
                    }
                    if (enemy[enemy_n].tag == 3 || enemy[n].tag == 4) {
                        hp[enemy_n][enemy_i] = enemy[enemy_n].HP_MAX;
                        label.textColor = [UIColor blackColor];
                    }
                    if (enemy[enemy_n].tag == 4) {
                        label.textColor = [UIColor purpleColor];
                    }
                    if (enemy[enemy_n].tag == 1) {
                        item = YES;
                    }
                }
            }
            i = [self bulletNextQueue:i :n];
        }
    }
    
}

- (void)atarihanteiOfEnemyBullet:(UILabel *)label :(NSInteger)enemyBullet_n{
    int lowX, highX, lowY, highY;
    int size;
    NSInteger x, y;
    NSInteger playerX, playerY;
    size = enemyBullet[enemyBullet_n].font;
    x = label.center.x;
    y = label.center.y;
    lowX = x - size/3;
    lowY = y - size/3;
    highX = x + size/2;
    highY = y + size/2;
    playerX = playerLabel.center.x;
    playerY = playerLabel.center.y;
    if (lowX < playerX && playerX < highX && lowY < playerY && playerY < highY) {
        [self enemyDeleteBullet:label];
        HP_num--;
        HP.text = [NSString stringWithFormat:@"HP:%d",HP_num];
    }
}


- (void)starttimer{
    if (jiwajiwa) {
        numOfEnemyKinds = 1;
    }
    playgame = [NSTimer scheduledTimerWithTimeInterval:0.04
                                                target:self
                                              selector:@selector(playing)
                                              userInfo:nil
                                              repeats:YES];
    [BGM play];
}
- (void)playing{
    [self movebackground];
    time += 1;
    NSInteger random = arc4random() % 8;
    int i;
    int n;
    n = arc4random() % numOfEnemyKinds;
    //n = N-1;
    if (random == 0 && ![self enemyChkFull:n]) {
        if (enemy[n].tag == 1) {
            int rand = arc4random() % 10;
            if (rand == 0) {
                [self appearEnemy:n:enemy[n].rear];
            }
        } else if (enemy[n].tag == 2) {
            int rand = arc4random() % 2;
            if (rand == 0) {
                [self appearEnemy:n:enemy[n].rear];
            }
        } else if (enemy[n].tag == 3) {
            int rand = arc4random() % 2;
            if (rand == 0) {
                [self appearEnemy:n:enemy[n].rear];
            }
        } else if (enemy[n].tag == 4) {
            int rand = arc4random() % 10;
            if (rand == 0) {
                [self appearEnemy:n:enemy[n].rear];
            }
        } else {
            [self appearEnemy:n:enemy[n].rear];
        }
    }
    if (time%30 == 0 && ![self bulletChkFull:0]) {
        [self appearBullet:0:bullet[0].rear];
    }
    for (int n=0; n<numOfEnemyKinds; n++) {
        i = enemy[n].front;
        int max = enemy[n].rear;
        if (enemy[n].tag == 2) {
            i = 0;
            max = enemySize-1;
        }
        while (i != max) {
            [self enemydown:enemyLabel[n][i]:i:n];
            i = [self enemyNextQueue:i];
        }
    }
    for (int n=0; n<numOfBulletKinds; n++) {
        i = bullet[n].front;
        while (i != bullet[n].rear) {
            [self bulletup:bulletLabel[n][i]:n:i];
            i = [self bulletNextQueue:i :n];
        }
    }
    for (int n=0; n<numOfEnemyBulletKinds; n++) {
        i = enemyBullet[n].front;
        int max = enemyBullet[n].rear;
        if (enemyBullet[n].tag == 1) {
            i = 0;
            max = enemyBulletSize-1;
        }
        while (i != max) {
            [self enemyBulletdown:enemyBulletLabel[n][i]:n];
            i = [self enemyBulletNextQueue:i];
        }
    }
    if (HP_num <= 0) {
        printf("ゲームオーバー\n");
        int highscore = [user integerForKey:@"highscore"];
        [user setInteger:score_num forKey:@"score"];
        if (score_num > highscore) {
            [user setInteger:score_num forKey:@"highscore"];
        }
        printf("highscore=%d\n",highscore);
        [BGM stop];
        [playgame invalidate];
        [self performSegueWithIdentifier:@"gameover" sender:self];
    }
    if (jiwajiwa) {
        if (score_num >= numOfEnemyKinds*15 && numOfEnemyKinds < sizeof(enemy) / sizeof(enemy[0])) {
            numOfEnemyKinds++;
            printf(",%d",numOfEnemyKinds);
        }
    }
}

- (void)movebackground{
    int x, y;
    int dy = 2;
    for (int i=0; i<12; i++) {
        for (int j=0; j<4; j++) {
            x = background[i][j].center.x;
            y = background[i][j].center.y;
            y += dy;
            if (y >= 560) {
                y -= 80*8;
            }
            background[i][j].center = CGPointMake(x, y);
        }
    }
}



@end
