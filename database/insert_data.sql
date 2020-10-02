USE ocpizza;

-------------------------------------------------------
-- INSERT address
-------------------------------------------------------
INSERT INTO address (address1, address2, zip_code, city) VALUES
('283 rue des Belles Vues', '', '75011', 'Paris'),
('5 rue de la Conquista', '', '75012', 'Paris'),
('16 avenue des Jules', '', '75013', 'Paris'),
('76 rue des Clots', '', '75015', 'Paris'),
('34 boulevard des Champs', '', '75020', 'Paris'),
('4 rue de l\'Excelsior', '', '92600', 'Asnières-sur-Seine'),
('27 avenue de Pratibha', 'Appt 15', '75016', 'Paris'),
('20 allée Jean-Sébastien Bach', '3e étage porte A', '75009', 'Paris'),
('12 avenue de la Comte', '', '75013', 'Paris'),
('28 rue Libergier', '', '75008', 'Paris'),
('5 rue de Barcelone', '', '75017', 'Paris'),
('10 rue Sollis', '', '75008', 'Paris');

-------------------------------------------------------
-- INSERT restaurant
-------------------------------------------------------
INSERT INTO restaurant (name, address_id) VALUES ('La Californienne', 1), ('La Valencienne', 2),
('La Pétillante', 3), ('La Catalane', 4), ('La Seine', 5);

------------------------------------------------------
-- INSERT team
-------------------------------------------------------
INSERT INTO team (last_name, first_name, phone, email, password, role, restaurant_id) VALUES
('ELREY', 'Nabill', '0611223345', 'nabill_elrey@ocpizza.com', 'gpeiob09', 'Responsable', 1),
('SY', 'Aby', '0688345678', 'aby_sy@ocpizza.com', 'dhhvdkgi', 'Pizzaïolo', '1'),
('GRANTI', 'Baptiste', '0699345618', 'baptise_granti@ocpizza.com', 'mlfnuis2', 'Livreur', '1'),
('ELSOL', 'Amelle', '0678162209', 'amelle_elsol@ocpizza.com', 'discn38', 'Responsable', '2'),
('JAPAGNE', 'Viviane', '0634660056', 'viviane_japagne@ocpizza.com', 'tunhme4', 'Pizzaïolo', '2'),
('TAMARU', 'Victor', '0611421156', 'victor_tamaru@ocpizza.com', 'neuddh45', 'Livreur', '2'),
('BROWN', 'Farida', '0691338901', 'farida_brown@ocpizza.com', 'numpi93', 'Responsable', '3'),
('BEGUR', 'Jordi', '0656112978', 'jordi_begur@ocpizza.com', 'mappzao33', 'Pizzaïolo', '3'),
('ROSSEL', 'Gabi', '0600843781', 'gaby_rossel@ocpizza.com', 'pmjekzi74', 'Livreur', '3'),
('SOTTO', 'Samira', '0600290335', 'samira_sotto@ocpizza.com', 'tyni6P', 'Responsable', '4'),
('SONRISA', 'Malina', '0610103456', 'malina_sonrisa@ocpizza.com', 'sqfsny43', 'Pizzaïolo', '4'),
('LASSO', 'Ines', '0612780007', 'ines_lasso@ocpizza.com', 'cnsiur12', 'Livreur', '4'),
('AHLEMI', 'Nora', '0671918902', 'nora_ahlemi@ocpizza.com', 'urezucr', 'Responsable', '5'),
('ORSICA', 'Marie-Ange', '0678112020', 'marieange_orsica@ocpizza.com', 'mahjnd02', 'Pizzaïolo', '5'),
('SCAVO', 'Tom', '0688664242', 'tom_scavo@ocpizza.com', 'cvcvbe22', 'Livreur', '5');

------------------------------------------------------
-- INSERT ingredient
-------------------------------------------------------

INSERT INTO ingredient (name) VALUES ('sauce tomate'),('mozzarella'), ('olives'), ('anchois'), ('origan'), ('poivrons'),
('gorgonzola'), ('emmental'), ('basilic'), ('aubergines'), ('courgettes'),
('fromage de chèvre'), ('calamars'), ('crevettes'), ('oignons');

-------------------------------------------------------
-- INSERT pizza
-------------------------------------------------------
INSERT INTO pizza (name, price) VALUES
('4 fromages', '14.00'),
('Margarita', '11.00'),
('Fruits de mer', '16.00'),
('Végétarienne', '12.00'),
('Napolitaine', '13.00');

------------------------------------------------------
-- INSERT client
-------------------------------------------------------
INSERT INTO client(last_name, first_name, phone, email, password, address_id) VALUES
('HAYES', 'Cindy', '0600238947', 'cindy_hayes@jmail.com', 'rc5fjd', 7),
('BOOKER', 'Adel', '', 'adel.booker@zmail.com', '', 11),
('HOOD', 'Robin', '', 'robin77@inlook.com', 'lkeand', 6),
('NOUVIE', 'Bilel', '069388847', 'bilel-nouvie@inlook.fr', 'chateau77', 8),
('BELLY', 'Myriam', '', 'myriambelly12@zmail.com', '', 10),
('BELLY', 'Charlie', '', 'charlie24@inlook.com', '', 12);

