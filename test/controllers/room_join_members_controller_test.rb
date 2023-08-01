require "test_helper"

class RoomJoinMembersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get room_join_members_create_url
    assert_response :success
  end

  test "should get destory" do
    get room_join_members_destory_url
    assert_response :success
  end
end
