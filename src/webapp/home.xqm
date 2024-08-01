module namespace home = "example/home";

declare namespace MyJava = "java:example.MyJava";
declare namespace AwsS3Facade = "java:example.AwsS3Facade";

declare
  %rest:path("/")
  %output:method("html")
function home:root() {
  <html>
  <body>
  <p>Hello Balisage!</p>
  <p><a href="/system">Show configuration</a></p>
  <p><a href="/xslt">XSLT</a></p>
  <p><a href="/greet1">Java (static method)</a></p>
  <p><a href="/greet2">Java (object instance)</a></p>
  <p><a href="/S3Download">AWS S3 download</a></p>
  </body>
  </html>
};


declare
  %rest:path("/system")
function home:system () {
  db:system()
};


declare
  %rest:path('/xslt')
  %output:method("text")
  %output:media-type("text/html")
function home:xslt() {
  let $xml := doc('../xslt/process2.xml')
  let $xslt := doc('../xslt/process2.xsl')
  return xslt:transform-text($xml, $xslt)
};

declare
  %rest:path("/greet1")
  %output:method("html")
function home:greet1() {
  MyJava:greet1()
};


declare
  %rest:path("/greet2")
  %output:method("html")
function home:greet2() {
  let $instance := MyJava:new()
  return MyJava:greet2($instance)
};

declare
  %rest:path("/S3Download")
  %output:method("text")
function home:S3Download() {
  let $tempFile := file:temp-dir() || "balisage.txt"
  let $s3facade := AwsS3Facade:new("eu-west-1")
  return (
    AwsS3Facade:downloadFileFromS3($s3facade, "jats-dev", "balisage.txt", $tempFile),
    file:read-text($tempFile)
  )
};

