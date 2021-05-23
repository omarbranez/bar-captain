class ProductsController < ApplicationController
    
    get '/products' do
        redirect_if_not_logged_in
        @user_products = current_user.products
        @random_product = Product.offset(rand(489)).first # this is 3x as fast as Product.all.order(Arel.sql('random()'))
        #but might have to be Product.offset(rand(Product.select(:id).count) if we add new products (or drinks, later)
        # or find_one()
        # binding.pry
        erb :'/products/index'
        # these will be changed to have the slug first
        # only the user sees these
    end

    get '/products/new' do
        redirect_if_not_logged_in
        erb :'products/new'
    end   
    
    
    get '/categories' do
        redirect_if_not_logged_in
        @products = Product.select(:category).where(subcategory: params[:subcategory]).distinct
        # binding.pry
        erb :'products/categories', :layout => false
    end

    get '/names' do
        redirect_if_not_logged_in
        # binding.pry
        @products = Product.select(:name, :id).where(category: params[:category])
        # binding.pry
        erb :'products/names', :layout => false
    end


    post '/products' do
        # maybe a confirm save flash message? that way we only query once and we can track when to generate drinks
        redirect_if_not_logged_in
        # redirect_if_not_owner(UserProduct) # check order of statements in testing
        user_products = current_user.user_products # we are only creating the record in user_products, not products
        new_product = Product.find(params[:id])# .id # change this to :name, not :product
        # would search be faster if id and not name?
        # binding.pry
        if user_products.where(product_id: new_product.id).exists? #id: @product
            flash[:notice] = "Error: #{new_product.name} already exists in your inventory."
            redirect '/products/new'
            halt 200
        else
            user_products.create(product_id: new_product.id)
            current_user.save
            redirect '/products/success'
        end
    end

    get '/products/success' do
        redirect_if_not_logged_in
        # redirect_if_not_owner(UserProduct)
        @last_product = Product.find(current_user.user_products.last.product_id).name
        erb :'products/success'
    end
    
    get '/products/edit' do 
        redirect_if_not_logged_in
        @user_products = current_user.products.pluck(:id, :name, :category, :subcategory)
        # will only need id, name, category, subcategory columns
        erb :'products/edit'
    end

    get '/products/:slug' do
        redirect_if_not_logged_in
        @product = Product.find_by_slug(params[:slug])
        erb :'products/show'
        # returns specific product
        # need all columns
        # will make directory as a quick add thing!
    end        
    
    patch '/products/' do # untested
        if params[:product] == ""
            redirect to "/products/#{params[:id]}/edit"
        else
            @products = Product.find_by_user(user: params[:id])
            redirect_if_not_owner(@products)
            if @products && @products.user == current_user
                @products.update(category: params[:product][:category])
                redirect to "/products/#{@products.id}"
            end
        end
    end

    delete '/products/:slug/delete' do # untested
        @product = Product.find_by_user(params[:id])
        redirect_if_not_owner
        if @product && @product.user == current_user
            @product.delete
            redirect '/products'
        end
    end

end