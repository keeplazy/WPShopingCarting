//
//  WPShopingCartTableViewCell.m
//  WPShopingCartViewController
//
//  Created by 吴鹏 on 16/9/7.
//  Copyright © 2016年 wupeng. All rights reserved.
//

#import "WPShopingCartTableViewCell.h"

@interface WPShopingCartTableViewCell ()
{
    CGPoint startPoint;
}

@property (nonatomic , strong) UILabel * sliderView;/**侧边的view我这里默认的是个lable 你可以根据自己需要去定制*/
@property (nonatomic , strong) UIView * menuView;/**根据自己需要去定制*/
@property (nonatomic , strong) UILabel * contentLabel;

@end

@implementation WPShopingCartTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for(UIView * view in self.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    
    [self.contentView addSubview:self.sliderView];
    [self.contentView addSubview:self.menuView];
}

#pragma mark - property

- (UILabel *)sliderView
{
    if(!_sliderView)
    {
        _sliderView = [[UILabel alloc]initWithFrame:CGRectMake(-CGRectGetWidth(self.frame), 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        _sliderView.textAlignment = NSTextAlignmentRight;
        _sliderView.textColor = [UIColor whiteColor];
        _sliderView.font = [UIFont systemFontOfSize:18];
        _sliderView.backgroundColor = [UIColor orangeColor];
        _sliderView.text = @"加入购物车";
    }
    return _sliderView;
}

- (UIView *)menuView
{
    if(!_menuView)
    {
        _menuView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        _menuView.backgroundColor = [UIColor brownColor];
        [_menuView addSubview:self.contentLabel];
        
    }
    return _menuView;
}

- (UILabel *)contentLabel
{
    if(!_contentLabel)
    {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, CGRectGetWidth(self.frame), 70)];
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.font = [UIFont systemFontOfSize:18];
    }
    return _contentLabel;
}

#pragma mark - private

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)animation:(float)x
{
    self.sliderView.frame = CGRectMake(-CGRectGetWidth(self.frame) + x,0  , CGRectGetWidth(self.frame),  CGRectGetHeight(self.frame));
    self.menuView.frame = CGRectMake(x, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (void)wp_getContentLabelText:(NSString *)str
{
    self.contentLabel.text = str;
}

# pragma mark - UITouch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    startPoint = [[touches anyObject]locationInView:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    
    float x = point.x - startPoint.x;
    if(x >= 0)
    {
        [self animation:x];
    }else
    {
        [self animation:0];
    }
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    float x = point.x - startPoint.x;
    float progress = x / CGRectGetWidth(self.frame);
    
    if(progress >= 0.5)
    {
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self animation:CGRectGetWidth(self.frame)];
        } completion:^(BOOL finished) {
            if(self.delegate && [self.delegate respondsToSelector:@selector(wp_shopingCartCell:)])
            {
                [self.delegate wp_shopingCartCell:self];
            }
            //当选中的事 需要讲view 恢复原样（因为当cell被复用有的view没有被复原）
            
            [self animation:0];
        }];
    
    }
    else
    {
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self animation:0];
        } completion:^(BOOL finished) {
            
        }];
    }
}



@end
