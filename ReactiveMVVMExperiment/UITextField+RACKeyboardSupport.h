#import <UIKit/UIKit.h>

@interface UITextField (RACKeyboardSupport)

- (RACSignal *)rac_keyboardReturnSignal;

@end
