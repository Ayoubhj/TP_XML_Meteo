<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/2000/svg">
  <xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="image/svg+xml"/>
  <xsl:template match="/">
    <xsl:variable name="largeur" select="200 + count(/meteo/mesure[1]/ville) * 135"/>
    <svg xmlns="http://www.w3.org/2000/svg" width="{$largeur}" height="580"
         viewBox="0 0 {$largeur} 580" role="img" aria-label="Histogramme animé des températures en degrés Celsius">
      <title>Comparaison animée des températures par ville</title>
      <desc>Une paire de barres par ville compare les températures des 1er et 2 janvier 2006. Les barres grandissent successivement.</desc>
      <rect width="100%" height="100%" fill="#f4f7fc"/>
      <rect x="20" y="18" width="{$largeur - 40}" height="535" rx="20" fill="#ffffff" stroke="#e3e9f3"/>
      <text x="65" y="67" font-family="Arial, sans-serif" font-size="28" font-weight="700" fill="#17233c">Températures par ville</text>
      <text x="65" y="95" font-family="Arial, sans-serif" font-size="15" fill="#64748b">Histogramme animé — températures en °C</text>
      <xsl:for-each select="/meteo/mesure">
        <xsl:variable name="i" select="position()"/>
        <rect x="{700 + ($i - 1) * 185}" y="48" width="18" height="18" rx="3">
          <xsl:attribute name="fill"><xsl:choose><xsl:when test="$i mod 2 = 1">#2563eb</xsl:when><xsl:otherwise>#f59e0b</xsl:otherwise></xsl:choose></xsl:attribute>
        </rect>
        <text x="{725 + ($i - 1) * 185}" y="63" font-family="Arial, sans-serif" font-size="16" fill="#334155"><xsl:value-of select="@date"/></text>
      </xsl:for-each>
      <xsl:for-each select="/meteo/mesure[1]/ville[position() &lt;= 5]">
        <xsl:variable name="tick" select="(position() - 1) * 10"/>
        <xsl:variable name="yy" select="470 - $tick * 9"/>
        <line x1="92" y1="{$yy}" x2="{$largeur - 65}" y2="{$yy}" stroke="#e5eaf2" stroke-width="1"/>
        <text x="78" y="{$yy + 5}" text-anchor="end" font-family="Arial, sans-serif" font-size="14" fill="#64748b"><xsl:value-of select="$tick"/></text>
      </xsl:for-each>
      <line x1="92" y1="110" x2="92" y2="470" stroke="#94a3b8" stroke-width="1.5"/>
      <line x1="92" y1="470" x2="{$largeur - 65}" y2="470" stroke="#94a3b8" stroke-width="1.5"/>
      <xsl:for-each select="/meteo/mesure[1]/ville">
        <xsl:variable name="ville" select="@nom"/>
        <xsl:variable name="n" select="position()"/>
        <xsl:variable name="centre" select="146 + ($n - 1) * 135"/>
        <text x="{$centre}" y="503" text-anchor="middle" font-family="Arial, sans-serif" font-size="15" font-weight="600" fill="#334155"><xsl:value-of select="$ville"/></text>
        <xsl:for-each select="/meteo/mesure">
          <xsl:variable name="i" select="position()"/>
          <xsl:variable name="temp" select="number(ville[@nom=$ville]/@temperature)"/>
          <xsl:variable name="haut" select="$temp * 9"/>
          <xsl:variable name="debut" select="($n - 1) * 0.15 + ($i - 1) * 0.10"/>
          <xsl:variable name="x" select="$centre - 35 + ($i - 1) * 38"/>
          <rect x="{$x}" y="470" width="29" height="0" rx="3">
            <xsl:attribute name="fill"><xsl:choose><xsl:when test="$i mod 2 = 1">#2563eb</xsl:when><xsl:otherwise>#f59e0b</xsl:otherwise></xsl:choose></xsl:attribute>
            <animate attributeName="y" from="470" to="{470 - $haut}" dur="1.1s" begin="{$debut}s" fill="freeze"/>
            <animate attributeName="height" from="0" to="{$haut}" dur="1.1s" begin="{$debut}s" fill="freeze"/>
          </rect>
          <text x="{$x + 14.5}" y="{470 - $haut - 12}" opacity="0" text-anchor="middle" font-family="Arial, sans-serif" font-size="13" fill="#1e293b"><xsl:value-of select="$temp"/>
            <animate attributeName="opacity" from="0" to="1" dur="0.3s" begin="{$debut + 1.1}s" fill="freeze"/>
          </text>
        </xsl:for-each>
      </xsl:for-each>
      <text x="{$largeur div 2}" y="539" text-anchor="middle" font-family="Arial, sans-serif" font-size="13" fill="#94a3b8">Source : document XML — Animation SVG SMIL</text>
    </svg>
  </xsl:template>
</xsl:stylesheet>
