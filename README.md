# 🍽 Recipe Database Project  

## 📌 Overview  
This is a **relational database** for an **interactive recipe application** that allows users to:  
✅ Search and filter recipes  
✅ Upload and review recipes  
✅ Manage grocery lists  
✅ Order grocery deliveries  
✅ Organize potluck events  

---

## 🏗 Database Design  

This project follows an **Entity-Relationship (ER) model**, organizing data into key entities and relationships that support the application's features.  

### **🔑 Key Components & Features:**  
- **Users**: Includes general users and delivery employees. Users can upload recipes, review dishes, manage grocery lists, and participate in potlucks.  
- **Recipes**: Uploaded by users, recipes can include video tutorials, receive ratings, and be shared at potlucks.  
- **Ingredients**: Linked to both grocery stores (where they are available) and recipes (where they are used).  
- **Grocery Stores & Deliveries**: Users can order groceries from stores, with deliveries made by designated employees.  
- **Potlucks**: Users can host and attend potluck events, coordinating dishes and guests.  
- **Video Tutorials**: Select recipes include step-by-step video tutorials to assist users in cooking.  


### 🔍 ER Diagram  
![ER Diagram](er-diagrams/ER-Diagram.png)  

---

## 📊 Database Schema  
### **📝 Tables (schema.sql)**  
```sql
CREATE TABLE Grocery_Stores (
    grocery_store_id INT PRIMARY KEY,
    grocery_store_name TEXT NOT NULL,
    grocery_store_address TEXT NOT NULL
);

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    delivery_employee_id INT UNIQUE
);
```
(Full schema in schema.sql)


## 🔍 Example Queries (`queries.sql`)  
### 1️⃣ **Find names of users who uploaded recipes under 60 minutes:**  
```sql
SELECT users.name, recipes.recipe_name
FROM upload_recipe 
NATURAL JOIN users 
NATURAL JOIN recipes
WHERE recipes.minutes_needed < 60;
```

### 2️⃣ **Find the most popular recipe at potlucks (including ties):**  
```sql
SELECT recipe_id, appearances
FROM (
    SELECT recipe_id, COUNT(*) AS appearances,
           RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
    FROM potluck_attendees
    GROUP BY recipe_id
) AS subquery
WHERE rank = 1;
```

(More queries in queries.sql)

