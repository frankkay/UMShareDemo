//
//  ViewController.m
//  shareDemo666
//
//  Created by frankay on 2017/12/7.
//  Copyright © 2017年 frankay. All rights reserved.
//

#import "ViewController.h"
#import "FKUMShareUtil.h"
#import "FKLoginInfoModel.h"

#import <AVKit/AVKit.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)yuyinActionBtn:(UIButton *)sender {
    /**胡思乱想**/
    if ([self.textView.text isEqualToString:@""]) {
        return;
    }
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:self.textView.text];
    utterance.volume = 0.8;//音量
    AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc] init];
    [synth speakUtterance:utterance];
}

- (IBAction)shareBtnAction:(UIButton *)sender {
    
    [FKUMShareUtil showShareMenuWithPlatformSelectionBlock:^(FKSharePlatform platform, NSDictionary *info) {

        [FKUMShareUtil shareWebPageToPlatform:platform withContent:@{@"title":@"嗯哼",@"desc":@"啊哈。",@"thumbImage":@"001.jpg",@"url":@"https://www.bai.com"} completion:^(id result, FKErrorType errorType) {
            if (errorType == FKErrorTypeNotInstall) {
                NSLog(@"应用未安装！");
            }else if (errorType == FKErrorTypeCancel){
                
                NSLog(@"取消分享");
            }
            
            
        }];
        
//
    }];
    
}

- (IBAction)loginBtn:(UIButton *)sender {
    [FKUMShareUtil loginWithPlatform:FKSharePlatformQQ completion:^(id result, FKErrorType errorType) {
      
        FKLoginInfoModel *model = result;
        NSLog(@">>>%@",model.name);
    }];
}

@end
