class ProductsController < ApplicationController
    
    get '/products' do
        redirect_if_not_logged_in
        erb :'products/index'
    end

    get '/products/new' do
        redirect_if_not_logged_in
        erb :'products/new'
    end
    
    get '/products/:id' do
        redirect_if_not_logged_in
        @products = Product.find_by_user(user: params[:id])
        if @products.user == current_user
            erb :'products/show'
        end # see if this returns that user's products only
    end

    post '/products' do
        if params[:category] == "" || params[:subcategory] == "" || params[:quantity] == ""
            flash[:message] = "Please fill in all fields"
            redirect '/addproducts'
        else
            @product = Product.create(params[:product])
            @product = current_user.products.create(category: params[:product][:category], subcategory: params[:product][:subcategory], quantity: params[:product][:quantity])
            @product.save
            redirect to '/products' # find way to add multiple items at once per post request instead of making them click 20 times
        end
    end

    get '/products/:id/edit' do
        redirect_if_not_logged_in
        @products = Product.find_by_user(user: params[:id])
        erb :'products/edit'
    end

    patch '/products/:id' do
        if params[:product] == ""
            redirect to "/products/#{params[:id]}/edit"
        else
            @products = Product.find_by_user(user: params[:id])
            redirect_if_not_owner(@products)
            if @products && @products.user == current_user
                @products.update(category: params[:product][:category], subcategory: params[:product][:subcategory], quantity: params[:product][:quantity])
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