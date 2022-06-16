({
    doInit : function(component, event, helper) {
        helper.getPosition(component);
    },
    
    doSomething : function(component, event, helper) {
        
        var lstPackages = component.get("v.lstPackages");
        
        //To check if list is not empty or null
        if(!$A.util.isEmpty(lstPackages) && !$A.util.isUndefined(lstPackages)){
            
            //Calling the Apex Function
            var action = component.get("c.performAction");
                                  
            //Json Encode to send the data to Apex Class
            var positionRecords = JSON.stringify(lstPackages);
            //Setting the Apex Parameter
            action.setParams({
                positionRecords : positionRecords
            });
            
            //Setting the Callback
            action.setCallback(this,function(a){
                //get the response state
                var state = a.getState();
                
                //check if result is successfull
                if(state == "SUCCESS"){
                    
                    //Perform Action after the result
                    alert('Success in calling server side action');
                    
                } else if(state == "ERROR"){
                    alert('Error in calling server side action');
                }
            });
            
            //adds the server-side action to the queue        
            $A.enqueueAction(action);
            
        }
        
        
    },
    sortFirstName : function(component, event, helper) {        
        var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
          table = document.getElementById("myTable");
          alert('in soritng'+table);
          switching = true;
          // Set the sorting direction to ascending:
          dir = "asc"; 
          /* Make a loop that will continue until
          no switching has been done: */
          while (switching) {
            // Start by saying: no switching is done:
            switching = false;
            rows = table.getElementsByTagName("TR");
              alert('rows length'+rows.length);
            /* Loop through all table rows (except the
            first, which contains table headers): */
            for (i = 1; i < (rows.length - 1); i++) {
              // Start by saying there should be no switching:
              shouldSwitch = false;
              /* Get the two elements you want to compare,
              one from current row and one from the next: */
              x = rows[i].getElementsByTagName("TD")[0];
                alert('x'+x.value);
                
              y = rows[i + 1].getElementsByTagName("TD")[0];
                alert('y'+y.value);
              /* Check if the two rows should switch place,
              based on the direction, asc or desc: */
              if (dir == "asc") {
                if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                  // If so, mark as a switch and break the loop:
                  shouldSwitch= true;
                  break;
                }
              } else if (dir == "desc") {
                if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                  // If so, mark as a switch and break the loop:
                  shouldSwitch= true;
                  break;
                }
              }
            }
            if (shouldSwitch) {
              /* If a switch has been marked, make the switch
              and mark that a switch has been done: */
              rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
              switching = true;
              // Each time a switch is done, increase this count by 1:
              switchcount ++; 
            } else {
              /* If no switching has been done AND the direction is "asc",
              set the direction to "desc" and run the while loop again. */
              if (switchcount == 0 && dir == "asc") {
                dir = "desc";
                switching = true;
              }
            }
          }
        
    },
})