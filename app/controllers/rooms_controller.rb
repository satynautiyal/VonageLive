class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: %i[ show edit update destroy ]

  # GET /rooms or /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1 or /rooms/1.json
  def show
    opentok = OpenTok::OpenTok.new ENV["API_KEY"], ENV["SECRET_KEY"]
    @token = opentok.generate_token @room.vonage_session_id, { name: current_user.email }
    create_token
    go_live
  end

  def create_token
    require "jwt"

    payload = {
      "iss": ENV["API_KEY"],
      "ist": "project",
      "iat": Time.now.to_i,
      "exp": Time.now.to_i+3600,
      "jti": "jwt_nonce" }

    # IMPORTANT: set nil as password parameter
    @token_2 = JWT.encode payload, ENV["SECRET_KEY"], "HS256"
  end

  def go_live
    require "uri"
    require "net/http"
    require "openssl"

    url = URI("https://api.opentok.com/v2/project/#{ENV["API_KEY"]}/broadcast")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/json"
    request["X-OPENTOK-AUTH"] = @token_2
    request.body = '{
      "sessionId": "'+"#{@room.vonage_session_id}"+'",
      
      "maxDuration": 5400,
      "outputs": {
        "hls": {
          "dvr": false,
          "lowLatency": false
        },
        "rtmp": [{
          "id": "foo",
          "serverUrl": "rtmps://myfooserver/myfooapp",
          "streamName": "myfoostream"
        },
        {
          "id": "bar",
          "serverUrl": "rtmp://mybarserver/mybarapp",
          "streamName": "mybarstream"
        }]
      },
      "resolution": "640x480",
      "streamMode" : "auto"
    }'

    response = http.request(request)
    @response = response.read_body
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to room_url(@room), notice: "Room was successfully created." }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to room_url(@room), notice: "Room was successfully updated." }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.destroy

    respond_to do |format|
      format.html { redirect_to rooms_url, notice: "Room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:name, :vonage_session_id)
    end
end
