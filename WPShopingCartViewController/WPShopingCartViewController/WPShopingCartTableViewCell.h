//
//  WPShopingCartTableViewCell.h
//  WPShopingCartViewController
//
//  Created by 吴鹏 on 16/9/7.
//  Copyright © 2016年 wupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WPShopingCartTableViewCell;
@protocol WPShopingCartTableViewCellDelegate <NSObject>

- (void)wp_shopingCartCell:(WPShopingCartTableViewCell *)cell;

@end

@interface WPShopingCartTableViewCell : UITableViewCell

@property (assign)id<WPShopingCartTableViewCellDelegate>delegate;

- (void)wp_getContentLabelText:(NSString *)str;

@end
