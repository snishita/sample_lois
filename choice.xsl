<xsl:stylesheet 
  xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
  xmlns:xsd="http://www.w3.org/2001/XMLSchema"
  xmlns:ea="http://takushoku-u.ac.jp/educational_affairs/ns/2.1"
  xmlns:rg="http://relaxng.org/ns/structure/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="2.0"
  exclude-result-prefixes="xsl ea xsd">
  <xsl:template match="rg:element[@name='faculty']" mode="choice">
    <xsl:param name="type"/>
    <label>
      <input value="eng" name="faculty">
        <xsl:attribute name="type" select="$type"/>
      </input>工学部</label>
  </xsl:template>
  <xsl:template match="rg:element[@name='department']" mode="choice">
    <xsl:param name="type"/>
    <label>
      <input value="cs" name="department">
        <xsl:attribute name="type" select="$type"/>
      </input>情報工学科</label>
    <label>
      <input value="id" name="department">
        <xsl:attribute name="type" select="$type"/>
      </input>デザイン学科</label>
  </xsl:template>
</xsl:stylesheet>

