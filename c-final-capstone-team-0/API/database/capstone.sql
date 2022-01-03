USE master
GO

--drop database if it exists
IF DB_ID('final_capstone') IS NOT NULL
BEGIN
	ALTER DATABASE final_capstone SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE final_capstone;
END
GO -- added this GO - not sure if it's needed

CREATE DATABASE final_capstone
GO

USE final_capstone
GO

--create tables
CREATE TABLE users (
	user_id int IDENTITY(1,1) NOT NULL,
	username varchar(50) NOT NULL,
	password_hash varchar(200) NOT NULL,
	salt varchar(200) NOT NULL,
	user_role varchar(50) NOT NULL
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);

--create recipes table
CREATE TABLE recipes (
	recipe_id INT IDENTITY(1,1) NOT NULL,
	recipe_name VARCHAR(200) NOT NULL,
	calories VARCHAR(100) NULL,
	instructions VARCHAR(2000) NOT NULL,
	recipe_image VARCHAR(512) NOT NULL,
	CONSTRAINT PK_recipes PRIMARY KEY (recipe_id),
	UNIQUE(recipe_name)

);
--create recipes_users table
CREATE TABLE recipes_users (
	recipe_id INT NOT NULL,
	user_id INT NOT NULL,
	CONSTRAINT PK_recipes_users PRIMARY KEY (recipe_id, user_id),
	CONSTRAINT FK_recipes_users_recipes FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id),
	CONSTRAINT FK_recipes_users_users FOREIGN KEY (user_id) REFERENCES users(user_id)
);
--create ingredients table
CREATE TABLE ingredients (
	ingredient_id INT IDENTITY (1,1) NOT NULL,
	ingredient_name VARCHAR(100) NOT NULL,
	CONSTRAINT PK_ingredients PRIMARY KEY (ingredient_id),
	UNIQUE(ingredient_name)
);
--create table to connect recipes and ingredients
CREATE TABLE recipe_ingredients (
	recipe_id INT NOT NULL,
	ingredient_id INT NOT NULL,
	amount VARCHAR(50) NOT NULL,
	unit VARCHAR(100) NOT NULL,
	CONSTRAINT PK_recipe_ingredients PRIMARY KEY (recipe_id, ingredient_id),
	CONSTRAINT FK_recipe_ingredients_recipes FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id),
	CONSTRAINT FK_recipe_ingredients_users FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id)
);
--create category table
CREATE TABLE category (
	category_id INT IDENTITY (1,1) NOT NULL,
	category_name VARCHAR(100) NOT NULL,
	CONSTRAINT PK_category PRIMARY KEY (category_id)
);
--relational category-recipes
CREATE TABLE recipe_category(
	recipe_id INT NOT NULL,
	category_id INT NOT NULL,
	CONSTRAINT FK_recipe_category_recipes FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id),
	CONSTRAINT FK_recipe_category_category FOREIGN KEY (category_id) REFERENCES category(category_id)
);
--create meal_plan table
CREATE TABLE meal_plan (
	meal_plan_id INT IDENTITY (1,1) NOT NULL,
	meal_plan_name VARCHAR(100) NOT NULL,
	CONSTRAINT PK_meal_plan PRIMARY KEY (meal_plan_id),
);
--Meal_Plan_User
CREATE TABLE meal_plan_user(
	meal_plan_id INT NOT NULL,
	user_id INT NOT NULL,
	CONSTRAINT FK_meal_plan_user_meal_plan FOREIGN KEY (meal_plan_id) REFERENCES meal_plan(meal_plan_id),
	CONSTRAINT FK_meal_plan_user_users FOREIGN KEY (user_id) REFERENCES users(user_id)
);
CREATE TABLE meal_plan_recipe(
	meal_plan_id INT NOT NULL,
	recipe_id INT NOT NULL,
	CONSTRAINT FK_meal_plan_recipe_meal_plan FOREIGN KEY (meal_plan_id) REFERENCES meal_plan(meal_plan_id),
	CONSTRAINT FK_meal_plan_recipe_recipes FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id)
);
CREATE TABLE dish_type(
	dish_type_id INT IDENTITY(1,1) NOT NULL,
	dish_type_name VARCHAR(100) NOT NULL,
	CONSTRAINT PK_dish_type PRIMARY KEY (dish_type_id)
);
CREATE TABLE recipe_dish_type(
	dish_type_id INT NOT NULL,
	recipe_id INT NOT NULL,
	CONSTRAINT FK_recipe_dish_type_dish_type FOREIGN KEY (dish_type_id) REFERENCES dish_type(dish_type_id),
	CONSTRAINT FK_recipe_dish_type_recipes FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id)
);

