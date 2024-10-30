class BreedsController < ApplicationController
  
    def index
        if params[:query].present?
            @results = Breed.where("name LIKE ?", "%#{params[:query]}%")
            @breeds = [] # No need to show all breeds
          else
            @breeds = Breed.all
            @results = []
          end
    end
  
  
    def search 
        redirect_to breeds_path(query: params[:query])
    end
  end