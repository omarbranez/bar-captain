class ProductsController < ApplicationController
    
    get '/products' do
        redirect_if_not_logged_in
        erb :'products/index'
    end

    get '/liquors/new' do
        redirect_if_not_logged_in
        @liquors = ProductsDB.where("subcategory = 'Liquor'").select(:category).distinct
        erb :'products/liquors'
        # ProductsDB.all.map {|productdb| productdb[:category]}
        # @dbproducts.map {|d| d.category}.uniq.compact
        # <% dbproducts = ProductsDB.where("subcategory = ''").select(:category).distinct %>
        # binding.pry
    end
    
    get '/products/:id' do
        redirect_if_not_logged_in
        @liquors = Product.find_by_user(user: params[:id])
        if @products.user == current_user
            erb :'products/show'
        end # see if this returns that user's products only
    end

    post '/products' do
        redirect_if_not_logged_in
        # binding.pry
        # @liquor_type = params[:liquors][:category]
        
        # @product = Product.create(params[:product])
        # @product = current_user.products.create(products_db_id)
        # @product.save
        redirect '/liquors' # find way to add multiple items at once per post request instead of making them click 20 times
    end

    get '/liquors' do
        redirect_if_not_logged_in
        @nliquors = ProductsDB.where("category = ?", params[:liquors][:category]).select(:name)
        binding.pry
        erb :'products/liquors'
    end

    post '/liquors' do
        redirect_if_not_logged_in
        @nliquors = ProductsDB.where("category = ?", params[:liquors][:category]).select(:name)
        
        binding.pry
    end
        # @products = ProductsDB.all
        #     if params[:search]
        #         @products = ProductsDB.search(params[:search]).order("created_at DESC")
        #     else
        #         @products = ProductsDB.all.order('created_at DESC')
        #     end
        # end


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