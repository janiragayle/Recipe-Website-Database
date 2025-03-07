-- Insert sample users
INSERT INTO Users (user_id, email, name, delivery_employee_id) VALUES
(1, 'alice@example.com', 'Alice Smith', NULL),
(2, 'bob@example.com', 'Bob Johnson', NULL),
(3, 'charlie@example.com', 'Charlie Davis', 101),  -- Delivery employee
(4, 'david@example.com', 'David White', NULL),
(5, 'emma@example.com', 'Emma Brown', NULL);

-- Insert sample grocery stores
INSERT INTO Grocery_Stores (grocery_store_id, grocery_store_name, grocery_store_address) VALUES
(1, 'Fresh Mart', '123 Main St'),
(2, 'Super Grocers', '456 Market Ave'),
(3, 'Green Foods', '789 Eco Blvd');

-- Insert sample ingredients
INSERT INTO Ingredients (ingred_id, ingred_name) VALUES
(10, 'Chicken'),
(11, 'Tomato'),
(12, 'Celery'),
(13, 'Onion'),
(14, 'Garlic'),
(15, 'Salt');

-- Insert sample grocery store supply (ingredients available at stores)
INSERT INTO Grocery_Store_Supply (grocery_store_id, ingred_id, price, unit) VALUES
(1, 10, 5.99, 'lb'),
(1, 11, 2.50, 'lb'),
(2, 12, 1.20, 'lb'),
(2, 13, 3.00, 'lb'),
(3, 14, 0.99, 'clove'),
(3, 15, 0.50, 'oz');

-- Insert sample grocery lists (user shopping lists)
INSERT INTO Grocery_List_Ingredients (ingred_id, user_id, bought, quantity, unit) VALUES
(10, 1, FALSE, 2, 'lb'),
(11, 1, FALSE, 1, 'lb'),
(12, 2, TRUE, 1, 'lb'),
(13, 3, FALSE, 2, 'lb'),
(14, 4, TRUE, 3, 'cloves'),
(15, 5, FALSE, 0.5, 'oz');

-- Insert sample recipes
INSERT INTO Recipes (recipe_id, recipe_name, instructions, minutes_needed) VALUES
(100, 'Chicken Curry', 'Cook chicken with curry powder.', 45),
(101, 'Tomato Soup', 'Blend tomatoes with spices.', 30),
(102, 'Garlic Roasted Chicken', 'Roast chicken with garlic and salt.', 60);

-- Insert sample recipe ingredients
INSERT INTO Recipe_Ingredients (recipe_id, ingred_id, quantity, unit) VALUES
(100, 10, 2, 'lb'),
(100, 11, 1, 'lb'),
(101, 11, 3, 'lb'),
(101, 15, 1, 'oz'),
(102, 10, 3, 'lb'),
(102, 14, 2, 'cloves');

-- Insert sample uploaded recipes
INSERT INTO Upload_Recipe (recipe_id, user_id) VALUES
(100, 1),
(101, 2),
(102, 3);

-- Insert sample reviews
INSERT INTO Reviews (user_id, recipe_id, rating, comment, post_date) VALUES
(1, 100, 5, 'Great dish!', '2024-02-01'),
(2, 101, 4, 'Tasty but needs more seasoning.', '2024-02-02'),
(3, 102, 5, 'Perfect for dinner.', '2024-02-03');

-- Insert sample delivery logs
INSERT INTO Delivery_Log (delivery_id, order_date, user_id, delivery_employee_id, grocery_store_id) VALUES
(1, '2024-03-01', 1, 101, 1),
(2, '2024-03-02', 2, 101, 2);

-- Insert sample video tutorials
INSERT INTO Video_Tutorials (user_id, recipe_id, duration, likes, upload_date, video_link) VALUES
(1, 100, 10, 50, '2024-02-05', 'https://example.com/video1'),
(2, 101, 5, 30, '2024-02-06', 'https://example.com/video2');

-- Insert sample potluck hosts
INSERT INTO Potluck_Host_Info (event_id, event_name, host_user_id, event_date) VALUES
(1, 'Spring Feast', 1, '2024-04-10'),
(2, 'Summer BBQ', 2, '2024-06-20');

-- Insert sample potluck attendees
INSERT INTO Potluck_Attendees (event_id, user_id, recipe_id) VALUES
(1, 3, 100),
(1, 4, 101),
(2, 5, 102);
