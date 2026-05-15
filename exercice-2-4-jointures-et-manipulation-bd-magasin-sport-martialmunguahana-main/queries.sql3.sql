-- 1. Le Rapport Lisible (La fin du RECHERCHEV)
-- Liste de toutes les ventes : nom du produit, ville du magasin, date, quantité
SELECT 
    p.nom_produit,
    m.ville AS ville_magasin,
    v.date_vente,
    v.quantite
FROM ventes v
INNER JOIN produits p ON v.id_produit = p.id_produit
INNER JOIN magasins m ON v.id_magasin = m.id_magasin;

-- 2. Le focus "Grand Kivu"
-- Ventes dans les magasins de Goma et Bukavu : nom produit, prix, quantité
SELECT 
    p.nom_produit,
    p.prix,
    v.quantite
FROM ventes v
INNER JOIN produits p ON v.id_produit = p.id_produit
INNER JOIN magasins m ON v.id_magasin = m.id_magasin
WHERE m.ville IN ('Goma', 'Bukavu');

-- 3. Le top "Katanga"
-- À Lubumbashi, produits de la catégorie 'Running' vendus : nom produit, total quantités vendues
SELECT 
    p.nom_produit,
    SUM(v.quantite) AS total_quantite_vendue
FROM ventes v
INNER JOIN produits p ON v.id_produit = p.id_produit
INNER JOIN magasins m ON v.id_magasin = m.id_magasin
WHERE m.ville = 'Lubumbashi'
  AND p.categorie = 'Running'
GROUP BY p.nom_produit;

-- 4. La rentabilité par Magasin
-- Chiffre d'affaires total par magasin (nom, ville, CA)
SELECT 
    m.nom_magasin,
    m.ville,
    SUM(v.quantite * p.prix) AS chiffre_affaires_total
FROM ventes v
INNER JOIN produits p ON v.id_produit = p.id_produit
INNER JOIN magasins m ON v.id_magasin = m.id_magasin
GROUP BY m.id_magasin, m.nom_magasin, m.ville
ORDER BY chiffre_affaires_total DESC;

-- 5. L'inventaire des catégories par Ville
-- Liste des catégories vendues par ville, sans doublons
SELECT DISTINCT
    m.ville,
    p.categorie
FROM ventes v
INNER JOIN produits p ON v.id_produit = m.id_produit
INNER JOIN magasins m ON v.id_magasin = m.id_magasin
ORDER BY ville, categorie;