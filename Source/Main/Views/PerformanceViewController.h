#import <UIKit/UIKit.h>
#import "PerformanceElementViewController.h"

@interface PerformanceViewController : UIViewController {
	NSDate *_xmlStartedAt;
	NSDate *_jsonStartedAt;
	NSDate *_plistStartedAt;
	
	UIScrollView *_scrollView;
	
	PerformanceElementViewController *_xmlController;
	PerformanceElementViewController *_jsonController;
	PerformanceElementViewController *_plistController;
	
	NSManagedObjectContext *_managedObjectContext;
}


@property (nonatomic, retain) NSDate *xmlStartedAt;
@property (nonatomic, retain) NSDate *jsonStartedAt;
@property (nonatomic, retain) NSDate *plistStartedAt;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet PerformanceElementViewController *xmlController;
@property (nonatomic, retain) IBOutlet PerformanceElementViewController *jsonController;
@property (nonatomic, retain) IBOutlet PerformanceElementViewController *plistController;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (IBAction)startDownloading:(id)sender;

@end
