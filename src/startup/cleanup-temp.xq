(:~ 
 : Cleanup 
 : deletes old temporary files.
 : intended to be invoked as a scheduled job.
 :)
 
(:~ 
 : age can be provided as a parameter in xs:dayTimeDuration format
 :)
declare variable $age external := 'PT1H';
declare variable $pattern external := 'balisage-2024-open-mic';

let $cutoff := current-dateTime() - xs:dayTimeDuration($age)
let $tempDirs := file:children(file:temp-dir())[matches(., $pattern)][file:last-modified(.) lt $cutoff]
return (
  admin:write-log('cleanup delete items in temporary folder older than ' || $cutoff || ' that match ' || $pattern),
  for $tmp in $tempDirs return (
    admin:write-log('cleanup deleting temp folder ' || $tmp),
    file:delete($tmp, true())
  )
)
