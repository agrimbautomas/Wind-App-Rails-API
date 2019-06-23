class Api::V1::ApiController < ApplicationController
	include ApiHandlers
	include ErrorRaiser

	serialization_scope :view_context

	private
	def authorize_member!
		authorized_user = AuthorizeUser.with user: current_user, projects: projects_from_params, action: @_action_name, model: model
		render_unauthorized_member_error unless authorized_user
	end

	def projects_from_params
		[project_from_params]
	end

	def render_unauthorized_member_error
		render_error UnauthorizedError.new :unauthorized, 'Member cannot perform this action'
	end
end
