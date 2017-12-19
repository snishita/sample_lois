declare namespace rg="http://relaxng.org/ns/structure/1.0";
(:declare namespace ea=$ns;:) 
declare namespace ea="http://takushoku-u.ac.jp/educational_affairs/ns/2.1";
declare namespace a="http://relaxng.org/ns/compatibility/annotations/1.0";
declare namespace xsl="http://www.w3.org/1999/XSL/Transform";
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:rg="http://relaxng.org/ns/structure/1.0"
  xmlns:ea="http://takushoku-u.ac.jp/educational_affairs/ns/2.1"
  xmlns:xsd="http://www.w3.org/2001/XMLSchema"
  xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"
  exclude-result-prefixes="xsl ea xsd">
{for $n in doc("lois/schema.rng")//rg:element[contains(a:documentation, "choice")]/@name
return (
   <xsl:template match="rg:element[@name='{$n}']" mode="choice">
     <xsl:param name="type"/>
     {
       for $e in doc("lois/students_sample.xml")//*[local-name(.)=$n and namespace-uri(.)="http://takushoku-u.ac.jp/educational_affairs/ns/2.1"]
       group by $eid:=$e/@id
       return (<label><input value="{$eid}" name="{$n}"><xsl:attribute name="type" select="$type"/></input>{distinct-values($e/text())}</label>)
     }
   </xsl:template>)}
</xsl:stylesheet>
