
#import "UIView+Hidable.h"
#import <objc/runtime.h>

@implementation UIView (Hidable)

static char showRectKey; // 表示フレーム用のキー
static char hideRectKey; // 非表示フレーム用のキー

@dynamic showFrame,hideFrame;

#pragma mark - Setter/Getter

// 表示フレームの保持
- (void)setShowFrame:(CGRect)inFrame
{
    NSValue *value = [NSValue valueWithCGRect:inFrame];
    objc_setAssociatedObject(self, &showRectKey,
                             value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 非表示フレームの保持
- (void)setHideFrame:(CGRect)inFrame
{
    NSValue *value = [NSValue valueWithCGRect:inFrame];
    objc_setAssociatedObject(self, &hideRectKey, value,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 保持された表示時フレームの取得
- (CGRect)showFrame
{
    return [objc_getAssociatedObject(self, &showRectKey) CGRectValue];
}

// 保持された非表示時フレームの取得
- (CGRect)hideFrame
{
    return [objc_getAssociatedObject(self, &hideRectKey) CGRectValue];
}

#pragma mark - Show Hide Function

// 表示非表示の切り替え
- (void)switchShowHide
{
    // 非表示なら表示する
    [self isHide] ? [self show] : [self hide];
}

// 表示処理 (保持している表示フレームがある時のみ実行)
- (void)show
{
    if (!CGRectEqualToRect(self.showFrame, CGRectZero)) {
        [self setHideFrame:self.frame];
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.frame = self.showFrame;
                         } completion:^(BOOL finished) {
                         }];
    }
}

// 非表示処理 (保持している非表示フレームがある時のみ実行)
- (void)hide
{
    if (!CGRectEqualToRect(self.hideFrame, CGRectZero)) {
        [self setShowFrame:self.frame];
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.frame = self.hideFrame;
                         } completion:^(BOOL finished) {
                         }];
    }
}

// 非表示かどうかを返す 画面内にViewがあるかどうかで判定
- (BOOL)isHide
{
    return !CGRectContainsRect([[UIScreen mainScreen] applicationFrame],self.frame);
}

@end
