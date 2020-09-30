----------------------------------
-- Modification table
----------------------------------
-- Ajout colonne 'unit_price' dans pizza_purchase
ALTER TABLE pizza_purchase ADD COLUMN unit_price DECIMAL(4,2) NOT NULL;
-- Copier données d'une colonne vers une autre (pour que modifications de prix n'impacte pas les commandes antérieures)
UPDATE pizza_purchase SET unit_price = (SELECT pizza.price FROM pizza WHERE pizza.id = pizza_purchase.pizza_id);

----------------------------------
-- REQUETES OK
----------------------------------

-- Ingrédients de la pizza 4 fromages
SELECT ingredient.name
FROM ingredient
LEFT JOIN ingredient_pizza
ON ingredient.id = ingredient_pizza.ingredient_id
RIGHT JOIN pizza
ON pizza.id = ingredient_pizza.pizza_id
WHERE pizza.name = '4 fromages'

-- Ingrédients et quantités en grammes de pizza 4 fromages
SELECT pizza.name AS 'Pizza', ingredient.name AS 'Ingrédient', ingredient_pizza.quantity AS 'Quantité (en grammes)'
FROM ingredient
LEFT JOIN ingredient_pizza
ON ingredient.id = ingredient_pizza.ingredient_id
RIGHT JOIN pizza
ON pizza.id = ingredient_pizza.pizza_id
WHERE pizza.name = '4 fromages';

-- Trouver recette pizza Napolitaine
SELECT pizza.name AS 'Pizza', ingredient.name AS 'Ingrédient', ingredient_pizza.quantity AS 'Quantité (en grammes)', ingredient_pizza.recipe AS 'Recette'
FROM ingredient
LEFT JOIN ingredient_pizza
ON ingredient.id = ingredient_pizza.ingredient_id
RIGHT JOIN pizza
ON pizza.id = ingredient_pizza.pizza_id
WHERE pizza.name = 'Napolitaine';

-- Supprimer olives de la recette 4 fromages
DELETE ingredient_pizza.*
FROM ingredient_pizza
LEFT JOIN ingredient
ON ingredient_pizza.ingredient_id = ingredient.id
RIGHT JOIN pizza
ON pizza.id = ingredient_pizza.pizza_id
WHERE pizza.name = '4 fromages' AND ingredient.name = 'olives';

-- Stocks de tous les ingrédients de tous les restos
SELECT restaurant.name AS Restaurant, ingredient.name AS Ingredient,
ingredient_restaurant.available_stock AS 'Stock (en grammes)'
FROM ingredient_restaurant
LEFT JOIN restaurant
ON restaurant.id = ingredient_restaurant.restaurant_id
RIGHT JOIN ingredient
ON ingredient.id = ingredient_restaurant.ingredient_id;

-- Stocks de tous les ingrédients du resto La Seine
SELECT restaurant.name AS Restaurant, ingredient.name AS Ingredient,
ingredient_restaurant.available_stock AS 'Stock (en grammes)'
FROM ingredient_restaurant
LEFT JOIN restaurant
ON restaurant.id = ingredient_restaurant.restaurant_id
RIGHT JOIN ingredient
ON ingredient.id = ingredient_restaurant.ingredient_id
WHERE restaurant.name = 'La Seine';

-- Commandes en attente dans un resto particulier
SELECT purchase.id AS 'N° commande', purchase.purchase_date AS 'Date', purchase.delivery_method AS 'Mode de retrait', purchase.purchase_status AS 'Statut', restaurant.name AS 'Restaurant'
FROM purchase
LEFT JOIN restaurant
ON purchase.restaurant_id = restaurant.id
WHERE (purchase.purchase_status = 'En attente de retrait' OR 'En attente de livraison') AND (restaurant.name = 'La Catalane')
ORDER BY purchase.id ASC;

-- Changer le prix d'une pizza
UPDATE pizza SET pizza.price = '13.00' WHERE pizza.name = 'Végétarienne';
'OU'
UPDATE pizza SET pizza.price = (pizza.price) + 1 WHERE pizza.name = 'Végétarienne';

-- Afficher commandes avec la pizza 'Végétarienne' avec le prix au moment de la commande
SELECT purchase.id AS 'N° commande', purchase.purchase_date AS 'Date', pizza.name AS 'Pizza', pizza_purchase.unit_price AS 'Prix'
FROM pizza_purchase
LEFT JOIN purchase
ON pizza_purchase.purchase_id = purchase.id
RIGHT JOIN pizza
ON pizza_purchase.pizza_id = pizza.id
WHERE pizza.name = 'Végétarienne';

-- Afficher le contenu d'une commande
SELECT purchase.id AS 'N° Commande', purchase.total_price AS 'Prix', pizza.name AS 'Pizza', pizza_purchase.pizza_unit AS 'Qté pizza', pizza_purchase.unit_price AS 'Prix unitaire'
FROM pizza_purchase
LEFT JOIN pizza
ON pizza_purchase.pizza_id = pizza.id
RIGHT JOIN purchase
ON pizza_purchase.purchase_id = purchase.id
WHERE purchase.id = 13
;

