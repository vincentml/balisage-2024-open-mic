(:~ schedule the cleanup jobs. :)
declare variable $static_path := static-base-uri() => replace('[/\\]$', '') => replace('[^/\\]+$', '');
job:remove('cleanup-temp', map { 'service': true() }),
job:eval(xs:anyURI($static_path || 'cleanup-temp.xq'), (), map { 'id':'cleanup-temp', 'interval':'PT1H', 'service': true() })
