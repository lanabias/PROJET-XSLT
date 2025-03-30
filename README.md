Étude de cas : 
L'Abbaye de Chaalis et ses réseaux

Cette étude de cas examine les relations entre l'abbaye cistercienne de Chaalis et divers groupes externes, en particulier la noblesse française, dans le contexte médiéval de l'Île-de-France. L'objectif est de combler les lacunes dans la recherche existante sur ces interactions en utilisant l'analyse de réseau pour mettre en évidence les collaborations entre l'abbaye et les individus externes, y compris les nobles, d'autres communautés ecclésiastiques, les villages et les roturiers. L'abbaye fondée en 1137 est affiliée à l'Abbaye cistercienne de Pontigny. Chaalis est située à environ 40 km au nord de Paris, près de la ville royale de Senlis. Elle comprend plusieurs granges où travaillent des frères lais.

Le projet présenté ici est d'identifier dans le cartulaire de l'abbaye de Chaalis les nobles franciliens cités et les relations qu'ils développent entre eux ou avec l'abbaye. La noblesse française a priorisé l'Ordre cistercien dans ses stratégies de bienfaisance religieuse, cherchant à obtenir le soutien de l'ordre en échange de leur domination sur les terres et les populations.

La source primaire utilisée est le cartulaire médiéval de l'abbaye, le manuscrit latin 11003 de la Bibliothèque Nationale de France, visible sur Gallica et en IIIF. Il comprend 392 folios, 1700 notices de chartes. La période couverte va de 1021 à 1484. Les chartes originales se trouvent aux Archives départementales de l'Oise et à l'abbaye de Chaalis proprement dite. Mes travaux de recherche pour ma thèse ont eu lieu entre 2009 et 2016 : la base de données relationnelle était alors initialement construite avec Access, avec une migration vers SQL. Mon idée était de présenter mes résultats en ligne.

L'étape initiale de modélisation des données consistait à mettre en œuvre les modèles CIDOC-CRM et féodaux développés par Michele Pasin et John Bradley (2014). Mais dans un premier temps, j'ai décidé de mettre en place une chaîne simplifiée, en utilisant la TEI pour encoder le cartulaire de Chaalis et identifier les individus et les relations entre eux et XSLT pour visualiser en HTML à la fois :

    la transcription des chartes du cartulaire

    et en annexes la liste des individus et des lieux dans une page index et le tableau des relations entre eux.

Dans ce projet XSLT, deux folios du cartulaire ms latin 11003 ont été sélectionnés. La transcription des folios du cartulaire est représentée sur trois colonnes, avec le texte principal dans la colonne centrale et les notes marginales nombreuses dans les colonnes de gauche et de droite. Les abréviations restituées sont signalées en italique. Les individus sont balisés avec <persName>, les lieux avec <place> et l'institution de l'abbaye avec <org>.

Les fichiers encodés en TEI sont nommés Ex1_Paris_BnF_Latin_11003_Description_LN et Ex2_Paris_BnF_Latin_11003_Description_LN. Ils sont associés aux deux images Manuscrit_fragment_1 et Manuscrit_fragment_2.

Les relations entre individus sont contenues dans les balises <relation>. Elles sont nommées et identifiées suivant une ontologie en cours de développement par la bibliothèque d'Allemagne, dans le cadre du projet AgRelOn (Agent Relationships ontology). Elles sont de plusieurs types et rangées dans plusieurs catégories : economic (économique), kinship (parenté), legal (juridique). L'ensemble des catégories et des éléments n'ont pas été traduits.

J'espère à terme étendre la méthode à :

    l'ensemble du cartulaire pour éclairer les dynamiques sociales et politiques entre l'abbaye de Chaalis et les pouvoirs séculiers locaux au Moyen Âge ou entre les nobles entre eux.

    la modélisation prosopographique du corpus de ma thèse intitulée « Pour lui aider à soustenir son estat » : alliances, fiefs, réseaux, clientèles et partis dans l'ancienne noblesse d'Île-de-France de Philippe Auguste à Charles VII (1180-1437) (https://theses.hal.science/tel-02880019)

