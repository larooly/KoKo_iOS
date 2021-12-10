//
//  PenSettingViewController.m
//  kkk
//
//  Created by active on 2020/05/27.
//  Copyright © 2020 activeKJS. All rights reserved.
//

#import "PenSettingViewController.h"
#import "CanvasViewController.h"
@interface PenSettingViewController ()

@end

@implementation PenSettingViewController
float red,green,blue,pensize;
- (void)viewDidLoad {
    [super viewDidLoad];
    red=0;
    green=0;
    blue=0;
    pensize=10;
    if([[NSUserDefaults standardUserDefaults]floatForKey:@"newPen"]>=0){
        NSLog(@"s");
        _sizeslider.value=[[NSUserDefaults standardUserDefaults]floatForKey:@"newPen"];
        _redslider.value=[[NSUserDefaults standardUserDefaults]floatForKey:@"newRed"];
        _blueslider.value=[[NSUserDefaults standardUserDefaults]floatForKey:@"newBlue"];
        _greenslider.value=[[NSUserDefaults standardUserDefaults]floatForKey:@"newGreen"];
        
        red=_redslider.value;
        green=_greenslider.value;
        blue=_blueslider.value;
        pensize=_sizeslider.value;
        _memowidth.constant= _sizeslider.value;
        _memoheight.constant = _sizeslider.value;
       _showNowPen.layer.cornerRadius=_sizeslider.value/2;
        NSLog(@"reSizing");
        _showNowPen.backgroundColor=[UIColor colorWithRed:_redslider.value green:_greenslider.value blue:_blueslider.value alpha:1];

        
        
    }
    else{
        NSLog(@"o");
        _sizeslider.value=10;
        _redslider.value=0;
        _blueslider.value=0;
        _greenslider.value=0;
        _memowidth.constant= _sizeslider.value;
        _memoheight.constant = _sizeslider.value;
        _showNowPen.layer.cornerRadius=_sizeslider.value/2;
        _showNowPen.backgroundColor=[UIColor colorWithRed:_redslider.value green:_greenslider.value blue:_blueslider.value alpha:1];
        
    }
    
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ClosedoNothing:(id)sender {//걍 닫기
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)ClosedChangesetting:(id)sender {//변경후 저장 후 가기
    
     CanvasViewController *goCanvas =[self.storyboard instantiateViewControllerWithIdentifier:@"CanvasView"];
    goCanvas.newPensize=pensize;
    [[NSUserDefaults standardUserDefaults]setFloat:pensize forKey:@"newPen"];
    [[NSUserDefaults standardUserDefaults]setFloat:red forKey:@"newRed"];
    [[NSUserDefaults standardUserDefaults]setFloat:blue forKey:@"newBlue"];
    [[NSUserDefaults standardUserDefaults]setFloat:green forKey:@"newGreen"];
    NSLog(@"%f , %f , %f , %f",pensize,red,green,blue);
           
     [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
- (IBAction)bluesliderMove:(id)sender {
    UISlider *sl=(UISlider *)sender;
    blue = sl.value;
    _showNowPen.backgroundColor=[UIColor colorWithRed:red green:green blue:blue alpha:1];
}

- (IBAction)greensliderMove:(id)sender {
    UISlider *sl=(UISlider *)sender;
    green= sl.value;
    _showNowPen.backgroundColor=[UIColor colorWithRed:red green:green blue:blue alpha:1];
}

- (IBAction)redsliderMove:(id)sender {
    UISlider *sl=(UISlider *)sender;
    red = sl.value;
    _showNowPen.backgroundColor=[UIColor colorWithRed:red green:green blue:blue alpha:1];
}

- (IBAction)sizesliderMove:(id)sender {
     UISlider *sl=(UISlider *)sender;
    pensize= sl.value;
    _memowidth.constant= sl.value;
    _memoheight.constant = sl.value;
    _showNowPen.layer.cornerRadius=sl.value/2;
  
    
}
@end
