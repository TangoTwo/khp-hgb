<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
	<html>
		<head> <title>XML Address Book</title> </head>
		<body>
			<table border="3" cellspacing="10" cellpadding="5">
				<xsl:apply-templates/>
			</table>
		</body>
	</html>
</xsl:template>

<xsl:template match="addressbook">
	<xsl:apply-templates select="person"/>
</xsl:template>

<xsl:template match="person">
	<tr>
		<td> <xsl:value-of select="firstname"/> </td> 
		<td> <b><xsl:value-of select="lastname"/></b> </td>
		<td> <xsl:value-of select="email"/> </td>
	</tr>
</xsl:template>
</xsl:stylesheet>
