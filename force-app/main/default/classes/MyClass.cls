@RestResource(urlMapping='/testsite/*')
global with sharing class MyClass 
{
    @HttpPost
    global static void doPost()
    {
        RestRequest restRequest = RestContext.request;
        //System.debug('======== Auth Header: ' + restRequest.headers.get('Authorization'));
        System.debug('** UserInfo.getSessionId() **'+UserInfo.getSessionId());

    }
}