class EntriesController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy
	def index
		@entry = Entry.all
	end
	def create
		@entry = current_user.entries.build(entry_params)
		if @entry.save
			flash[:success] = "Entry created!"
			redirect_to root_url
		else
			@feed_items = []
			render 'static_pages/home'
		end
	end
	def destroy
		@entry.destroy
		flash[:success] = "Micropost deleted"
		redirect_to request.referrer || root_url
	end
	private
		def entry_params
			params.require(:entry).permit(:content)
		end
		def correct_user
			@entry = current_user.entries.find_by(id: params[:id])
			redirect_to root_url if @entry.nil?
		end
end
