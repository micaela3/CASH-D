function addQuery(val){
	//Runs the code only if val exists
    if(val){
        //Checks if the ? in query is already present in the url
		if(window.location.href.indexOf("?") > -1){
            //Gets the index of the query the user wants from the url
			let index = window.location.href.indexOf(val.substring(0, val.indexOf("=")));
			//Checks if the query the user wants to add already exists in the url
            if(index > -1 ){
                //Checks if the query being added is the first query or not
				if(index < window.location.href.indexOf("&")){
                    //If it is the first query then replaces the prexisting query in the url with the new query being requested
					window.location.href = window.location.href.replace(window.location.href.substring(index, window.location.href.indexOf("&")), val);
				}else{
                    //If the preexisting query is not the first query then replace the prexisting query with the new query being requested
                    //The difference between the top and this replacement is that the top replaces the preexisting query uptill the index of & whereas this replaces everything up till the length of the url from the index of the preexisting query
					window.location.href = window.location.href.replace(window.location.href.substring(index, window.location.href.length), val);
				}
			}else{
                //If there is already a query then add the new query preceeded by an "&" symbol
				window.location.href += '&' + val;
			}
		} else {
            //If there is no query in the url, then add the query with a preceeding "?" character
			window.location.href += "?" + val;
		}
	}
}

//Export the function because rails doesnt recognize the javascript function unless it is exported
export default addQuery
