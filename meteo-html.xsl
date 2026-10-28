<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <html lang="fr">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title>Relevés météorologiques des villes</title>
        <style>
          body { margin:0; padding:48px 24px; background:#f4f7fc; font-family:Arial,Helvetica,sans-serif; color:#17233c; }
          main { max-width:1060px; margin:auto; }
          h1 { margin-bottom:8px; font-size:32px; }
          p { color:#58667c; }
          .card { margin-top:26px; padding:28px; background:white; border:1px solid #e3e9f3; border-radius:18px; box-shadow:0 10px 28px #1b2b4710; overflow-x:auto; }
          table { border-collapse:collapse; width:100%; text-align:left; }
          th { background:#eef4ff; color:#16417c; }
          th,td { padding:14px 18px; border-bottom:1px solid #e7edf6; }
          tr:last-child td { border-bottom:none; }
          tbody tr:nth-child(even) { background:#f9fbff; }
          .temp { font-weight:700; color:#1b5db7; }
          footer { padding:22px 0; font-size:13px; color:#627088; }
        </style>
      </head>
      <body>
        <main>
          <h1>Relevés des températures</h1>
          <p>Comparaison de <xsl:value-of select="count(/meteo/mesure[1]/ville)"/> villes sur <xsl:value-of select="count(/meteo/mesure)"/> dates.</p>
          <section class="card">
            <table>
              <thead>
                <tr>
                  <th>Ville</th>
                  <xsl:for-each select="/meteo/mesure">
                    <th><xsl:value-of select="@date"/></th>
                  </xsl:for-each>
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="/meteo/mesure[1]/ville">
                  <xsl:variable name="nomVille" select="@nom"/>
                  <tr>
                    <td><strong><xsl:value-of select="$nomVille"/></strong></td>
                    <xsl:for-each select="/meteo/mesure">
                      <td class="temp"><xsl:value-of select="ville[@nom=$nomVille]/@temperature"/><xsl:text> °C</xsl:text></td>
                    </xsl:for-each>
                  </tr>
                </xsl:for-each>
              </tbody>
            </table>
          </section>
          <footer>Source : document XML météorologique — Transformation XSLT 1.0</footer>
        </main>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
