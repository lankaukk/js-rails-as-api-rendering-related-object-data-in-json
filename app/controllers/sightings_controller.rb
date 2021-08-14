class SightingsController < ApplicationController
    def index
        sightings = Sighting.all
        render json: sightings.to_json(include: [:bird, :location])
      end

    def show
        sighting = Sighting.find_by(id: params[:id])
        # render json: sighting
        
        # render json: { id: sighting.id, bird: sighting.bird, location: sighting.location }
        if sighting
            # nested info
            # render json: sighting, include: [:bird, :location]
            # same as 
            # render json: sighting.to_json(include: [:bird, :location])

            # render json: sighting, include: [:bird, :location], except: [:updated_at]

            render json: sighting.to_json(:include => {
                :bird => {:only => [:name, :species]},
                :location => {:only => [:latitude, :longitude]}
            }, :except => [:updated_at, :created_at])
            
        else
            render json: { message: 'No sighting found with that id' }
        end

      end

    
end
