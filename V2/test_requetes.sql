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

-- Contenu d'une commande
SELECT

-- Commandes en attente dans un resto particulier
SELECT purchase.id AS 'N° commande', purchase.purchase_date AS 'Date', purchase.delivery_method AS 'Mode de retrait', purchase.purchase_status AS 'Statut', restaurant.name AS 'Restaurant'
FROM purchase
LEFT JOIN restaurant
ON purchase.restaurant_id = restaurant.id
WHERE (purchase.purchase_status = 'En attente de retrait' OR 'En attente de livraison') AND (restaurant.name = 'La Catalane')
ORDER BY purchase.id ASC;

----------------------------------
-- REQUETES A TESTER
----------------------------------

-- Afficher commandes avec la pizza 'Végétarienne' (AVANT CHANGEMENT PRIX: 3, 6, 8, 11)
SELECT purchase.id AS 'N° commande', purchase.purchase_date AS 'Date', pizza.name AS 'Pizza', pizza.price AS 'Prix'
FROM pizza_purchase
LEFT JOIN purchase
ON pizza_purchase.purchase_id = purchase.id
RIGHT JOIN pizza
ON pizza_purchase.pizza_id = pizza.id
WHERE pizza.name = 'Végétarienne';

-- Changer le prix d'une pizza (fonctionne mais change aussi les purchases)
UPDATE pizza SET pizza.price = '13.00' WHERE pizza.name = 'Végétarienne';

UPDATE pizza SET pizza.price = (pizza.price) + 1 WHERE pizza.name = 'Végétarienne';


-- Changer l'adresse d'un client


-- Commandes contenant plusieurs pizzas (plusieurs unités d'une mm pizza cmt faire pour dire plusieurs pizzas ?)
-- créer ligne total_unit dans purchase ? / où pizza_purchase.purchase_id apprrait 2 fois ?
SELECT purchase.id AS 'N° commande', pizza_purchase.pizza_unit AS 'Quantité de pizzas', pizza.name AS 'Pizza'
FROM pizza_purchase
LEFT JOIN purchase
ON pizza_purchase.purchase_id = purchase.id
RIGHT JOIN pizza
ON pizza_purchase.pizza_id = pizza.id
WHERE pizza_purchase.pizza_unit > 1;

----------------------------------
-- REQUETES DE MODIF TABLES
----------------------------------

-- Afficher le contenu d'une commande

-- Afficher l'adresse de livraison d'une commande terminée même après que le client ait changé d'adresse
-- Afficher le prix payé pour une pizza d'une commande terminée même après que le prix ait changé
-- Afficher les pizzas pour lesquelles tous les ingrédients sont en stock ( vérifier que la Q en stock soit supérieur à la Q requise par le recette)
SELECT restaurant.name AS 'Restaurant', pizza.name AS 'Pizza'
FROM pizza_restaurant
LEFT JOIN pizza
ON pizza_restaurant.pizza_id = pizza.id
RIGHT JOIN restaurant
ON pizza_restaurant.restaurant_id = restaurant.id
WHERE
(
SELECT restaurant.name AS 'Restaurant', ingredient_restaurant.available_stock AS 'Stock disponible', ingredient.name AS 'Ingrédient'
FROM ingredient_restaurant
LEFT JOIN ingredient
ON ingredient_restaurant.ingredient_id = ingredient.id
RIGHT JOIN restaurant
ON ingredient_restaurant.restaurant_id = restaurant.id
)
>
(
SELECT ingredient.name AS 'Ingrédient', pizza.name AS 'Pizza', ingredient_pizza.quantity AS 'Quantité ingrédient (grammes)'
FROM ingredient_pizza
LEFT JOIN pizza
ON ingredient_pizza.pizza_id = pizza.id
)

----V2---
SELECT restaurant.name AS 'Restaurant', pizza.name AS 'Pizza'
FROM pizza_restaurant
LEFT JOIN pizza
ON pizza_restaurant.pizza_id = pizza.id
RIGHT JOIN restaurant
ON pizza_restaurant.restaurant_id = restaurant.id
WHERE
    (
    SELECT restaurant.name, ingredient_restaurant.available_stock, ingredient.name
    FROM ingredient_restaurant
    LEFT JOIN ingredient
    ON ingredient_restaurant.ingredient_id = ingredient.id
    RIGHT JOIN restaurant
    ON ingredient_restaurant.restaurant_id = restaurant.id
    )
        >
            (
            SELECT ingredient.name, pizza.name, ingredient_pizza.quantity
            FROM ingredient_pizza
            LEFT JOIN pizza
            ON ingredient_pizza.pizza_id = pizza.id
            RIGHT JOIN ingredient
            ON ingredient_pizza.ingredient_id = ingredient.id
            ) LIMIT 10;


-- Afficher les commandes en attente d'un client ?? Pquoi en aurait-il plusieurs en attente en même temps?


-- Add AUTO INCREMENT
ALTER TABLE ingredient_restaurant MODIFY id INT UNSIGNED NOT NULL AUTO_INCREMENT;
-- Rename column
ALTER TABLE purchase CHANGE date purchase_date DATETIME NOT NULL;
-- Obtenir date et heure actuelle
SELECT NOW();

-- Ajout prix
ALTER TABLE pizza_purchase ADD COLUMN price DECIMAL(4,2) NOT NULL;
ALTER TABLE pizza_purchase CHANGE price unit_price DECIMAL(4,2) NOT NULL;