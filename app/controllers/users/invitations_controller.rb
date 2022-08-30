# frozen_string_literal: true

# invitations custom handling
module Users
  class InvitationsController < Devise::InvitationsController
    before_action :configure_permitted_parameters

    protected

    # Permit the new params here.
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:accept_invitation, keys: %i[image email first_name last_name cnic constituency])
      devise_parameter_sanitizer.permit(:invite, keys: %i[image email first_name last_name cnic constituency])
    end
  end
end
