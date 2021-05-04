require './config/environment'

use Rack::MethodOverride
use MenusController
use DrinksController
use ProductsController
use UsersController
run ApplicationController