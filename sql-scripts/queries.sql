-- 1️. Find names of users who uploaded recipes that take less than 60 minutes to make
SELECT users.name, recipes.recipe_name
FROM upload_recipe 
NATURAL JOIN users 
NATURAL JOIN recipes
WHERE recipes.minutes_needed < 60;

-- 2️. Count the number of missing ingredients from a user's grocery list that are needed for a specific recipe
SELECT COUNT(ri.ingred_id) AS missing_ingredients
FROM recipes 
NATURAL JOIN recipe_ingredients AS ri 
NATURAL JOIN ingredients
WHERE recipe_id = 6 
AND ri.ingred_id NOT IN (
    SELECT ingred_id
    FROM grocery_list_ingredients AS gli 
    NATURAL JOIN ingredients AS i
    WHERE user_id = 6
);

-- 3️. Find the recipe with "Chicken" that takes the minimum time to make
SELECT recipe_name
FROM recipes
WHERE minutes_needed = (
    SELECT MIN(minutes_needed)
    FROM recipes 
    NATURAL JOIN recipe_ingredients 
    NATURAL JOIN ingredients
    WHERE ingred_name = 'Chicken'
);

-- 4️. Find the highest and lowest-rated reviews for a specific recipe (White Bean Chicken Chili)
SELECT rating, comment
FROM reviews 
WHERE recipe_id = 8 
AND rating = (
    SELECT MAX(rating)
    FROM reviews
    WHERE recipe_id = 8
)
UNION
SELECT rating, comment
FROM reviews 
WHERE recipe_id = 8 
AND rating = (
    SELECT MIN(rating)
    FROM reviews
    WHERE recipe_id = 8
);

-- 5️. Find recipes that contain "Celery" as an ingredient
SELECT recipes.recipe_name
FROM recipes
JOIN recipe_ingredients ON recipes.recipe_id = recipe_ingredients.recipe_id
WHERE recipe_ingredients.ingred_id = (
    SELECT ingred_id FROM ingredients WHERE ingred_name = 'Celery'
);

-- 6️. Find the grocery store where the user pays the least for their grocery list items
DROP VIEW IF EXISTS min_totals;
DROP VIEW IF EXISTS total_for_ingred;

WITH total_for_ingred AS (
    SELECT user_id, grocery_store_id, SUM(price * quantity) AS ingred_total
    FROM grocery_list_ingredients AS gli 
    LEFT JOIN grocery_store_supply AS gss 
    ON gli.ingred_id = gss.ingred_id
    GROUP BY user_id, grocery_store_id
),
min_totals AS (
    SELECT user_id, MIN(ingred_total) AS total
    FROM total_for_ingred
    GROUP BY user_id
)
SELECT mt.user_id, gs.grocery_store_id, gs.grocery_store_name, mt.total
FROM min_totals AS mt
JOIN total_for_ingred AS tfi
ON mt.user_id = tfi.user_id AND mt.total = tfi.ingred_total
JOIN grocery_stores AS gs
ON tfi.grocery_store_id = gs.grocery_store_id;

-- 7️. Find the total expected price for all deliveries
WITH total_for_ingred AS (
    SELECT user_id, grocery_store_id, SUM(price * quantity) AS ingred_total
    FROM grocery_list_ingredients AS gli 
    LEFT JOIN grocery_store_supply AS gss 
    ON gli.ingred_id = gss.ingred_id
    GROUP BY user_id, grocery_store_id
)
SELECT delivery_id, dl.user_id, order_date, dl.grocery_store_id, ingred_total
FROM delivery_log AS dl
LEFT JOIN total_for_ingred AS tfi
ON dl.user_id = tfi.user_id 
AND dl.grocery_store_id = tfi.grocery_store_id;

-- 8️. Find the most popular recipe at potlucks (including ties)
SELECT recipe_id, appearances
FROM (
    SELECT recipe_id, COUNT(*) AS appearances,
           RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
    FROM potluck_attendees
    GROUP BY recipe_id
) AS subquery
WHERE rank = 1;
