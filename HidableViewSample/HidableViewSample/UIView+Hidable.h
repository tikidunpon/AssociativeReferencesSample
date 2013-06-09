
#import <UIKit/UIKit.h>

@interface UIView (Hidable)

- (void)switchShowHide;     // 表示非表示の切り替え
- (BOOL)isHide;             // 非表示かどうか

@property (nonatomic)CGRect showFrame;
@property (nonatomic)CGRect hideFrame;

@end