------------------------------------------------------
-- INSERT ingredient_pizza (recipe)
-------------------------------------------------------
INSERT INTO ingredient_pizza (recipe, quantity, ingredient_id, pizza_id) VALUES
('Etaler la pâte. Ajouter la garniture. Mettre au four à 350°C pendant 10mn', '200', '1', '1'),
('Etaler la pâte. Ajouter la garniture. Mettre au four à 350°C pendant 10mn', '20', '2', '1'),
('Etaler la pâte. Ajouter la garniture. Mettre au four à 350°C pendant 10mn', '40', '7', '1'),
('Etaler la pâte. Ajouter la garniture. Mettre au four à 350°C pendant 10mn', '40', '8', '1'),
('Etaler la pâte. Ajouter la garniture. Mettre au four à 350°C pendant 10mn', '10', '5', '1'),

('Etaler la pâte. Ajouter la garniture. Mettre au four à 350°C pendant 10mn', '200', '1', '2'),
('Etaler la pâte. Ajouter la garniture. Mettre au four à 350°C pendant 10mn', '100', '2', '2'),
('Etaler la pâte. Ajouter la garniture. Mettre au four à 350°C pendant 10mn', '10', '9', '2'),
('Etaler la pâte. Ajouter la garniture. Mettre au four à 350°C pendant 10mn', '10', '9', '2'),

('Etaler la pâte. Ajouter la garniture. Mettre au four à 370°C pendant 15mn', '150', '1', '3'),
('Etaler la pâte. Ajouter la garniture. Mettre au four à 370°C pendant 15mn', '10', '5', '3'),
('Etaler la pâte. Ajouter la garniture. Mettre au four à 370°C pendant 15mn', '60', '8', '3'),
('Etaler la pâte. Ajouter la garniture. Mettre au four à 370°C pendant 15mn', '70', '13', '3'),
('Etaler la pâte. Ajouter la garniture. Mettre au four à 370°C pendant 15mn', '70', '14', '3'),
('Etaler la pâte. Ajouter la garniture. Mettre au four à 370°C pendant 15mn', '40', '15', '3'),

('Etaler la pâte. Ajouter la garniture. Mettre au four à 350°C pendant 15mn', '200', '1', '4'),
('Etaler la pâte. Ajouter la garniture. Mettre au four à 350°C pendant 15mn', '125', '2', '4'),
('Etaler la pâte. Ajouter la garniture. Mettre au four à 350°C pendant 15mn', '100', '6', '4'),
('Etaler la pâte. Ajouter la garniture. Mettre au four à 350°C pendant 15mn', '100', '10', '4'),
('Etaler la pâte. Ajouter la garniture. Mettre au four à 350°C pendant 15mn', '100', '11', '4'),
('Etaler la pâte. Ajouter la garniture. Mettre au four à 350°C pendant 15mn', '40', '15', '4'),
('Etaler la pâte. Ajouter la garniture. Mettre au four à 350°C pendant 15mn', '10', '3', '4'),

('Etaler la pâte. Ajouter la garniture. Mettre au four à 350°C pendant 15mn', '200', '1', '5'),
('Etaler la pâte. Ajouter la garniture. Mettre au four à 350°C pendant 15mn', '125', '2', '5'),
('Etaler la pâte. Ajouter la garniture. Mettre au four à 350°C pendant 15mn', '10', '3', '5'),
('Etaler la pâte. Ajouter la garniture. Mettre au four à 350°C pendant 15mn', '90', '4', '5'),
('Etaler la pâte. Ajouter la garniture. Mettre au four à 350°C pendant 15mn', '10', '5', '5');

------------------------------------------------------
-- INSERT ingredient_restaurant (stock ingredient)
-------------------------------------------------------
INSERT INTO ingredient_restaurant (available_stock, restaurant_id, ingredient_id) VALUES
('30000', '1', '1'), ('10000', '1', '2'), ('5000', '1', '3'), ('3000', '1', '4'), ('800', '1', '5'),
('4000', '1', '6'), ('2000', '1', '7'), ('2000', '1', '8'), ('700', '1', '9'), ('3000', '1', '10'),
('2500', '1', '11'), ('2000', '1', '12'), ('2000', '1', '13'), ('1000', '1', '14'), ('3000', '1', '15'),

('25000', '2', '1'), ('9000', '2', '2'), ('3000', '2', '3'), ('1000', '2', '4'), ('500', '2', '5'),
('4000', '2', '6'), ('2000', '2', '7'), ('2000', '2', '8'), ('700', '2', '9'), ('3000', '2', '10'),
('2500', '2', '11'), ('2000', '2', '12'), ('2000', '2', '13'), ('1000', '2', '14'), ('3000', '2', '15'),

('25000', '3', '1'), ('8000', '3', '2'), ('1500', '3', '3'), ('2000', '3', '4'), ('1000', '3', '5'),
('4000', '3', '6'), ('2000', '3', '7'), ('2000', '3', '8'), ('700', '3', '9'), ('3000', '3', '10'),
('2500', '3', '11'), ('2000', '3', '12'), ('2000', '3', '13'), ('1000', '3', '14'), ('2000', '3', '15'),

