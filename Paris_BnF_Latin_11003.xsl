<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0" >  
  
    <xsl:output method="html" indent="yes"/>

   
<!-- VARIABLE CONTENANT LE HEAD DES DOCUMENTS HTML -->
    
    <xsl:variable name="head">
        <head>
            <meta charset="utf-8"/>
            <meta name="viewport" content="width=device-width, initial-scale=1"/>
            <title>Chartes contenues dans le manuscrit BnF Latin 11003 - Cartulaire de l'Abbaye de Chaalis</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
            <style>
                #navbar > ul > li {
                display: inline-block;
                list-style: none;
                }
            </style>
              
        </head>
    
    </xsl:variable>
    
<!-- VARIABLE CONTENANT LE FOOTER -->
    <xsl:variable name="footer">
        <footer style="margin: 5em 0 0 0;">
             <hr/>
             <p>Site réalisé dans le cadre du cours de XSLT du Master TNAH de l'École nationale des chartes.</p>
        </footer>
    </xsl:variable>
    
<!-- VARIABLE CONTENANT LA NAVBAR -->
    <xsl:variable name="navbar">
        <div style="text-align: center;" id="navbar">
            <ul>
                <li><a href="home.html">Accueil</a> - </li>
                <!-- AJOUT D'UN LIEN PAR CHARTE CONTENUE DANS L'IMAGE DU MANUSCRIT ET AJOUT DE L'INDEX -->
                <xsl:for-each select=".//body//div[@type='chart']">
                    <li>
                        <a href="{concat('charte', ./@n, '.html')}">Charte n° <xsl:value-of select="./@n"/></a> 
                        - 
                    </li>
                </xsl:for-each>
                <li><a href="index.html">Index</a></li>
            </ul>
        </div>
    </xsl:variable>
    
<!-- TEMPLATE QUI MATCHE LA RACINE ET APPELLE LES TEMPLATES -->
    <xsl:template match="/">
        <xsl:call-template name="home"/>
        <xsl:call-template name="chartes"/>
        <xsl:call-template name="index"/>
    </xsl:template>
    
<!-- TEMPLATE CONTENANT LA PAGE D'ACCUEIL DU SITE -->
    <xsl:template name="home">
        <xsl:result-document href="out/home.html" method="html" indent="yes">
            <html>   
                <body>
                    <div class="container">
                       <xsl:copy-of select="$head"/>
                       <xsl:copy-of select="$navbar"/>
                       <xsl:copy-of select="$footer"/>
                    </div>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="chartes">   
        <xsl:for-each select="//body/div[@type='chart']">
                     
                    <xsl:result-document href="{concat('out/', 'charte', ./@n, '.html')}">
                        <html>
                            <div class="container">
                                <xsl:copy-of select="$head"/>
                                <body style="margin: 2em 20em 5em 20em; font-family: 'Roboto', serif;">
                                    <xsl:copy-of select="$navbar"/>
                                    
                                     <h1 style="text-align: center;">
                                         <xsl:value-of select="//body/div[1]/head/text()"/>
                                     </h1>
                                     <h1 style="text-align: center;">
                                         Charte n° <xsl:value-of select="./@n"/>
                                     </h1>
                                     <div class="row">
                                        <div class="col-md-4">
                                            <xsl:for-each select="./note[@place='margin-left']">
                                                <p>
                                                    <xsl:apply-templates/>
                                                </p>
                                            </xsl:for-each>
                                        </div>
                                        <div class="col-md-4">
                                             <xsl:for-each select="./p">
                                                 <p>
                                                   <xsl:apply-templates/>
                                                 </p>
                                            </xsl:for-each>
                                         </div>
                                        <div class="col-md-4">
                                            <xsl:for-each select="./note[@place='margin-right']">
                                                <p>
                                                    <xsl:apply-templates/>
                                                </p>
                                            </xsl:for-each>
                                        </div> 
                                     </div>
                                </body>
                                <xsl:copy-of select="$footer"/> 
                             </div>
                        </html>
                    </xsl:result-document>       
        </xsl:for-each>       
    </xsl:template>
   
    
    <!-- MISE EN FORME DES ABBREVIATIONS DANS LE TEXTE DES CHARTES -->
    <xsl:template match="//body//p//choice">
        <span style="font-style:italic"> <xsl:value-of select="./ex"/></span>      
    </xsl:template>
   
   
    
