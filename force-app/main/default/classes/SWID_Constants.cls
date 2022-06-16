/*****************************************************************************************************************************************************************************
Class Name: SWID_Constants

Purpose:    1. This is the Constant Class                
Please maintain only the last 5 history changes/modifications in the audit log

History of Changes:                 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Date                                Developer                               Comments
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
26-Apr-2018                             Vikram                                  Initial Code

********************************************************************************************************************************/
public class SWID_Constants{ 
    //STATE & STATUS
    public static final String STR_PENDING = 'PENDING';
    public static final String STR_IGNORED = 'IGNORED';
    public static final String STR_READY = 'READY';
    public static final String STR_TEST = 'TEST';
    public static final String STR_IN_DISTRIBUTION = 'IN DISTRIBUTION';
    public static final String STR_DELETED = 'DELETED';
    public static final String STR_SWID = 'SWID_';
    public static final String STR_INPROGRESS = 'IN PROGRESS';
    public static final String STR_ERROR = 'ERROR';
    
    //Permission Sets Names
    public static final String STR_SWID_VIEW_ACCESS_ONLY = 'SWID_VIEW_ACCESS_ONLY';
    public static final String STR_SWID_LOCAL_RELEASE_MANAGER_ACCESS = 'SWID_LOCAL_RELEASE_MANAGER_ACCESS';
    
    //Boolean vales
    public static final Boolean BOOL_TRUE = TRUE;
    public static final Boolean BOOL_FALSE = FALSE;
    
    //BUTTONS ACTIONS
    public static final String STR_ACT_RDY_LOC_REL = 'LOCALLY RELEASED';
    public static final String STR_ACT_RDY_TEST_REL = 'TEST RELEASED';
    public static final String STR_ACT_RDY_IGN = 'IGNORED';    
    public static final String STR_ACT_IN_DIST_REL_DEL = 'RELEASE DELETED';
    public static final String STR_ACT_IN_DIST_TESTED = 'TESTED';    
    public static final String STR_ACT_DEL_LOC_REL = 'LOCAL RELEASE DELETED';
    public static final String STR_ACT_DEL_TEST_REL = 'TEST RELEASE DELETED';
    public static final String STR_ACT_UNIGN = 'UNIGNORED';
    public static final String STR_ACT_CREATED = 'PACKAGE CREATED';    
    public static final String STR_ACT_ERROR = 'ERROR';
    
}