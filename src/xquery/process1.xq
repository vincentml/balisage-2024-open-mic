declare variable $inputPath external := 'files/in';
declare variable $outputPath external := 'files/out';

let $archive := file:resolve-path($inputPath) => archive:create-from()
let $path := file:resolve-path($outputPath) || file:dir-separator() || 'archive.zip'
return file:write-binary($path, $archive)
