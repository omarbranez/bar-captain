class ProductsController < ApplicationController
    
    get '/products' do
        redirect_if_not_logged_in
        @user_products = current_user.products
        binding.pry
        erb :'/products/index'
        # these will be changed to have the slug first
        # only the user sees these

    end

    get '/products/new' do
        redirect_if_not_logged_in
        @products = Product.all
        @liquor_categories = Product.where(subcategory: 'Liquor').select(:category).distinct
        @liquor_names = Product.where(category: params[:category]).select(:name) # default to vodka, for testing
        @mixer_names = Product.where(subcategory: 'Mixer').select(:name)
        erb :'products/new'
        # ids via here, then call their names as values
    end    

    post '/products' do
        # maybe a confirm save flash message? that way we only query once and we can track when to generate drinks
        redirect_if_not_logged_in
        redirect_if_not_owner # check order of statements in testing
        user_products = current_user.user_products # we are only creating the record in user_products, not products
        @product = Product.find_by(name: params[:product][:name])
        # would search be faster if id and not name?
        if !!user_products.find_by(product_id: Product.find_by(name: params[:product][:name]))
            flash[:notice] = "Error: #{params[:product][:name]} already exists in your inventory."
            redirect '/products/new'
        else
            if !!@product
                user_products.create(product_id: (Product.find_by(name: params[:product][:name])).id)
                current_user.save
                redirect '/products/success'
            end
        end
    end

    get '/products/success' do
        redirect_if_not_logged_in
        redirect_if_not_owner()
        @last_product = current_user.products.last.name
        erb :'products/success'
    end

    get '/products/:slug' do
        redirect_if_not_logged_in
        @product = Product.find_by_slug(params[:slug])
        erb :'products/show'
        # returns specific product
        # need all columns
        # will make directory as a quick add thing!
    end        


    get '/products/:id/edit' do # untested
        redirect_if_not_logged_in
        @user_products = current_user.products
        # will only need id, name, category, subcategory columns
        erb :'products/edit'
    end

    patch '/products/:id' do # untested
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

    delete '/products/:id/delete' do # untested
        @product = Product.find_by_user(params[:id])
        redirect_if_not_owner
        if @product && @product.user == current_user
            @product.delete
            redirect '/products'
        end
    end

end