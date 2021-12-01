var index = 0;
window.addNewTimeSlot = function(weekday=0, startTime=0, endTime=0){ 
    
    var form = document.getElementById('availability_template').cloneNode(true);
    form.id = "";
    form.style.display = 'flex';
    form.querySelector('#availability_weekday').setAttribute('name','availability['+(index)+'][weekday]');
    form.querySelector('#availability_start_time').setAttribute('name','availability['+(index)+'][start_time]');
    form.querySelector('#availability_end_time').setAttribute('name','availability['+(index)+'][end_time]');   

    if (startTime!=0 && endTime !=0) {
        startTime = new Date(Date.parse(startTime));
        endTime = new Date(Date.parse(endTime));
        form.querySelector('#availability_weekday').selectedIndex=weekday;
        form.querySelector('#availability_start_time').value=startTime.toISOString().substring(11,16); 
        form.querySelector('#availability_end_time').value=endTime.toISOString().substring(11,16); 
    }
  
    var list = document.getElementById('availabilities');
    index++;
    list.append(form);
    
}

var courseIndex = 0;
window.addNewCourse = function(courseID=undefined) {
    var form = document.getElementById('course_template').cloneNode(true);
    form.id = "";
    form.style.display = 'flex';
    form.querySelector('#course_id').setAttribute('name','courses['+(courseIndex)+'][course_id]');
    form.querySelector('#course_id').setAttribute('required','true');
    form.querySelector('#course_id').value=courseID;

    courseIndex++;
    var list = document.getElementById('courses');
    list.append(form);

}
