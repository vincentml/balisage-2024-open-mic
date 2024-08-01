# Resource Files

Software such as BaseX, Saxon, oXygen, and XSpec should be configured to use the XML Catalog file `catalog.xml` so that references to the DTDs appearing in XML documents can be resolved to these files.

The DTDs in this folder are typically flattened (compressed) versions of publicly available DTDs. The tools used to flatten DTDs are *DTD Analyzer* and *SGML-DTDParse*

## DTD Analyzer

[DTD Analyzer](https://dtd.nlm.nih.gov/ncbi/dtdanalyzer/) requires [Java](https://java.com).

Example of usage from the command line:

```
dtdflatten -s atypon-archivearticle3.dtd atypon-nlm-v3.0.5-article.dtd
```

where "atypon-archivearticle3.dtd" is the file name of the input DTD and "atypon-nlm-v3.0.5-article.dtd" is the output file name.

This tool seems to output subtle differences in certain types of attributes, although these differences do not seem to be significant.

* Attributes defined as CDATA are output as CDATA #IMPLIED.
* Attributes defined as NOTATION are output as CDATA #IMPLIED.

The `dtdcompare` tool can produce a report that shows any differences between the original and flattened DTDs.

```
dtdcompare -s original.dtd -s flat.dtd report.html
```


## SGML-DTDParse

[SGML-DTDParse](https://metacpan.org/release/EHOOD/SGML-DTDParse-2.00) requires [Perl 5](http://strawberryperl.com/) and can be installed using cpan.

Example of usage from the command line:

```
dtdflatten --declaration --xml --output atypon-nlm-v3.0.5-issuexml.dtd issue.dtd
```

where "issuexml.dtd" is the file name of the input DTD and "atypon-nlm-v3.0.5-issue.dtd" is the output file name.

The `dtddiff` tool can produce a report that shows any differences between the original and flattened DTDs. See the [instructions](https://metacpan.org/pod/release/EHOOD/SGML-DTDParse-2.00/bin/dtddiff) for details.