-- Afficher le contenu de chaque commande
SELECT purchase.id AS 'N° Commande', purchase.total_price AS 'Prix', pizza.name AS 'Pizza', pizza_purchase.pizza_unit AS 'Qté pizza', pizza_purchase.unit_price AS 'Prix unitaire'
FROM pizza_purchase
LEFT JOIN pizza
ON pizza_purchase.pizza_id = pizza.id
RIGHT JOIN purchase
ON pizza_purchase.purchase_id = purchase.id
;

-- Affichée commandes terminées
SELECT * FROM purchase WHERE purchase.purchase_status = 'Commande livrée' OR purchase.purchase_status = 'Commande retirée';


------------ Changer adresse d'un client sans changer l'adresse de ses anciennes commandes
-- ajouter nouvelle adresse dans table asdress
INSERT INTO address (address1, address2, zip_code, city) VALUES ('10 rue Sollis', '', '75008', 'Paris');
-- Assigner l'id de la nouvelle adresse d'un client
UPDATE client SET address_id = 13 WHERE email = 'charlie24@inlook.com';
-- Afficher commandes terminées avec adresse (celles du client.id = 6 n'ont pas changé d'adresse)
SELECT purchase.id AS 'N° Commande', purchase.purchase_status AS 'Statut', address.address1 AS 'Adresse', address.zip_code AS 'CP', address.city AS 'Ville', purchase.client_id AS 'N° Client'
FROM purchase
LEFT JOIN address
ON purchase.address_id = address.id
WHERE purchase.purchase_status = 'Commande livrée' OR purchase.purchase_status = 'Commande retirée';
'OU'
-- Afficher commandes terminées avec adresse du client 6
SELECT purchase.id AS 'N° Commande', purchase.purchase_status AS 'Statut', address.address1 AS 'Adresse', address.zip_code AS 'CP', address.city AS 'Ville', purchase.client_id AS 'N° Client'
FROM purchase
LEFT JOIN address
ON purchase.address_id = address.id
WHERE (purchase.purchase_status = 'Commande livrée' OR purchase.purchase_status = 'Commande retirée' ) AND purchase.client_id = 6;
-- Afficher l'adresse d'un client
SELECT client.id AS 'N° client', client.last_name AS 'Nom', client.first_name AS 'Prénom', address.id AS 'N° Adresse',
CONCAT(address.address1, '-', address.address2, ' ', address.zip_code, ' ', address.city) AS 'Adresse complète'
FROM address
INNER JOIN client
ON address.id = client.address_id
WHERE client.email = 'charlie24@inlook.com';


-- Afficher les pizzas pour lesquelles tous les ingrédients sont en stock (selon chaque restaurant)
SELECT DISTINCT pizza.name AS "Pizzas disponibles"
FROM pizza
INNER JOIN ingredient_pizza ON ingredient_pizza.pizza_id = pizza.id
INNER JOIN ingredient ON ingredient.id = ingredient_pizza.ingredient_id
INNER JOIN ingredient_restaurant ON ingredient_restaurant.ingredient_id = ingredient.id
INNER JOIN restaurant ON restaurant.id = ingredient_restaurant.restaurant_id
WHERE pizza.name NOT IN (
                SELECT pizza.name
                FROM pizza
                INNER JOIN ingredient_pizza ON ingredient_pizza.pizza_id = pizza.id
                INNER JOIN ingredient ON ingredient.id = ingredient_pizza.ingredient_id
                INNER JOIN ingredient_restaurant ON ingredient_restaurant.ingredient_id = ingredient.id
                INNER JOIN restaurant ON restaurant.id = ingredient_restaurant.restaurant_id
                WHERE restaurant.name = 'La Seine'
                AND ingredient_restaurant.available_stock - ingredient_pizza.quantity <= 0
                GROUP BY pizza.name
                        );


----------------------------------
-- REQUETES A TESTER
----------------------------------

-- Commandes contenant plusieurs pizzas (cmt faire pour trier par purchase_id ?)
SELECT pizza_purchase.purchase_id AS 'N° commande', pizza_purchase.pizza_unit AS 'Quantité de pizzas', pizza.name AS 'Pizza'
FROM pizza_purchase
RIGHT JOIN pizza
ON pizza_purchase.pizza_id = pizza.id
WHERE pizza_purchase.purchase_id IN
    (
        SELECT pizza_purchase.purchase_id
        FROM pizza_purchase
        GROUP BY pizza_purchase.purchase_id
        HAVING COUNT(DISTINCT pizza_purchase.id)>1
    );





----------------------------------
-- REQUETES DE MODIF TABLES
----------------------------------







-- Afficher les commandes en attente d'un client ?? Pquoi en aurait-il plusieurs en attente en même temps?


-- Add AUTO INCREMENT
--ALTER TABLE ingredient_restaurant MODIFY id INT UNSIGNED NOT NULL AUTO_INCREMENT;

-- Rename column
--ALTER TABLE purchase CHANGE date purchase_date DATETIME NOT NULL;

-- Obtenir date et heure actuelle
--SELECT NOW();

-- Ajout prix
--ALTER TABLE pizza_purchase ADD COLUMN price DECIMAL(4,2) NOT NULL;
--ALTER TABLE pizza_purchase CHANGE price unit_price DECIMAL(4,2) NOT NULL;