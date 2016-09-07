//
//  ViewController.m
//  WPShopingCartViewController
//
//  Created by 吴鹏 on 16/9/7.
//  Copyright © 2016年 wupeng. All rights reserved.
//

#import "WPViewController.h"
#import "WPShopingCartTableViewCell.h"

@interface WPTableView : UITableView

@end

@implementation WPTableView

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
    return YES;
}
- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{

    return NO;
}

@end

@interface WPViewController ()<UITableViewDelegate,UITableViewDataSource,WPShopingCartTableViewCellDelegate>

@property (nonatomic , strong) WPTableView * tableView;
@property (nonatomic , strong) NSMutableArray  * dataArray;
@property (nonatomic , strong) NSMutableArray * chooseArray;/**被选中的数组*/
@property (nonatomic , strong) UIView * topView;/**最上面的view*/
@property (nonatomic , strong) NSMutableArray * viewArray;/**存储5个view*/
@property (nonatomic , strong) NSArray * colorArray;

@end

@implementation WPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    NSArray * dataArray1 = @[@"柿子",
                             @"茄子",
                             @"黄瓜",
                             @"土豆",
                             @"南瓜",
                             @"大葱",
                             @"大蒜",
                             @"豆角",
                             @"巴豆",
                             @"葫芦",
                             @"葫芦",
                             @"葫芦",
                             @"葫芦",
                             @"葫芦",
                             @"葫芦",
                             @"葫芦",
                             @"竹笋"];
    self.colorArray = @[[UIColor blueColor],[UIColor blackColor],[UIColor grayColor],[UIColor greenColor],[UIColor orangeColor]];
    
    self.dataArray = [NSMutableArray arrayWithArray:dataArray1];
    self.chooseArray = [NSMutableArray array];
    self.viewArray = [NSMutableArray array];
    
    self.title = @"shopingCart";
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    [self setTopViewUI];
    
}

#pragma mark - property

- (WPTableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[WPTableView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setCanCancelContentTouches:YES];
        [_tableView setDelaysContentTouches:NO];
    }
    return _tableView;
}

- (UIView *)topView
{
    if(!_topView)
    {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(-CGRectGetWidth(self.view.frame), 64, CGRectGetWidth(self.view.frame), 70)];
        
        _topView.clipsToBounds = YES;
        
    }
    return _topView;
}

#pragma mark - UITableViewDelegate & UITableViewDataDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * str = @"cell";
    WPShopingCartTableViewCell * cell = (WPShopingCartTableViewCell *)[tableView dequeueReusableCellWithIdentifier:str];
    if(cell == nil)
    {
        cell = [[WPShopingCartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    [cell wp_getContentLabelText:self.dataArray[indexPath.row]];
    cell.delegate = self;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



#pragma mark - WPShopingCartTableViewDlegate

- (void)wp_shopingCartCell:(WPShopingCartTableViewCell *)cell
{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    [self.chooseArray addObject:self.dataArray[indexPath.row]];
    /**因为最上面只出现了5个view 所以要<= 5*/
    if(self.chooseArray.count <= 5)
    {
        UILabel * label = self.viewArray[5 - self.chooseArray.count];
        label.text = self.dataArray[indexPath.row];
        [self refreshUI];
        
        if(self.chooseArray.count == 5)
        {
            self.tableView.userInteractionEnabled = NO;
            
            [UIView animateWithDuration:1
                                  delay:1
                 usingSpringWithDamping:0.5
                  initialSpringVelocity:10
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 
                                 self.topView.frame = CGRectMake(-30,
                                                                 64,
                                                                 CGRectGetWidth(self.view.frame) + 30,
                                                                 70);
                             } completion:^(BOOL finished) {
                                 for(NSInteger i = self.viewArray.count - 1 ; i >= 0 ; i--)
                                 {
                                     [self animation:4-i view:self.viewArray[i]];
                                 }
                             }];
            
        }
    }

    [self.dataArray removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}

#pragma mark - private

/**
 * 调整整个的topview 将一个个制作好的 小view 展现出来
 */

- (void)refreshUI
{
    float vspace = 10;
    float width = (CGRectGetWidth(self.view.frame) - vspace * 6)/5;
    if(self.chooseArray.count > 0)
    {
        self.tableView.frame = CGRectMake(0,
                                          70 + 64,
                                          CGRectGetWidth(self.view.frame),
                                          CGRectGetHeight(self.view.frame)-70 - 64);
        [UIView animateWithDuration:1
                              delay:0
             usingSpringWithDamping:0.5
              initialSpringVelocity:10
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
            
                             self.topView.frame = CGRectMake(-CGRectGetWidth(self.view.frame) + self.chooseArray.count * (vspace + width) + vspace,
                                                             64,
                                                             CGRectGetWidth(self.view.frame),
                                                             70);
        } completion:^(BOOL finished) {
            
        }];
    }
}


- (void)animation:(NSInteger)index view:(UIView *)view;
{
    [UIView animateWithDuration:0.3
                          delay:(0.15 + index*0.15f)
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         view.frame = CGRectMake(CGRectGetWidth(self.view.frame) + 60,
                                                 view.frame.origin.y,
                                                 view.frame.size.width,
                                                 view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         
                         if(index == 4)
                         {
                             [self resumedUI];
                         }
                         
                     }];
}

/**
 * 将数据恢复到最初
 */

- (void)resumedUI
{
    [self.chooseArray removeAllObjects];
    [self.viewArray removeAllObjects];
    self.tableView.userInteractionEnabled = YES;
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.tableView.frame = CGRectMake(0,
                                                           64,
                                                           CGRectGetWidth(self.view.frame),
                                                           CGRectGetHeight(self.view.frame)-64);
    } completion:nil];
    self.topView.frame = CGRectMake(-CGRectGetWidth(self.view.frame),
                                    64,
                                    CGRectGetWidth(self.view.frame),
                                    70);
    [self setTopViewUI];

}

/**
 * 设置topview上的5个小view 可以根据自己的需要去定制view
 */

- (void)setTopViewUI
{
    for(UIView * view in self.topView.subviews)
        [view removeFromSuperview];
    float vspace = 10;
    float hspace = 5;
    float width = (CGRectGetWidth(self.view.frame) - vspace * 6)/5;
    float height = 70 - hspace * 2;
    
    for(NSInteger i = 0 ; i < 5 ;i++)
    {
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(vspace *(i+1) + i * width,
                                                                   hspace,
                                                                   width,
                                                                   height)];
        label.backgroundColor = self.colorArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:18];
        
        
        [self.viewArray addObject:label];
        [self.topView addSubview:label];
        
    }
}

@end
