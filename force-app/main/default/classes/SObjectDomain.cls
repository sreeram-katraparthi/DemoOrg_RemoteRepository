/*Provides an implementation of the Enterprise Application Architecture Unit Of Work, as defined by Martin Fowler
 *   http://martinfowler.com/eaaCatalog/unitOfWork.html
 *
 * "When you're pulling data in and out of a database, it's important to keep track of what you've changed; otherwise, 
 *  that data won't be written back into the database. Similarly you have to insert new objects you create and 
 *  remove any objects you delete."
 *
 * "You can change the database with each change to your object model, but this can lead to lots of very small database calls, 
 *  which ends up being very slow. Furthermore it requires you to have a transaction open for the whole interaction, which is 
 *  impractical if you have a business transaction that spans multiple requests. The situation is even worse if you need to
 *  keep track of the objects you've read so you can avoid inconsistent reads."
 *
 * "A Unit of Work keeps track of everything you do during a business transaction that can affect the database. When you're done, 
 *  it figures out everything that needs to be done to alter the database as a result of your work."
 *
 * In an Apex context this pattern provides the following specific benifits
 *  - Applies bulkfication to DML operations, insert, update and delete
 *  - Manages a business transaction around the work and ensures a rollback occurs (even when exceptions are later handled by the caller)
 *  - Honours dependency rules between records and updates dependent relationships automatically during the commit 
 * */
public virtual with sharing class SObjectDomain
{
 	 /**
* Method constructs the given Domain class with the current Trigger context 
* before calling the applicable override methods such as beforecreateEntitySubscription, beforeUpdate etc.
**/
    public List<SObject> Records { get; private set;}
    
    public Schema.DescribeSObjectResult SObjectDescribe {get; private set;}
    
    //public static ErrorFactory Errors  {get; private set;}
    
    public static SObjectUnitOfWork unitOfWork;
    
    public Static Map<String,TriggerProgressStatus> triggersProgressStatusMap = new Map<String,TriggerProgressStatus>();
    
    public interface IConstructable
    {
        SObjectDomain construct(List<SObject> sObjectList);
    }
    public SObjectDomain(List<SObject> sObjectList)
    {
        Records = sObjectList;
        
        SObjectDescribe = Records.getSObjectType().getDescribe();
    }
    public static void triggerHandler(Type domainClass)
    {
        
        System.debug('MM start opp trigger ' + datetime.now().second() + ' ' + datetime.now().millisecond() + '\n');
        
        
        // Construct the domain class constructor class
        
        String domainClassName = domainClass.getName().contains('ChangeEvent')?domainClass.getName().removeEnd('__c').remove('_').remove('ChangeEvent') + 'ChgEvtHandler':domainClass.getName().removeEnd('__c').remove('_') + 'Handler';  
        
        
        system.debug('^^domainClassName ::'+domainClassName);
        Type constructableClass = domainClassName.endsWith('Constructor') ? Type.forName(domainClassName) : Type.forName(domainClassName+'.Constructor');
        IConstructable constructor = (IConstructable) constructableClass.newInstance();
        system.debug('^^constructor '+constructor);   
        if (!triggersProgressStatusMap.containsKey(domainClassName)) {
            triggersProgressStatusMap.put(domainClassName,new TriggerProgressStatus(false,false,false));
        } 
        system.debug('^^triggersProgressStatusMap '+triggersProgressStatusMap); 
        
        TriggerProgressStatus tgrProgressStatus = triggersProgressStatusMap.get(domainClassName);
        
        System.debug('^^tgrProgressStatus initial'+tgrProgressStatus);
        
        
        
        // Process the runtime Apex Trigger context 
        
        if (trigger.isInsert) {
            triggerHandler(constructor, 
                           Trigger.isBefore, 
                           Trigger.isAfter, 
                           Trigger.isInsert, 
                           Trigger.isUpdate, 
                           Trigger.isDelete, 
                           null,
                           null,
                           Trigger.new, 
                           null,
                           tgrProgressStatus);            
            
        }
        else {
            triggerHandler(constructor, 
                           Trigger.isBefore, 
                           Trigger.isAfter, 
                           Trigger.isInsert, 
                           Trigger.isUpdate, 
                           Trigger.isDelete,
                           Trigger.isUndelete,
                           Trigger.newMap,        //TFS-238293
                           Trigger.new, 
                           Trigger.oldMap,
                           tgrProgressStatus);            
            
        }
        
        System.debug('MM End opp trigger' + datetime.now().second() + ' ' + datetime.now().millisecond() + '\n');
        
    }
    
    /**
* Calls the applicable override methods such as beforeInsert, beforeUpdate etc. based on a Trigger context
**/
    private static void triggerHandler(IConstructable domainConstructor, Boolean isBefore, Boolean isAfter, Boolean isInsert, Boolean isUpdate, Boolean isDelete, Boolean isUndelete, Map<Id, SObject> newRecordsMap, List<SObject> newRecords, Map<Id, SObject> oldRecordsMap,TriggerProgressStatus tgrProgressStatus)
    {  

        unitOfWork = new SObjectUnitOfWork();
        if(isBefore) {
            //if(isInsert) domainConstructor.construct(newRecords).handleBeforeInsert();
            //else if(isUpdate) domainConstructor.construct(newRecords).handleBeforeUpdate(oldRecordsMap,tgrProgressStatus.triggerIsBeforeComplete);
            //else if(isDelete) domainConstructor.construct(oldRecordsMap.values()).handleBeforeDelete();
        }
        else {
            if(isInsert)
            {
                //domainConstructor.construct(newRecords).handleAfterInsert();                
            }
            else if(isUpdate) 
            {
                //domainConstructor.construct(newRecords).handleAfterUpdate(oldRecordsMap,tgrProgressStatus.triggerIsAfterComplete);
            }
            else if(isDelete) 
            {
                //domainConstructor.construct(oldRecordsMap.values()).handleAfterDelete();
            }
            else if(isUndelete) 
            {
                //domainConstructor.construct(newRecordsMap.values()).handleAfterUnDelete(); //TFS-238293
            }
        }
        
        if (!tgrProgressStatus.triggerInProgress) 
        {
            tgrProgressStatus.triggerInProgress = true;
        }
        if (isBefore && !tgrProgressStatus.triggerIsBeforeComplete)
        {
            tgrProgressStatus.triggerIsBeforeComplete = true;
        }
        if (isAfter && !tgrProgressStatus.triggerIsAfterComplete)
        {
            tgrProgressStatus.triggerIsAfterComplete = true;
        }
        
        System.debug('^^tgrProgressStatus after calling handler '+tgrProgressStatus);
        
        //Mark trigger in progress to false 
        //triggerInProgress = false;
        
        //Commit after completion of all event execution.
        unitOfWork.commitWork();
        
    }
    
    public class TriggerProgressStatus {
        
        public Boolean triggerInProgress {get; set;}
        public Boolean triggerIsBeforeComplete {get; set;}
        public Boolean triggerIsAfterComplete {get; set;}    
        
        public TriggerProgressStatus (Boolean tgrInProgress,Boolean tgrIsBeforeComplete, Boolean tgrIsAfterComplete) {
            triggerInProgress = tgrInProgress;
            triggerIsBeforeComplete = tgrIsBeforeComplete;
            triggerIsAfterComplete = tgrIsAfterComplete;
        }
        
        
    }   
}