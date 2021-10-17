module Api
    class AuthController < ApplicationController
        def index
            users = User.order('created_at DESC');
            render json: {status: 'SUCCESS', message: 'Loaded Users', data: users }, status: :ok
        end
        
        def register 
            new_user = User.new(users_params)
            if new_user.save 
                render json: {status: 'SUCCESS', message: 'User created successfully', data: new_user}, status: :ok
            else
                render json: {status: 'ERROR', message: 'User creation failed', data: new_user.errors }, status: :unprocessable_entity
            end
        end

        def login 
            email = users_params[:email]
            password = users_params[:password]
            user = User.find_by(email: email )
            if user && user.authenticate(password)
                render json: { status: "SUCCESS", message: "User Successfully logged In", data: user }, status: :ok
            else 
                render json: { status: "ERRORS", message: "User Login Failed", data: [] }, status: :unprocessable_entity
            end
        end

        def logout
            render json: {status: "SUCCESS", message: "User Successfully logged out", data: {}}, status: :ok
        end
        private

        def users_params
            params.permit(:email, :password)
        end

    end
end