-- 1. Le Rapport Lisible (La fin du RECHERCHEV)
-- Liste de toutes les ventes : nom du produit, ville du magasin, date, quantité
SELECT 
    p.nom_produit AS produit,
    v.nom_ville AS ville_magasin,
    ventes.date_vente,
    ventes.quantite_vendue
FROM ventes
INNER JOIN produits p ON ventes.id_produit = p.id_produit
INNER JOIN magasins m ON ventes.id_magasin = m.id_magasin
INNER JOIN villes v ON m.id_ville = v.id_ville;

-- 2. Le focus "Grand Kivu"
-- Ventes réalisées dans les magasins de Goma et Bukavu (nom produit, prix, quantité)
SELECT 
    p.nom_produit,
    p.prix,
    ventes.quantite_vendue
FROM ventes
INNER JOIN produits p ON ventes.id_produit = p.id_produit
INNER JOIN magasins m ON ventes.id_magasin = m.id_magasin
INNER JOIN villes v ON m.id_ville = v.id_ville
WHERE v.nom_ville IN ('Goma', 'Bukavu');

-- 3. Le top "Katanga"
-- À Lubumbashi, produits de la catégorie 'Running' : nom produit et total des quantités vendues
SELECT 
    p.nom_produit,
    SUM(ventes.quantite_vendue) AS total_quantite_vendue
FROM ventes
INNER JOIN produits p ON ventes.id_produit = p.id_produit
INNER JOIN categories c ON p.id_categorie = c.id_categorie
INNER JOIN magasins m ON ventes.id_magasin = m.id_magasin
INNER JOIN villes v ON m.id_ville = v.id_ville
WHERE v.nom_ville = 'Lubumbashi'
  AND c.nom_categorie = 'Running'
GROUP BY p.nom_produit
ORDER BY total_quantite_vendue DESC;

-- 4. La rentabilité par Magasin
-- Chiffre d'affaires total par magasin (nom du magasin, ville, CA total)
SELECT 
    m.nom_magasin,
    v.nom_ville,
    SUM(ventes.quantite_vendue * p.prix) AS chiffre_affaires_total
FROM ventes
INNER JOIN produits p ON ventes.id_produit = p.id_produit
INNER JOIN magasins m ON ventes.id_magasin = m.id_magasin
INNER JOIN villes v ON m.id_ville = v.id_ville
GROUP BY m.id_magasin, m.nom_magasin, v.nom_ville
ORDER BY chiffre_affaires_total DESC;

-- 5. L'inventaire des catégories par Ville
-- Liste des catégories vendues par ville, sans doublons (ex: catégorie 'Yoga' à Matadi ?)
SELECT DISTINCT
    v.nom_ville,
    c.nom_categorie
FROM ventes
INNER JOIN produits p ON ventes.id_produit = p.id_produit
INNER JOIN categories c ON p.id_categorie = c.id_categorie
INNER JOIN magasins m ON ventes.id_magasin = m.id_magasin
INNER JOIN villes v ON m.id_ville = v.id_ville
ORDER BY v.nom_ville, c.nom_categorie;