({
    doInit: function(component, event, helper) {
        console.log(" do init started ...");
        component.find("medicationRecordCreator").getNewRecord(
            "Medication_Prescribed__c", // sObject type (objectApiName)
            null,      // recordTypeId
            false,     // skip cache?
            $A.getCallback(function() {
                var rec = component.get("v.newMedication");
                var error = component.get("v.newMedicationError");
                if(error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                    return;
                }else{
                    console.log("Record template initialized: " +  JSON.stringify(rec) );
                }
            })
        );
        var action = component.get("c.getMedicationList");
        action.setCallback(this, function(response) {
            console.log("inside call back started");
            if (response.getState() == "SUCCESS") {
                component.set("v.medicationNameList", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },

    cancel: function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    },

    storeMedicationName: function(component, event, helper){
        var val = event.getSource().get('v.value');
        component.set('v.medicationName', val);
    },

    handleSaveContact: function(component, event, helper) {
        var action = component.get("c.getInventoryItem");
        action.setParams({ consultId : component.get("v.consultationId"), InventoryName : component.get("v.medicationName")});
        console.log(action.getParams);
        $A.enqueueAction(action);
        component.set("v.simpleNewMedication.Consultation__c", component.get("v.recordId"));
        component.set("v.simpleNewMedication.Medication_Name__c", component.get("v.medicationName"));
        component.find("medicationRecordCreator").saveRecord(function(saveResult) {
            if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title": "Saved",
                    "message": "The record was saved."
                });
                resultsToast.fire();
            } else if (saveResult.state === "INCOMPLETE") {
                // handle the incomplete state
                console.log("User is offline, device doesn't support drafts.");
            } else if (saveResult.state === "ERROR") {
                // handle the error state
                console.log('Problem saving contact, error: ' + JSON.stringify(saveResult.error));
            } else {
                console.log('Unknown problem, state: ' + saveResult.state + ', error: ' + JSON.stringify(saveResult.error));
            }
        });
        $A.get("e.force:closeQuickAction").fire();
    }
})