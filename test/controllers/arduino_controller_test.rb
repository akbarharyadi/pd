require 'test_helper'

class ArduinoControllerTest < ActionDispatch::IntegrationTest
  test "should get sensor" do
    get arduino_sensor_url
    assert_response :success
  end

  test "should get led" do
    get arduino_led_url
    assert_response :success
  end

end