--populate default data
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('user','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('admin','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','admin');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('Alec','6cWcPlWhm/SgDxa9LCqPZOscnRU=', 'Y7JKLDfzcLg=','user');
--GO
INSERT INTO category (category_name) VALUES ('Vegetarian');
INSERT INTO category (category_name) VALUES ('Easy');
INSERT INTO category (category_name) VALUES ('Low Carb');
INSERT INTO category (category_name) VALUES ('Gluten Free');
INSERT INTO category (category_name) VALUES ('Keto');
INSERT INTO category (category_name) VALUES ('Other');
INSERT INTO category (category_name) VALUES ('Mexican');
INSERT INTO category (category_name) VALUES ('Low-Ingredients');

--Insert Users

INSERT INTO ingredients (ingredient_name)
VALUES
('Basil Leaf'),('Chicken'),('Rice'),('Garbanzo Beans'),('Green Beans'),('Black Pepper'),('Olive Oil'),('Kosher Salt'),('Butter'),('Flour'),('Milk'),('Cheddar Cheese'),('Butternut Squash'),
('Salmon'),('Shredded Mexican Blend Cheese'),('Shredded Cheddar Cheese'),('Potato'),('Onion'),('Tomato'),('Red Enchilada Sauce'),('Flour Tortilla'),('Ground Beef'),('Penne Pasta'),('Broccoli'),
('Alfredo Sauce'),('Lasagna Noodles'),('Ricotta Cheese'),('Pasta Sauce'),('Mixed Veggies'),('Mozzarella Cheese'),('Elbow Macaroni'),('Salt'),('Cauliflower'),('Italian Seasoning'),
('Garlic'),('Parmesan Cheese'),('Lemon Pepper'),('Chicken Breast'),('Basil Pesto'),('Prosciutto'),('Honey Barbeque Sauce'),('Bacon'),('Shallot'),('Balsamic Vinegar'),('Goat Cheese'),('Water'),
('Quinoa'),('Walnuts'),('Frozen Peas'),('Eggs'),('Egg Whites'),('Mushrooms'),('Baby Spinach'),('Provolone Cheese'),('Red Potatoes'),('Whole Grain Spiral Pasta'),('Parmesan Reggiano Cheese'),
('Green Onion'),('Eggplant'),('Fresh Basil'),('Pepper'),('Rigatoni'),('Creamed Spinach'),('Artichoke Hearts'),('Feta Cheese'),('Sweet Potatoes'),('Whole Wheat Tortillas'),('Black Beans'),
('Pepper Jack Cheese'),('Salsa'),('Corn Tortillas'),('Fresh Spinach'),('Blueberries'),('Sugar'),('Cornstarch'),('Refrigerated Pie Crust'),('Egg Yolk'),('Cream Cheese'),('Semisweet Chocolate Chips'),
('Nutella'),('Graham Cracker Crumbs'),('Hazelnuts, Chopped'),('Hazelnuts, Whole'),('Mango Chunks'),('Passion Fruit Juice'),('Raspberry Pie Filling'),('Yellow Cake Mix'),('Canola Oil'),('Vanilla Ice Cream'),
('Confectioners Sugar'),('Pecans');

--add recipes
INSERT INTO recipes (recipe_name, calories, instructions, recipe_image)
VALUES ('Easy Cheesy Ground Beef Enchiladas', '517' , 'Heat oven to 375�. Brown ground beef until thoroughly cooked; drain. Stir in 3/4 cup enchilada sauce and one cup of cheese. Spoon meat mixture onto tortillas roll-up and place seam-side down in lightly greased baking dish. Pour remaining enchilada sauce over top. Cover with remaining cheese. Bake for 15 to 20 minutes or until cheese melts. Serve with yellow rice and refried beans. Garnish with sour cream, salsa, and lettuce.',
'https://cdn.greatlifepublishing.net/wp-content/uploads/sites/2/2020/04/30113119/Easy-Cheesy-Ground-Beef-Enchiladas-Horizontal-12-728x546.jpg');
INSERT INTO recipes (recipe_name, calories, instructions, recipe_image)
VALUES ('Vegetable Lasagna', '330', 'Preheat oven to 350�F. Spread a thin layer of sauce on the bottom of a 9"x13" casserole. Cover with a layer of noodles (3 or 4 noodles should be enough). Place ricotta in a bowl and add about 1/4 cup of water, stirring until blended. Spread 1/3 of this mixture over the pasta (you can use a cake spatula). Spread 1/3 of the remaining pasta sauce over the cheese. Spread 1/3 of the vegetables over the sauce. Sprinkle 1/3 of the mozzarella over the veggies. Repeat twice starting with the noodles and ending with the mozzarella. Cover and bake until the noodles are tender (35 to 40 minutes). Remove cover and bake 5 minutes until cheese starts to become golden. Remove from oven and allow to stand for 5 minutes before cutting into squares.',
'https://img.sndimg.com/food/image/upload/w_560,h_315,c_thumb,fl_progressive,q_80/v1/img/recipes/28/62/90/xnRxs4TfSwtXd2jIxuOD_untitled-0483.jpg');
INSERT INTO recipes (recipe_name, calories, instructions, recipe_image)
VALUES ('Grilled Tomatoes', '43', 'First seed the tomatoes, next cut the tomatoes in half and season them with salt and pepper, brush the tomatoes with olive oil, grill tomatoes(cut side down) for 2-4 minutes',
'https://www.simplyrecipes.com/thmb/4DUYNg7DSHOzljsFWKnwKRXnrG8=/648x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__simply_recipes__uploads__2008__07__grilled-tomatoes-vertical-a-1800-f331b06bd8724c268cc1d3f404d23bc6.jpg')
INSERT INTO recipes(recipe_name, calories, instructions, recipe_image)
VALUES ('Simple Mac n Cheese', '630', 'Bring a large pot of lightly salted water to a boil. Boil elbow macaroni for 8 minutes, then drain. Melt butter in a saucepan over medium heat; stir in flour, salt, and pepper until smooth, about 5 minutes. Slowly pour milk into butter-flour mixture while continuously stirring until mixture is smooth and bubbling. Stir cheese into mixture until cheese is melting.',
'https://www.seriouseats.com/thmb/kufAZ3RBFU5V95r1hoQE1QKf2Ns=/900x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__serious_eats__seriouseats.com__2021__02__20210214-stovetop-mac-cheese-reshoot-vicky-wasik-9-0760b642ca704cf8b2c5121a363a60a2.jpg');
INSERT INTO recipes(recipe_name, calories, instructions, recipe_image)
VALUES ('Garlic Parmesan Roasted Cauliflower', '230', 'To make the roasted cauliflower: Preheat your oven to 400�F (200�C). Cut the cauliflower head into florets, and rinse in a colander. Prepare a large baking sheet �  you can line it with parchment paper if you like. Pat the cauliflower florets dry with paper towels and place them in a large salad bowl. Add olive oil, Italian seasoning, garlic, Parmesan, salt, and pepper. Toss gently to coat the cauliflower florets evenly. Place cauliflower florets on the prepared baking sheet, spreading evenly into one layer. Bake the garlic parmesan cauliflower florets on the center rack of your oven for 25 to 30 minutes � Adjust the time depending on your oven, the cauliflower should be golden brown and crisp on the edges. Use a fork to check cauliflower for doneness, it should easily pierce the cauliflower pieces. Transfer the parmesan roasted cauliflower florets to a large serving bowl and sprinkle with fresh chopped parsley if you like. Enjoy!',
'https://www.eatwell101.com/wp-content/uploads/2021/12/oven-roasted-cauliflower-recipe.jpg');
INSERT INTO recipes(recipe_name, calories, instructions, recipe_image)
VALUES ('Simple Roasted Butternut Squash', '177', 'Preheat oven to 400 degrees F (200 degrees C). Toss butternut squash with olive oil and garlic in a large bowl. Season with salt and black pepper. Arrange coated squash on a baking sheet. Roast in the preheated oven until squash is tender and lightly browned, 25 to 30 minutes.',
'https://www.wellplated.com/wp-content/uploads/2017/11/Cinnamon-Roasted-Butternut-Squash-Easy-butternut-squash-recipe-768x1035.jpg');
INSERT INTO recipes(recipe_name, calories, instructions, recipe_image)
VALUES ('Buttery Garlic Green Beans', '116', 'Place green beans into a large skillet and cover with water; bring to a boil. Reduce heat to medium-low and simmer until beans start to soften, about 5 minutes. Drain water. Add butter to green beans; cook and stir until butter is melted, 2 to 3 minutes. Cook and stir garlic with green beans until garlic is tender and fragrant, 3 to 4 minutes. Season with lemon pepper and salt.',
'https://i2.wp.com/completelydelicious.com/wp-content/uploads/2019/09/buttery-garlic-green-beans-4.jpg');
INSERT INTO recipes(recipe_name, calories, instructions, recipe_image)
VALUES ('Pesto Chicken', '312', 'Preheat oven to 400 degrees F (200 degrees C). Grease a baking dish. Spread about 2 tablespoons of pesto per chicken breast over the top of each breast, and wrap each breast in prosciutto slices to cover the entire breast. Place the wrapped chicken breasts into the prepared baking dish. Bake in the preheated oven until the chicken is no longer pink, the juices run clear, and the prosciutto is lightly crisped, about 25 minutes.',
'https://cafedelites.com/wp-content/uploads/2016/07/chicken-pesto-recipe-9.jpg');
INSERT INTO recipes(recipe_name, calories, instructions, recipe_image)
VALUES ('Bacon Chicken', '522', 'Preheat oven to 350 degrees F (175 degrees C). Wash chicken and pat dry, then place in a 9x13 inch baking dish. Smother chicken with 1/2 of the barbecue sauce, then layer bacon slices cross-ways on top. Pour remaining 1/2 of barbecue sauce over all. Bake at 350 degrees F (175 degrees C) for about 45 minutes or until chicken is cooked through and juices run clear. Serve one chicken breast per person with just the crispy, top pieces of bacon.',
'https://www.dinneratthezoo.com/wp-content/uploads/2018/05/bacon-wrapped-chicken-4-1.jpg');
INSERT INTO recipes(recipe_name, calories, instructions, recipe_image)
VALUES ('Balsamic Goat Cheese Stuffed Chicken Breasts', '340', 'Preheat oven to 350 degrees F (175 degrees C). Heat olive oil in a skillet over medium heat; cook and stir shallot until translucent, about 5 minutes. Pour balsamic vinegar into skillet and bring to a boil. Reduce heat to low and simmer until balsamic vinegar mixture is reduced by half, about 10 minutes. Stir often. Cut chicken breasts from one side through the middle horizontally to within one-half inch of the other side. Open the two sides and spread them out like an open book. Spread half the goat cheese onto one half of each chicken breast and drizzle 1/3 of the reduced balsamic vinegar mixture over the goat cheese. Close the chicken breasts over the goat cheese and secure with toothpicks. Arrange chicken into a baking dish. Drizzle with remaining 1/3 of the balsamic reduction. Bake in the preheated oven until the chicken is no longer pink inside, the filling is hot, and the juices run clear, 30 to 35 minutes. An instant-read meat thermometer inserted into the center of a filled breast should read at least 160 degrees F (70 degrees C).',
'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F1120650.jpg&w=596&h=596&c=sc&poi=face&q=85');
INSERT INTO recipes(recipe_name, calories, instructions, recipe_image)
VALUES ('Quinoa with Peas and Onion', '174', 'In a large saucepan, bring water to a boil. Add quinoa. Reduce heat; cover and simmer until water is absorbed, 12-15 minutes. Remove from the heat; fluff with a fork. Meanwhile, in a large cast-iron or other heavy skillet, saute onion in oil until tender, 2-3 minutes. Add peas; cook and stir until heated through. Stir in the cooked quinoa, salt and pepper. Sprinkle with walnuts.',
'https://www.tasteofhome.com/wp-content/uploads/2018/01/Quinoa-with-Peas-and-Onion_EXPS_SDAM19_46330_E12_04_10b-4.jpg?fit=700,1024');
INSERT INTO recipes(recipe_name, calories, instructions, recipe_image)
VALUES ('Spinach Mushroom Scrambled Eggs', '162', 'In a small bowl, whisk eggs, egg whites, salt and pepper until blended. In a small nonstick skillet, heat butter over medium-high heat. Add mushrooms; cook and stir 3-4 minutes or until tender. Add spinach; cook and stir until wilted. Reduce heat to medium. Add egg mixture; cook and stir just until eggs are thickened and no liquid egg remains. Stir in cheese.',
'https://www.tasteofhome.com/wp-content/uploads/2018/01/Spinach-Mushroom-Scrambled-Eggs_exps62041_THHC2377563B05_04_8bC_RMS-5.jpg?fit=700,1024');
INSERT INTO recipes(recipe_name, calories, instructions, recipe_image)
VALUES ('Pesto Pasta and Potatoes', '261', 'Place potatoes in a large saucepan; add water to cover. Bring to a boil. Reduce heat; cook, uncovered, until tender, 8-10 minutes. Drain; transfer to a large bowl. Meanwhile, cook pasta according to package directions, adding green beans during the last 5 minutes of cooking. Drain, reserving 3/4 cup pasta water; add to potatoes. Toss with pesto, cheese and enough pasta water to moisten.',
'https://www.tasteofhome.com/wp-content/uploads/2018/01/exps62488_SD143204D12_10_5b-2.jpg?fit=700,1024');
INSERT INTO recipes(recipe_name, calories, instructions, recipe_image)
VALUES ('Spinach Parm Casserole', '239', 'Preheat oven to 400�. In a stockpot, bring 5 cups water to a boil. Add spinach; cook, covered, 1 minute or just until wilted. Drain well. In a small skillet, heat butter and oil over medium-low heat. Add garlic, Italian seasoning and salt; cook and stir until garlic is tender, 1-2 minutes. Spread spinach in a greased 1-1/2-qt. or 8-in. square baking dish. Drizzle with butter mixture; sprinkle with cheese. Bake, uncovered, until cheese is lightly browned, 10-15 minutes.',
'https://mykitchenserenity.com/wp-content/uploads/2020/08/Spinach-Parmesan-Casserole-3.jpg');
INSERT INTO recipes(recipe_name, calories, instructions, recipe_image)
VALUES ('Mediterranean Omelet', '236', 'In a small bowl, whisk eggs, water, salt and pepper until blended. In a large nonstick skillet, heat butter over medium-high heat. Pour in egg mixture. Mixture should set immediately at edge. As eggs set, push cooked portions toward the center, letting uncooked eggs flow underneath. When eggs are thickened and no liquid egg remains, add cheese, tomato and green onion to 1 side. Fold omelet in half and cut into 2 portions; slide onto plates.',
'https://www.tasteofhome.com/wp-content/uploads/2018/01/exps69429_SD163614C12_04_4b-2.jpg?fit=700,1024');
INSERT INTO recipes(recipe_name, calories, instructions, recipe_image)
VALUES ('Grilled Eggplant Parmesan Stacks', '449', 'Trim ends of eggplant; cut eggplant crosswise into eight slices. Sprinkle with salt; let stand 5 minutes. Blot eggplant dry with paper towels; brush both sides with oil and sprinkle with pepper. Grill, covered, over medium heat 4-6 minutes on each side or until tender. Remove from grill. Top eggplant with mozzarella cheese, tomato and Parmesan cheese. Grill, covered, 1-2 minutes longer or until cheese begins to melt. Top with basil.',
'https://www.tasteofhome.com/wp-content/uploads/2018/01/exps69630_SD163617B02_03_5b-3.jpg?fit=700,1024');
INSERT INTO recipes(recipe_name, calories, instructions, recipe_image)
VALUES ('Spinach Artichoke Rigatoni', '448', 'Preheat broiler. Prepare rigatoni and spinach according to package directions. Drain pasta, reserving 1/2 cup pasta water; return to pan. Add artichoke hearts, 1/2 cup mozzarella cheese, Parmesan cheese, salt, pepper and creamed spinach; toss to combine, adding some of the reserved pasta water to thin, if desired. Transfer to a greased 2-qt. broiler-safe baking dish; sprinkle with remaining mozzarella cheese. Broil 4-6 in. from heat 2-3 minutes or until cheese is melted.',
'https://www.tasteofhome.com/wp-content/uploads/2018/01/Spinach-Artichoke-Rigatoni_exps89100_TH143190C11_08_2bC_RMS-3.jpg?fit=700,1024');
INSERT INTO recipes(recipe_name, calories, instructions, recipe_image)
VALUES ('Spanakopita Mashed Potatoes', '145', 'Place potatoes in a large saucepan and cover with water. Bring to a boil. Reduce heat; cover and cook for 15-20 minutes or until tender. Meanwhile, in another large saucepan, bring 1/2 in. of water to a boil. Add spinach; cover and boil for 3-5 minutes or until wilted. Drain and coarsely chop; keep warm. Drain potatoes and return to the saucepan. Add milk, butter, salt and pepper; mash until smooth. Fold in cheese and spinach.',
'https://www.tasteofhome.com/wp-content/uploads/2018/01/Spanakopita-Mashed-Potatoes_exps94241_THCB2302822D02_07_1bC_RMS-1.jpg?fit=700,1024');
INSERT INTO recipes(recipe_name, calories, instructions, recipe_image)
VALUES ('Sweet Potato & Bean Quesadillas', '306', 'Scrub sweet potatoes; pierce several times with a fork. Place on a microwave-safe plate. Microwave, uncovered, on high, turning once, until very tender, 7-9 minutes. When cool enough to handle, cut each potato lengthwise in half. Scoop out pulp. Spread onto half of each tortilla; top with beans and cheese. Fold other half of tortilla over filling. Heat a cast-iron skillet or griddle over medium heat. Cook quesadillas until golden brown and cheese is melted, 2-3 minutes on each side. Serve with salsa.',
'https://www.tasteofhome.com/wp-content/uploads/2018/01/Sweet-Potato-Bean-Quesadillas_exps166396_TH143190A09_27_2bC_RMS.jpg?fit=700,1024');
INSERT INTO recipes(recipe_name, calories, instructions, recipe_image)
VALUES ('Southwest Tortilla Scramble', '195', 'In a large bowl, whisk egg whites, eggs and pepper. Stir in tortillas, spinach and cheese. Heat a large skillet coated with cooking spray over medium heat. Pour in egg mixture; cook and stir until eggs are thickened and no liquid egg remains. Top with salsa.',
'https://www.tasteofhome.com/wp-content/uploads/2018/01/Southwest-Tortilla-Scramble_exps163395_TH132104C06_21_5b_RMS-5.jpg?fit=700,1024');
INSERT INTO recipes(recipe_name, calories, instructions, recipe_image)
VALUES ('No-Bake Chocolate Hazelnut Thumbprints', '111', 'Beat cream cheese, melted chocolate chips and Nutella until blended. Stir in cracker crumbs. Refrigerate until firm enough to roll, about 30 minutes. Shape mixture into 1-in. balls; roll in chopped hazelnuts. Make an indentation in the center of each with the end of a wooden spoon handle. Fill with a hazelnut. Store between layers of waxed paper in an airtight container in the refrigerator.',
'https://www.tasteofhome.com/wp-content/uploads/2018/01/No-Bake-Chocolate-Hazelnut-Thumbprints_EXPS_UCSBZ17_92915_B05_24_5b-1.jpg?fit=700,1024');
INSERT INTO recipes(recipe_name, calories, instructions, recipe_image)
VALUES ('Mini Blueberry Tarts', '383', 'Preheat oven to 425�. Crush half the blueberries. Sift together sugar and cornstarch. Add whole and crushed blueberries; toss until berries are well coated. Set aside. On a lightly floured surface, unroll crusts. Cut out six 4-1/2-in. circles; press circles onto bottoms and up sides of greased muffin cups. Evenly spoon in blueberry mixture. Cut out six 2-in. circles from remaining crust; place over filling. Brush with yolk. Bake until crust is golden and filling bubbles, 13-17 minutes. Cool in pans 10 minutes; run a knife around sides of muffin cups and remove tarts to a serving plate.',
'https://www.adashofmegnut.com/wp-content/uploads/2018/04/Mini-Blueberry-Tarts-6.jpg');
INSERT INTO recipes(recipe_name, calories, instructions, recipe_image)
VALUES ('Quick Mango Sorbet', '91', 'Place all ingredients in a blender; cover and process until smooth. Serve immediately. If desired, for a firmer texture, cover and freeze at least 3 hours.',
'https://www.tasteofhome.com/wp-content/uploads/2019/10/Quick-Mango-Passion-Fruit-Sorbet_EXPS_TOHFM20_238674_B09_20_3b-4.jpg?fit=700,1024');
INSERT INTO recipes(recipe_name, calories, instructions, recipe_image)
VALUES ('Cake & Berry Campfire Cobbler', '342', 'Prepare grill or campfire for low heat, using 16-20 charcoal briquettes or large wood chips. Line an ovenproof Dutch oven with heavy-duty aluminum foil; add pie filling. In a large bowl, combine the cake mix, water and oil. Spread over pie filling. Cover Dutch oven. When briquettes or wood chips are covered with white ash, place Dutch oven directly on top of 8-10 of them. Using long-handled tongs, place remaining briquettes on pan cover. Cook until filling is bubbly and a toothpick inserted in the topping comes out clean, 30-40 minutes. To check for doneness, use the tongs to carefully lift the cover. If desired, serve with ice cream.',
'https://www.tasteofhome.com/wp-content/uploads/2018/01/Cake-Berry-Campfire-Cobbler_EXPS_BDSMZ17_45582_C03_02_5b-6.jpg?fit=700,1024');
INSERT INTO recipes(recipe_name, calories, instructions, recipe_image)
VALUES ('Pecan Roll-Ups', '51', 'In a large bowl, beat butter, cream cheese and salt until smooth. Gradually beat in flour. Divide dough in half; shape each into a disk. Wrap and refrigerate 2 hours or until firm enough to roll. Preheat oven to 350�. Dust a work surface with about 2 tablespoons confectioners sugar. Roll 1 portion of dough into an 18x8-in. rectangle; cut dough crosswise into six 3-in.-wide sections. Cut each section crosswise into eight 1-in.-wide strips. Roll each strip around a pecan half; place 1 in. apart on ungreased baking sheets. Repeat with remaining dough and pecans, dusting work surface with an additional 2 tablespoons confectioners sugar. Bake 12-15 minutes or until bottoms are lightly browned. Remove to wire racks to cool completely. Place remaining confectioners sugar in a shallow bowl. Roll cookies in sugar, coating well. Freeze option: Bake, cool and roll cookies in confectioners sugar as directed. Freeze in freezer containers, separating layers with waxed paper, up to 3 months. Thaw before serving; dust with additional confectioners sugar.',
'https://www.tasteofhome.com/wp-content/uploads/2018/01/exps46127_BHD153762C07_10_3b-2.jpg?fit=700,1024');


--add recipe categories
INSERT INTO recipe_category(recipe_id, category_id)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Easy Cheesy Ground Beef Enchiladas'),(SELECT category_id FROM category WHERE category_name = 'Mexican')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Vegetable Lasagna'),(SELECT category_id FROM category WHERE category_name = 'Vegetarian')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Garlic Parmesan Roasted Cauliflower'),(SELECT category_id FROM category WHERE category_name = 'Vegetarian')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Balsamic Goat Cheese Stuffed Chicken Breasts'),(SELECT category_id FROM category WHERE category_name = 'Low Carb')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Simple Roasted Butternut Squash'),(SELECT category_id FROM category WHERE category_name = 'Vegetarian')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Buttery Garlic Green Beans'),(SELECT category_id FROM category WHERE category_name = 'Vegetarian')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Pesto Chicken'),(SELECT category_id FROM category WHERE category_name = 'Low Carb')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Bacon Chicken'),(SELECT category_id FROM category WHERE category_name = 'Keto')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Quinoa with Peas and Onion'),(SELECT category_id FROM category WHERE category_name = 'Vegetarian')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Grilled Tomatoes'),(SELECT category_id FROM category WHERE category_name = 'Vegetarian')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Simple Mac n Cheese'),(SELECT category_id FROM category WHERE category_name = 'Easy')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Mushroom Scrambled Eggs'),(SELECT category_id FROM category WHERE category_name = 'Easy')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Pesto Pasta and Potatoes'),(SELECT category_id FROM category WHERE category_name = 'Vegetarian')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Parm Casserole'),(SELECT category_id FROM category WHERE category_name = 'Vegetarian')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Mediterranean Omelet'),(SELECT category_id FROM category WHERE category_name = 'Easy')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Grilled Eggplant Parmesan Stacks'),(SELECT category_id FROM category WHERE category_name = 'Vegetarian')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Artichoke Rigatoni'),(SELECT category_id FROM category WHERE category_name = 'Vegetarian')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spanakopita Mashed Potatoes'),(SELECT category_id FROM category WHERE category_name = 'Vegetarian')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Sweet Potato & Bean Quesadillas'),(SELECT category_id FROM category WHERE category_name = 'Mexican')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Southwest Tortilla Scramble'),(SELECT category_id FROM category WHERE category_name = 'Mexican')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'No-Bake Chocolate Hazelnut Thumbprints'),(SELECT category_id FROM category WHERE category_name = 'Easy')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Mini Blueberry Tarts'),(SELECT category_id FROM category WHERE category_name = 'Easy')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Quick Mango Sorbet'),(SELECT category_id FROM category WHERE category_name = 'Low-Ingredients')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Cake & Berry Campfire Cobbler'),(SELECT category_id FROM category WHERE category_name = 'Low-Ingredients')),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Pecan Roll-Ups'),(SELECT category_id FROM category WHERE category_name = 'Easy'));

