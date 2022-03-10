## Canvas Custom User Data API Plugin

Adds a Canvas API endpoint to return custom user data for all enrolled users in a course.  Access is restricted to 
teachers.

```
GET /api/v1/courses/:course_id/enrollments/user_custom_data(/*scope)?ns=<namespace>
```

## Example Usage

```
https://<canvas>/api/v1/courses/1234/enrollments/user_custom_data/food_app/favorites/dessert?ns=com.my-organization.canvas-app
```
The query follows the same pattern as the Load custom data endpoint (https://canvas.instructure.com/doc/api/users.html#method.custom_data.get_data)

To restrict to specific users: 
```
https://<canvas>/api/v1/courses/1234/enrollments/user_custom_data/food_app/favorites/dessert?ns=com.my-organization.canvas-app&user_id=223,224
```
or
```
https://<canvas>/api/v1/courses/1234/enrollments/user_custom_data/food_app/favorites/dessert?ns=com.my-organization.canvas-app&user_id[]=223&user_id[]=224
```

### Output samples:
```json
[{"user":223,"data":"ice cream"},{"user":224,"data":"cake"}]
```

```json
[{"user":223,"data":{"type":"ice cream", "flavor":"chocolate"}}]
```

