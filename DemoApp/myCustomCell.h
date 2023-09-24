//
//  myCustomCell.h
//  DemoApp
//
//  Created by Kumar Anand on 23/09/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface myCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *minimumTempLbl;
@property (weak, nonatomic) IBOutlet UILabel *maximumTempLbl;

@end

NS_ASSUME_NONNULL_END
