#import "PerformanceElementViewController.h"

@implementation PerformanceElementViewController

@synthesize downloadTime=_downloadTime;
@synthesize parseTime=_parseTime;
@synthesize status=_status;
@synthesize downloadLabel=_downloadLabel;
@synthesize parseLabel=_parseLabel;
@synthesize startImage=_startImage;
@synthesize downloadImage=_downloadImage;
@synthesize parseImage=_parseImage;
@synthesize formatLabel=_formatLabel;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self resetView];
	
	[self addObserver:self 
		   forKeyPath:@"status"
			  options:NSKeyValueObservingOptionNew
			  context:@selector(statusChanged:)];
}

- (void)resetView
{	
	self.startImage.image = [UIImage imageNamed:@"performance_black_status.png"];
	self.downloadImage.image = [UIImage imageNamed:@"performance_black_status.png"];
	self.parseImage.image = [UIImage imageNamed:@"performance_black_status.png"];
	
	self.downloadLabel.text = @"N/A";
	self.parseLabel.text = @"N/A";
}

- (void)statusChanged:(id)sender
{
	switch (self.status) {
		case StartedStatus:
			self.startImage.image = [UIImage imageNamed:@"performance_green_status.png"];
			break;
		case DownloadedStatus:
			self.downloadImage.image = [UIImage imageNamed:@"performance_orange_status.png"];
			break;
		case ParsedStatus:
			self.parseImage.image = [UIImage imageNamed:@"performance_red_status.png"];
			break;
		default:
			break;
	}
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[self removeObserver:self forKeyPath:@"status"];
	
	[_formatLabel release];
	[_downloadLabel release];
	[_parseLabel release];
	[_startImage release];
	[_downloadImage release];
	[_parseImage release];
	
    [super dealloc];
}


@end
