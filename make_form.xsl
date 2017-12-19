<?xml version="1.0" encoding="UTF-8"?> 
<xsl:stylesheet
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:rg="http://relaxng.org/ns/structure/1.0"
  xmlns:ea="http://takushoku-u.ac.jp/educational_affairs/ns/2.1"
  xmlns:xsd="http://www.w3.org/2001/XMLSchema"
  xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
  exclude-result-prefixes="xsl ea xsd">
  <xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="no"/>
  <xsl:key name="formItem" match="rg:element" use="../@name"/>
  <xsl:include href="choice.xsl"/>
  <xsl:template match="rg:element[contains(a:documentation/text(),'FormRoot')]">
    <form> <fieldset>
      <legend>
        <xsl:value-of select="replace(normalize-space(a:documentation/text()), '.*Title (\S*).*', '$1')"/>の検索
      </legend>
      <xsl:for-each select="key('formItem', rg:ref/@name)">
        <xsl:apply-templates select="current()" mode="formItem"/>
      </xsl:for-each>
    </fieldset></form>
  </xsl:template>
  <xsl:template match="rg:element[contains(a:documentation/text(),'FormItem')]" mode="formItem">
    <xsl:variable name="title" select="replace(normalize-space(a:documentation/text()), '.*Title (\S*).*', '$1')"/>
    <xsl:variable name="type" select="replace(normalize-space(a:documentation/text()), '.*type=(\S*).*', '$1')"/>
    <xsl:choose>
      <xsl:when test="$type='substring' or $type='string' or $type='number'">
        <p><label><xsl:value-of select="$title"/>:<input>
          <xsl:attribute name="type">text</xsl:attribute>
          <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
          <xsl:if test="contains(a:documentation/text(), 'length')">
            <xsl:attribute name="size">
              <xsl:value-of select="replace(normalize-space(a:documentation/text()), '.*length=([0-9]+).*', '$1')"/>
            </xsl:attribute>
          </xsl:if>
        </input>
        <xsl:if test="$type='number'">
          〜<input>
          <xsl:attribute name="type">text</xsl:attribute>
          <xsl:attribute name="name">to-<xsl:value-of select="@name"/></xsl:attribute>
          <xsl:if test="contains(a:documentation/text(), 'length')">
            <xsl:attribute name="size">
              <xsl:value-of select="replace(normalize-space(a:documentation/text()), '.*length=([0-9]+).*', '$1')"/>
            </xsl:attribute>
          </xsl:if></input>
        </xsl:if>
        </label></p>
      </xsl:when>
      <xsl:when test="$type='choice'">
        <p><xsl:value-of select="$title"/>:
        <xsl:apply-templates select="current()" mode="choice">
          <xsl:with-param name="type">checkbox</xsl:with-param>
        </xsl:apply-templates></p>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="a:documentation"/>
  <xsl:template match="a:documentation" mode="formItem"/>
</xsl:stylesheet>
