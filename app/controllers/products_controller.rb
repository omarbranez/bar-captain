class ProductsController < ApplicationController
    
    get '/products' do
        redirect_if_not_logged_in
        @user = User.find(session[:user_id])
        redirect "/products/#{@user.id}"
    end

    get '/products/new' do
        redirect_if_not_logged_in
        @products = Product.all
        @liquor_categories = Product.where(subcategory: 'Liquor').select(:category).distinct
        @liquor_names = Product.where(category: 'Vodka').select(:name)
        @mixer_names = Product.where(subcategory: 'Mixer').select(:name)
        erb :'products/new'
        # ids via here, then call their names as values
    end

    get '/liquors' do
        erb :'products/liquors'
    end

    get '/mixers' do
        erb :'products/mixers'
    end
    

    post '/products' do
        redirect_if_not_logged_in
        # binding.pry
        user_products = current_user.user_products
        @product = Product.find_by(name: params[:product][:name])
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
        # binding.pry
        @last_product = Product.find(current_user.user_products.last.product_id).name
        erb :'products/success'
    end

    get '/products/:id' do
        redirect_if_not_logged_in
        @userproducts = UserProduct.where(user_id: current_user.id)
        # binding.pry
        erb :'products/show'
             # see if this returns that user's products only
    end        


    get '/products/:id/edit' do
        redirect_if_not_logged_in
        @myproducts = UserProduct.find_by_user(user: params[:id])
        erb :'products/edit'
    end

    patch '/products/:id' do
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

    delete '/products/:id/delete' do
        @product = Product.find_by_user(params[:id])
        redirect_if_not_owner
        if @product && @product.user == current_user
            @product.delete
            redirect '/products'
        end
    end

end