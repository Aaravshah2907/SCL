<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
  <body>
      <table>
      <tr>
        <th>Country</th>
        <th>Capital</th>
      </tr>
      <xsl:for-each select="Countries/Country">
        <tr>
          <td><xsl:value-of select="Name"/></td>
          <td><xsl:value-of select="Capital"/></td>
        </tr>
      </xsl:for-each>
    </table>
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>