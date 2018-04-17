/**
 * Created by Adelchi on 19/12/2017.
 */
({
    loadContacts : function(component, event, helper) {
        var name = component.get("v.contactName");
        console.log('Name >> '+name);
        var date = component.get("v.birthdate");
        console.log('Date >> '+date);
        var action = component.get("c.searchForContacts");
        action.setParams({searchText : name, searchDate : date});
        console.log(action);
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log(state);
            var toastEvent = $A.get("e.force:showToast");
            if (state === "SUCCESS") {
                component.set("v.contactList", response.getReturnValue());
            }
            if (state === 'ERROR'){
                var errors = response.getError();
                if(errors){
                    toastEvent.setParams({
                        "title": "Errors!",
                        "message": "No Contact returned with selected parameters." + errors[0].message+ "Please try refresh the page."
                    });
                }
            }
            toastEvent.fire();
        });
        $A.enqueueAction(action);
    },

    convertDate: function (component, event, helper) {
        console.log('hello world');
        var brtD = component.find('birthdate');
        var bD = brtD.get('v.value');
        console.log(bd);
        var day;
        var month;
        var year;
        var dateList = [];
        dateList = bd.split('-');
        year  = dateList[0];
        month = dateList[1];
        day = dateList[2];
        var convertedDate = day+'-'+month+'-'+year;
        bd.set
        component.set('v.converted-birthdate', convertedDate);
    }
})