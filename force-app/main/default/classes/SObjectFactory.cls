public abstract class SObjectFactory {

    protected Schema.sObjectType sObjectType{get;set;}
    protected String dataFileStaticResourseName{get;set;}

    //Counter can be used during data generation
	protected Integer counter {
        get {
            if (counter == null) {
                counter = 0;
            }
            counter++;
            return counter;
        }
        private set;
    }    
    
    //If the caller wants to override data for some fields
    protected List<Map<Schema.SObjectField, Object>> fieldToValueList;
   
    //Constructor
    public SObjectFactory() {
        fieldToValueList = new List<Map<Schema.SObjectField, Object>>();
    }
    
    //Add field value to override
    public void addFieldToValueMapping( Map<Schema.SObjectField, Object> fieldToValue ) {
        this.fieldToValueList.add(fieldToValue);
    }
    
    //Create SObject
    public SObject buildRecord() {
        return buildRecords(1)[0];
    }

    //Create SObject and insert
    public SObject buildAndInsertRecord() {
        return buildAndInsertRecords(1)[0];
    }

    //Build and insert record
    public List<SObject> buildAndInsertRecords( Integer numRecords ) {
        List<SObject> records = buildRecords( numRecords );
        insert records;
        return records;
    }
    
    //Load data from Static Resource
    public List<SObject> InsertRecordsFromStaticResource() {
        return Test.loadData(sObjectType, dataFileStaticResourseName);
    }    
    
    //build sobjects
    public List<SObject> buildRecords( Integer numRecords ) {
        List<SObject> records = new List<SObject>();
        for( Integer i = 0; i < numRecords; i++ ) {
            Sobject record = buildRecordWithData();
            if (fieldToValueList.size()>0 && fieldToValueList.size()>i+1)
            	mergeFields( record ,fieldToValueList[i]);
            
            records.add( record );
        }
        return records;
    }
    
    //merge override fields
    private void mergeFields(SObject record,Map<Schema.SObjectField, Object> fieldToValue) {
        if( fieldToValue == NULL ) return;
        for( Schema.SObjectField field : fieldToValue.keySet() ) {
            record.put( field, fieldToValue.get( field ) );
        }
    }    
    
    //to be implemented by extending class 
    abstract SObject buildRecordWithData(); 
    
}