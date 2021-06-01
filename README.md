# Bar Captain
![](http://forthebadge.com/images/badges/made-with-ruby.svg)

![](https://d2rf0detuhmti.cloudfront.net/wp-content/uploads/2016/07/frank-sinatra-drinking-martini.jpg)

Bar Captain is a Sinatra based app utilizing the ActiveRecord ORM.

Bar Captain takes your collection of liquor products and nonliquor mixers, checks it against a database of cocktail recipes, and shows what you can make from it. You can also upload your own recipe to share with the world.

Bar Captain's collection of products and drink recipes is pulled primarily from ![The CocktailDB](https://www.thecocktaildb.com/). 

## Installation
Clone this repository:

```ruby
    git clone git@github.com:omarbranez/bar-captain.git
```

Install the required gems:

```ruby
    bundle install
```

Run table migrations:

```ruby
    rake db:migrate
```

**coming soon** Seed the database:

```ruby
    rake db:seed
```
## Usage

1. Register for an account.
2. Visit Products Home and use the Add Products form to search for products you have at home.
3. When you have finished filling out your collection, hit the Generate Drinks button in Products Home.
4. In Drinks Home, you will see recipe matches based on your inventory.

You're free to search for products you don't own and recipes you don't match with. 
Each product page also has a list of drinks where they are included. Each drink page has a list of links to the products that comprise them, and a list of what you're missing to complete them. 

You can write your own recipes and add them to the database through Add a New Drink. Only that drink's author can edit or delete it. 

Enjoy responsibly! 
![](https://www.thecuriouscreature.com/wp-content/uploads/2016/01/Frank-Sinatra2_3035299b.jpg)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).



