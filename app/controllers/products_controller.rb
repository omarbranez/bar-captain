class ProductsController < ApplicationController
    
    get '/products' do
        redirect_if_not_logged_in
        @user_products = current_user.products
        @random_product = Product.offset(rand(489)).first # this is 3x as fast as Product.all.order(Arel.sql('random()'))
        #but might have to be Product.offset(rand(Product.select(:id).count) if we add new products (or drinks, later)
        # or find_one()
        erb :'/products/index'
        # only the user sees these. create a page where sample appears and give link to register.
    end

    get '/products/new' do
        redirect_if_not_logged_in
        erb :'products/new'
    end   
    
    
    get '/categories' do
        redirect_if_not_logged_in
        @products = Product.select(:category).where(subcategory: params[:subcategory]).distinct
        erb :'products/categories', :layout => false
    end

    get '/names' do
        redirect_if_not_logged_in
        @products = Product.select(:name, :id).where(category: params[:category])
        erb :'products/names', :layout => false
    end


    post '/products' do
        redirect_if_not_logged_in
        user_products = current_user.user_products
        new_product = Product.find(params[:id])
        if user_products.where(product_id: new_product.id).exists?
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
        @last_product = Product.find(current_user.user_products.last.product_id).name
        erb :'products/success'
    end
    
    get '/products/edit' do 
        redirect_if_not_logged_in
        @user_products = current_user.products.select(:id, :name, :category, :subcategory)
        erb :'products/edit'
    end

    get '/products/:slug' do
        # redirect_if_not_logged_in # i think this should be public
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

    delete '/products/:id' do
        product = current_user.user_products.find_by(product_id: params[:id])
        redirect_if_not_owner(product)
        if product && product.user == current_user
            product.delete
            # flash[:message] = "You have successfully deleted #{Product.find(product.product_id).name}"
        end
    end

    helpers do
        def redirect_if_not_owner(product)
            if product.user != current_user
                flash[:message] = "Please don't steal someone else's stuff!"
                redirect '/products'
            end
        end
    end 
end