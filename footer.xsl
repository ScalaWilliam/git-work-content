<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:saxon="http://saxon.sf.net/dtd"
        version="2.0">
        
        

    <xsl:template match="body">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
        <hr/>
            
            
            
            
        <xsl:value-of select="'&amp;copy;'" disable-output-escaping="yes"/> 2016 Apt Elements
    </xsl:template>

    <xsl:template match="@*|node()">
            
            
            
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
