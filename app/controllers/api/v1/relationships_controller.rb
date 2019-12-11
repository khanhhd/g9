class Api::V1::RelationshipsController < ApplicationController

  def_param_group :relationship do
    param :user_id, String
    param :friend_id, String
  end

  api :POST, "/v1/users/:user_id/relationships", "Follow user"
  param_group :relationship
  def create
    result = RelationshipService.new(relationship_params).follow
    json_response(result, result[:status])
  end

  api :DELETE, "/v1/users/:user_id/relationships", "Unfollow user"
  param_group :relationship
  def destroy
    result = RelationshipService.new(relationship_params).unfollow
    json_response(result, result[:status])
  end

  private
  def relationship_params
    params.permit(:follower_id, :followed_id)
  end

end
