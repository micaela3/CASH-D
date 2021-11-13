require "application_system_test_case"

class MeetingsTest < ApplicationSystemTestCase
  setup do
    @meeting = meetings(:one)
  end

  test "visiting the index" do
    visit meetings_url
    assert_selector "h1", text: "Meetings"
  end

  test "creating a Meeting" do
    visit meetings_url
    click_on "New Meeting"

    fill_in "End time", with: @meeting.end_time
    check "Friday" if @meeting.friday
    fill_in "Location", with: @meeting.location
    check "Monday" if @meeting.monday
    check "Saturday" if @meeting.saturday
    fill_in "Section", with: @meeting.section_id
    fill_in "Start time", with: @meeting.start_time
    check "Sunday" if @meeting.sunday
    check "Thursday" if @meeting.thursday
    check "Tuesday" if @meeting.tuesday
    check "Wednesday" if @meeting.wednesday
    click_on "Create Meeting"

    assert_text "Meeting was successfully created"
    click_on "Back"
  end

  test "updating a Meeting" do
    visit meetings_url
    click_on "Edit", match: :first

    fill_in "End time", with: @meeting.end_time
    check "Friday" if @meeting.friday
    fill_in "Location", with: @meeting.location
    check "Monday" if @meeting.monday
    check "Saturday" if @meeting.saturday
    fill_in "Section", with: @meeting.section_id
    fill_in "Start time", with: @meeting.start_time
    check "Sunday" if @meeting.sunday
    check "Thursday" if @meeting.thursday
    check "Tuesday" if @meeting.tuesday
    check "Wednesday" if @meeting.wednesday
    click_on "Update Meeting"

    assert_text "Meeting was successfully updated"
    click_on "Back"
  end

  test "destroying a Meeting" do
    visit meetings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Meeting was successfully destroyed"
  end
end
