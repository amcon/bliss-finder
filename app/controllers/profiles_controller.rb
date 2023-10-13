class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[ show edit update randomize destroy share_to_social ]

  # GET /profiles or /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1 or /profiles/1.json
  def show
    set_meta_tags(
      title: @profile.full_name,
      description: "Name: #{@profile.full_name}. Age: #{@profile.age}. Occupation: #{@profile.occupation}. Favorite Song: 'I Need a New Boyfriend' by Charly Bliss"
    )

    set_meta_tags twitter: {
      card: "photo",
      site: "@charlybliss",
      url: request.original_url,
      title: @profile.full_name,
      description: "Name: #{@profile.full_name}. Age: #{@profile.age}. Occupation: #{@profile.occupation}. Favorite Song: 'I Need a New Boyfriend' by Charly Bliss",
      image: {
        _: @profile.generated_profile_img_url
      }
    }

    # <meta name="twitter:card" content="summary" />
    # <meta name="twitter:site" content="@nytimesbits" />
    # <meta name="twitter:creator" content="@nickbilton" />
    # <meta property="og:url" content="http://bits.blogs.nytimes.com/2011/12/08/a-twitter-for-my-sister/" />
    # <meta property="og:title" content="A Twitter for My Sister" />
    # <meta property="og:description" content="In the early days, Twitter grew so quickly that it was almost impossible to add new features because engineers spent their time trying to keep the rocket ship from stalling." />
    # <meta property="og:image" content="http://graphics8.nytimes.com/images/2011/12/08/technology/bits-newtwitter/bits-newtwitter-tmagArticle.jpg" />
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
    set_meta_tags(
      title: "Create a Profile",
      description: "Here at Bliss-Finder™️, our mission is simple. Unite the world in harmony through meaningful connections. So go ahead, make a profile today and watch how quickly your life can change."
    )
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles or /profiles.json
  def create
    @profile = Profile.new(profile_params)

    # connect to bannerbear
    bb = Bannerbear::Client.new
    # send the profile info to the template
    new_profile = bb.create_image("PowdyxbdM14LZlYBAg",
      synchronous: true,
      modifications: [
        {
          "name": "Profile_pic",
          "image_url": @profile.profile_image_url
        },
        {
          "name": "Name_result",
          "text": "Name: #{@profile.full_name}",
        },
        {
          "name": "Age_result",
          "text": "Age: #{@profile.age}",
        },
        {
          "name": "Occupation_result",
          "text": "Occupation: #{@profile.occupation}",
        },
      ]
    )
    # get the image from bannerbear
    bb_image_object = bb.get_image(new_profile["uid"])
    puts 'bb_image_object is: ', bb_image_object
    if bb_image_object.present?
      @profile.generated_profile_img_url = bb_image_object["image_url"]
      @profile.save
    end

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

  def share_to_social
    @social_network = params["social"]
    if @social_network.present?
      # use image in social media share
      if @social_network.eql?("twitter")
        puts "this is for twitter"
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
      params.require(:profile).permit(:first_name, :last_name, :occupation, :email, :age, :profile_image, :question_1, :question_2, :question_3, :question_4, :question_5, :generated_profile_img_url)
    end
end
