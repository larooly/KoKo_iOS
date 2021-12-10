//
//  ViewController.m
//  kkk
//
//  Created by active on 2020/05/19.
//  Copyright © 2020 activeKJS. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    count=0;
    loadingTimer =[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(startLoading) userInfo:nil repeats:YES];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"ClearAction"];
    
  FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://im3.ezgif.com/tmp/ezgif-3-bdaea39db57d.gif"]]];
    
    //Test
    NSURL *urlTest=[[NSBundle mainBundle]URLForResource:@"cool-loading-animated-gif-1" withExtension:@"gif"];
    FLAnimatedImage *image6         = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:urlTest]];
    //Ok
    
    
    
  FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
  imageView.animatedImage        = image6;
    imageView.frame                = _LogoJPG.bounds;//CGRectMake(0.0, 0.0, _LogoJPG.bounds.size.width, _LogoJPG.frame.size.height); //As your Wish you can set frame
    NSLog(@"%f",_LogoJPG.bounds.size.width);
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    [_LogoJPG addSubview:imageView];
//  [_LogoJPG addSubview:imageView];
    
    
    
}
-(void)startLoading{
    count++;
    int sec = floor(count/100);
    if((count%15)==0){
        if([_MainTitle.text isEqualToString:@"Loading.."]){
          _MainTitle.text=@"Loading...";
        }
        else if([_MainTitle.text isEqualToString:@"Loading..."]){
          _MainTitle.text=@"Loading.";
        }
        else if([_MainTitle.text isEqualToString:@"Loading."]){
          _MainTitle.text=@"Loading..";
        }
    }
    
    if(sec> 1.5){
        [loadingTimer invalidate];
        loadingTimer = nil;
        
        MainViewController *main = [self.storyboard instantiateViewControllerWithIdentifier:@"MainView"];
        [self presentViewController:main animated:YES completion:nil];
    }
}

@end
