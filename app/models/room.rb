class Room < ApplicationRecord
    before_create do
        opentok = OpenTok::OpenTok.new ENV["API_KEY"], ENV["SECRET_KEY"]
        session = opentok.create_session
        self.vonage_session_id = session.session_id
    end
end
