-- Drop tables if they exist to avoid conflicts
DROP TABLE IF EXISTS Potluck_Attendees, Potluck_Host_Info, Video_Tutorials, Delivery_Log, Grocery_Stores, Grocery_Store_Supply, Users, Reviews, Ingredients, Grocery_List_Ingredients, Recipes, Recipe_Ingredients, Upload_Recipe CASCADE;

-- Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY, 
    email TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    delivery_employee_id INT UNIQUE
);

-- Grocery Stores Table
CREATE TABLE Grocery_Stores (
    grocery_store_id INT PRIMARY KEY,
    grocery_store_name TEXT NOT NULL,
    grocery_store_address TEXT NOT NULL
);

-- Grocery Store Supply Table (Many-to-Many Relationship)
CREATE TABLE Grocery_Store_Supply (
    grocery_store_id INT REFERENCES Grocery_Stores(grocery_store_id),
    ingred_id INT REFERENCES Ingredients(ingred_id),
    price DOUBLE PRECISION NOT NULL,
    unit TEXT NOT NULL,
    PRIMARY KEY (grocery_store_id, ingred_id)
);

-- Ingredients Table
CREATE TABLE Ingredients (
    ingred_id INT PRIMARY KEY,
    ingred_name TEXT NOT NULL
);

-- Grocery List Ingredients Table (User Grocery Lists)
CREATE TABLE Grocery_List_Ingredients (
    ingred_id INT NOT NULL REFERENCES Ingredients(ingred_id),
    user_id INT NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE,
    bought BOOLEAN NOT NULL,
    quantity FLOAT,
    unit TEXT,
    PRIMARY KEY (ingred_id, user_id)
);

-- Recipes Table
CREATE TABLE Recipes (
    recipe_id INT PRIMARY KEY,
    recipe_name TEXT NOT NULL,
    instructions TEXT NOT NULL,
    minutes_needed INT
);

-- Recipe Ingredients Table (Many-to-Many Relationship)
CREATE TABLE Recipe_Ingredients (
    recipe_id INT REFERENCES Recipes(recipe_id),
    ingred_id INT REFERENCES Ingredients(ingred_id),
    quantity FLOAT,
    unit TEXT,
    PRIMARY KEY (recipe_id, ingred_id)
);

-- Upload Recipe Table (Links Users to Recipes They Upload)
CREATE TABLE Upload_Recipe (
    recipe_id INT REFERENCES Recipes(recipe_id) ON DELETE CASCADE,
    user_id INT REFERENCES Users(user_id) ON DELETE CASCADE,
    PRIMARY KEY (recipe_id, user_id)
);

-- Reviews Table
CREATE TABLE Reviews (
    user_id INT REFERENCES Users(user_id) ON DELETE CASCADE,
    recipe_id INT NOT NULL REFERENCES Recipes(recipe_id) ON DELETE CASCADE,
    rating INT NOT NULL,
    comment TEXT,
    post_date DATE NOT NULL,
    PRIMARY KEY (recipe_id, user_id)
);

-- Delivery Log Table (Tracks Grocery Deliveries)
CREATE TABLE Delivery_Log (
    delivery_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    user_id INT NOT NULL REFERENCES Users(user_id),
    delivery_employee_id INT NOT NULL REFERENCES Users(delivery_employee_id),
    grocery_store_id INT NOT NULL REFERENCES Grocery_Stores(grocery_store_id)
);

-- Video Tutorials Table (Weak Entity of Recipe)
CREATE TABLE Video_Tutorials (
    user_id INT REFERENCES Users(user_id) ON DELETE CASCADE,
    recipe_id INT NOT NULL REFERENCES Recipes(recipe_id) ON DELETE CASCADE,
    duration INT NOT NULL CHECK (duration > 0),
    likes INT NOT NULL CHECK (likes >= 0),
    upload_date DATE NOT NULL,
    video_link TEXT UNIQUE NOT NULL,
    PRIMARY KEY (recipe_id, user_id)
);

-- Potluck Host Info Table
CREATE TABLE Potluck_Host_Info (
    event_id INT PRIMARY KEY,
    event_name TEXT NOT NULL,
    host_user_id INT NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE,
    event_date DATE NOT NULL
);

-- Potluck Attendees Table (Many-to-Many Relationship)
CREATE TABLE Potluck_Attendees (
    event_id INT NOT NULL REFERENCES Potluck_Host_Info(event_id),
    user_id INT NOT NULL REFERENCES Users(user_id),
    recipe_id INT,  -- Optional: Attendee may bring a dish
    PRIMARY KEY (event_id, user_id)
);
