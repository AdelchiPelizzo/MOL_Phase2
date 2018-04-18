/**
 * Created by Adelchi on 23/03/2018.
 */
({
    doInit: function(cmp){
        var action = cmp.get("c.getUserName");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set("v.Name", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
})