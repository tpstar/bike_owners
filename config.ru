require './config/environment'


use Rack::MethodOverride # lets you use patch and delete

use BikesController
use OwnersController
use BrandsController
run ApplicationController