--add recipe ingredients
INSERT INTO dish_type (dish_type_name) 
VALUES
	('Main Dish'),
	('Side Dish'),
	('Appetizer'),
	('Dessert');

--Add meal plans
INSERT INTO meal_plan(meal_plan_name)
VALUES ('Cheesetastic');

--Add meal plan recipes
INSERT INTO meal_plan_recipe(meal_plan_id,recipe_id)
VALUES 
	((SELECT meal_plan_id FROM meal_plan WHERE meal_plan_name = 'Cheesetastic'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Simple Mac n Cheese')),
	((SELECT meal_plan_id FROM meal_plan WHERE meal_plan_name = 'Cheesetastic'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Easy Cheesy Ground Beef Enchiladas')),
	((SELECT meal_plan_id FROM meal_plan WHERE meal_plan_name = 'Cheesetastic'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Grilled Tomatoes'));

--Add dish type to recipes
INSERT INTO recipe_dish_type (dish_type_id, recipe_id)
VALUES 
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Main Dish'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Easy Cheesy Ground Beef Enchiladas')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Main Dish'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Vegetable Lasagna')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Main Dish'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Balsamic Goat Cheese Stuffed Chicken Breasts')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Main Dish'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Quinoa with Peas and Onion')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Main Dish'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Pesto Chicken')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Main Dish'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Bacon Chicken')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Main Dish'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Mushroom Scrambled Eggs')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Main Dish'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Pesto Pasta and Potatoes')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Main Dish'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Parm Casserole')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Main Dish'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Mediterranean Omelet')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Main Dish'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Grilled Eggplant Parmesan Stacks')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Main Dish'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Artichoke Rigatoni')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Main Dish'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Sweet Potato & Bean Quesadillas')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Main Dish'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Southwest Tortilla Scramble')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Side Dish'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Garlic Parmesan Roasted Cauliflower')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Side Dish'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Spanakopita Mashed Potatoes')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Side Dish'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Simple Roasted Butternut Squash')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Side Dish'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Buttery Garlic Green Beans')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Side Dish'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Simple Mac n Cheese')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Side Dish'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Grilled Tomatoes')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Dessert'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'No-Bake Chocolate Hazelnut Thumbprints')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Dessert'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Mini Blueberry Tarts')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Dessert'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Quick Mango Sorbet')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Dessert'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Cake & Berry Campfire Cobbler')),
	((SELECT dish_type_id FROM dish_type WHERE dish_type_name = 'Dessert'),(SELECT recipe_id FROM recipes WHERE recipe_name = 'Pecan Roll-Ups'));


