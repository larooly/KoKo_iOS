//
//  CanvasViewController.m
//  kkk
//
//  Created by active on 2020/05/27.
//  Copyright © 2020 activeKJS. All rights reserved.
//

#import "CanvasViewController.h"

@interface CanvasViewController ()

@end

@implementation CanvasViewController
int basiclayer;
float rotateDegree;



@synthesize totalview;
- (void)viewDidLoad {
    [super viewDidLoad];
    rotateDegree=0;
    // Do any additional setup after loading the view.
    [[NSUserDefaults standardUserDefaults]setObject:UIImagePNGRepresentation(NULL) forKey:@"newBack"];

    [[NSUserDefaults standardUserDefaults]setFloat:10 forKey:@"newPen"];
    _newPensize=10.0;
     basiclayer= (int)self.view.layer.sublayers.count;
    NSLog(@"!!!basiclayer:  %d",basiclayer);
   // NSLog(@"#classname %@",self);
    //(@"!!! %d",_totalview.layer.sublayers.count);
    
    ClearNow =[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(Testremove) userInfo:nil repeats:YES];
   
}
#pragma mark - "선그리기"
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch =[[event allTouches] anyObject];
    CGPoint pt =[touch locationInView:self.view];
    backX= pt.x;
    backY= pt.y;
    nowX=pt.x;
    nowY= pt.y;
    
//    NSData *imageData =[[NSUserDefaults standardUserDefaults]objectForKey:@"newBack"];
//    UIImage *kk =[UIImage imageWithData:imageData];
//    _backgroundImage.image=kk;
    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    //이건 원그리기
        UITouch *touch =[[event allTouches] anyObject];
        CGPoint pt =[touch locationInView:self.view];
    if([[NSUserDefaults standardUserDefaults]floatForKey:@"newPen"]>0){
    _newPensize= [[NSUserDefaults standardUserDefaults]floatForKey:@"newPen"];
    }
    _newRed= [[NSUserDefaults standardUserDefaults]floatForKey:@"newRed"];
    _newBlue= [[NSUserDefaults standardUserDefaults]floatForKey:@"newBlue"];
    _newGreen= [[NSUserDefaults standardUserDefaults]floatForKey:@"newGreen"];
