<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">  
  
 <xsl:output method="html" indent="yes"/>

   
<!-- VARIABLE CONTENANT LE HEAD DES DOCUMENTS HTML -->
    
    <xsl:variable name="head">
        <head>
            <meta charset="utf-8"/>
            <meta name="viewport" content="width=device-width, initial-scale=1"/>
            <title>Chartes contenues dans le manuscrit BnF Latin 11003 - Cartulaire de l'Abbaye de Chaalis</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://openseadragon.github.io/openseadragon/openseadragon.min.js"></script>
            <style>
                
                /*stylle du menu*/
                #navbar > ul > li {
                display: inline-block;
                list-style: none;
                }
                
                /*barre de séparation entre notes marginales et le texte central dans les chartes*/
                .col-md-4 {
                border-right: 1px solid #ddd;
                }
                
                /* Classe pour le tableau d'index*/
                .table-index {
                border-collapse: collapse;
                border: medium solid #000000;
                width: 100%;
                margin: 20px auto;
                }
                
                /* Classe pour les cellules */
                .cell {
                border: thin solid #6495ed;
                padding: 8px;
                text-align: left;
                }
                
                /* Classe pour les en-têtes */
                .header {
                background-color: #333;
                color: white;
                font-weight: bold;
                text-align: center;
                }
                
                /* Classes pour alternance de couleurs */
                .row-odd {
                background-color: #f2f2f2;
                }
                
                .row-even {
                background-color: #ffffff;
                }
                table {
                table-layout: auto; /* Permet aux cellules de s'adapter au contenu */
                width: 100%; /* Pour que le tableau prenne toute la largeur disponible */
                border-collapse: collapse; /* Pour éviter les espaces entre les cellules */
                }
                
                tr {
                background-color: #f8f8f8; /* Fond de ligne */
                border-bottom: 1px solid #ddd; /* Séparation entre les lignes */
                }
                
                td {
                padding: 10px; /* Espacement interne dans les cellules */
                border: 1px solid #ddd; /* Bordure autour des cellules */
                text-align: center; /* Alignement du texte dans les cellules */
                }
                
                th {
                padding: 10px; /* Espacement interne dans les en-têtes */
                border: 1px solid #ddd; /* Bordure autour des en-têtes */
                text-align: center; /* Alignement du texte dans les en-têtes */
                background-color: #eee; /* Fond des en-têtes */
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
                <li><a href="index.html">Index</a> - </li>
                <li><a href="tableau_relations.html"> Tableau des relations </a></li>
            </ul>
        </div>
    </xsl:variable>
    
<!-- TEMPLATE QUI MATCHE LA RACINE ET APPELLE LES TEMPLATES -->
    <xsl:template match="/">
        <xsl:call-template name="home"/>
        <xsl:call-template name="chartes"/>
        <xsl:call-template name="index"/>
        <xsl:call-template name="tableau_relations"/>
    </xsl:template>
    
<!-- TEMPLATE CONTENANT LA PAGE D'ACCUEIL DU SITE -->
    <xsl:template name="home">
        <xsl:variable name="numerisation" select="concat('https://gallica.bnf.fr/ark:/', //msIdentifier/idno[@source='gallica'])"/>
        <xsl:result-document href="out/home.html" method="html" indent="yes">
            <html>   
                <body>
                    <div class="container">
                       <xsl:copy-of select="$head"/>
                       
                        <xsl:copy-of select="$navbar"/>
                       <h1 style="text-align: center;">Édition numérique du <em><xsl:value-of select="//titleStmt/title"/></em></h1>
                        <div style="margin: 2em 0 2em 0;">
                            <p>Ce site propose un édition de plusieurs chartes tirées du manuscrit du
                                <em><xsl:value-of select="//msItem[@class='fragment']/title"/></em>, dont on peut trouver une analyse dans <xsl:value-of select="//msItem[@class='fragment']/bibl"/></p>
                        </div> 
                       <div style="margin: 2em 0 2em 0;">
                            <h2>Informations sur le manuscrit:</h2>
                            <ul>
                                <li>Institution: <xsl:value-of select="//msIdentifier/repository"/></li>
                                <li>Cote: <xsl:value-of select="//msIdentifier/idno[@source='bnf']"/></li>
                                <li>Numérisation: <a href="{$numerisation}" target="_blank">lien</a></li>
                            </ul>
                        </div>
                        
                        <div id="visioneuse">
                            <div id="_viewer" style="width: 100%; height: 800px;"></div>
                            <script type="text/javascript">
                                var _viewer = OpenSeadragon({
                                id: "_viewer",
                                prefixUrl: "https://openseadragon.github.io/openseadragon/images/",
                                sequenceMode: true,
                                tileSources:[
                                <xsl:for-each select="//facsimile">
                                    <xsl:text>'</xsl:text><xsl:value-of select="concat('https://gallica.bnf.fr/iiif/ark:/', ./graphic/@url, '/info.json')"/><xsl:text>', </xsl:text>
                                </xsl:for-each>
                                ],
                                });
                            </script>
                        </div>
                        <div>
                            <h2>Chapitres disponibles:</h2>
                            <ul>
                                <xsl:for-each select="//msItem[@class='charte']">
                                    <li>
                                        <a href="{concat('charte', ./@n, '.html')}" target="_blank">
                                            <xsl:value-of select="./title"/>
                                        </a>
                                    </li>
                                </xsl:for-each>
                            </ul>
                        </div>
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
    <xsl:template match="//body//note//choice">
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
                      <div class="table-index">
                        <div class="header">Index des noms de personnes</div>
                        <div class="cell">
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
                            
                        <div class="header">Index des noms de lieux</div>
                        <div class="cell">
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
                      <div class="header">Index des organisations</div>
                      <div class="cell">
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
                   </div>
                </body>
                <xsl:copy-of select="$footer"/>
            </html>
        </xsl:result-document>
    </xsl:template>
    <xsl:template name="tableau_relations">
        <xsl:result-document href="out/tableau_relations.html">
            <html>
                <xsl:copy-of select="$head"/>
                <body style="margin: 2em 20em 5em 20em; font-family: 'Roboto', serif;">
                    <xsl:copy-of select="$navbar"/>
                    <h1 style="text-align: center;">Tableau de relations entre personnes</h1>
                    <div style="margin: 2em 0 2em 0;">
                        <!-- BOUCLE N°1: GROUPER LES RELATIONS AVEC CATEGORIE=ECONOMIQUE, LES TRIER PAR ORDRE ALPHABÉTIQUE -->
                        <!--             ET CRÉER UN <P> POUR CHAQUE GROUPE (= POUR CHAQUE NOM PROPRE) -->
                        <xsl:for-each-group select=".//relation" group-by="./@category">
                            <xsl:sort select="translate(current-grouping-key(), '_#', ' ')"/>
                            <p>Relations de type <xsl:value-of select="translate(current-grouping-key(), '_#', ' ')"/> </p>
                      
                                <!-- BOUCLE N°2: AFFICHER LES ATTRIBUTS DE CHAQUE RELATION-->
                                    <table>
                                        <thead>
                                            <tr>
                                                <th scope="col">Type de relation</th>
                                                <th scope="col">Première(s) personne(s) dans la relation</th>
                                                <th scope="col">Seconde(s) personne(s) dans la relation</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <xsl:for-each select="current-group()">
                                               <tr>
                                                   <!--Affichage de la relation -->
                                                  <td> <xsl:value-of select="current()/@name"/></td>
 
                                                   <!--Affichage des individus-->
                                                   <!-- Conservez une référence au nœud actuel -->
                                                   <xsl:variable name="currentNode" select="."/>
                                                  
                                                   <!--Cas d'une relation non bidirectionnnelle--> 
                                                         <xsl:if test="not(@mutual)">       
                                                               <!--Cas de l'individu actif-->
                                                               <xsl:variable name="tokens" select="tokenize(current()/@active, ' ')"/>
                                                               <td>
                                                                   <xsl:for-each select="$tokens">
                                                                       <text>
                                                                           <!-- Utilisez le chemin relatif par rapport au document entier -->
                                                                           <xsl:value-of select="concat($currentNode/ancestor::*/teiHeader//person/persName[@xml:id=translate(current(), '_#', '')]/forename,' ',$currentNode/ancestor::*/teiHeader//person/persName[@xml:id=translate(current(), '_#', '')]/nameLink,' ',$currentNode/ancestor::*/teiHeader//person/persName[@xml:id=translate(current(), '_#', '')]/surname)"/>
                                                                       </text>
                                                                   </xsl:for-each>
                                                               </td>
                                                                <!--cas de l'individu passif-->
                                                                <xsl:variable name="tokens2" select="tokenize(current()/@passive, ' ')"/>
                                                                <td>
                                                                    <xsl:for-each select="$tokens2">
                                                                        <text>
                                                                            <!-- Utilisez le chemin relatif par rapport au document entier -->
                                                                            <xsl:value-of select="concat($currentNode/ancestor::*/teiHeader//person/persName[@xml:id=translate(current(), '_#', '')]/forename,' ',$currentNode/ancestor::*/teiHeader//person/persName[@xml:id=translate(current(), '_#', '')]/nameLink,' ',$currentNode/ancestor::*/teiHeader//person/persName[@xml:id=translate(current(), '_#', '')]/surname)"/>
                                                                            <xsl:value-of select="$currentNode/ancestor::*/teiHeader//orgName[@xml:id=translate(current(), '_#', '')]"/>
                                                                        </text>
                                                                    </xsl:for-each>
                                                                </td>
                                                         </xsl:if>
                                                                  
                                                <!--Cas d'une relation bidirectionnnelle--> 
                                                <xsl:if test="@mutual">       
                                                    <xsl:variable name="tokens" select="tokenize(current()/@mutual, ' ')"/>
                                                    <xsl:for-each select="$tokens">
                                                        <td>
                                                            <!-- Utilisez le chemin relatif par rapport au document entier -->
                                                            <xsl:value-of select="concat($currentNode/ancestor::*/teiHeader//person/persName[@xml:id=translate(current(), '_#', '')]/forename,' ',$currentNode/ancestor::*/teiHeader//person/persName[@xml:id=translate(current(), '_#', '')]/nameLink,' ',$currentNode/ancestor::*/teiHeader//person/persName[@xml:id=translate(current(), '_#', '')]/surname)"/>
                                                        </td>
                                                    </xsl:for-each>
                                                </xsl:if>
                                               </tr>
                                             </xsl:for-each>
                                        </tbody>                      
                                    </table>
                        </xsl:for-each-group>
                    </div>
                </body>
                <xsl:copy-of select="$footer"/>
            </html>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>