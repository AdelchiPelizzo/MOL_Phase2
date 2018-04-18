/**
 * Created by Adelchi on 23/03/2018.
 */

public with sharing class LoggedInUserDataCtrl {
//Use @AuraEnabled to enable client- and server-side access to the method
    @AuraEnabled
    public static String getUserName() {
        return userInfo.getName();
    }
}