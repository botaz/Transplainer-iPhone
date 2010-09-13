
// URL
#define BASE_URL @"http://cort.local:3000"
#define SERVICEURL(path) [NSString stringWithFormat:@"%@%@", BASE_URL, path]

// Timeout Request
#define RequestTimeOutSeconds 60.0

// Performance
#define PerformanceFinishedDownloadingForFormat @"PerformanceFinishedDownloadingForFormat"
#define PerformanceFinishedParsingForFormat @"PerformanceFinishedParsingForFormat"

typedef enum {
    StartedStatus,        
    DownloadedStatus,    
    ParsedStatus
} PerformanceStatus;  

