class Api::UserController < Api::ApplicationController
	skip_before_filter :verify_authenticity_token
	before_filter :verify_request_source

end
