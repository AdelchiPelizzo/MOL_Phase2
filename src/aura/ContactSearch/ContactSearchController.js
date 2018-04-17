/**
 * Created by Adelchi on 19/12/2017.
 */
({
    doInit: function (component, event, helper)
    {
        console.log('Run Helper from Init');
        helper.loadContacts(component);
    },

    navigate: function(component, event, helper) {
        var navEvt = $A.get("e.force:navigateToSObject");
        var ctarget = event.currentTarget;
        console.log('this should be the Id of the record clicked>>'+ctarget.dataset.value);
        navEvt.setParams({
            "recordId": ctarget.dataset.value
        });
        navEvt.fire();
    },

    convertDate: function (component, event, helper) {
        var brtD = component.find('birthdate').get('v.value');
        var bD = brtD.get('v.value');
        var day;
        var month;
        var year;
        var dateList = [];
        dateList = bd.split('-');
        year  = dateList[0];
        month = dateList[1];
        day = dateList[2];
        var convertedDate = day+'-'+month+'-'+year;
        component.set('v.converted-birthdate', convertedDate);
    }
})