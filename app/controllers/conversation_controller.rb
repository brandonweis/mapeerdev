class ConversationController < ApplicationController
  def create
    # @post = Post.find(params[:comment][:post_id])
    # @post = Post.where( :_id => '5348fd493be278ada7000005')
    # @post = Post.where( "comments._id" => Moped::BSON::ObjectId('534a43733be278e54b00000e'))
    # @post = Post.find('534bebb23be27852f600000f')
    # @comments = @post.comments.find('534bebe83be278c253000012')
    # @conversation = Conversation.new(conversation_params)
    # @comments.conversations << @conversation
    # render :text => @comments.to_json


    respond_to do |format|
      @post = Post.where( "comments._id" => Moped::BSON::ObjectId(params[:conversation][:comment_id]))[0]
      @comment = @post.comments.find(params[:conversation][:comment_id])
      
      if !@post.nil? && !@comment.nil?
	      @conversation = Conversation.new(conversation_params)
	      @comment.conversations << @conversation


        if @post.save!
        	format.json {
          		render :json => {:error => false, :msg => "replied", :replied_text => params[:conversation][:text]}
        	}
        else
        	format.json {
          		render :json => {:error => true, :msg => "try again"}
          	}
        end
      else
      	format.json {
        	render :json => {:error => true, :msg => "invalid request"}
        }
      end
    end
  end

  def show
	  # @post = Post.where( "comments._id" => Moped::BSON::ObjectId(params[:comment_id]))[0]
	  # @comments = @post.comments
	  # render :text => @comments.to_json
    respond_to do |format|
      # @post = Post.find(params[:comment_id])
      @post = Post.where( "comments._id" => Moped::BSON::ObjectId(params[:comment_id]))[0]
	  @comment = @post.comments.find(params[:comment_id])

      # @user = User.find(current_user._id);

      if !@comment.conversations.nil?
          format.json { # This block will be called for JSON requests
            render :json => @comment.conversations
          }
      else
        format.json { # This block will be called for JSON requests
          render :json => {:error => true, :msg => "no conversations"}
        }
      end

    end
  end

	def approve
		respond_to do |format|
		  @post = Post.where( "comments._id" => Moped::BSON::ObjectId(params[:comment_id]))[0]
	      @comment = @post.comments.find(params[:comment_id])
	      
	      if !@post.nil? && !@comment.nil?
		      @conversation = Conversation.new({:status => "approved", :user_name => current_user.name, :user_id => current_user._id})
		      @comment.conversations << @conversation

	        if @post.save!
	        	format.json {
	          		render :json => {:error => false, :msg => "replied", :replied_text => params[:text]}
	        	}
	        else
	        	format.json {
	          		render :json => {:error => true, :msg => "try again"}
	          	}
	        end
	      else
	      	format.json {
	        	render :json => {:error => true, :msg => "invalid request"}
	        }
	      end
		end
	end

	def reject
		respond_to do |format|
		  @post = Post.where( "comments._id" => Moped::BSON::ObjectId(params[:comment_id]))[0]
	      @comment = @post.comments.find(params[:comment_id])
	      
	      if !@post.nil? && !@comment.nil?
		      @conversation = Conversation.new({:status => "rejected", :user_name => current_user.name, :user_id => current_user._id})
		      @comment.conversations << @conversation

	        if @post.save!
	        	format.json {
	          		render :json => {:error => false, :msg => "replied", :replied_text => params[:text]}
	        	}
	        else
	        	format.json {
	          		render :json => {:error => true, :msg => "try again"}
	          	}
	        end
	      else
	      	format.json {
	        	render :json => {:error => true, :msg => "invalid request"}
	        }
	      end
		end
	end

  private
	# Never trust parameters from the scary internet, only allow the white list through.
	def conversation_params
	  params.require(:conversation).permit(:text).merge(user_name: current_user.name, user_id: current_user._id)
	end
end
