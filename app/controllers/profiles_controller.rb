class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[ show edit update randomize destroy create_image ]

  # GET /profiles or /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1 or /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles or /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to profile_url(@profile), notice: "Profile was successfully created." }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1 or /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to profile_url(@profile), notice: "Profile was successfully updated." }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def randomize
    respond_to do |format|
      if @profile.update(first_name: @profile.random_first_name, last_name: @profile.random_last_name, occupation: @profile.random_occupation, age: @profile.random_age)
        @profile.save
        format.html { redirect_to profile_url(@profile), notice: "Profile was successfully randomized." }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :show, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_image
    # connect to bannerbear
    bb = Bannerbear::Client.new
    # send the profile info to the template
    @social_network = params[:social]
    # new_profile = bb.create_image("PowdyxbdM14LZlYBAg",
    #   modifications: [
    #     {
    #       "name": "Profile_pic",
    #       "image_url": @profile.profile_image_url
    #     },
    #     {
    #       "name": "Name_result",
    #       "text": "Name: #{@profile.full_name}",
    #     },
    #     {
    #       "name": "Age_result",
    #       "text": "Age: #{@profile.age}",
    #     },
    #     {
    #       "name": "Occupation_result",
    #       "text": "Occupation: #{@profile.occupation}",
    #     },
    #   ]
    # )
    # get the image from bannerbear
    bb_image_object = bb.get_image("9e2VGL0qn6VA2nAdzEAv5mxr1") #(new_profile["uid"])
    if bb_image_object.present? && @social_network.present?
      # use image in social media share
      if @social_network.eql?("twitter")
        x_credentials = {
          api_key:             ENV["X_API_KEY"],
          api_key_secret:      ENV["X_API_SECRET"],
          access_token:        ENV["X_ACCESS_TOKEN"],
          access_token_secret: ENV["X_ACCESS_TOKEN_SECRET"],
          bearer_token:        ENV["X_BEARER_TOKEN"]
        }
        # x_client = X::Client.new(**x_credentials)
        # puts "this is for twitter", x_client
        # x_client.get("users/me")
        @response_image = bb_image_object["image_url"]
      elsif @social_network.eql?("instagram")
        puts "this is for instagram"
      end
      @response = 'success'
      respond_to do |format|
        format.html { redirect_to :back, notice: 'success' }
        format.js
      end
    else
      # something went wrong because the image wasn't created on bannerbear
      puts "something went wrong. no response_image and social_network"
      @response = 'failure'
      respond_to do |format|
        format.html { redirect_to :back, notice: 'sorry, something went wrong' }
        format.js
      end
    end
  end

  # DELETE /profiles/1 or /profiles/1.json
  def destroy
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to root_url, notice: "Profile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :occupation, :email, :age, :profile_image, :question_1, :question_2)
    end
end
