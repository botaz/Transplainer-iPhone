#import <UIKit/UIKit.h>

@interface PerformanceElementViewController : UIViewController {
	NSTimeInterval _downloadTime;
	NSTimeInterval _parseTime;
	
	PerformanceStatus _status;
	
	UILabel *_formatLabel;
	
	UILabel *_downloadLabel;
	UILabel *_parseLabel;
	
	UIImageView *_startImage;
	UIImageView *_downloadImage;
	UIImageView *_parseImage;
}

@property (nonatomic) NSTimeInterval downloadTime;
@property (nonatomic) NSTimeInterval parseTime;
@property (nonatomic) PerformanceStatus status;

@property (nonatomic, retain) IBOutlet UILabel *formatLabel;

@property (nonatomic, retain) IBOutlet UILabel *downloadLabel;
@property (nonatomic, retain) IBOutlet UILabel *parseLabel;

@property (nonatomic, retain) IBOutlet UIImageView *startImage;
@property (nonatomic, retain) IBOutlet UIImageView *downloadImage;
@property (nonatomic, retain) IBOutlet UIImageView *parseImage;

- (void)resetView;
- (void)statusChanged:(id)sender;

@end