//
//        CAShapeLayer *circleLayer = [CAShapeLayer layer];
//        [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(pt.x, pt.y, 5, 5)] CGPath]];//도형 모양설정
//        [circleLayer setFillColor:[[UIColor colorWithRed:0 green:1 blue:1 alpha:1]CGColor]];//색 지정
//        [[self.view layer] addSublayer:circleLayer];
    
        //이러면 모양이 속도 측정기처럼 나온다
    //    UIView *line =[[UIView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 10)];
    //    [line setBackgroundColor:[UIColor yellowColor]];
    //    [self.view addSubview:line];//완전 수평선
    
    /////요건 선 그리기////////
    CAShapeLayer *line = [CAShapeLayer layer];
    UIBezierPath *linePath=[UIBezierPath bezierPath];
    nowX=pt.x;
    nowY= pt.y;
    [linePath moveToPoint:CGPointMake(backX, backY)];
    [linePath addLineToPoint:CGPointMake(nowX, nowY)];
    line.lineWidth = _newPensize;//선 두께10.0
    
    line.path=linePath.CGPath;//벨지에 연결
      //  line.fillColor = [[UIColor colorWithRed:0 green:1 blue:1 alpha:1]CGColor];
    line.lineCap=kCALineCapRound;//모서리 둥글게 만들어주는 부분
    
    
    
    
    
    //여기서부터 갈린다.
    bool PEPE= [[NSUserDefaults standardUserDefaults]boolForKey:@"PenChangeEraser"];
    if(PEPE){//연필이면
        line.strokeColor = [[UIColor colorWithRed:_newRed green:_newGreen blue:_newBlue alpha:1]CGColor];//선색깔
  
        [[self.view layer] addSublayer:line];//이걸쓰면 고양그림이 가능할듯?
       
    }
    else{//지우개면
        line.backgroundColor=[UIColor whiteColor].CGColor;
        line.strokeColor = [UIColor blackColor].CGColor;//선색깔
        
       // /================
        UIImageView *dot =[[UIImageView alloc] initWithFrame:_backgroundImage.frame];
        dot.image=_backgroundImage.image;
        CGFloat radians = rotateDegree * M_PI/180;
        dot.backgroundColor=UIColor.whiteColor;
        dot.transform = CGAffineTransformMakeRotation(radians);
        dot.frame=totalview.frame;
        dot.contentMode=UIViewContentModeScaleAspectFit;
        //배경 뷰 생성
        
        
        //==============
        UIView *newV=[[UIView alloc] initWithFrame:totalview.frame];
        [newV addSubview:dot];
        newV.layer.mask=line;
        CGRect rect =[newV bounds];
        UIGraphicsBeginImageContextWithOptions(rect.size,NO,0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [newV.layer renderInContext:context];
        UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();//구멍난이미지저장
        
        newV.layer.contents=(id)([image CGImage]);//레이어에저장
        [[self.view layer] addSublayer:newV.layer];
        //==============
        
    }
   backX= nowX;
    backY= nowY;

   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//-(void)RotateImageBack{
//    rotateDegree+=90.0f;
//    CGFloat degree = rotateDegree;//+오른쪽/-왼쪽
//    CGFloat radians = degree * M_PI/180;
//    _backgroundImage.transform = CGAffineTransformMakeRotation(radians);
//
//}

#pragma mark - "테스트용"
/*- (IBAction)TTTTTestAction:(id)sender {
//    CAShapeLayer *circleLayer = [CAShapeLayer layer];
//    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(150,150, 200, 200)] CGPath]];//도형 모양설정
//    [circleLayer setFillColor:[[UIColor redColor]CGColor]];//색 지정// //UIColor colorWithRed:0 green:1 blue:1 alpha:1
   
     UIImageView *dot =[[UIImageView alloc] initWithFrame:_backgroundImage.frame];
   dot.image=_backgroundImage.image;
   CGFloat radians = rotateDegree * M_PI/180;
   dot.backgroundColor=UIColor.whiteColor;
   dot.transform = CGAffineTransformMakeRotation(radians);
   dot.frame=_backgroundImage.frame;
   dot.contentMode=UIViewContentModeScaleAspectFit;
   //뷰생성은 잘됬다.뜯어붙일배경이미지
      CAShapeLayer *masklayer=[CAShapeLayer layer];
      masklayer.backgroundColor =[UIColor whiteColor].CGColor;
      CGRect pathRect = CGRectMake(0,0 , 100, 600);
      UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:pathRect];
      masklayer.path=path.CGPath;
      masklayer.fillColor=[UIColor blackColor].CGColor;//이건 마스크
   UIView *newV=[[UIView alloc] initWithFrame:totalview.frame];
   //회전으로인해 구멍뚫은 곳의 위치가 바뀌어서 여기서 구멍뚫는다.
   [newV addSubview:dot];//일단 연결
   newV.layer.mask=masklayer;//구멍뚫기
   CGRect rect =[newV bounds];
   UIGraphicsBeginImageContext(rect.size);
   CGContextRef context = UIGraphicsGetCurrentContext();
   [newV.layer renderInContext:context];
   UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();//구멍난이미지저장
   newV.layer.contents=(id)([image CGImage]);//레이어에저장
   [[self.view layer] addSublayer:newV.layer];
   //레이어로 추가->뷰로 추가하면 난리난다.
}*/
/*
-(void)ShadowAdd:(CALayer *)lline{
    lline.shadowColor=UIColor.blackColor.CGColor;
    //line.shadowOffset = CGSize(width: 0.0, height: 2.0)
    lline.shadowOpacity = 1;
    lline.shadowRadius = 3;
    lline.shadowOffset=CGSizeMake(-10, 0);
    [[self.view layer] addSublayer:lline];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for(int i=(int)self.view.layer.sublayers.count;i>basiclayer;i--){
        [self ShadowAdd: self.view.layer.sublayers[i-1]];
        
    }
}
 */



#pragma mark - "자주 쓰이는 부분"
-(void)deleteOnlyDraw{//선날리기
    for(int i=(int)self.view.layer.sublayers.count;i>basiclayer;i--){
        CALayer *layer= self.view.layer.sublayers[i-1];
        [layer removeFromSuperlayer];
    }
}


//시간에따른 변화값
#pragma mark - "타이머 연동 함수"
-(void)Testremove {
//    for(CALayer *layer in self.view.layer.sublayers){
//        [layer removeFromSuperlayer];
//    }view.layer.sublayers
//  싹지워 함수
    //선만 다지우기
    bool isNow = [[NSUserDefaults standardUserDefaults]boolForKey:@"ClearAction"];
    if(isNow){
        [self deleteOnlyDraw];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"ClearAction"];
    }
    //////////////////배경 바꾸기
    NSData *imageData =[[NSUserDefaults standardUserDefaults]objectForKey:@"newBack"];
    if(imageData){
       UIImage *kk =[UIImage imageWithData:imageData];
       _backgroundImage.image= kk;
        rotateDegree=0;
         _backgroundImage.transform = CGAffineTransformMakeRotation(0);
        [[NSUserDefaults standardUserDefaults]setObject:UIImagePNGRepresentation(NULL) forKey:@"newBack"];
    }
    ////////////회전하기
    bool rotate =[[NSUserDefaults standardUserDefaults]boolForKey:@"RotateNow"];
    if(rotate){
        rotateDegree+=90.0f;
        CGFloat degree = rotateDegree;//+오른쪽/-왼쪽
        CGFloat radians = degree * M_PI/180;
        _backgroundImage.frame = totalview.frame;
        _backgroundImage.transform = CGAffineTransformMakeRotation(radians);
        _backgroundImage.frame = totalview.frame;
            _backgroundImage.contentMode=UIViewContentModeScaleAspectFit;
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"RotateNow"];
        [self deleteOnlyDraw];
    }
    //전체 초기화
    bool allclear=[[NSUserDefaults standardUserDefaults]boolForKey:@"AllClear"];
    if(allclear){
        rotateDegree=0;
        [self deleteOnlyDraw];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"ClearAction"];
        _backgroundImage.image= NULL;
        [[NSUserDefaults standardUserDefaults]setObject:UIImagePNGRepresentation(NULL) forKey:@"newBack"];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"AllClear"];
        _backgroundImage.transform = CGAffineTransformMakeRotation(0);

    }
    ///////////////
    
    
}

@end
