class BulkCustomDataController < ApplicationController
  before_action :require_plugin_enabled
  before_action :get_course_from_section, :require_context
  before_action :require_namespace, :get_scope
  before_action :require_user

  # @API Return custom user data for all enrolled users in a course
  #
  # @argument user_id [String]
  #   Filter by user_id.  Specify as array or as a comma-separated string
  #
  # @argument ns [Required, String]
  #   The namespace from which to retrieve the data.
  #
  # @example_request
  #   curl 'https://<canvas>/api/v1/courses/:course_id/enrollments/user_custom_data/food_app/favorites/dessert' \
  #     -X GET \
  #     -F 'ns=com.my-organization.canvas-app' \
  #     -H 'Authorization: Bearer <token>'
  #
  # @example_response
  #   {
  #     [{ "user":2, "data": "pistachio ice cream" },]
  #      { "user":3, "data": "chocolate" }]
  #   }
  def get_data
    return unless @context.is_a?(Course)
    return unless authorized_action(@context, @current_user, [:read_roster, :view_all_grades])

    enrollments = @context.apply_enrollment_visibility(@context.all_enrollments, @current_user).active_or_pending

    user_ids = params[:user_ids]
    if user_ids.present?
      user_ids = user_ids.split(",") if user_ids.is_a?(String)
      enrollments = enrollments.where(user_id: user_ids)
    end

    cds = CustomData.where(user_id: enrollments.pluck(:user_id), namespace: @namespace)
    out = cds.map do |cd|
      custom_data =
        begin
          cd.get_data @scope
        rescue ArgumentError => e
          nil
        end
      { user: cd.user_id, data: custom_data }
    end
    render(json: out)
  end

  private

  def require_plugin_enabled
    render(json: { message: "plugin disabled" }, status: :bad_request) and return unless CanvasCustomDataApi.enabled?
  end

  def require_namespace
    @namespace = params[:ns]
    render(json: { message: "invalid namespace" }, status: :bad_request) and return if @namespace.blank?
  end

  def get_scope
    @scope = params[:scope]
  end
end
