window.addEventListener('load', (event) => {
    console.log('page is fully loaded');
});

var index = 0;
window.addNewTimeSlot = function(){
    var form = document.getElementById('availability_template').cloneNode(true);
    form.id = "";
    form.style.display = 'flex';
    form.querySelector('#availability_weekday').setAttribute('name','availability['+(index)+'][weekday]');
    form.querySelector('#availability_start_time').setAttribute('name','availability['+(index)+'][start_time]');
    form.querySelector('#availability_end_time').setAttribute('name','availability['+(index)+'][end_time]');
    var list = document.getElementById('availabilities');
    index++;
    console.log(list.append(form));
    
}