--Add recipe ingredients
INSERT INTO recipe_ingredients (recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Easy Cheesy Ground Beef Enchiladas'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Ground Beef'),'1','lb'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Easy Cheesy Ground Beef Enchiladas'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Red Enchilada Sauce'),'1','10 oz can'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Easy Cheesy Ground Beef Enchiladas'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Shredded Mexican Blend Cheese'),'8','oz'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Easy Cheesy Ground Beef Enchiladas'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Shredded Cheddar Cheese'),'8','oz'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Easy Cheesy Ground Beef Enchiladas'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Flour Tortilla'),'12','6"');
INSERT INTO recipe_ingredients (recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Vegetable Lasagna'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Pasta Sauce'),'1','28 oz jar'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Vegetable Lasagna'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Lasagna Noodles'),'8','oz'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Vegetable Lasagna'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Ricotta Cheese'),'15','oz'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Vegetable Lasagna'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Mixed Veggies'),'3','cups'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Vegetable Lasagna'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Mozzarella Cheese'),'8','oz');
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, amount, unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Grilled Tomatoes'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Tomato'), '2', 'Tomatoes'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Grilled Tomatoes'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Olive Oil'), 'user defined', 'user defined'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Grilled Tomatoes'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Kosher Salt'), 'user defined', 'user defined'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Grilled Tomatoes'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Black Pepper'), 'user defined', 'user defined'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Grilled Tomatoes'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Basil Leaf'), '4', 'Leaves');
INSERT INTO recipe_ingredients(recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Simple Mac n Cheese'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Butter'),'1/4','Cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Simple Mac n Cheese'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Flour'),'1/4','Cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Simple Mac n Cheese'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Salt'),'1/2','tsp'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Simple Mac n Cheese'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Black Pepper'),'to taste','Not Applicable'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Simple Mac n Cheese'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Milk'), '2', 'Cups'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Simple Mac n Cheese'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Elbow Macaroni'), '8', 'Oz'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Simple Mac n Cheese'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Cheddar Cheese'), '2', 'Cups');
INSERT INTO recipe_ingredients(recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Garlic Parmesan Roasted Cauliflower'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Cauliflower'),'1','Head'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Garlic Parmesan Roasted Cauliflower'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Olive Oil'),'3','Tbs'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Garlic Parmesan Roasted Cauliflower'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Kosher Salt'),'1/2','tsp'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Garlic Parmesan Roasted Cauliflower'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Black Pepper'),'1/2','tsp'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Garlic Parmesan Roasted Cauliflower'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Italian Seasoning'),'1','tsp'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Garlic Parmesan Roasted Cauliflower'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Garlic'),'3','cloves'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Garlic Parmesan Roasted Cauliflower'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Parmesan Cheese'),'1/2','cup');
INSERT INTO recipe_ingredients(recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Simple Roasted Butternut Squash'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Butternut Squash'),'1','Peeled and Seeded'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Simple Roasted Butternut Squash'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Olive Oil'),'2','Tbs'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Simple Roasted Butternut Squash'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Garlic'),'2','cloves');
INSERT INTO recipe_ingredients(recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Buttery Garlic Green Beans'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Green Beans'),'1','pound'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Buttery Garlic Green Beans'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Butter'),'3','tablespoons'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Buttery Garlic Green Beans'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Garlic'),'3','cloves'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Buttery Garlic Green Beans'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Lemon Pepper'),'2','pinches'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Buttery Garlic Green Beans'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Salt'),'1','pinch');
INSERT INTO recipe_ingredients(recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Pesto Chicken'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Chicken Breast'),'4','halves'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Pesto Chicken'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Basil Pesto'),'1/2','cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Pesto Chicken'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Prosciutto'),'4','slices');
INSERT INTO recipe_ingredients(recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Bacon Chicken'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Chicken Breast'),'4','halves'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Bacon Chicken'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Honey Barbeque Sauce'),'1','18 ounce bottle'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Bacon Chicken'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Bacon'),'1','pound');
INSERT INTO recipe_ingredients(recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Balsamic Goat Cheese Stuffed Chicken Breasts'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Chicken Breast'),'2','halves'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Balsamic Goat Cheese Stuffed Chicken Breasts'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Shallot'),'1','finely diced'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Balsamic Goat Cheese Stuffed Chicken Breasts'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Balsamic Vinegar'),'1','cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Balsamic Goat Cheese Stuffed Chicken Breasts'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Olive Oil'),'1','teaspoon'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Balsamic Goat Cheese Stuffed Chicken Breasts'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Goat Cheese'),'2','ounces');
INSERT INTO recipe_ingredients(recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Quinoa with Peas and Onion'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Water'),'2','cups'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Quinoa with Peas and Onion'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Quinoa'),'1','cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Quinoa with Peas and Onion'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Onion'),'1','small chopped'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Quinoa with Peas and Onion'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Olive Oil'),'1','tablespoon'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Quinoa with Peas and Onion'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Frozen Peas'),'1','cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Quinoa with Peas and Onion'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Salt'),'1/2','teaspoon'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Quinoa with Peas and Onion'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Black Pepper'),'1/4','teaspoon'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Quinoa with Peas and Onion'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Walnuts'),'2','tablespoons chopped');
INSERT INTO recipe_ingredients(recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Mushroom Scrambled Eggs'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Eggs'),'2','large'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Mushroom Scrambled Eggs'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Egg Whites'),'2','large'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Mushroom Scrambled Eggs'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Butter'),'1','teaspoon'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Mushroom Scrambled Eggs'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Mushrooms'),'1/2','cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Mushroom Scrambled Eggs'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Baby Spinach'),'1/2','cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Mushroom Scrambled Eggs'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Provolone Cheese'),'2','tablespoons'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Mushroom Scrambled Eggs'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Salt'),'1/8','teaspoon'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Mushroom Scrambled Eggs'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Black Pepper'),'1/8','teaspoon');
INSERT INTO recipe_ingredients(recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Pesto Pasta and Potatoes'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Red Potatoes'),'1','pound halved'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Pesto Pasta and Potatoes'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Whole Grain Spiral Pasta'),'12','ounces'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Pesto Pasta and Potatoes'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Green Beans'),'3','cups'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Pesto Pasta and Potatoes'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Basil Pesto'),'1','6 ounce jar'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Pesto Pasta and Potatoes'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Parmesan Reggiano Cheese'),'1','cup');
INSERT INTO recipe_ingredients(recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Parm Casserole'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Baby Spinach'),'2','pounds'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Parm Casserole'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Butter'),'5','tablespoons'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Parm Casserole'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Olive Oil'),'3','tablespoons'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Parm Casserole'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Garlic'),'3','cloves'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Parm Casserole'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Italian Seasoning'),'1','tablespoon'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Parm Casserole'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Salt'),'3/4','teaspoon'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Parm Casserole'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Parmesan Cheese'),'1','cup');
INSERT INTO recipe_ingredients(recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Mediterranean Omelet'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Eggs'),'4','large'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Mediterranean Omelet'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Water'),'1/4','cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Mediterranean Omelet'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Butter'),'1','tablespoon'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Mediterranean Omelet'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Goat Cheese'),'1/4','cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Mediterranean Omelet'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Tomato'),'1/4','cup chopped'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Mediterranean Omelet'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Green Onion'),'1','chopped'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Mediterranean Omelet'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Salt'),'1/8','teaspoon');
INSERT INTO recipe_ingredients(recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Grilled Eggplant Parmesan Stacks'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Eggplant'),'1','large'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Grilled Eggplant Parmesan Stacks'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Mozzarella Cheese'),'1','pound'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Grilled Eggplant Parmesan Stacks'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Tomato'),'1','large'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Grilled Eggplant Parmesan Stacks'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Parmesan Cheese'),'1/2','cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Grilled Eggplant Parmesan Stacks'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Fresh Basil'),'1','chopped'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Grilled Eggplant Parmesan Stacks'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Olive Oil'),'1','tablespoon'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Grilled Eggplant Parmesan Stacks'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Salt'),'1/2','teaspoon'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Grilled Eggplant Parmesan Stacks'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Pepper'),'1/2','teaspoon');
INSERT INTO recipe_ingredients(recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Artichoke Rigatoni'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Rigatoni'),'3','cups'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Artichoke Rigatoni'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Creamed Spinach'),'1','package frozen'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Artichoke Rigatoni'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Artichoke Hearts'),'1','can'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Artichoke Rigatoni'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Mozzarella Cheese'),'2','cups'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Artichoke Rigatoni'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Parmesan Cheese'),'1/4','cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Artichoke Rigatoni'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Salt'),'1/2','teaspoon'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spinach Artichoke Rigatoni'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Pepper'),'1/4','teaspoon');
INSERT INTO recipe_ingredients(recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spanakopita Mashed Potatoes'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Red Potatoes'),'6','medium'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spanakopita Mashed Potatoes'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Baby Spinach'),'1','package'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spanakopita Mashed Potatoes'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Milk'),'1/4','cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spanakopita Mashed Potatoes'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Butter'),'1','tablespoon'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spanakopita Mashed Potatoes'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Feta Cheese'),'3/4','cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spanakopita Mashed Potatoes'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Salt'),'1/2','teaspoon'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Spanakopita Mashed Potatoes'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Pepper'),'1/2','teaspoon');
INSERT INTO recipe_ingredients(recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Sweet Potato & Bean Quesadillas'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Sweet Potatoes'),'2','medium'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Sweet Potato & Bean Quesadillas'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Whole Wheat Tortillas'),'4','tortillas'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Sweet Potato & Bean Quesadillas'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Black Beans'),'3/4','cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Sweet Potato & Bean Quesadillas'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Pepper Jack Cheese'),'1/2','cup shredded'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Sweet Potato & Bean Quesadillas'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Salsa'),'3/4','cup');
INSERT INTO recipe_ingredients(recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Southwest Tortilla Scramble'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Egg Whites'),'4','large'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Southwest Tortilla Scramble'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Eggs'),'2','large'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Southwest Tortilla Scramble'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Corn Tortillas'),'2','cut into strips'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Southwest Tortilla Scramble'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Fresh Spinach'),'1/4','cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Southwest Tortilla Scramble'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Shredded Cheddar Cheese'),'2','tablespoons'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Southwest Tortilla Scramble'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Salsa'),'1/4','cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Southwest Tortilla Scramble'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Pepper'),'1/4','teaspoon');
INSERT INTO recipe_ingredients(recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'No-Bake Chocolate Hazelnut Thumbprints'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Cream Cheese'),'8','ounces'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'No-Bake Chocolate Hazelnut Thumbprints'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Semisweet Chocolate Chips'),'1','cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'No-Bake Chocolate Hazelnut Thumbprints'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Nutella'),'1/2','cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'No-Bake Chocolate Hazelnut Thumbprints'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Graham Cracker Crumbs'),'2 1/4','cups'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'No-Bake Chocolate Hazelnut Thumbprints'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Hazelnuts, Chopped'),'1','cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'No-Bake Chocolate Hazelnut Thumbprints'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Hazelnuts, Whole'),'1','cup');
INSERT INTO recipe_ingredients(recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Mini Blueberry Tarts'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Blueberries'),'2','cups'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Mini Blueberry Tarts'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Sugar'),'1/3','cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Mini Blueberry Tarts'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Cornstarch'),'4','teaspoons'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Mini Blueberry Tarts'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Refrigerated Pie Crust'),'2','sheets'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Mini Blueberry Tarts'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Egg Yolk'),'1','large, lightly beaten');
INSERT INTO recipe_ingredients(recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Quick Mango Sorbet'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Mango Chunks'),'1','package, frozen'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Quick Mango Sorbet'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Passion Fruit Juice'),'1/2','cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Quick Mango Sorbet'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Sugar'),'2','tablespoons');
INSERT INTO recipe_ingredients(recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Cake & Berry Campfire Cobbler'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Raspberry Pie Filling'),'2','cans'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Cake & Berry Campfire Cobbler'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Yellow Cake Mix'),'1','package'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Cake & Berry Campfire Cobbler'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Water'),'1 1/4','cups'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Cake & Berry Campfire Cobbler'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Canola Oil'),'1/2','cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Cake & Berry Campfire Cobbler'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Vanilla Ice Cream'),'1/2','cup');
INSERT INTO recipe_ingredients(recipe_id, ingredient_id,amount,unit)
VALUES
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Pecan Roll-Ups'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Butter'),'1','cup'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Pecan Roll-Ups'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Cream Cheese'),'8','ounces'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Pecan Roll-Ups'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Flour'),'2','cups'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Pecan Roll-Ups'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Confectioners Sugar'),'1 1/4','cups'),
	((SELECT recipe_id FROM recipes WHERE recipe_name = 'Pecan Roll-Ups'), (SELECT ingredient_id FROM ingredients WHERE ingredient_name = 'Pecans'),'2','cups');


INSERT INTO recipes_users(recipe_id, user_id) 
VALUES
	(9, 3),
	(8, 3),
	(10,3)

INSERT INTO meal_plan(meal_plan_name) VALUES('cheese delight')

INSERT INTO meal_plan_user(meal_plan_id, user_id) VALUES((SELECT meal_plan_id FROM meal_plan WHERE meal_plan_name = 'cheese delight'), 3)

INSERT INTO meal_plan_recipe(meal_plan_id, recipe_id) VALUES 
	((SELECT meal_plan_id FROM meal_plan WHERE meal_plan_name = 'cheese delight'), 1),
	((SELECT meal_plan_id FROM meal_plan WHERE meal_plan_name = 'cheese delight'), 4),
	((SELECT meal_plan_id FROM meal_plan WHERE meal_plan_name = 'cheese delight'), 10);




	

