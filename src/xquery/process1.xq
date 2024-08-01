declare variable $source external := 'files/in';
declare variable $dest external := 'files/out';

let $archive := file:resolve-path($source) => archive:create-from()
let $path := file:resolve-path($dest) || file:dir-separator() || 'archive.zip'
return file:write-binary($path, $archive)
