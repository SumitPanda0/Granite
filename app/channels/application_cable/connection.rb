# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      puts "Connection attempt with params: #{request.query_parameters}"
      self.current_user = find_verified_user
      puts "Connected as user: #{current_user.id} (#{current_user.email})"
    end

    private

      def find_verified_user
        verified_user = User.find_by(
          email: request.query_parameters[:email],
          authentication_token: request.query_parameters[:auth_token])
        if verified_user
          verified_user
        else
          reject_unauthorized_connection
        end
      end
  end
end
