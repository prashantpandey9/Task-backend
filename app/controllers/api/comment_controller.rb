module Api
    class CommentController < ApplicationController
                
        def get_comments
            add = Advertisement.find_by_id(params[:id])
            if !add
                render json: {status: 'ERROR', message: 'Something went wrong', data: [] }, status: :unprocessable_entity
            else
                comment = Comment.where( advertisement: add)
                if comment.exists?(conditions = :none)
                    render json: {status: "SUCCESS", message: "Comment Found", data: comment }, status: :ok
                else
                    render json: {status: "ERRORS", message: "Comment Not Found", data: []}, status: :ok
                end
            end
        end

        def post_comment 
            add = Advertisement.find_by_id(params[:id])
            if !add
                render json: {status: 'ERROR', message: 'Something went wrong', data: [] }, status: :unprocessable_entity
            end

            new_comment = Comment.new( user_email: comment_params[:user_email], content: comment_params[:content], advertisement: add )
            if new_comment.save 
                render json: {status: 'SUCCESS', message: 'Comment created successfully', data: new_comment}, status: :ok
            else
                render json: {status: 'ERROR', message: 'Comment creation failed', data: new_comment.errors }, status: :unprocessable_entity
            end
        end


        def update_comment 
            comment = Comment.find(params[:id])
            if comment.update(comment_params) 
                render json: {status: 'SUCCESS', message: 'Comment updated successfully', data: comment}, status: :ok
            else
                render json: {status: 'ERROR', message: 'Comment updation failed', data: comment.errors }, status: :unprocessable_entity
            end
        end

        def get_user_comments
            comments = Comment.where(user_email: params[:id] )
            if comments.exists?(conditions = :none)
                render json: {status: 'SUCCESS', message: 'Comment listed successfully', data: comments}, status: :ok
            else
                render json: {status: 'ERROR', message: 'Comments not found', data: [] }, status: :unprocessable_entity
            end
        end
                

        def destroy 
            comments = Comment.find_by_id(params[:id])
            if comments
                comments.destroy
                render json: {status: 'SUCCESS', message: 'Comment deleted successfully', data: comments}, status: :ok
            else
                render json: {status: 'ERROR', message: 'Comments not found', data: [] }, status: :unprocessable_entity
            end  
        end
        private

        def comment_params
            params.permit(:user_email, :content)
        end

    end
end