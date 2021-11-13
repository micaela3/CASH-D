require 'test_helper'

class SectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @section = sections(:one)
  end

  test "should get index" do
    get sections_url
    assert_response :success
  end

  test "should get new" do
    get new_section_url
    assert_response :success
  end

  test "should create section" do
    assert_difference('Section.count') do
      post sections_url, params: { section: { class_number: @section.class_number, component: @section.component, course_id: @section.course_id, day: @section.day, end_date: @section.end_date, location: @section.location, section_number: @section.section_number, start_date: @section.start_date, time: @section.time } }
    end

    assert_redirected_to section_url(Section.last)
  end

  test "should show section" do
    get section_url(@section)
    assert_response :success
  end

  test "should get edit" do
    get edit_section_url(@section)
    assert_response :success
  end

  test "should update section" do
    patch section_url(@section), params: { section: { class_number: @section.class_number, component: @section.component, course_id: @section.course_id, day: @section.day, end_date: @section.end_date, location: @section.location, section_number: @section.section_number, start_date: @section.start_date, time: @section.time } }
    assert_redirected_to section_url(@section)
  end

  test "should destroy section" do
    assert_difference('Section.count', -1) do
      delete section_url(@section)
    end

    assert_redirected_to sections_url
  end
end
