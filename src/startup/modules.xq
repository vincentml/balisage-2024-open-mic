declare function local:install ($namespace as xs:string, $version as xs:string, $url as xs:string) {
  if (repo:list()[@name = $namespace][not(@version = $version)]) then (
    repo:delete($namespace)
  ),
  if (repo:list()[@name = $namespace][@version = $version]) then () else (
    'Installing XQuery module ' || $url,
    repo:install($url)
  )
};

let $modules :=
<modules>
  <module
    namespace="http://www.functx.com"
    url="https://www.datypic.com/xq/functx-1.0.1-doc.xq"
    version="1.0.1"
  />
  <module 
    namespace="https://doi.org/10.5281/zenodo.1495494"
    url="https://github.com/schxslt/schxslt/releases/download/v1.10.1/schxslt-basex-1.10.1.xar"
    version="1.10.1"
  />
</modules>
return $modules/module/local:install(@namespace, @version, @url)
