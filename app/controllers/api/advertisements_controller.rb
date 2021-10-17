module Api
    class AdvertisementsController < ApplicationController
        def index
            advertisements = Advertisement.order('created_at DESC');
            render json: {status: 'SUCCESS', message: 'Loaded Advertisements', data: advertisements }, status: :ok
        end
        
        def get
            advertisement = Advertisement.find(params[:id])
            if advertisement
                render json: {status: "SUCCESS", message: "Advertisement Found", data: advertisement }, status: :ok
            else
                render json: {status: "ERRORS", message: "Advertisement Not Found", data: advertisement.errors}, status: :ok
            end
        end

        def create 
            new_advertisement = Advertisement.new(advertisements_params)
            if new_advertisement.save 
                render json: {status: 'SUCCESS', message: 'Advertisement created successfully', data: new_advertisement}, status: :ok
            else
                render json: {status: 'ERROR', message: 'Advertisement creation failed', data: new_advertisement.errors }, status: :unprocessable_entity
            end
        end

        def update 
            advertisement = Advertisement.find(params[:id])
            puts "advertisement---#{advertisement}"
            if advertisement.update(advertisements_params) 
                render json: {status: 'SUCCESS', message: 'Advertisement updated successfully', data: advertisement}, status: :ok
            else
                render json: {status: 'ERROR', message: 'Advertisement updation failed', data: advertisement.errors }, status: :unprocessable_entity
            end
        end

        def destroy 
            advertisement = Advertisement.find(params[:id])
            advertisement.destroy
            render json: {status: 'SUCCESS', message: 'Advertisement deleted successfully', data: advertisement}, status: :ok


        end
        private

        def advertisements_params
            params.permit(:title, :body)
        end

    end
end