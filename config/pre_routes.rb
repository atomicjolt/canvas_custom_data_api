CanvasRails::Application.routes.draw do
  ApiRouteSet::V1.draw(self) do
    scope(controller: :bulk_custom_data) do
      glob = '(/*scope)'
      get "courses/:course_id/enrollments/user_custom_data/#{glob}", action: 'get_data'
    end
  end
end