<!-- MISE EN FORME DE L'INDEX -->
    <xsl:template name="index">
        <xsl:result-document href="out/index.html">
            <html>
                <xsl:copy-of select="$head"/>
                <body style="margin: 2em 20em 5em 20em; font-family: 'Roboto', serif;">
                  <div class="container">
                        <xsl:copy-of select="$navbar"/>
                        <h1 style="text-align: center;">Index des noms de personnes</h1>
                        <div style="margin: 2em 0 2em 0;">
                                <!-- REGROUPEMENT DES INDIVIDUS PAR REFERENCE DANS L'INDEX-->
                                    <xsl:for-each-group select=".//div/p/persName" group-by="./@ref">
                                        <!-- TRI PAR ORDRE ALPHABETIQUE-->
                                            <xsl:sort select="translate(current-grouping-key(), '_#', ' ')"/>
                                           <!-- DEFINIR UNE ENTREE PAR GROUPE --> 
                                            <p>
                  
                                                <xsl:value-of select="//teiHeader//persName[@xml:id=translate(current-grouping-key(),'_#', ' ')]/forename"/><xsl:text>&#160;</xsl:text>
                                                <xsl:value-of select="//teiHeader//persName[@xml:id=translate(current-grouping-key(),'_#', ' ')]/nameLink"/><xsl:text>&#160;</xsl:text>
                                                <xsl:value-of select="//teiHeader//persName[@xml:id=translate(current-grouping-key(),'_#', ' ')]/surname"/><xsl:text> &#160;:&#160;</xsl:text>
                                                      <!-- BOUCLE N°2: GROUPER LES APPARITIONS D'UN MÊME INDIVIDU EN FONCTION DES -->
                                                      <!-- NUM DES <DIV> DANS LESQUELLES IL APPARAÎT ET INDIQUER CES NUM DANS DES LIENS-->
                                                
                                                      <xsl:for-each-group select="current-group()" group-by="current-group()/ancestor::div/@n">
                                                          <a>
                                                              <xsl:attribute name="href">
                                                                  <xsl:value-of select="concat('charte', current-grouping-key(), '.html')"/>
                                                              </xsl:attribute>
                                                              charte n°<xsl:value-of select="current-grouping-key()"/>
                                                          </a>
                                                          <xsl:if test="position()!= last()">, 
                                                          </xsl:if>
                                                          <xsl:if test="position() = last()">.
                                                          </xsl:if>     
                                                    </xsl:for-each-group>
                                                
                                            </p> 
                                    </xsl:for-each-group>
                        </div>
                        <h1 style="text-align: center;">Index des noms de lieux</h1>
                        <div style="margin: 2em 0 2em 0;">
                            <!-- REGROUPEMENT DES LIEUX PAR REFERENCE DANS L'INDEX-->
                            <xsl:for-each-group select=".//div/p/placeName" group-by="./@ref">
                                <!-- TRI PAR ORDRE ALPHABETIQUE-->
                                <xsl:sort select="translate(current-grouping-key(), '_#', ' ')"/>
                                <!-- DEFINIR UNE ENTREE PAR GROUPE --> 
                                <p>
                                  
                                  <a>
                                    <xsl:attribute name="href"> 
                                        <xsl:variable name="code" select="//teiHeader//place[@xml:id=translate(current-grouping-key(),'_#', ' ')]/idno"/>
                                        <xsl:value-of select="concat('https://www.wikidata.org/wiki/',$code)"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="//teiHeader//place[@xml:id=translate(current-grouping-key(),'_#', ' ')]/placeName"/><xsl:text>&#160;</xsl:text>
                                    </a>    
                                    <xsl:value-of select="//teiHeader//place[@xml:id=translate(current-grouping-key(),'_#', ' ')]/location"/><xsl:text>&#160;</xsl:text>
                                    <!-- BOUCLE N°2: GROUPER LES APPARITIONS D'UN MÊME LIEU EN FONCTION DES -->
                                    <!-- NUM DES <DIV> DANS LESQUELLES IL APPARAÎT ET INDIQUER CES NUM DANS DES LIENS-->
                                    
                                    <xsl:for-each-group select="current-group()" group-by="current-group()/ancestor::div/@n">
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:value-of select="concat('charte', current-grouping-key(), '.html')"/>
                                            </xsl:attribute>
                                            charte n°<xsl:value-of select="current-grouping-key()"/>
                                        </a>
                                        <xsl:if test="position()!= last()">, 
                                        </xsl:if>
                                        <xsl:if test="position() = last()">.
                                        </xsl:if>     
                                    </xsl:for-each-group>   
                                </p> 
                            </xsl:for-each-group>
                        </div>
                      <h1 style="text-align: center;">Index des organisations</h1>
                      <div style="margin: 2em 0 2em 0;">
                          <!-- REGROUPEMENT DES ORGANISATIONS PAR REFERENCE DANS L'INDEX-->
                          <xsl:for-each-group select=".//div/p/orgName" group-by="./@ref">
                              <!-- TRI PAR ORDRE ALPHABETIQUE-->
                              <xsl:sort select="translate(current-grouping-key(), '_#', ' ')"/>
                              <!-- DEFINIR UNE ENTREE PAR GROUPE --> 
                              <p>
                                      <xsl:value-of select="translate(current-grouping-key(), '_#', ' ')"/> : 
                                      <xsl:value-of select="//teiHeader//org[@xml:id=translate(current-grouping-key(),'_#', ' ')]/orgName"/><xsl:text>&#160;</xsl:text>
                                      <xsl:value-of select="//teiHeader//org[@xml:id=translate(current-grouping-key(),'_#', ' ')]/desc"/><xsl:text>&#160;</xsl:text>
                                  <!-- BOUCLE N°2: GROUPER LES APPARITIONS D'UNE même ORGANISATION EN FONCTION DES -->
                                  <!-- NUM DES <DIV> DANS LESQUELLES ELLE APPARAÎT ET INDIQUER CES NUM DANS DES LIENS-->
                                  
                                  <xsl:for-each-group select="current-group()" group-by="current-group()/ancestor::div/@n">
                                      <a>
                                          <xsl:attribute name="href">
                                              <xsl:value-of select="concat('charte', current-grouping-key(), '.html')"/>
                                          </xsl:attribute>
                                          charte n°<xsl:value-of select="current-grouping-key()"/>
                                      </a>
                                      <xsl:if test="position()!= last()">, 
                                      </xsl:if>
                                      <xsl:if test="position() = last()">.
                                      </xsl:if>     
                                  </xsl:for-each-group>   
                              </p> 
                          </xsl:for-each-group>
                      </div>
                   </div>
                </body>
                <xsl:copy-of select="$footer"/>
            </html>
        </xsl:result-document>
    </xsl:template>

</xsl:stylesheet>