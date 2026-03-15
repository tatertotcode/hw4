class EntriesController < ApplicationController

  def new
    @place = Place.find_by({ "id" => params["place_id"] })
  end

  def create
    @entry = Entry.new
    @entry["title"] = params["title"]
    @entry["description"] = params["description"]
    @entry["occurred_on"] = params["occurred_on"]
    @entry["place_id"] = params["place_id"]

    # Assign the logged-in user's ID to the entry
    @entry["user_id"] = @current_user["id"]

    # attach the file from the form parameters
    @entry.uploaded_image.attach(params["uploaded_image"])

    @entry.save
    redirect_to "/places/#{@entry["place_id"]}", status: :see_other
  end

end
