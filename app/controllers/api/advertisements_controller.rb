module Api
    class AdvertisementsController < ApplicationController

        def index
            advertisements = Advertisement.where(is_published: true).order('created_at DESC')
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

        def create_adds 
            user = User.find_by_email(params[:email])
            puts "create add #{user}"
            if !user
                render json: {status: 'ERROR', message: 'Advertisement creation failed', data: [] }, status: :unprocessable_entity
            else
                new_advertisement = Advertisement.new(title: advertisements_params[:title], body: advertisements_params[:body], user: user, is_published:  advertisements_params[:is_published])

                if new_advertisement.save 
                    render json: {status: 'SUCCESS', message: 'Advertisement created successfully', data: new_advertisement}, status: :ok
                else
                    render json: {status: 'ERROR', message: 'Advertisement creation failed', data: new_advertisement.errors }, status: :unprocessable_entity
                end
            end
        end
    
        def publish
            publish_add = Advertisement.find(params[:id])
            if publish_add.update_attribute( :is_published, true )
                render json: {status: 'SUCCESS', message: 'Advertisement Published successfully', data: publish_add}, status: :ok
            else
                render json: {status: "ERRORS", message: "Something went wrong", data: []}, status: :unprocessable_entity
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

        def get_user_adds
            user_adds = Advertisement.where(user_id: params[:id])
            if user_adds.exists?
                render json: {status: 'SUCCESS', message: 'Advertisement listed successfully', data: user_adds}, status: :ok
            else
                render json: {status: 'ERROR', message: 'Advertisement Not found', data: [] }, status: :unprocessable_entity
            end
        end
        private

        def advertisements_params
            params.permit(:title, :body, :is_published)
        end

    end
end