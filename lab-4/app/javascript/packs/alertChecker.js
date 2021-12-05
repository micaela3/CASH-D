//Checks if there is content in the alert box and if there is displays it if not it hides it
function alertChecker() {
    //Get the element
    var alerts = document.getElementsByClassName('alert');
    var notices = document.getElementsByClassName('notice');
    //Check if the element is empty
    if(alerts[0].innerText.length == 0){
        //hide the element
        alerts[0].classList.remove("block");
    }else{
        //Display the element
        alerts[0].classList.add("block");
    }
    //Checks if the element is empty
    if(notices[0].innerText.length == 0){
        //hides the element
        notices[0].classList.remove("block");
    }else{
        //displays the element
        notices[0].classList.add("block");
    }
}

//export the function for webpacker to see
export default alertChecker