('20000', '4', '1'), ('9000', '4', '2'), ('2000', '4', '3'), ('1500', '4', '4'), ('900', '4', '5'),
('3000', '4', '6'), ('2000', '4', '7'), ('2000', '4', '8'), ('900', '4', '9'), ('3000', '4', '10'),
('2000', '4', '11'), ('2000', '4', '12'), ('2000', '4', '13'), ('1000', '4', '14'), ('2000', '4', '15'),

('15000', '5', '1'), ('6000', '5', '2'), ('1000', '5', '3'), ('1500', '5', '4'), ('800', '5', '5'),
('3000', '5', '6'), ('2000', '5', '7'), ('2000', '5', '8'), ('1000', '5', '9'), ('3000', '5', '10'),
('2000', '5', '11'), ('2000', '5', '12'), ('2000', '5', '13'), ('1000', '5', '14'), ('2000', '5', '15');


------------------------------------------------------
-- INSERT purchase
-------------------------------------------------------

INSERT INTO purchase
(purchase_date, total_price, client_id, restaurant_id, address_id, delivery_method, payment_method, purchase_status, payment_status)
VALUES
('2020-06-23 13:01:55', '16.00', 1, 1, 7, 'LIVRER', 'CB', 'Commande livrée', 'Paiement effectué'),
('2020-06-24 12:29:14', '14.00', 2, 1, 11, 'EMPORTER', 'Espèces', 'Commande retirée', 'Paiement effectué'),
('2020-06-24 19:11:55', '12.00', 1, 1, 7, 'LIVRER', 'CB', 'Commande livrée', 'Paiement effectué'),
('2020-06-24 19:30:31', '11.00', 3, 2, 6, 'LIVRER', 'CB', 'Commande livrée', 'Paiement effectué'),
('2020-06-24 20:30:31', '11.00', 4, 3, 8, 'LIVRER', 'CB', 'Annulée', 'Paiement en attente'),
('2020-06-25 12:35:42', '12.00', 4, 3, 8, 'LIVRER', 'CB', 'Commande livrée', 'Paiement effectué'),
('2020-06-25 13:32:01', '11.00', 2, 4, 11, 'EMPORTER', 'CB', 'En attente de retrait', 'Paiement en attente'),
('2020-06-25 13:34:13', '12.00', 3, 4, 6, 'EMPORTER', 'Espèces', 'En attente de retrait', 'Paiement en attente'),
('2020-06-25 13:45:22', '13.00', 6, 5, 12, 'EMPORTER', 'CB', 'Commande retirée', 'Paiement effectué'),
('2020-06-25 20:51:33', '14.00', 6, 5, 12, 'LIVRER', 'CB', 'Commande livrée', 'Paiement effectué'),
('2020-06-26 12:38:11', '12.00', 4, 2, 8, 'EMPORTER', 'Espèces', 'En attente de retrait', 'Paiement en attente'),
('2020-06-26 20:34:09', '30.00', 1, 1, 7, 'LIVRER', 'CB', 'Commande livrée', 'Paiement effectué'),
('2020-06-26 20:37:09', '36.00', 2, 3, 11, 'LIVRER', 'CB', 'Commande livrée', 'Paiement effectué'),
('2020-06-26 20:40:55', '13.00', 2, 3, 11, 'LIVRER', 'CB', 'Commande livrée', 'Paiement effectué');


------------------------------------------------------
-- INSERT pizza_purchase
-------------------------------------------------------
INSERT INTO pizza_purchase (pizza_unit, pizza_id, purchase_id, unit_price) VALUES
(1, 3, 1, '16.00'),
(1, 1, 2, '14.00'),
(1, 4, 3, '12.00'),
(1, 2, 4, '11.00'),
(1, 2, 5, '11.00'),
(1, 4, 6, '12.00'),
(1, 2, 7, '11.00'),
(1, 4, 8, '12.00'),
(1, 5, 9, '13.00'),
(1, 1, 10, '14.00'),
(1, 4, 11, '12.00'),
(1, 1, 12, '14.00'),
(1, 3, 12, '16.00'),
(1, 1, 13, '14.00'),
(2, 2, 13, '11.00'),
(1, 4, 14, '13.00');

------------------------------------------------------
-- INSERT pizza_restaurant (stock_pizza)
-- chaque ligne = resto
-------------------------------------------------------
INSERT INTO pizza_restaurant (available_amount, pizza_id, restaurant_id) VALUES
(40, 1, 1), (35, 2, 1), (20, 3, 1), (30, 4, 1), (20, 5, 1),
(30, 1, 2), (40, 2, 2), (20, 3, 2), (20, 4, 2), (20, 5, 2),
(35, 1, 3), (30, 2, 3), (30, 3, 3), (20, 4, 3), (15, 5, 3),
(50, 1, 4), (20, 2, 4), (10, 3, 4), (30, 4, 4), (30, 5, 4),
(20, 1, 5), (20, 2, 5), (20, 3, 5), (20, 4, 5), (10, 5, 5);
