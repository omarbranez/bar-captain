class ProductsController < ApplicationController
    
    get '/products' do
        redirect_if_not_logged_in
        @user_products = current_user.products.select(:name).order(:name)
        @random_product = Product.offset(rand(489)).first # this is 3x as fast as Product.all.order(Arel.sql('random()'))
        #but might have to be Product.offset(rand(Product.select(:id).count) if we add new products (or drinks, later)
        # or find_one()
        erb :'products/index'
        # only the user sees these. create a page where sample appears and give link to register.
    end

    get '/products/new' do
        redirect_if_not_logged_in
        # we COULD just use the search to create. add a button at the end of each row to add...
        erb :'products/new'
    end   

    
    get '/subcategories' do
        redirect_if_not_logged_in
        # may have to redirect if they're not in the process of adding something
        @products = Product.select(:subcategory).where(category: params[:category]).distinct.order(:subcategory)
        erb :'products/subcategories', :layout => false
    end


    get '/names' do
        redirect_if_not_logged_in
        # may have to redirect if they're not in the process of adding something
        @products = Product.select(:name, :id).where(subcategory: params[:subcategory]).order(:name)
        erb :'products/names', :layout => false
    end

    get '/products/search' do
        erb :'products/search'
    end

    post '/products/search' do
        if !params[:search].empty?
            @products = Product.where("name LIKE ?", "%#{params[:search]}%")
        end
        erb :'result', :layout => false
    end

    post '/products' do
        redirect_if_not_logged_in
        user_products = current_user.user_products
        new_product = Product.find(params[:id])
        if user_products.where(product_id: new_product.id).exists?
            flash[:notice] = "Error: #{new_product.name} already exists in your inventory."
            erb :'products/new'
        else
            user_products.create(product_id: new_product.id)
            current_user.save
            redirect to "/products/#{new_product.slug}"
        end
    end

    get '/products/success' do
        redirect_if_not_logged_in
        @last_product = Product.find(current_user.user_products.last.product_id).name
        erb :'products/success', :layout => false
    end
    
    get '/products/edit' do 
        redirect_if_not_logged_in
        @user_products = current_user.products.select(:id, :name, :category, :subcategory)
        erb :'products/edit'
    end

    get '/products/:slug' do
        @product = Product.find_by_slug(params[:slug])
        @drinks = DrinkProduct.select(:drink_id).where(product_id: @product.id)
        if logged_in?
            if current_user.user_products.where(product_id: @product.id).exists?
                @owned = "True"
            else
                @owned = "False"
            end
        end
        erb :'products/show'
    end        

    delete '/products/:id' do
        product = current_user.user_products.find_by(product_id: params[:id])
        deleted_product = Product.find(params[:id])
        redirect_if_not_owner(product)
        if product && product.user == current_user
            product.delete
        end
        if params[:origin] == "show"
            redirect to "/products/#{deleted_product.slug}"
        else
            redirect to "/products/edit"
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