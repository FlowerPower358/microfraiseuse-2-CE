# microfraiseuse 2 CE
Montage et améliorations

## Améliorations 

1. Limitation de la surface de travail
   1. évaluer
   2. limitation logicielle
   3. limitation matérielle
     * limiteur Z (max HS) et/ou plateau martyre ?
     * limiteur (X,Y) bloquant => coupure de l'alimentation à remplacer par un retour à la position d'origine arrêt du travail en cours.
    * centrage matériel en (X,Y), gravure de repères sur les supports
2. Sécurité
   1. arrêt d'urgence manuel et à l'ouverture du capot
   2. aspiration des poussières
3. Précision
   1. entrainement des axes filetés (actuellement avec un simple couple de vis)
     * limitation de la vitesse de plongée en fonction de la matière pour éviter les glissements
     * ajout d'un méplat mais complexe et supprime l'effet limiteur de couple
   2. position de repos
     * axe Z surface du matériel via un test de conductivité
     * axe (X,Y) via laser, limiteurs de fins de courses ?
   3. aspiration des poussières
  
## Fraisage

Uiliser le programme [GrblController](https://fr.wikipedia.org/wiki/Grbl) avec un fichier [GCode](https://fr.wikipedia.org/wiki/Programmation_de_commande_num%C3%A9rique#Langage).

### installation et configuration
Télécharger **[GrblController 20140506](https://grbl-controller.software.informer.com/T%C3%A9l%C3%A9charger/)**, résumé en [anglais](http://www.diymachining.com/downloads/GRBL_Settings_Pocket_Guide_Rev_B.pdf). La configuration a été réalisée avec le fichier [GrblController_fr.qm](https://github.com/latelierpartage/microfraiseuse-2-CE/blob/master/GrblController_fr.qm).

## Codage

### installation
**[CAMBAM](http://www.cambam.info/)** a été privilégié pour générer le gcode (cf [manuel](http://www.cambam.info/doc/fr/doc-cambam098l-fr-v1-34.pdf)) par rapport à
* [Linux CNC](http://linuxcnc.org/)
* [Light burn (laser)](https://jtechphotonics.com/?p=10204)

### Paramètres généraux

* **Activé** generation du gcode pour cette opération.
* **ID Primitives** liste des objets (formes) à inclure.
* **Infos** notes ou paramètres des compléments (plugins).
* **Nom** inclus sous forme de commentaire dans le Gcode produit.
* **Style** choix d'un ensemble de paramètres par défaut.
* choix de l'outil
  * **Diamètre de l'outil**
  * **Forme d'outil**
  * **Numéro d'outil** dans la bibliothèque d'outils si = 0 aucun gcode de changement n'est généré.
* Broche
  * **Gamme de vitesses** mémo e.g. valeur du bouton de réglage de la broche par exemple.
  * **Sens de rotation** horaire (CW) – anti-horaire (CCW) – Arrêt
  * **Vitesse de rotation** en tr/min
* **Vitesse d'avance** en usinage normal (G1, G2, G3)
* **Vitesse d'avance en plongée** dans la matière. (en Z)
* **Déplacement latéral maxi** en fraction du Ø de la fraise ( 0 à 1) ou la matière sera coupée par déplacement horizontal de l'outil. Si la distance jusqu'à la prochaine trajectoire et supérieure à Déplacement latéral maxi l'outil remontera, se déplacera en rapide à la hauteur définie dans Plan de dégagement jusqu'à la prochaine trajectoire, puis plongera de nouveau dans la matière.
* **Surépaisseur** C'est la quantité de matière à laisser sur le coté par rapport à la cote finale. Le reste est généralement enlevé plus tard lors de la passe de finition. Des valeurs négatives peuvent être utilisées pour augmenter la valeur de la dernière passe. (cela créera un usinage plus "large")
* **Incrément de passe** , profondeur maximum prise par la fraise à chaque passe.
* **Incrément dernière passe**
* **Plan de dégagement** Z où remontera l'outil pour les déplacements rapides (G0) libres de tous obstacles
* **Profondeur finale** Z de la dernière passe (coordonnées absolues)
* **Surface pièce** Z d'où démarrera l'usinage
* **Entrée / Sortie dans la matière**
* *Transformer*
* *Ebauche / finition* utilisée dans les calculs automatiques de vitesse de broche et d'avance dans une future version.
* **Mode d'optimisation** utilisé pour déterminer l'ordre dans lequel les trajectoires seront exécutées
* **En-tête / Fin d'opération personnalisée**, un script en Gcode (multiligne) qui sera inséré avant/après l'opération d'usinage courante dans le Gcode produit.
* **Mode de déplacement** à Vitesse constante (G64, moins précis), Trajectoire exacte (G61, à coups dans la vitesse d'avance).
* **Plan de travail** XY, XZ ou YZ
* **Point de départ** proche de l'endroit ou devra démarrer l'usinage.

### 2D (DXF)
Il faut partir d'un fichier DXF généré avec
* **[Openscad](https://www.openscad.org/)**
* **[Inscape](https://inkscape.org/fr/)**
* **[qelectrotech](https://qelectrotech.org/download.html)***
* **[Meshlab](http://www.meshlab.net/)*** conversions et corrections

#### Contour (Profile)
* **Largeur d'usinage** totale, si elle est supérieure au Ø de la fraise, plusieurs usinages parallèles seront effectués.
* **Intérieur / extérieur** Détermine si l'usinage doit se faire à l'intérieur ou à l'extérieur de la forme sélectionnée. Pour les formes ouvertes, l'intérieur ou l'extérieur seront déterminés par l'ordre dans lequel les points auront été dessinés.
* **Profilage des bords**, rayons et des chanfreins
* **Vitesse d'avance latérale** à utiliser en déplacement horizontal pour passer d'une trajectoire à la suivante. ( poche, contour plus large que la fraise, ..)
* **Détection de collision** fusionne les trajectoires multiples
* **Gestion des attaches** permet de générer des attaches de maintient (ponts) qui maintiendront la pièce en place pendant l'usinage.
* **Dégagement des angles** pour ajouter une opération supplémentaire qui coupera la partie interne des angles
* **Ordre d'usinage** jusqu'à la profondeur finale ou chaque niveau.
* **Sens d'usinage** en Opposition, en Avalant, ou Mixte
#### Poche (Pocketing)
* **Vitesse d'avance latérale** à utiliser en déplacement horizontal pour passer d'une trajectoire à la suivante. ( poche, contour plus large que la fraise, ..)
* **Recouvrement**, incrément de passe horizontale en fraction du Ø de la fraise (0-1). Si la valeur de Recouvrement est supérieure au Ø de la fraise est si Largeur d'usinage à une largeur appropriée, il est possible d'usiner des cercles concentriques d'une largeur égale au Ø de la fraise, distants entre eux de la valeur de Recouvrement et sur une largeur totale égale à Largeur d'usinage.
* **Détection de collision** fusionne les trajectoires multiples
* **Dernière passe à profondeur maxi** et si Recouvrement dernière passe est différent de 0 alors la dernière passe latérale définie dans Recouvrement dernière passe sera prise sur toute la hauteur d'usinage. Si à Faux, cette dernière passe latérale sera prise à chaque incrément du niveau d'usinage (Z).
* **Recouvrement**, incrément de passe horizontale en fraction du Ø de la fraise (0-1). Si la valeur de Recouvrement est supérieure au Ø de la fraise est si Largeur d'usinage à une largeur appropriée, il est possible d'usiner des cercles concentriques d'une largeur égale au Ø de la fraise, distants entre eux de la valeur de Recouvrement et sur une largeur totale égale à Largeur d'usinage.
* **Recouvrement dernière passe** latérale en unité courante, c'est l'équivalent du paramètre Incrément dernière passe mais appliqué ici à la paroi de la poche.
* **Style de remplissage région** contrôle le motif utilisé pour créer les trajectoires à l'intérieur d'une poche. Tous les effets de ces options sont les mêmes que pour l'option de dessin "remplissage de région" Dessiner – Remplir RégionLes options sont: Lignes horizontales, Lignes Verticales, Décalage (intérieur + extérieur) progressif de la trajectoire partant de l'extérieur vers l'intérieur et une union des trajectoires rayonnants autours des îlots, Décalage (extérieur) progressif de la trajectoire depuis l'extérieur vers l'intérieur. Décalage (intérieur) progressif autour des îlots.     
* **Ordre d'usinage** jusqu'à la profondeur finale ou chaque niveau.
* **Sens d'usinage** en Opposition, en Avalant, ou Mixte
#### Perçage (Drilling)
* **Méthode de perçage** utilisée pour générer les instructions de perçage. Les options possibles sont: Cycle de perçage: Utilise les instructions G81, G82 ou G83 Fraisage en spirale (horaire): Fraisage en spirale, sens horaire Fraisage en spirale (anti-horaire): Fraisage en spirale, sens anti-horaire Script personnalisé: Utilise un script personnalisé.
* en mode perçage avec débourrage
  * **Script personnalisé** Gcode personnalisé utilisé si Méthode de perçage = Script personnalisé divers macro peuvent être utilisées dans ce script
  * **Hauteur de rétraction** pour chaque débourrage. (en mode Cycle de perçage avec débourrage)
  * **Incrément débourrage** profondeur avant débourrage. Si à 0, pas de débourrage. (en mode Cycle de perçage)
* en mode Fraisage en spirale
  * **Diamètre du trou** définit le Ø de perçage. Si sur Auto, le Ø du trou sera calculé à partir de la forme sélectionnée pour cette opération (cercle).
  * **Fond plat**, Nouveau 0.9.8K, ajoute une trajectoire circulaire au fond du perçage afin d'obtenir un fond plat.
  * **Longueur de la sortie** à parcourir en direction du centre du trou avant rétraction. Si positif, se rapproche du centre du trou, si négatif, s'en éloigne.
elles seront complétées par le post-processeur.
  * **Utiliser sortie** s'approcher ou s'éloigner du centre du trou avant rétraction.
* **Pause**  en position basse dans un cycle de perçage en s ou ms en fonction du paramétrage de l'interpréteur de commande.
#### Gravure (Engraving)
* **Profondeur finale** Z de la dernière passe (coordonnées négatives relatives au tracé)
* **Surface pièce** doit être mis à 0 en gravure. C'est la position en Zdes lignes du dessin à graver qui définit la surface de la pièce.
### 3D (STL)
Il faut partir d'un fichier STL généré avec
* **[Openscad](https://www.openscad.org/)**
ou d'une image (Bitmap Heightmaps)

#### Profilage 3D (3D Profile)
* **Recouvrement** incrément de passe horizontale exprimée en fraction du Ø de la fraise (0-1). Pour les modes Horizontal et Vertical, c'est la distance entre chaque "ligne" de balayage. En mode Lignes de niveau – ébauche c'est le décalage entre les lignes de remplissage. En mode Lignes de niveau – finition, cette valeur n'est pas utilisée.
* méthodes 3D Horizontal et Vertical
  * **Résolution** est la distance qui sépare les points de mesure de la hauteur de la pièce (Z) sur chaque ligne de balayage (en fraction du Ø de l'outil - 0 à 1). Une valeur élevée permet un calcul plus rapide mais réduit la précision sur la hauteur des détails du modèle 3D..
* **Vitesse d'avance latérale** à utiliser en déplacement horizontal pour passer d'une trajectoire à la suivante. ( poche, contour plus large que la fraise, ..)
* en Face arrière
  * **Axe de retournement** autour duquel la pièce sera retournée pour usiner la face arrière.
  * **Face arrière**, les parcours d'outil seront créés pour la face arrière du modèle. Vous devrez fournir une valeur correcte pour Zéro Z face arrière.
  * **Zéro Z face arrière** cette valeur corresponds à la coordonnée Z qui sera au niveau Z=0 après retournement du modèle.  ( par rapport à Axe de retournement) Cette valeur remplace la propriété *BackStockSurface* utilisée précédemment dans la méthode *BasReliefs* des anciennes versions de CamBam
* **Etendre limites** extérieure telle que définie dans Limites - Méthode et étendue de la valeur de ce paramètre. Il est recommandé d'utiliser une valeur supérieure à 0 si vous utilisez conjointement les méthodes Lignes de niveau et Contour forme 3D pour définir la limite extérieure.
* **ID formes limites** d'une liste de formes qui représentent les limites de la zone à usiner. Méthode doit être sur Formes sélectionnées.
* **Inclinaison des bords** angle en degrés par rapport à la verticale de l'inclinaison des bords extérieurs (les "murs" crées par la limitation d'usinage)
* **Limite maxi (zone)** un point 2D utilisé conjointement avec "Limite mini" et qui permet de définir les limites de la zone d'usinage Méthode doit être sur Boite englobante pour utiliser ce type de limites. Si les limite Mini et maxi sont toute les deux à 0, la zone d'usinage 3D ne sera pas limitée.
* **Limite mini (zone)** un point 2D utilisé conjointement avec "Limite maxi" et qui permet de définir les limites de la zone d'usinage Méthode doit être sur Boite englobante pour utiliser ce type de limites. Si les limite Mini et maxi sont toute les deux à 0, la zone d'usinage 3D ne sera pas limitée.
* **Méthode** Cette propriété contrôle la forme de la zone qui limite la partie à usiner. Les options disponibles sont: Contour forme 3D: La forme du contour du modèle 3D à la profondeur finale d'usinage Boite englobante: Une boite englobante contenant le modèle 3D entier. Formes sélectionnées: Une liste de formes 2D ou 3D spécifiées dans ID formes limites
* **Ignorer faces arrières** pour améliorer la vitesse de génération du code, les facettes du modèle 3D pointant dans la direction opposée sont ignorées. Cela peut créer des problèmes de compatibilité avec certains modèles (organisation des facettes), dans ce cas, mettez cette option à Faux.
* **Ordre d'usinage** permet de définir si l'on usine jusqu'à la profondeur finale en premier ou si l'on usine chaque niveau en premier.
* **Plan de coupe** seul Les routines des méthodes Ligne de niveau ont été conçues pour un fonctionnement optimal avec les objets naturels, en courbes. Les formes "techniques" avec des faces perpendiculaires peuvent potentiellement poser des problèmes. Si vous rencontrez de tels problèmes, mettez ce paramètre à Vrai peut améliorer les choses, mais l'objet ne doit pas avoir de surplombs..
* **Sens d'usinage** en Opposition, en Avalant, ou Mixte
* **Coin de départ** Pour les méthodes Horizontal et Vertical uniquement: Angle de départ de l'usinage
* **Méthode additive** les parcours d'outil seront créés en mode additif pour l'utilisation avec les têtes d'extrusion. (Méthode par ajout de matière - impression 3D). Les parcours d'outil en mode additif sont générés depuis le bas vers le haut (Z), avec le niveau bas (départ) à Z = Surface pièce. Pour de bons résultats, ce réglage devrait être combiné avec une méthode Lignes de niveau - ébauche et une petite valeur pour Incrément de passe. Cette méthode est encore expérimentale.
* **Méthode profilage 3D** Horizontal (Balayage de la pièce en X), Vertical (Balayage de la pièce en Y), Lignes de niveau – ébauche (série de lignes de niveau qui sont ensuite usinées comme une poche, chaque ligne de niveau servant de limite) Lignes de niveau -  finition (contour à chaque ligne de niveau). Note: en mode Lignes de niveau, c'est l'incrément de profondeur de passe qui détermine l'espacement vertical (Z) des lignes de niveau.
* **Moule** un parcours d'outil en négatif est généré à partir d'une forme en positif.
* **Style de remplissage région** contrôle le motif utilisé pour créer les trajectoires à l'intérieur d'une poche. Tous les effets de ces options sont les mêmes que pour l'option de dessin "remplissage de région" Dessiner – Remplir RégionLes options sont: Lignes horizontales, Lignes Verticales, Décalage (intérieur + extérieur) progressif de la trajectoire partant de l'extérieur vers l'intérieur et une union des trajectoires rayonnants autours des îlots, Décalage (extérieur) progressif de la trajectoire depuis l'extérieur vers l'intérieur. Décalage (intérieur) progressif autour des îlo
