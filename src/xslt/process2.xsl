<xsl:stylesheet version="3.0"	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" encoding="us-ascii" indent="no" html-version="5.0"/>

    <xsl:template match="article">
        <html>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
        
    <xsl:template match="para">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
</xsl:stylesheet>