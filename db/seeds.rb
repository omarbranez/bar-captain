# scrapes drink information from thecocktaildb
# need to move ingredient quantities to drink_products to eliminate those 16 columns
agent_1 = Mechanize.new
drink_page = agent_1.get("https://www.thecocktaildb.com/api/json/v2/ENV["API_KEY"]]/filter.php?a=Alcoholic")
drink_data = JSON.parse(drink_page.body)
drink_data.first[1].each do |drink|
    drink_hash = {}
    drink_hash[:name] = drink["strDrink"]
    drink_hash[:photo_url] = drink["strDrinkThumb"]
    agent_2 = Mechanize.new
    drink_detail_page = agent_2.get("https://www.thecocktaildb.com/api/json/v2/ENV["API_KEY"]/lookup.php?i=#{drink["idDrink"]}")
    drink_detail = JSON.parse(drink_detail_page.body)
    drink_detail.first[1].each do |d_detail|
        drink_hash[:drink_type] = d_detail["strCategory"]
        drink_hash[:glass_type] = d_detail["strGlass"]
        drink_hash[:instructions] = d_detail["strInstructions"]
        drink_hash[:ingredient1] = d_detail["strIngredient1"]
        drink_hash[:ingredient2] = d_detail["strIngredient2"]
        drink_hash[:ingredient3] = d_detail["strIngredient3"]
        drink_hash[:ingredient4] = d_detail["strIngredient4"]
        drink_hash[:ingredient5] = d_detail["strIngredient5"]
        drink_hash[:ingredient6] = d_detail["strIngredient6"]
        drink_hash[:ingredient7] = d_detail["strIngredient7"]
        drink_hash[:ingredient8] = d_detail["strIngredient8"]
        drink_hash[:quantity1] = d_detail["strMeasure1"]
        drink_hash[:quantity2] = d_detail["strMeasure2"]
        drink_hash[:quantity3] = d_detail["strMeasure3"]
        drink_hash[:quantity4] = d_detail["strMeasure4"]
        drink_hash[:quantity5] = d_detail["strMeasure5"]
        drink_hash[:quantity6] = d_detail["strMeasure6"]
        drink_hash[:quantity7] = d_detail["strMeasure7"]
        drink_hash[:quantity8] = d_detail["strMeasure8"]
        Drinks.where(drink_hash).first_or_create
    end
end

# scrapes product information

agent_3 = Mechanize.new
product_page = agent_3.get("https://www.thecocktaildb.com/api/json/v2/#{ENV["API_KEY"]}/list.php?i=list")
product_data = JSON.parse(product_page.body)
product_data.first[1].each do |product|
    product_hash = {}   
    product_hash[:name] = product["strIngredient1"]
    agent_4 = Mechanize.new
    product_detail_page = agent_4.get("https://www.thecocktaildb.com/api/json/v2/#{ENV["API_KEY"]}/search.php?i=#{product["strIngredient1"]}")
    product_detail = JSON.parse(product_detail_page.body)
    product_detail.first[1].each do |p_detail|
        # binding.pry
        product_hash[:category] = p_detail["strType"]
        product_hash[:description] = p_detail["strDescription"]
        p_detail["strAlcohol"] != "Yes" ? product_hash[:subcategory] = "Mixer" : product_hash[:subcategory] = ""
        Product.where(product_hash).first_or_create
    end
end

Drink.all.each do |drink|
    drink.ingredient1 = drink.ingredient1.titleize
    drink.ingredient2 = drink.ingredient2.titleize
    drink.ingredient3 = drink.ingredient3.titleize
    drink.ingredient4 = drink.ingredient4.titleize
    drink.ingredient5 = drink.ingredient5.titleize
    drink.ingredient6 = drink.ingredient6.titleize
    drink.ingredient7 = drink.ingredient7.titleize
    drink.ingredient8 = drink.ingredient8.titleize
    drink.save
    # names or quantities do not need to be titleized
    # need to account for nulls in database, as null cannot be titleized
    # conditional drink.ingredientX.present?
end

Product.all.each do |product|
    if product.name.present?
        product.name = product.name.titleize
        product.save
    end
end
