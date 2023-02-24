create table accounting_estimate
(
    Id                int auto_increment
        primary key,
    AuditfileNumber   int          null,
    SectionId         int          null,
    FormId            int          null,
    ParentWPI         varchar(14)  null,
    RowIndexId        int          null,
    RefText           varchar(14)  null,
    NatureOfKey       varchar(255) null,
    RelatedDisclosure varchar(255) null,
    CreatedByUserId   int          null,
    CreatedAt         int          null,
    DeletedAt         int          null
)
    collate = utf8_unicode_ci;

create index idx_auditfilenumber
    on accounting_estimate (AuditfileNumber);

create table phinxlog
(
    version        bigint               not null
        primary key,
    migration_name varchar(100)         null,
    start_time     timestamp            null,
    end_time       timestamp            null,
    breakpoint     tinyint(1) default 0 not null
)
    charset = utf8;

create table schema_migrations
(
    version varchar(255) not null
        primary key
)
    collate = latin1_bin;

create table tblaccountingstructure
(
    AccountingStructureId       int unsigned auto_increment
        primary key,
    AccountingStructureCode     varchar(64)  null,
    Title                       varchar(255) null,
    Status                      varchar(12)  null,
    CreatedAt                   int          null,
    CreatedByStaffId            int          null,
    isTemplate                  tinyint(1)   null,
    SourceAccountingStructureId int unsigned null
)
    collate = utf8_unicode_ci;

create table tblaccounttype
(
    AccountTypeId         int auto_increment
        primary key,
    AccountType           varchar(1024) null,
    AccountName           varchar(1024) null,
    AuditFileNumber       int           null,
    Nature                varchar(3)    null,
    ParentId              int           null,
    `Rank`                int           null,
    OnlyTotalSelf         tinyint(1)    null,
    TotalAccountIds       varchar(256)  null,
    AccountTypeDesc       varchar(1024) null,
    AccountTypeName       varchar(1024) null,
    AccountingStructureId int unsigned  null,
    FolderCode            varchar(16)   null,
    LeadScheduleCode      varchar(16)   null,
    RowType               varchar(16)   null,
    Formula               text          null,
    FormulaName           varchar(1024) null,
    Reference             varchar(48)   null comment 'To record References for LeadSchedule',
    Tickmarks             varchar(1024) null comment 'To record Tickmarks for LeadSchedule'
)
    collate = utf8_unicode_ci;

create index INDEX_AuditFileNumber
    on tblaccounttype (AuditFileNumber);

create index idx_AccountingStructureId
    on tblaccounttype (AccountingStructureId);

create index idx_nature
    on tblaccounttype (Nature);

create table tblaccounttype_lang
(
    AccountTypeId   int           not null,
    lang_code       varchar(12)   not null,
    AccountName     varchar(1024) null,
    AccountTypeName varchar(1024) null,
    AccountTypeDesc varchar(1024) null,
    FormulaName     varchar(1024) null,
    primary key (AccountTypeId, lang_code)
)
    collate = utf8_unicode_ci;

create table tblactivityfeeds
(
    ActivityId        int auto_increment
        primary key,
    ActivitySubject   varchar(128)  null,
    ActivityType      varchar(18)   null,
    ActivityDetails   varchar(3000) null,
    CreatedDate       int           null,
    CreatedByUsername varchar(128)  null,
    CreatedByUserId   int           null,
    AuditFileNumber   int           null
)
    collate = utf8_unicode_ci;

create table tbladasacompliancechecklist
(
    ASAid            int auto_increment
        primary key,
    AuditFileNumber  int         null,
    ASA              varchar(24) null,
    ASATitle         varchar(64) null,
    ProcedureNumber1 varchar(64) null,
    Status1          tinyint(1)  null,
    ProcedureNumber2 varchar(64) null,
    Status2          tinyint(1)  null
)
    collate = utf8_unicode_ci;

create table tblafactionpoints
(
    ActionPointId   int auto_increment
        primary key,
    AuditFileNumber int          null,
    FormRef         varchar(20)  null,
    PointNumber     int          null,
    WPref           varchar(255) null,
    Matter          varchar(255) null,
    Resolved        tinyint(1)   null,
    Comments        text         null
)
    collate = utf8_unicode_ci;

create table tblafadjustments
(
    AdjustmentId                                int auto_increment
        primary key,
    AuditFileNumber                             int            null,
    AdjustmentDetails                           varchar(512)   null,
    AdjustmentComments                          varchar(1024)  null,
    DateAdded                                   varchar(11)    null,
    WPref                                       varchar(24)    null,
    AccountCode                                 varchar(24)    null,
    AccountName                                 varchar(255)   null,
    BalanceSheet                                varchar(32)    null comment 'Dr/(Cr) - if Credit, value in bracket',
    ProfitLoss                                  varchar(32)    null comment 'Dr/(Cr) - if Credit, value in bracket',
    Balance                                     decimal(17, 2) null comment 'Account balance',
    DateAdjusted                                int            null,
    Adjusted                                    varchar(12)    null,
    ParentRowId                                 int            null,
    isNew                                       tinyint(1)     null comment 'determine if this adjustment entry exists in AB1 or AB1.1',
    Trivial                                     tinyint(1)     null,
    EffectOnAuditOpinion                        varchar(12)    null,
    CreatedBy                                   varchar(128)   null comment 'created by staff name',
    CreatedByDate                               int            null,
    LastUpdatedBy                               varchar(128)   null comment 'last updated by staff name',
    LastUpdatedByDate                           int            null,
    AccountType                                 varchar(255)   null,
    AccountTypeId                               int            null,
    LeadSchedule                                varchar(16)    null,
    Source                                      varchar(12)    null comment 'iris,class,bgl, or Null if AF',
    Narrative                                   varchar(255)   null,
    xero_event_id                               varchar(36)    null comment 'guid of the transaction posted in xero',
    xero_event_status                           varchar(12)    null comment 'status of the transaction posted in xero',
    manual_journal_id                           varchar(36)    null comment 'guid assign to manual journal in xero',
    xero_manual_journal_status                  varchar(12)    null comment 'status assign to manual journal in xero',
    xero_manual_journal_account_id              varchar(36)    null comment 'account id to manual journal entry by xero',
    date_updated_in_xero                        varchar(26)    null comment 'date update of manual journal in xero',
    last_updated_by_in_xero                     varchar(128)   null comment 'latest user who exported the manual journal to xero',
    last_updated_by_user_id_in_xero             varchar(36)    null comment 'latest user id who exported the manual journal to xero',
    adjustment_comments_last_updated_on         int            null comment 'date update of last comment on journals',
    adjustment_comments_last_updated_by         varchar(128)   null comment 'username who update the comment on journal',
    adjustment_comments_last_updated_by_user_id varchar(36)    null comment 'latest user id who update the comment on journal',
    xero_warnings                               text           null comment 'Warnings while exporting in Xero',
    xero_validation_errors                      text           null comment 'Validation Errors while exporting in Xero',
    ledger_account_id                           varchar(50)    null comment 'ledger account id',
    export_type                                 int            null comment 'journal export type',
    legacy_id                                   int            null comment 'sage journal account legacy_id',
    transaction_id                              varchar(50)    null comment 'sage journal account transaction id'
)
    collate = utf8_unicode_ci;

create table tblafannotatedpdffiles
(
    Id              int unsigned auto_increment
        primary key,
    UploadedFileId  int                       not null comment 'Reference/FK to tblaffiles.UploadedFileId',
    AuditFileNumber int                       not null,
    FileName        varchar(255)              null comment 'Filename with extensions, no path',
    ReferenceName   varchar(255) charset utf8 null comment 'Filename without extensions, should be the same across versions',
    FilePath        varchar(1024)             null comment 'Filepath, self explanatory',
    DateCreated     int                       null comment 'Field to record the history entry TS corresponds to this point of time when this file is created.'
)
    comment 'Table to store annotated versions of supporting documents (PDF)' collate = utf8_unicode_ci;

create index idx_datecreated_uploadedfileid_auditfilenumber
    on tblafannotatedpdffiles (DateCreated, UploadedFileId, AuditFileNumber);

create table tblafapfinancialratio
(
    ApFinancialRatioId                     int auto_increment comment 'unique ID for recored in AC3, AC7, AC10'
        primary key,
    AuditFileNumber                        int          null,
    StatementDetailsId                     int          null,
    CurrentRatioCurrentYear                varchar(32)  null comment 'DEPRECATED',
    CurrentRatioInterim                    varchar(32)  null,
    CurrentRatioInitial                    varchar(32)  null,
    CurrentRatioFinal                      varchar(32)  null,
    CurrentRatioPreviousYear               varchar(32)  null,
    CurrentRatioVariance                   varchar(32)  null comment 'DEPRECATED',
    CurrentRatioVarianceInterimValue       varchar(32)  null,
    CurrentRatioVarianceInterimPercent     varchar(32)  null,
    CurrentRatioVarianceInitialValue       varchar(32)  null,
    CurrentRatioVarianceInitialPercent     varchar(32)  null,
    CurrentRatioVarianceFinalValue         varchar(32)  null,
    CurrentRatioVarianceFinalPercent       varchar(32)  null,
    CurrentRatioReason                     varchar(512) null comment 'DEPRECATED',
    CurrentRatioReasonInterim              varchar(512) null,
    CurrentRatioReasonInitial              varchar(512) null,
    CurrentRatioReasonFinal                varchar(512) null,
    DebtRatioCurrentYear                   varchar(32)  null comment 'DEPRECATED',
    DebtRatioInterim                       varchar(32)  null,
    DebtRatioInitial                       varchar(32)  null,
    DebtRatioFinal                         varchar(32)  null,
    DebtRatioPreviousYear                  varchar(32)  null,
    DebtRatioVariance                      varchar(32)  null comment 'DEPRECATED',
    DebtRatioVarianceInterimValue          varchar(32)  null,
    DebtRatioVarianceInterimPercent        varchar(32)  null,
    DebtRatioVarianceInitialValue          varchar(32)  null,
    DebtRatioVarianceInitialPercent        varchar(32)  null,
    DebtRatioVarianceFinalValue            varchar(32)  null,
    DebtRatioVarianceFinalPercent          varchar(32)  null,
    DebtRatioReason                        varchar(512) null comment 'DEPRECATED',
    DebtRatioReasonInterim                 varchar(512) null,
    DebtRatioReasonInitial                 varchar(512) null,
    DebtRatioReasonFinal                   varchar(512) null,
    InterestCoverageCurrentYear            varchar(32)  null comment 'DEPRECATED',
    InterestCoverageInterim                varchar(32)  null,
    InterestCoverageInitial                varchar(32)  null,
    InterestCoverageFinal                  varchar(32)  null,
    InterestCoveragePreviousYear           varchar(32)  null,
    InterestCoverageVariance               varchar(32)  null comment 'DEPRECATED',
    InterestCoverageVarianceInterimValue   varchar(32)  null,
    InterestCoverageVarianceInterimPercent varchar(32)  null,
    InterestCoverageVarianceInitialValue   varchar(32)  null,
    InterestCoverageVarianceInitialPercent varchar(32)  null,
    InterestCoverageVarianceFinalValue     varchar(32)  null,
    InterestCoverageVarianceFinalPercent   varchar(32)  null,
    InterestCoverageReason                 varchar(512) null comment 'DEPRECATED',
    InterestCoverageReasonInterim          varchar(512) null,
    InterestCoverageReasonInitial          varchar(512) null,
    InterestCoverageReasonFinal            varchar(512) null,
    LiquidRatioReasonInterim               varchar(512) null,
    LiquidRatioReasonInitial               varchar(512) null,
    LiquidRatioReasonFinal                 varchar(512) null,
    EquityRatioReasonInterim               varchar(512) null,
    EquityRatioReasonInitial               varchar(512) null,
    EquityRatioReasonFinal                 varchar(512) null,
    GrossProfitRatioReasonInterim          varchar(512) null,
    GrossProfitRatioReasonInitial          varchar(512) null,
    GrossProfitRatioReasonFinal            varchar(512) null,
    NetProfitRatioReasonInterim            varchar(512) null,
    NetProfitRatioReasonInitial            varchar(512) null,
    NetProfitRatioReasonFinal              varchar(512) null
)
    collate = utf8_unicode_ci;

create table tblafauditplan
(
    ApproachId             int auto_increment
        primary key,
    WpiIndexRowId          int         not null,
    FormRef                varchar(24) not null,
    AuditProgramIndexRowId int         not null,
    AuditProgramFormRef    varchar(24) not null,
    AuditFileNumber        int         not null,
    wpiSectionId           int         not null comment 'WPI Section Id for auditplan workpaper section'
)
    collate = utf8_unicode_ci;

create table tblafclientfiles
(
    ClientFilesNumber int auto_increment
        primary key,
    AuditFileNumber   int          null,
    FormRef           varchar(12)  null comment 'i.e. BH',
    FormRefName       varchar(255) null comment 'i.e. Ethical Clearance',
    TemplatePath      varchar(512) null comment 'folder path and file name',
    CompletedFormPath varchar(512) null comment 'folder path and filename'
)
    collate = utf8_unicode_ci;

create table tblafcommentsdetails
(
    CommentId   int auto_increment
        primary key,
    CommentNum  int  null,
    CommentText text null
)
    collate = utf8_unicode_ci;

create table tblafcontact
(
    afContactId     int auto_increment
        primary key,
    AuditFileNumber int          null,
    afContactType   varchar(128) null,
    ContactName     varchar(255) null,
    Reference       varchar(255) null,
    Firm            varchar(255) null,
    Address         varchar(255) null,
    Suburb          varchar(255) null,
    State           varchar(32)  null,
    Pcode           varchar(32)  null,
    Country         varchar(255) null,
    Phone           varchar(255) null,
    Fax             varchar(255) null,
    Email           varchar(255) null,
    Mobile          varchar(128) null,
    Website         varchar(128) null
)
    collate = utf8_unicode_ci;

create table tblafdocumentcontrol
(
    DocumentControlId int auto_increment
        primary key,
    AuditFileNumber   int          null,
    RefName           varchar(12)  null,
    ReceivedStatus    tinyint(1)   null,
    StaffId           int          null comment 'Staff Id',
    StaffName         varchar(255) null comment 'Full Staff Name',
    DocumentVersion   varchar(12)  null,
    ReceivedDate      int          null
)
    collate = utf8_unicode_ci;

create table tblaffiles
(
    UploadedFileId       int auto_increment
        primary key,
    AuditFileNumber      int                      null,
    FormName             varchar(32)              null comment 'i.e. AA2, AA1.4, etc..',
    FileSequenceNumber   int                      null comment 'file sequence number',
    ReferenceName        varchar(255)             null,
    FileName             varchar(255)             null,
    FilePath             varchar(1024)            null,
    Description          text                     null,
    UploadedDate         int                      null,
    AddedByStaffId       int                      null,
    AddedByStaffName     varchar(255)             null,
    ReferenceType        varchar(255)             null,
    Active               tinyint(1)               null,
    wpiRowId             int                      null,
    FileSize             int                      null comment 'in bytes',
    FileSource           text                     null,
    WopiLock             varchar(1024)            null,
    WopiLockStaffId      varchar(256)             null,
    WopiFileVersion      int unsigned             null,
    PdfCurrentlyEditedBy int unsigned default '0' null comment 'User ID who currently editing the PDF document',
    PdfLastLocked        int unsigned default '0' null comment 'Used to validate the locking expiration',
    WopiLockLastUpdated  int unsigned             null,
    checksummd5          varchar(32)              null
)
    collate = utf8_unicode_ci;

create index INDEX_AFNUM
    on tblaffiles (AuditFileNumber);

create table tblaffilesannotations
(
    AnnotationId            int auto_increment comment 'The annotation Id'
        primary key,
    GeneratedAnnotationId   varchar(75) default '0' null comment 'Actual annotation ID generated by PDFTron',
    SuppFileId              int         default 0   null comment 'Uploaded file Id',
    AuditFileNumber         int         default 0   null comment 'Auditfile number',
    AnnotatorId             int         default 0   null comment 'User who create this annotation',
    AnnotationEncodedString mediumtext              null comment 'The annotation string content, in XML (XFDF spec)',
    DateCreated             int                     null comment 'History date. The actual annotation date stays in XFDF string.',
    DateDeleted             int                     null comment 'For soft deletion.'
)
    comment 'PDF annotation data' collate = utf8_unicode_ci;

create index idx_datecreated_suppfileid_auditfilenumber
    on tblaffilesannotations (DateCreated, SuppFileId, AuditFileNumber);

create index idx_datedeleted_suppfileid_auditfilenumber
    on tblaffilesannotations (DateDeleted, SuppFileId, AuditFileNumber);

create table tblaffraudrisk
(
    AuditFileNumber                           int                            not null
        primary key,
    FraudRiskFactors                          text                           null,
    MatterArisenPastInvolvingFraudYesNo       tinyint(1)                     null,
    MatterArisenPastInvolvingFraud            text                           null,
    MatterOfConcernSignificantDecisions       text                           null,
    MatterStep3CommunicatedYesNo              tinyint(1)                     null,
    ManagementAssessmentOfRiskLowMedHi        enum ('Low', 'Medium', 'High') null,
    ManagementAssessmentOfRisk                text                           null,
    ManagementProcess                         text                           null,
    ManagementCommunicationGovernance         text                           null,
    ManagementCommunicationEmployees          text                           null,
    ManagementActualSuspectedAllegedFraud     text                           null,
    OversightManagementProcess                text                           null,
    BoardCommitteeActualSuspectedAllegedFraud text                           null,
    FraudAffectingEntity                      text                           null comment 'AA1.4 Q7(a)',
    CommentAssessmentOfRisk                   text                           null comment 'AA1.4 Q7(b)',
    FraudRiskFactorsPresentYesNo              tinyint(1)                     null,
    FraudRiskFactorsPresent                   text                           null,
    PresumptionRiskMaterialYesNo              tinyint(1)                     null,
    PresumptionRiskMaterial                   text                           null,
    MatterFraudClientManagement               text                           null,
    MatterFraudBoardCommittee                 text                           null
)
    collate = utf8_unicode_ci;

create table tblaffraudriskissues
(
    AuditFraudRiskId int auto_increment
        primary key,
    AuditFileNumber  int          null,
    StaffId          int          null,
    StaffName        varchar(255) null,
    Position         varchar(128) null,
    Issue            varchar(255) null,
    Communicated     tinyint(1)   null
)
    collate = utf8_unicode_ci;

create table tblafgoingconcern
(
    ConcernId          int auto_increment
        primary key,
    AuditFileNumber    int          null,
    FormRef            varchar(12)  null,
    AuditYear          varchar(8)   null,
    NetProfitRatio     varchar(128) null,
    CurrentAsset       varchar(128) null,
    CurrentLiability   varchar(128) null,
    LiquidityRatio     varchar(128) null,
    NetProfitBeforeTax varchar(128) null,
    TotalInterest      varchar(128) null,
    InterestRatio      varchar(128) null,
    DaysPayableRatio   varchar(128) null,
    OperatingCashFlow  varchar(128) null
)
    collate = utf8_unicode_ci;

create table tblafinternalcontrol
(
    InternalControlId int auto_increment
        primary key,
    AuditFileNumber   int           null,
    RowCode           varchar(12)   null comment 'i.e. A.1, A.2, etc.',
    Response          tinyint(1)    null comment 'NULL = N/A, 1 = YES, 0 = NO',
    Comment           varchar(1024) null
)
    collate = utf8_unicode_ci;

create table tblafissues
(
    IssueId             int auto_increment comment 'issue id for all issues box at bottom of form creator forms'
        primary key,
    AuditFileNumber     int               null,
    ReviewPointNum      int               null comment 'increment number of review point per auditfile',
    FormRef             varchar(24)       null,
    FormRefName         varchar(255)      null,
    FormRefDestination  varchar(12)       null comment 'FormRef this issue should go to',
    IssueDescription    varchar(3000)     null comment 'Text Description of the issue',
    Status              varchar(128)      null,
    LodgedStaffId       int               null,
    LodgedStaffName     varchar(255)      null,
    IssueLodgedDate     int               null,
    IssueResolvedDate   int               null,
    ResolvedStaffId     int               null,
    ResolvedStaffName   varchar(255)      null,
    AssignedToStaffId   int               null comment 'Reference to tbluser.UserId',
    AssignedToStaffName varchar(255)      null comment 'Cached staff name from tbluserdetails at time of this row''s creation',
    ClearedDate         int               null,
    ClearedStaffId      int               null comment 'Reference to tbluser.UserId',
    ClearedStaffName    varchar(255)      null comment 'Cached staff fullname',
    Comment             varchar(3000)     null,
    CustomField         varchar(128)      null comment 'Used in A1 for Regulation',
    PercentCompleted    tinyint default 0 null comment '0-100 percent completion of this issue'
)
    collate = utf8_unicode_ci;

create index INDEX_AFNUM
    on tblafissues (AuditFileNumber);

create table tblafissuesfiles
(
    IssueId        int not null,
    UploadedFileId int not null,
    primary key (IssueId, UploadedFileId)
)
    collate = utf8_unicode_ci;

create table tblafissuesnotification
(
    AuditFileNumber int not null,
    UserId          int not null,
    primary key (AuditFileNumber, UserId)
)
    collate = utf8_unicode_ci;

create table tblafissuesresponse
(
    IssuesResponseId int auto_increment
        primary key,
    IssueId          int           null comment 'tblafissues issueid',
    UserId           int           null,
    UserFullname     varchar(128)  null,
    Response         varchar(1024) null,
    ResponseDate     int           null
)
    collate = utf8_unicode_ci;

create table tblafmaterialrisk
(
    MaterialRiskId     int auto_increment comment 'data for AI.1 - Assessing the Risks of Material Misstatement'
        primary key,
    AuditFileNumber    int           null,
    StatementDetailsId int           null,
    IdentifiedRisk     varchar(1024) null comment 'Risk description',
    Assertions         varchar(64)   null comment 'E, C, VA, RO',
    ApplicableControls varchar(64)   null comment 'Ref',
    RelyOnControls     tinyint(1)    null comment 'Yes/No',
    ControlsTesting    varchar(64)   null comment 'Ref/NA',
    RiskLikelyhood     varchar(1)    null comment '1,2,3',
    RiskImpact         varchar(1)    null comment '1,2,3',
    OverallRisk        varchar(2)    null comment 'RiskLikelihood x RiskImpact',
    ResponseRef        varchar(64)   null comment 'Ref'
)
    collate = utf8_unicode_ci;

create table tblafnaturetimingextent
(
    NatureTimingExtentId int auto_increment
        primary key,
    AuditFileNumber      int          null,
    Section              tinyint      null,
    RowTitle             varchar(255) null,
    StatementDetailsId   int          null,
    Purpose              varchar(255) null,
    NTEtype              varchar(255) null,
    Timing               varchar(32)  null,
    Extent               varchar(255) null,
    Assertions           varchar(32)  null,
    WPref                varchar(64)  null,
    YesNo                tinyint(1)   null,
    Interim              tinyint(1)   null,
    Initial              tinyint(1)   null,
    Final                tinyint(1)   null,
    `Rank`               smallint     null,
    DefaultValue         tinyint(1)   null
)
    collate = utf8_unicode_ci;

create table tblafntefurtherproceduresrows
(
    NTEFurtherProceduresRowId int auto_increment comment 'Row Id for form AI.1'
        primary key,
    SectionId                 int                      null,
    YesNo                     tinyint(1)               null,
    Purpose                   varchar(255)             null,
    Type                      varchar(255) default '0' null,
    Timing                    varchar(255) default '0' null,
    Extent                    varchar(255) default '0' null,
    Assertions                varchar(255)             null,
    Ref                       varchar(255)             null,
    `Rank`                    int                      null,
    DefaultRowId              int                      null
)
    collate = utf8_unicode_ci;

create table tblafntefurtherproceduressections
(
    NTEFurtherProceduresSectionId int auto_increment comment 'Row Id section for AI.1'
        primary key,
    AuditFileNumber               int          null,
    FormRef                       varchar(20)  null,
    StatementDetailsId            int          null,
    SectionTitle                  varchar(255) null,
    InherentRisk                  tinyint      null,
    ControlRisk                   tinyint      null,
    `Rank`                        int          null
)
    collate = utf8_unicode_ci;

create table tblafpreparerreviewer
(
    AuditFileNumber int         not null,
    PageReference   varchar(12) not null,
    PreparerStaffId int         null,
    PreparedDate    int         null,
    ReviewerStaffId int         null,
    ReviewedDate    int         null,
    primary key (AuditFileNumber, PageReference)
)
    collate = utf8_unicode_ci;

create table tblafreffiles
(
    RefFileNumber        int auto_increment
        primary key,
    AuditFileNumber      int           null,
    FormRef              varchar(12)   null,
    FormRefReference     varchar(12)   null,
    FormRefReferenceName varchar(255)  null,
    FileName             varchar(255)  null comment 'Uploaded File Name',
    FilePath             varchar(512)  null,
    SystemFilePath       varchar(1024) null,
    FileDescription      text          null,
    UploadedDate         int           null,
    StaffId              int           null,
    StaffFullName        varchar(512)  null
)
    collate = utf8_unicode_ci;

create table tblafrelatedpartiesrow
(
    RelatedPartyId  int auto_increment
        primary key,
    AuditFileNumber int           null,
    RowName         varchar(255)  null,
    Completed       tinyint(1)    null,
    StaffId         int           null,
    StaffName       varchar(255)  null,
    DateCompleted   int           null,
    Reference       varchar(1024) null comment 'links to other FormRef - HTML'
)
    collate = utf8_unicode_ci;

create table tblafrelatedpartyrisk
(
    AuditFileNumber                              int                            not null
        primary key,
    EntityProcedures                             text                           null,
    TransactionsWithRelatedParties               text                           null,
    AmountOwedDebtors                            text                           null,
    AmountOwedCreditors                          text                           null,
    LoanReceivable                               text                           null,
    LoanPayable                                  text                           null,
    RelatedPartyRelationship                     text                           null comment 'AA1.5 Q9(a)',
    TransactionAndArrangementsWithRelatedParties text                           null comment 'AA1.5 Q9(b)',
    TransactionAndArrangementsOutside            text                           null comment 'AA1.5 Q9(b)',
    FinancialReportLowMedHi                      enum ('Low', 'Medium', 'High') null,
    FinancialReport                              text                           null
)
    collate = utf8_unicode_ci;

create table tblafrelatedpartyrisklist
(
    RelatedPartyListId int auto_increment
        primary key,
    AuditFileNumber    int                                                 null,
    ListType           enum ('AllRelatedParties', 'ManagementAffiliation') null,
    RelatedPartyName   varchar(255)                                        null,
    Relationship       varchar(255)                                        null
)
    collate = utf8_unicode_ci;

create table tblafriskassessment
(
    RiskAssessmentId int auto_increment comment 'Row Id for form AI'
        primary key,
    AuditFileNumber  int          null,
    FormRef          varchar(8)   null,
    Situation        text         null,
    ImpactedAccount  varchar(255) null comment 'Impacted Account for Identified Risk Box',
    Consequence      text         null,
    Response         text         null,
    Ref              varchar(255) null,
    IRALikelihood    tinyint      null,
    IRAConsequence   tinyint      null,
    IRAInherentRisk  tinyint      null,
    `Rank`           smallint     null,
    Assertion        varchar(48)  null
)
    collate = utf8_unicode_ci;

create table tblafriskassessmentanalysis
(
    RiskAssessmentAnalysisId int auto_increment
        primary key,
    AuditFileNumber          int          null,
    ProgramType              varchar(128) null comment 'i.e. sections in AI or AI.1: Income, Equity, Cash and Cash Equivalent, Tax Liabilities',
    ProgramName              varchar(512) null,
    RiskExists               tinyint(1)   null,
    RiskMaterial             tinyint(1)   null,
    RiskExistence            varchar(1)   null,
    RiskCompleteness         varchar(1)   null,
    RiskValuation            varchar(1)   null,
    RiskRights               varchar(1)   null,
    RiskPresentation         varchar(1)   null,
    AuditProgramReference    varchar(48)  null comment 'used for Risk Analysis Assertion Level forms',
    RowRank                  int          null,
    Hidden                   tinyint(1)   null
)
    collate = utf8_unicode_ci;

create table tblafriskassessmentassertionrows
(
    RiskAssessmentAssertionRowId int auto_increment comment 'Row Id for form AI.1'
        primary key,
    SectionId                    int               null,
    FormRef                      varchar(24)       null,
    IdentifiedRisk               text              null,
    Assertions                   varchar(255)      null,
    Likelihood                   tinyint default 0 null,
    Consequence                  tinyint default 0 null,
    ControlRating                tinyint default 0 null,
    ControlReliance              tinyint(1)        null,
    ApplicableControls           varchar(255)      null,
    Significant                  tinyint(1)        null,
    Response                     text              null,
    Ref                          varchar(255)      null,
    `Rank`                       int               null
)
    collate = utf8_unicode_ci;

create table tblafriskassessmentassertionsections
(
    RiskAssessmentAssertionSectionId int auto_increment comment 'Row Id section for AI.1'
        primary key,
    AuditFileNumber                  int                            null,
    FormRef_OLD                      varchar(20)                    null comment '--- DEPRECATED',
    StatementDetailsId               int                            null,
    SectionTitle                     varchar(255)                   null,
    RisksIdentified                  tinyint(1)   default 1         null,
    `Rank`                           int                            null,
    AssertionType                    varchar(255) default 'Default' null,
    ImpactedAccount                  varchar(255)                   null comment 'Impacted Account for Identified Risk box'
)
    collate = utf8_unicode_ci;

create table tblafrisks
(
    RiskId                int auto_increment
        primary key,
    AuditFileNumber       int          not null,
    FormRef               varchar(24)  not null,
    FormSectionId         int          not null,
    Schedule              text         null,
    RiskNature            varchar(255) null,
    RiskIdentification    text         null comment '(eg. what could go wrong?)',
    RelevantAssertion     varchar(255) null comment 'Relevant assertion(s) and the related significant classes of transactions, account balances and disclosures2',
    RiskLevel             varchar(255) null,
    InherentRisk          varchar(15)  null,
    FraudRisk             varchar(15)  null,
    SigRisk               varchar(15)  null,
    ControlRisk           varchar(15)  null,
    RMM                   varchar(15)  null,
    AffectsRMM            varchar(15)  null comment 'Affects the RMM at the assertion level?^1',
    NatureAndExtentOfRisk text         null comment 'Evaluate the nature and extent of the risk''s pervasive effect on the financial statements',
    EffectOnPlannedAudit  text         null comment 'Summarise the effect on the planned audit approach and reference to how risks are covered in the individual area audit plans (B40/X2)',
    Ref                   text         null,
    AuditPlan             int          null,
    AuditPlanType         varchar(20)  null,
    Description           text         null,
    RiskLevelType         varchar(64)  null,
    CreatedAt             int          not null,
    CreatedById           int          not null,
    CreatedByName         varchar(255) not null,
    UpdatedAt             int          null,
    UpdatedById           int          null,
    UpdatedByName         varchar(255) null,
    CopiedWPI1            int          null,
    CopiedWPI2            int          null,
    CopiedWPI3            int          null
)
    charset = utf8;

create table tblafsignofftemplate
(
    SignOffTemplateId int auto_increment
        primary key,
    AuditFileNumber   int                  not null comment 'FK to tblauditfile.AuditFileNumber',
    Name              varchar(255)         not null comment 'The name of the sign-off',
    DisplayInWPI      tinyint(1) default 0 null comment 'Whether this sign-off should be displayed in the WPI',
    `Rank`            int                  null comment 'Order to display the sign-off in'
)
    collate = utf8_unicode_ci;

create index AuditFileNumber
    on tblafsignofftemplate (AuditFileNumber);

create table tblafstatementdetails
(
    StatementDetailsId     int auto_increment
        primary key,
    AuditFileNumber        int                       null,
    AccountCode            varchar(24)               null comment 'used from trial balance import (1-1110, 1-1120, etc)',
    Description            varchar(1024)             null comment 'AB1 and AB1.1',
    Interim                varchar(32)               null comment 'AB1 and AB1.1 - i.e. value entered during interim period, prior actual audit start',
    Annualised             varchar(32)               null comment 'AC forms',
    Initial                varchar(32)               null comment 'AB1 and AB1.1 - i.e. value at start of audit',
    Adjustment             varchar(32)               null comment 'AB1 and AB1.1',
    Final                  varchar(32)               null comment 'AB1 and AB1.1 - i.e. final value with initial and adjustment values',
    PreviousYear           varchar(32)               null comment 'AB1 and AB1.1',
    PriorYearPreAdjust     varchar(32)               null,
    MaterialInterim        tinyint(1)                null comment 'AB1 and AB1.1 - Material cell only if 10% or more than total of AD1',
    MaterialInitial        tinyint(1)                null comment 'AB1 and AB1.1 - Material cell only if 10% or more than total of AD2',
    MaterialFinal          tinyint(1)                null comment 'AB1 and AB1.1 - Material cell only if 10% or more than total of AD3',
    MaterialBudget         tinyint(1)                null comment 'for AC4 Initial Income Statement vs BUDGET - Material cell',
    Overwrite              tinyint(1)                null comment 'AB1',
    LeadSchedule           varchar(16)               null,
    Reference              varchar(48)               null comment 'field used for lead schedule form (i.e. H1) for further reference',
    ControlRisk            int                       null comment 'CB1, AI.2(Control Risk)',
    StatementType          varchar(255)              null,
    RelyOnIc               tinyint                   null comment 'CB1',
    InherentRisk           int                       null comment 'AI.2',
    DetectionRisk          int                       null comment 'AI.2',
    Variance               varchar(32)               null comment 'AC1 and AC3',
    VarianceInterimValue   varchar(32)               null comment 'AC forms - variance in dollar value',
    VarianceInterimPercent varchar(32)               null comment 'AC forms - variance in percentage',
    VarianceInitialValue   varchar(32)               null comment 'AC5, AC6',
    VarianceInitialPercent varchar(32)               null comment 'AC5, AC6',
    VarianceFinalValue     varchar(32)               null comment 'AC8, AC9',
    VarianceFinalPercent   varchar(32)               null comment 'AC8, AC9',
    Reason                 varchar(255)              null comment 'AC1 and AC3',
    ReasonInterim          varchar(255)              null,
    ReasonInitial          varchar(255)              null,
    ReasonFinal            varchar(255)              null,
    Budget                 varchar(32)               null comment 'AC3',
    BudgetVarianceValue    varchar(32)               null comment 'AC4',
    BudgetVariancePercent  varchar(32)               null comment 'AC4',
    BudgetReason           varchar(255)              null comment 'AC4',
    FollowUpInterim        varchar(255) charset utf8 null,
    FollowUpInitial        varchar(255) charset utf8 null,
    FollowUpFinal          varchar(255) charset utf8 null,
    BudgetFollowUp         varchar(255) charset utf8 null,
    Tickmarks              varchar(1024)             null,
    ExternalGuid           varchar(140)              null,
    AccountTypeId          int                       null comment 'FK to tblaccounttype',
    Units                  varchar(32)               null,
    AccountComments        text                      null,
    IgnoreAlert            tinyint(1) default 0      null comment 'Yes/no if we should ignore unmapped account warnings for this row',
    CurrentYTD             varchar(32)               null,
    PriorYTD               varchar(32)               null,
    PriorPeriod            varchar(32)               null
)
    collate = utf8_unicode_ci;

create index IDX_AFNUM_ACCCODE
    on tblafstatementdetails (AuditFileNumber, AccountCode);

create index IDX_AFNUM_STMTID
    on tblafstatementdetails (AuditFileNumber, StatementDetailsId);

create index INDEX_AFNUM
    on tblafstatementdetails (AuditFileNumber);

create index idx_accountTypeId
    on tblafstatementdetails (AccountTypeId);

create table tblafstatementdetailscomments
(
    CommentId          int not null comment 'FK to tblafcomments.CommentId',
    StatementDetailsId int not null comment 'FK to tblafstatementdetails.StatementDetailsId',
    AuditFileNumber    int not null comment 'FK to tblauditfile.AuditFileNumber',
    primary key (CommentId, StatementDetailsId)
)
    collate = utf8_unicode_ci;

create index INDEX_StatementDetailsId
    on tblafstatementdetailscomments (StatementDetailsId);

create table tblafstatementfinancials
(
    StatementFinancialsId                       int auto_increment
        primary key,
    AuditFileNumber                             int         null,
    TotalCurrentAssetsInterim                   varchar(32) null comment 'Total for AB1.1',
    TotalCurrentAssetsInitial                   varchar(32) null comment 'Total for AB1.1',
    TotalCurrentAssetsAdjustment                varchar(32) null comment 'Total for AB1.1',
    TotalCurrentAssetsFinal                     varchar(32) null comment 'Total for AB1.1',
    TotalCurrentAssetsPreviousYear              varchar(32) null comment 'Total for AB1.1',
    TotalNonCurrentAssetsInterim                varchar(32) null comment 'Total for AB1.1',
    TotalNonCurrentAssetsInitial                varchar(32) null comment 'Total for AB1.1',
    TotalNonCurrentAssetsAdjustment             varchar(32) null comment 'Total for AB1.1',
    TotalNonCurrentAssetsFinal                  varchar(32) null comment 'Total for AB1.1',
    TotalNonCurrentAssetsPreviousYear           varchar(32) null comment 'Total for AB1.1',
    TotalAssetsInterim                          varchar(32) null comment 'Total for AB1.1',
    TotalAssetsInitial                          varchar(32) null comment 'Total for AB1.1',
    TotalAssetsAdjustment                       varchar(32) null comment 'Total for AB1.1',
    TotalAssetsFinal                            varchar(32) null comment 'Total for AB1.1',
    TotalAssetsPreviousYear                     varchar(32) null comment 'Total for AB1.1',
    TotalCurrentLiabilitiesInterim              varchar(32) null comment 'Total for AB1.1',
    TotalCurrentLiabilitiesInitial              varchar(32) null comment 'Total for AB1.1',
    TotalCurrentLiabilitiesAdjustment           varchar(32) null comment 'Total for AB1.1',
    TotalCurrentLiabilitiesFinal                varchar(32) null comment 'Total for AB1.1',
    TotalCurrentLiabilitiesPreviousYear         varchar(32) null comment 'Total for AB1.1',
    TotalNonCurrentLiabilitiesInterim           varchar(32) null comment 'Total for AB1.1',
    TotalNonCurrentLiabilitiesInitial           varchar(32) null comment 'Total for AB1.1',
    TotalNonCurrentLiabilitiesAdjustment        varchar(32) null comment 'Total for AB1.1',
    TotalNonCurrentLiabilitiesFinal             varchar(32) null comment 'Total for AB1.1',
    TotalNonCurrentLiabilitiesPreviousYear      varchar(32) null comment 'Total for AB1.1',
    TotalLiabilitiesInterim                     varchar(32) null comment 'Total for AB1.1',
    TotalLiabilitiesInitial                     varchar(32) null comment 'Total for AB1.1',
    TotalLiabilitiesAdjustment                  varchar(32) null comment 'Total for AB1.1',
    TotalLiabilitiesFinal                       varchar(32) null comment 'Total for AB1.1',
    TotalLiabilitiesPreviousYear                varchar(32) null comment 'Total for AB1.1',
    NetAssetsInterim                            varchar(32) null comment 'Total for AB1.1',
    NetAssetsInitial                            varchar(32) null comment 'Total for AB1.1',
    NetAssetsAdjustment                         varchar(32) null comment 'Total for AB1.1',
    NetAssetsFinal                              varchar(32) null comment 'Total for AB1.1',
    NetAssetsPreviousYear                       varchar(32) null comment 'Total for AB1.1',
    TotalEquityInterim                          varchar(32) null comment 'Total for AB1.1',
    TotalEquityInitial                          varchar(32) null comment 'Total for AB1.1',
    TotalEquityAdjustment                       varchar(32) null comment 'Total for AB1.1',
    TotalEquityFinal                            varchar(32) null comment 'Total for AB1.1',
    TotalEquityPreviousYear                     varchar(32) null comment 'Total for AB1.1',
    CurrentAssetsMaterialityInterimLow          varchar(32) null comment 'AD1 Materiality percentage',
    CurrentAssetsMaterialityInitialLow          varchar(32) null comment 'AD2 Materiality percentage',
    CurrentAssetsMaterialityFinalLow            varchar(32) null comment 'AD3 Materiality percentage',
    CurrentAssetsMaterialityInterimHigh         varchar(32) null comment 'AD1',
    CurrentAssetsMaterialityInitialHigh         varchar(32) null comment 'AD2',
    CurrentAssetsMaterialityFinalHigh           varchar(32) null comment 'AD3',
    NonCurrentAssetsMaterialityInterimLow       varchar(32) null comment 'AD1',
    NonCurrentAssetsMaterialityInitialLow       varchar(32) null comment 'AD2',
    NonCurrentAssetsMaterialityFinalLow         varchar(32) null comment 'AD3',
    NonCurrentAssetsMaterialityInterimHigh      varchar(32) null comment 'AD1',
    NonCurrentAssetsMaterialityInitialHigh      varchar(32) null comment 'AD2',
    NonCurrentAssetsMaterialityFinalHigh        varchar(32) null comment 'AD3',
    CurrentLiabilitiesMaterialityInterimLow     varchar(32) null comment 'AD1',
    CurrentLiabilitiesMaterialityInitialLow     varchar(32) null comment 'AD2',
    CurrentLiabilitiesMaterialityFinalLow       varchar(32) null comment 'AD3',
    CurrentLiabilitiesMaterialityInterimHigh    varchar(32) null comment 'AD1',
    CurrentLiabilitiesMaterialityInitialHigh    varchar(32) null comment 'AD2',
    CurrentLiabilitiesMaterialityFinalHigh      varchar(32) null comment 'AD3',
    NonCurrentLiabilitiesMaterialityInterimLow  varchar(32) null comment 'AD1',
    NonCurrentLiabilitiesMaterialityInitialLow  varchar(32) null comment 'AD2',
    NonCurrentLiabilitiesMaterialityFinalLow    varchar(32) null comment 'AD3',
    NonCurrentLiabilitiesMaterialityInterimHigh varchar(32) null comment 'AD1',
    NonCurrentLiabilitiesMaterialityInitialHigh varchar(32) null comment 'AD2',
    NonCurrentLiabilitiesMaterialityFinalHigh   varchar(32) null comment 'AD3',
    NetAssetsMaterialityInterimLow              varchar(32) null comment 'AD1',
    NetAssetsMaterialityInitialLow              varchar(32) null comment 'AD2',
    NetAssetsMaterialityFinalLow                varchar(32) null comment 'AD3',
    NetAssetsMaterialityInterimHigh             varchar(32) null comment 'AD1',
    NetAssetsMaterialityInitialHigh             varchar(32) null comment 'AD2',
    NetAssetsMaterialityFinalHigh               varchar(32) null comment 'AD3'
)
    collate = utf8_unicode_ci;

create index IDX_AFNUM
    on tblafstatementfinancials (AuditFileNumber);

create index INDEX_AFNUM
    on tblafstatementfinancials (AuditFileNumber);

create table tblafstatementincome
(
    StatementIncomeId                   int auto_increment
        primary key,
    AuditFileNumber                     int         null,
    TotalOperatingRevenueInterim        varchar(32) null comment 'AB1 - Total Operating Revenue',
    TotalOperatingRevenueInitial        varchar(32) null,
    TotalOperatingRevenueAdjustment     varchar(32) null,
    TotalOperatingRevenueFinal          varchar(32) null,
    TotalOperatingRevenuePreviousYear   varchar(32) null,
    TotalIncomeInterim                  varchar(32) null,
    TotalIncomeInitial                  varchar(32) null,
    TotalIncomeAdjustment               varchar(32) null,
    TotalIncomeFinal                    varchar(32) null,
    TotalIncomePreviousYear             varchar(32) null comment 'field Total for AB1',
    TotalCOGSInterim                    varchar(32) null,
    TotalCOGSInitial                    varchar(32) null,
    TotalCOGSAdjustment                 varchar(32) null,
    TotalCOGSFinal                      varchar(32) null,
    TotalCOGSPreviousYear               varchar(32) null comment 'field Total for AB1',
    TotalExpensesInterim                varchar(32) null,
    TotalExpensesInitial                varchar(32) null,
    TotalExpensesAdjustment             varchar(32) null,
    TotalExpensesFinal                  varchar(32) null,
    TotalExpensesPreviousYear           varchar(32) null comment 'field Total for AB1',
    TotalInterestExpenseInterim         varchar(32) null comment 'AB1 Interest Expense',
    TotalInterestExpenseInitial         varchar(32) null,
    TotalInterestExpenseAdjustment      varchar(32) null,
    TotalInterestExpenseFinal           varchar(32) null,
    TotalInterestExpensePreviousYear    varchar(32) null,
    TotalExpenseBeforeTaxInterim        varchar(32) null comment 'Total Expense Before Tax = Total Expenses + Total Interest Expense',
    TotalExpenseBeforeTaxInitial        varchar(32) null,
    TotalExpenseBeforeTaxAdjustment     varchar(32) null,
    TotalExpenseBeforeTaxFinal          varchar(32) null,
    TotalExpenseBeforeTaxPreviousYear   varchar(32) null,
    ProfitBeforeInterestTaxInterim      varchar(32) null comment 'Profit Before Tax (Interest taken out)',
    ProfitBeforeInterestTaxInitial      varchar(32) null,
    ProfitBeforeInterestTaxAdjustment   varchar(32) null,
    ProfitBeforeInterestTaxFinal        varchar(32) null,
    ProfitBeforeInterestTaxPreviousYear varchar(32) null comment 'field Total for AB1',
    IncomeTaxInterim                    varchar(32) null,
    IncomeTaxInitial                    varchar(32) null,
    IncomeTaxAdjustment                 varchar(32) null,
    IncomeTaxFinal                      varchar(32) null,
    IncomeTaxPreviousYear               varchar(32) null comment 'field Total for AB1',
    InterestInterim                     varchar(32) null,
    InterestInitial                     varchar(32) null,
    InterestAdjustment                  varchar(32) null,
    InterestFinal                       varchar(32) null,
    InterestPreviousYear                varchar(32) null comment 'field Total for AB1',
    ProfitAfterInterestTaxInterim       varchar(32) null,
    ProfitAfterInterestTaxInitial       varchar(32) null,
    ProfitAfterInterestTaxAdjustment    varchar(32) null,
    ProfitAfterInterestTaxFinal         varchar(32) null,
    ProfitAfterInterestTaxPreviousYear  varchar(32) null comment 'field Total for AB1',
    IncomeMaterialityInterimLow         varchar(32) null comment 'AD1',
    IncomeMaterialityInitialLow         varchar(32) null comment 'AD2',
    IncomeMaterialityFinalLow           varchar(32) null comment 'AD3',
    IncomeMaterialityInterimHigh        varchar(32) null comment 'AD1',
    IncomeMaterialityInitialHigh        varchar(32) null comment 'AD2',
    IncomeMaterialityFinalHigh          varchar(32) null comment 'AD3',
    COGSMaterialityInterimLow           varchar(32) null comment 'AD1',
    COGSMaterialityInitialLow           varchar(32) null comment 'AD2',
    COGSMaterialityFinalLow             varchar(32) null comment 'AD3',
    COGSMaterialityInterimHigh          varchar(32) null comment 'AD1',
    COGSMaterialityInitialHigh          varchar(32) null comment 'AD2',
    COGSMaterialityFinalHigh            varchar(32) null comment 'AD3',
    ExpensesMaterialityInterimLow       varchar(32) null comment 'AD1',
    ExpensesMaterialityInitialLow       varchar(32) null comment 'AD2',
    ExpensesMaterialityFinalLow         varchar(32) null comment 'AD3',
    ExpensesMaterialityInterimHigh      varchar(32) null comment 'AD1',
    ExpensesMaterialityInitialHigh      varchar(32) null comment 'AD2',
    ExpensesMaterialityFinalHigh        varchar(32) null comment 'AD3',
    NetResultInterim                    varchar(32) null comment 'AD1',
    NetResultInitial                    varchar(32) null comment 'AD2',
    NetResultFinal                      varchar(32) null comment 'AD3',
    NetResultMaterialityInterimLow      varchar(32) null comment 'AD1',
    NetResultMaterialityInitialLow      varchar(32) null comment 'AD2',
    NetResultMaterialityFinalLow        varchar(32) null comment 'AD3',
    NetResultMaterialityInterimHigh     varchar(32) null comment 'AD1',
    NetResultMaterialityInitialHigh     varchar(32) null comment 'AD2',
    NetResultMaterialityFinalHigh       varchar(32) null comment 'AD3',
    GrossProfitInterim                  varchar(32) null,
    GrossProfitInitial                  varchar(32) null,
    GrossProfitAdjustment               varchar(32) null,
    GrossProfitFinal                    varchar(32) null,
    GrossProfitPreviousYear             varchar(32) null
)
    collate = utf8_unicode_ci;

create index IDX_AFNUM
    on tblafstatementincome (AuditFileNumber);

create index INDEX_AFNUM
    on tblafstatementincome (AuditFileNumber);

create table tblafteam
(
    AuditFileNumber       int          not null,
    StaffId               int          not null,
    StaffName             varchar(255) null,
    Role                  varchar(255) null,
    YesNoDeclaration      tinyint(1)   null comment 'used in AH1 Auditor Independence Declaration',
    CompletedDeclaration  tinyint(1)   null comment 'used in AH1 Auditor Independence Declaration',
    CompletedDate         int          null comment 'used in AH1 Auditor Independence Declaration',
    CommentsDeclaration   varchar(512) null comment 'used in AH1 Auditor Independence Declaration',
    AuditPlanStrategyDate int          null,
    primary key (AuditFileNumber, StaffId)
)
    collate = utf8_unicode_ci;

create index INDEX_AFNUM
    on tblafteam (AuditFileNumber);

create table tblafuser
(
    AuditFileNumber int        not null,
    UserId          int        not null,
    Active          tinyint(1) not null,
    DateAdded       int        not null,
    primary key (AuditFileNumber, UserId)
)
    collate = utf8_unicode_ci;

create table tblafworkflow
(
    RowId           int auto_increment
        primary key,
    AuditFileNumber int                  null,
    ParentId        int                  null,
    RowType         varchar(16)          null comment 'step, section, row, etc...',
    RowName         varchar(512)         null,
    RowRank         int                  null,
    Completed       tinyint(1) default 0 null,
    FormRef         varchar(100)         null,
    PreparedBy      varchar(45)          null comment 'staff name',
    PreparedDate    int                  null,
    Comment         varchar(255)         null comment 'Only applicable for rows',
    Origin          varchar(12)          null comment 'i.e. user, app (application)'
)
    collate = utf8_unicode_ci;

create index INDEX_AFNUM
    on tblafworkflow (AuditFileNumber);

create table tblafworkingpaperindex
(
    IndexRowId          int auto_increment
        primary key,
    AuditFileNumber     int                  null,
    FormRef             varchar(14)          null,
    FormCode            varchar(16)          null,
    FormTitle           varchar(255)         null,
    FormType            varchar(24)          null,
    Responsability      varchar(32)          null comment 'UserType',
    Issues              int                  null,
    StepsTotal          int                  null,
    StepsCompleted      int                  null,
    CompletedProgress   varchar(12)          null,
    CompletedByStaffId  int                  null comment 'staff who has completed this WP',
    CompletedDate       int                  null comment 'completed date',
    CompletedByStaff    varchar(128)         null,
    PreparedByStaffId   int                  null,
    PreparedByStaff     varchar(255)         null,
    PreparedDate        int                  null,
    UpdatedByStaffId    int                  null,
    UpdatedByStaff      varchar(255)         null,
    UpdatedDate         int                  not null,
    FirstReviewStaffId  int                  null,
    FirstReviewStaff    varchar(255)         null,
    FirstReviewDate     int                  null,
    SecondReviewStaffId int                  null,
    SecondReviewStaff   varchar(255)         null,
    SecondReviewDate    int                  null,
    ReviewedByStaffId   int                  null,
    ReviewedByStaff     varchar(255)         null,
    ReviewedDate        int                  null,
    Hidden              tinyint(1)           null comment '1 = hidden, null or 0 = show',
    FormOrder           int                  null,
    FormId              int                  null comment 'dbcontroller.tblformcontent.FormId',
    UploadedFileId      int                  null comment 'tblaffiles.UploadedFileId',
    ParentId            int                  null comment 'IndexRowId, or NULL if wpi section',
    VersionNumber       varchar(8)           null comment 'Overrides the version number of this form - otherwise version number is determined from the form''s parent auditfile',
    FormSource          varchar(8)           null comment 'industry or firm, null = read tblauditfile TemplateType',
    RevisionNumber      varchar(7)           null,
    LatestRevisionDate  int                  null comment 'The date that the latest revision to this workpaper was made',
    ExternalGuid        varchar(140)         null,
    FormView            varchar(512)         null comment 'View name on the file system - to be used for static views',
    ForceDisplay        tinyint(1) default 1 null comment 'This is to indicate that a folder or workpaper should be permanently display',
    isExcelConnect      tinyint(1) default 0 null,
    ButtonDetail        text                 null,
    isConverted         int        default 0 not null comment '1-> Livedoc converted to worddoc 2-> Livedoc replaced with industry doc 3-> Firm Livedoc replaced with selected industry doc 4-> LiveDoc replaced with an empty worddoc 5-> Firm Ref not found replaced with placeholder doc
6-> Industry Ref not found replaced with placeholder doc',
    IsClientChecklist   tinyint(1) default 0 not null
)
    collate = utf8_unicode_ci;

create index IDX_AFNUM_INDEXROWID
    on tblafworkingpaperindex (AuditFileNumber, IndexRowId);

create index UNIQUE_AFNUM_FORMREF
    on tblafworkingpaperindex (AuditFileNumber, FormRef, IndexRowId);

create index idx_auditfilenumber_uploadedfileid
    on tblafworkingpaperindex (UploadedFileId, AuditFileNumber);

create index idx_formid_auditfilenumber
    on tblafworkingpaperindex (FormId, AuditFileNumber);

create index idx_formtype_auditfilenumber
    on tblafworkingpaperindex (FormType, AuditFileNumber);

create index idx_parentid
    on tblafworkingpaperindex (ParentId);

create table tblafworkingpaperindex_lang
(
    IndexRowId int          not null,
    lang_code  varchar(12)  not null,
    FormTitle  varchar(255) null,
    primary key (IndexRowId, lang_code)
)
    collate = utf8_unicode_ci;

create table tblafwpihistory
(
    HistoryId      int auto_increment
        primary key,
    IndexRowId     int         null comment 'FK to tblafworkingpaperindex',
    UserId         int         null comment 'FK to tbluser - created by user id',
    UploadedFileId int         null comment 'FK to tblaffiles',
    DateCreated    int         null comment 'Unix timestamp',
    Status         varchar(24) null comment 'type of history item, i.e.: check_in, check_out, replaced, restored, initial'
)
    collate = utf8_unicode_ci;

create index INDEX_IndexRowId
    on tblafwpihistory (IndexRowId);

create table tblafwpsignoff
(
    SignOffId         int auto_increment
        primary key,
    SignOffTemplateId int          not null comment 'FK to tblafsignofftemplate.SignOffTemplateId',
    AuditFileNumber   int          not null comment 'FK to tblauditfile.AuditFileNumber',
    FormRef           varchar(255) not null comment 'FK to tblafworkingpaperindex.FormRef',
    DateSignedOff     int          not null comment 'Unix timestamp for date sign-off happened',
    UserId            int          null comment 'FK to tbluser.UserId',
    UserNameCached    varchar(255) null comment 'Cached user name, in case the user gets deleted from tbluser we still want to have some record of who did the signoff'
)
    collate = utf8_unicode_ci;

create index AuditFileNumber
    on tblafwpsignoff (AuditFileNumber, FormRef);

create table tblapiitems
(
    apiitemid     int auto_increment
        primary key,
    app_key       varbinary(128) null,
    guid          varchar(128)   null,
    targetTable   varchar(128)   null,
    targetPK      varchar(64)    null,
    targetPKvalue varchar(128)   null
)
    collate = utf8_unicode_ci;

create index INDEX_APPKEY_GUID
    on tblapiitems (app_key, guid);

create table tblapiusers
(
    app_key    varbinary(128) not null,
    user_key   varbinary(128) not null,
    UserId     int            null comment 'tbluser.UserId',
    UserSecret varbinary(255) not null,
    primary key (app_key, user_key)
)
    collate = utf8_unicode_ci;

create table tblauditfile
(
    AuditFileNumber         int auto_increment
        primary key,
    ClientId                int                  null comment 'SME: Auditee UserId. SMSF: Trustee UserId (not used for login)',
    AccountantId            int                  null comment 'SMSF: Administrator(accountant) userid from tbluser',
    AuditeeName             varchar(255)         null,
    AuditPeriod             varchar(128)         null,
    AuditPeriodDate         int                  null comment 'Displayed across all audit file forms',
    StartDate               int                  null,
    EndDate                 int                  null,
    PriorDate               int                  null,
    StatutoryReportingDate  int                  null,
    InterimDate             int                  null comment 'Interim Date (to use for AB1, AB1.1, AC forms, etc)',
    CreatedDate             int                  null comment 'Date auditfile was created',
    FileExpiryDate          int                  null comment 'Expiry date for this auditfile',
    LastUpdated             int                  null comment 'last updated date',
    CreatedByStaffId        int                  null,
    CreatedByStaffName      varchar(255)         null,
    VoucherCode             varchar(255)         null,
    Inactive                tinyint(1) default 0 null,
    NoFinancialPeriod       varchar(128)         null,
    PartnerRotation         varchar(128)         null,
    PhysicalLocation        varchar(128)         null,
    AuditFee                varchar(64)          null,
    Address                 varchar(255)         null,
    Suburb                  varchar(255)         null,
    State                   varchar(64)          null,
    Pcode                   varchar(11)          null,
    Country                 varchar(255)         null,
    Phone                   varchar(64)          null,
    Fax                     varchar(64)          null,
    AddressPostal           varchar(255)         null,
    SuburbPostal            varchar(255)         null,
    StatePostal             varchar(128)         null,
    PcodePostal             varchar(128)         null,
    CountryPostal           varchar(255)         null,
    ContactName1            varchar(128)         null,
    ContactLastName1        varchar(128)         null,
    ContactPosition1        varchar(128)         null,
    ContactPhone1           varchar(32)          null,
    ContactMobile1          varchar(32)          null,
    ContactEmail1           varchar(128)         null,
    ContactName2            varchar(128)         null,
    ContactLastName2        varchar(128)         null,
    ContactPosition2        varchar(128)         null,
    ContactPhone2           varchar(32)          null,
    ContactMobile2          varchar(32)          null,
    ContactEmail2           varchar(128)         null,
    Website                 varchar(1024)        null,
    ImportedFileName        varchar(255)         null comment 'File name for the imported file trial balance',
    ImportedFileFullPath    varchar(1024)        null comment 'Full file path location for the imported file trial balance',
    VersionNumber           varchar(8)           null comment 'Version Number',
    StatusProgress          varchar(48)          null comment 'last entry from completion checklist',
    isTemplate              tinyint(1)           null comment 'TRUE = audit file is a template',
    TemplateName            varchar(64)          null,
    TemplateId              int                  null,
    TemplateType            varchar(12)          null comment 'NULL, industry, firm',
    ArchiveDate             int                  null comment 'Archive or Lockdown date',
    AuditFileReportDate     int                  null,
    AuditFileSignoffBy      varchar(128)         null,
    AuditFileSignoffDate    int                  null,
    AuditFileJurisdiction   varchar(12)          null comment 'au, uk, others',
    AuditFileLockDownPeriod smallint             null comment 'in days',
    AccountingStructure     varchar(24)          null,
    AccountingStructureList text                 null comment 'JSON list of available account charts',
    AccountingStructureId   int                  null,
    LastAPISyncDate         int                  null,
    dbctrltemplatetype      varchar(12)          null comment 'FK to dbcontroller.tblformtemplates.TemplateType',
    CompletionProgress      tinyint              null comment 'in percentage',
    StatusHistoryId         int                  null comment 'FK to latest status history for this auditfile in tblstatushistory',
    DeadlineDate            int                  null comment 'Unix timestamp for the auditfile''s deadline.',
    CurrencyLocale          varchar(12)          null comment 'fr_FR, en_US, it_IT',
    DisplayCurrency         tinyint(1)           null,
    Currency                varchar(3)           null comment 'USD, AUD, EUR, etc',
    Decimals                smallint             null comment 'Number of decimals',
    DecimalPoints           varchar(1)           null,
    ThousandsSep            varchar(1)           null,
    LastChangedNameDate     int                  null,
    PYAuditFileNumber       int                  null comment 'FK to tblauditfile.AuditFileNumber. This is the prior year audit file for this audit',
    organization_id         varchar(50)          null comment 'organization id from third party integration, against which TB is imported.',
    integration_type        varchar(50)          null comment 'third party integration name, against which TB is imported.',
    StatusImport            tinyint(1) default 0 null
)
    collate = utf8_unicode_ci;

create table tblauditfile_lang
(
    AuditFileNumber          int           not null,
    lang_code                varchar(12)   null,
    userid                   int           not null,
    accountingstructure_lang varchar(12)   null,
    use_content_lang         int default 1 null,
    constraint uniq_auditfile_lang
        unique (AuditFileNumber, lang_code, userid)
)
    collate = utf8_unicode_ci;

create table tblauditfile_lang_available
(
    AuditFileNumber int         not null,
    lang_code       varchar(12) not null,
    loaded          tinyint(1)  null,
    primary key (AuditFileNumber, lang_code)
)
    collate = utf8_unicode_ci;

create table tblauditfiledetailsmsf
(
    AuditFileNumber             int          not null comment 'for smsf auditfile details'
        primary key,
    FundName                    varchar(128) null,
    DateReceived                int          null,
    DateReviewPointsAvailable   int          null,
    NoPointsOutstanding         int          null,
    DateAdminResponsesAvailable int          null,
    DateAuditReportIssue        int          null,
    AuditReportType             varchar(64)  null,
    AuditorContraventionReport  tinyint(1)   null
)
    collate = utf8_unicode_ci;

create table tblauditfilefield
(
    FieldId         bigint auto_increment
        primary key,
    AuditFileNumber int          null,
    FormRef         varchar(24)  null,
    FieldName       varchar(128) null,
    FieldValue      text         null
)
    collate = utf8_unicode_ci;

create index INDEX_AFNUM_FORMREF
    on tblauditfilefield (AuditFileNumber, FormRef);

create table tblauditfilenotes
(
    AuditfileNoteId int auto_increment
        primary key,
    AuditFileNumber int  null comment 'FK to tblauditfile',
    CreatedByUserId int  null comment 'FK to tbluser',
    CreatedAtDate   int  null comment 'Unix timestamp',
    Content         text null comment 'Text content of audit file note'
)
    collate = utf8_unicode_ci;

create table tblauditfilesubfield
(
    FieldId        bigint auto_increment
        primary key,
    FieldName      varchar(255)  null,
    FieldValue     varchar(5120) null,
    FieldRowId     bigint        null,
    FieldGroupName varchar(255)  null
)
    collate = utf8_unicode_ci;

create index INDEX_FieldName
    on tblauditfilesubfield (FieldName(10));

create table tblauditfilesubrow
(
    FieldRowId      bigint auto_increment
        primary key,
    FieldGroupName  varchar(255) null comment 'audit coverage',
    AuditFileNumber int          null,
    FormRef         varchar(128) null comment 'AA11, AB1, AB2, etc...'
)
    collate = utf8_unicode_ci;

create index INDEX_AFNUM_FORMREF
    on tblauditfilesubrow (AuditFileNumber, FormRef);

create table tblauditstrategy
(
    AuditFileNumber                              int                          not null
        primary key,
    NatureHistoryOfBusiness                      text                         null,
    TypeOfEntity                                 enum ('Profit', 'NonProfit') null,
    CurrentFinancialPeriod                       varchar(11)                  null,
    IncorporationEstabilishmentDate              varchar(24)                  null,
    CommencementDate                             varchar(24)                  null,
    EntityLegalStructure                         text                         null,
    LargePropCompany25m                          tinyint(1)                   null,
    LargePropCompany12m                          tinyint(1)                   null,
    LargePropCompany50employees                  tinyint(1)                   null,
    CompanyLimitedBy                             enum ('Shares', 'Guarantee') null,
    ReportingEntity                              tinyint(1)                   null,
    FinancialReportLodgedWith                    text                         null,
    FinancialReportType                          enum ('GPFR', 'SPFR')        null,
    FinancialReportFramework                     text                         null comment 'AA1.2 Q1.12',
    FinanRepFrameworkAccountingEstimates         tinyint(1)                   null comment 'AA1.2 following Q1.12',
    FinanRepFrameworkPrescribeCondition          tinyint(1)                   null comment 'AA1.2 Q1.12(b)',
    FinanRepFrameworkPrescribeConditionComment   text                         null,
    FinanRepFrameworkCertainConditions           tinyint(1)                   null comment 'AA1.2 Q1.12(c)',
    FinanRepFrameworkCertainConditionsComment    text                         null,
    FinanRepFrameworkSpecifyDisclosure           tinyint(1)                   null comment 'AA1.2 Q1.12(d)',
    FinanRepFrameworkSpecifyDisclosureComment    text                         null,
    FinanRepFrameworkAccountingPolicies          tinyint(1)                   null comment 'AA1.2 Q1.12(e)',
    FinanRepFrameworkAccountingPoliciesComment   text                         null,
    FinanRepFrameworkRegulatory                  tinyint(1)                   null comment 'AA1.2 Q1.12(f)',
    FinanRepFrameworkRegulatoryComment           text                         null,
    FinanRepFrameworkgi                          varchar(1)                   null comment 'AA1.2 Q1.12(g) i - L(Low), M(Medium), H(High)',
    FinanRepFrameworkgii                         varchar(1)                   null comment 'AA1.2 Q1.12(g) ii',
    FinanRepFrameworkgiii                        varchar(1)                   null,
    FinanRepFrameworkgiv                         varchar(1)                   null,
    FinanRepFrameworkgv                          varchar(1)                   null,
    FinanRepFrameworkgvi                         varchar(1)                   null,
    FinanRepFrameworkOverallRisk                 varchar(1)                   null comment 'AA1.2 Q1.12(g) Overall Risk',
    FinanRepFrameworkhi                          varchar(1)                   null comment 'AA1.2 Q1.12(h) i',
    FinanRepFrameworkhii                         varchar(1)                   null comment 'AA1.2 Q1.12(h) ii',
    FinanRepFrameworkhiii                        varchar(1)                   null,
    FinanRepFrameworkhiv                         varchar(1)                   null,
    FinanRepFrameworkhv                          varchar(1)                   null,
    FinanRepFrameworkhComment                    text                         null comment 'AA1.2 Q1.12(h) Comment',
    IndustrySpecificReportingReq                 text                         null,
    ApplicableLegislationRegulation              text                         null,
    ControlledByForeignCompany                   tinyint(1)                   null,
    GroupStructureParentEntity                   text                         null,
    GroupStructureControlledEntities             text                         null,
    GroupStructureRelatedParties                 text                         null,
    ExpectedUseAuditEvidence                     text                         null,
    AASrequireSpecialConsideration               tinyint(1)                   null comment 'AA1.2 Q1.20',
    AASrequireSpecialConsiderationComment        text                         null comment 'AA1.2 Q1.20 Comment',
    PeriodEnd                                    varchar(128)                 null comment 'period end date',
    StatutoryReportingDeadline                   varchar(128)                 null comment 'statutory reporting date',
    AGMdate                                      varchar(11)                  null comment 'AGM Date',
    ClientDeadline                               varchar(11)                  null comment 'Client deadline date',
    SelfImposedDeadline                          varchar(11)                  null comment 'self imposed date',
    CommencementDateInterim                      varchar(11)                  null comment 'interim date',
    CommencementDateFinal                        varchar(11)                  null comment 'final date',
    KeyManagementPersonel                        text                         null,
    AuditCriticalEmployees                       text                         null,
    OverviewAccountingFunction                   text                         null,
    MaterialityQuantitativeNetIncome             varchar(128)                 null comment '--- DEPRECATED',
    MaterialityQuantitativeNetAssets             varchar(128)                 null comment '--- DEPRECATED',
    MaterialityQuantitativeLiabilities           varchar(128)                 null comment '--- DEPRECATED',
    MaterialityQuantitativeError                 varchar(128)                 null comment '--- DEPRECATED',
    MaterialityQuantitativeCurrentAssets         varchar(8)                   null comment 'AA1.2 Question3.1 Materiality',
    MaterialityQuantitativeNonCurrentAssets      varchar(8)                   null comment 'AA1.2 Question3.1 Materiality',
    MaterialityQuantitativeCurrentLiabilities    varchar(8)                   null comment 'AA1.2 Question3.1 Materiality',
    MaterialityQuantitativeNonCurrentLiabilities varchar(8)                   null comment 'AA1.2 Question3.1 Materiality',
    MaterialityQuantitativeIncome                varchar(8)                   null comment 'AA1.2 Question3.1 Materiality',
    MaterialityQuantitativeExpenses              varchar(8)                   null comment 'AA1.2 Question3.1 Materiality',
    MaterialityQuantitativeOther                 varchar(8)                   null comment 'AA1.2 Question3.1 Materiality',
    MaterialityQuanlitative                      text                         null,
    MaterialComponentsAccountBalances            text                         null comment '--- DEPRECATED',
    MaterialAssets                               varchar(256)                 null comment 'AA1.2 Q3.3(a)',
    MaterialLiabilities                          varchar(256)                 null comment 'AA1.2 Q3.3(b)',
    MaterialIncomeItems                          text                         null,
    MaterialExpenseItems                         text                         null,
    HighRiskAuditAreas                           text                         null,
    AuditClosingReport                           text                         null,
    PointsBroughtForward                         text                         null,
    ModifiedAuditReportYesNo                     tinyint(1)                   null,
    ModifiedAuditReport                          text                         null,
    ReportToRegulatorDetails                     varchar(255)                 null comment 'AA1.2 q3.10',
    ReportToRegulatorDate                        varchar(24)                  null comment 'AA1.2 q3.10',
    ContingentAssetsLiabilitiesYesNo             tinyint(1)                   null,
    ContingentAssetsLiabilities                  text                         null,
    EconomicDependencyYesNo                      tinyint(1)                   null,
    EconomicDependency                           text                         null,
    EventsAfterBalanceSheetDateYesNo             tinyint(1)                   null,
    EventsAfterBalanceSheetDate                  text                         null,
    SignificantAccountingBusinessDevelopment     text                         null,
    SignificantIndustryLegislativeDevelopment    text                         null,
    SignificantChangesFinancialReport            text                         null,
    OtherSignificantChanges                      text                         null,
    SignificantChangesMade                       tinyint(1)                   null comment 'AA1.2 Q4.1',
    SignificantChangesMadeComment                text                         null comment 'AA1.2 Q4.1 Comment'
)
    collate = utf8_unicode_ci;

create table tblchecklist
(
    ChecklistItemId      int auto_increment
        primary key,
    AuditFileNumber      int           null,
    RowId                int           null,
    Completed            varchar(255)  null,
    CompletedComment     varchar(1000) null,
    CompletedCommentDate varchar(24)   null comment 'Date string for amount field (section invoicing)',
    Reference            varchar(100)  null,
    Responsibility       varchar(30)   null,
    Initials             int           null,
    DateCompleted        int           null,
    Ranking              smallint      null,
    ItemEnabled          tinyint(1)    null
)
    collate = utf8_unicode_ci;

create table tblclassaccounts
(
    id              int auto_increment
        primary key,
    AuditFileNumber int          not null,
    FormRef         varchar(255) not null,
    description     varchar(255) not null
)
    charset = utf8;

create table tblclient
(
    ClientId                int auto_increment
        primary key,
    ClientName              varchar(255)                     null,
    AuditeeName             varchar(255)                     null,
    ClientDescription       text                             null,
    ABN                     varchar(64)                      null,
    ACN                     varchar(64)                      null,
    ASRN                    varchar(64)                      null,
    Phone1                  varchar(64)                      null,
    Phone2                  varchar(64)                      null,
    Fax                     varchar(64)                      null,
    Address                 varchar(255)                     null,
    Suburb                  varchar(255)                     null,
    State                   varchar(64)                      null,
    Pcode                   varchar(12)                      null,
    Country                 varchar(255)                     null,
    AddressPostal           varchar(255)                     null,
    SuburbPostal            varchar(255)                     null,
    StatePostal             varchar(64)                      null,
    PcodePostal             varchar(12)                      null,
    CountryPostal           varchar(255)                     null,
    PrimaryContactName      varchar(255)                     null,
    PrimaryEmail            varchar(255)                     null,
    ClientClientId          varchar(64)                      null,
    IncorporatedDate        int                              null,
    TradingCommencementDate int                              null,
    LastYearEndDate         int                              null,
    Address2                varchar(255)                     null comment 'e.g. Street Address',
    City                    varchar(255)                     null,
    Address2Postal          varchar(255)                     null comment 'e.g. Street Address',
    CityPostal              varchar(255)                     null,
    TFN                     varchar(32)                      null,
    Staff                   varchar(1024)                    null comment 'References to tbluser.UserId. Multiple references separated by pipes "|"',
    DefaultTemplate         varchar(256)                     null,
    ClientTags              varchar(1024)                    null comment 'Tags separated by a pipe character "|"',
    RegisteredNumber        varchar(1024)                    null,
    ClientType              varchar(256)                     null,
    SMSFTrusteeName1        varchar(256)                     null,
    SMSFTrusteeName2        varchar(256)                     null,
    SMSFTrusteeName3        varchar(256)                     null,
    SMSFTrusteeName4        varchar(256)                     null,
    SMSFFundMember1         varchar(256)                     null,
    SMSFFundMember2         varchar(256)                     null,
    SMSFFundMember3         varchar(256)                     null,
    SMSFFundMember4         varchar(256)                     null,
    TrustDeedDate           int                              null,
    Jurisdiction            varchar(255)                     null,
    DeedType                varchar(255)                     null,
    Trustee                 varchar(255)                     null,
    AdminComments           varchar(2048)                    null,
    GSTStatus               varchar(255)                     null,
    GSTRemittance           varchar(255)                     null,
    ClassSuperFundCode      varchar(64)                      null comment 'Fund code reference from Class Super',
    ClassSuperBrandCode     varchar(255)                     null,
    ClassSuperBusinessCode  varchar(255)                     null,
    SuperMateFundCode       varchar(64)                      null,
    SuperMateBusinessCode   varchar(255)                     null,
    BGLSimpleFund360UID     varchar(128)                     null,
    BGLSimpleFund360Code    varchar(128)                     null,
    LastImportDate          int                              null,
    Active                  tinyint(1) default 1             null comment 'True/false whether or not this client is active',
    LastChangedNameDate     int                              null,
    ClientSource            varchar(24)                      null comment 'eg. Class, BGL, IRIS, Forbes',
    AdministratorId         int                              null comment 'Default Administrator',
    TrusteeStructure        enum ('Individual', 'Corporate') null comment 'Client Trustee Structure - Individual or Corporate'
)
    collate = utf8_unicode_ci;

create table tblclientacceptancedoc
(
    AuditFileNumber       int                       not null,
    DocumentReference     varchar(12)               not null,
    DocumentReferenceName varchar(255)              not null,
    Completed             tinyint(1)                null,
    NotApplicable         tinyint(1)                null,
    StaffId               int                       null,
    StaffName             varchar(128)              null,
    DateCompleted         int                       null,
    DocumentStatus        enum ('sent', 'received') null,
    LetterTemplate        varchar(255)              null,
    LetterResponse        varchar(255)              null,
    primary key (AuditFileNumber, DocumentReferenceName)
)
    collate = utf8_unicode_ci;

create table tblclientacceptanceretention
(
    AuditFileNumber                  int        not null comment 'Audit file number dbtable mainly for AA1.1'
        primary key,
    PreviouslyAudited                tinyint(1) null,
    CurrentlyPerformedByOther        tinyint(1) null,
    ReasonForChangeAuditor           text       null,
    HowAwarePotentialClient          text       null,
    IntegrityOfClientComment         text       null,
    TypeOfLegalEntity                text       null,
    TypeOfBusiness                   text       null,
    ServicesExpectedToPerform        text       null,
    LegislationAgainsClient          text       null,
    SignificantDraft                 text       null,
    HaveNecessaryExpertise           tinyint(1) null comment 'AA1.1 question2.7',
    ExpertKnowledgeRequired          tinyint(1) null comment 'AA1.1 question2.8',
    UseExpertWork                    tinyint(1) null comment 'AA1.1 question2.9',
    CompetenceTimeResourceComment    text       null,
    CompetenceEthicalReqComment      text       null comment 'AA1.1 quesiton 3.4 comment',
    AlternativeLawComment            text       null comment 'AA1.1 quesiton 4.3 comment',
    PurposeOfFinancialReportComment  text       null comment 'AA1.1 quesiton 4.4 comment',
    IntendedUsersComment             text       null comment 'AA1.1 quesiton 4.5 comment',
    StepsManagementTakeComment       text       null comment 'AA1.1 quesiton 4.6 comment',
    FinancialReportUsedInPreparation tinyint(1) null comment 'AA1.1 Q4.1',
    PreconditionsMet                 tinyint(1) null comment 'AA1.1 Q4.2',
    AlternativeLawAuditedBool        tinyint(1) null comment 'AA1.1 Q4.3',
    AcceptDelineEngagement           tinyint(1) null
)
    collate = utf8_unicode_ci;

create table tblclientfields
(
    ClientFieldId int auto_increment
        primary key,
    ClientId      int          null,
    GroupKey      varchar(255) null,
    FieldKey      varchar(255) null,
    FieldValue    text         null
)
    collate = utf8_unicode_ci;

create table tblclientuser
(
    ClientId            int                  not null,
    UserId              int                  not null,
    DefaultNotification tinyint(1) default 0 null,
    primary key (ClientId, UserId)
)
    collate = utf8_unicode_ci;

create table tblcoa
(
    AccountTypeId      int                     not null,
    AccountCode        varchar(24)             not null,
    isCR               tinyint(1)   default 0  not null,
    AccountDescription varchar(255) default '' not null,
    DefaultSelected    tinyint(1)              null,
    primary key (AccountTypeId, AccountCode, isCR, AccountDescription)
)
    collate = utf8_unicode_ci;

create table tblcoa_lang
(
    AccountCode        varchar(24)             not null,
    isCR               tinyint(1)   default 0  not null,
    AccountDescription varchar(255) default '' not null,
    AccountTypeId      int                     not null,
    lang_code          varchar(12)             not null,
    primary key (AccountTypeId, AccountCode, isCR, AccountDescription, lang_code)
)
    collate = utf8_unicode_ci;

create table tblcustomfields
(
    CustomFieldId    int auto_increment
        primary key,
    CustomFieldName  varchar(1024) null,
    CustomFieldValue text          null,
    TargetTable      varchar(64)   null,
    TargetPKId       int           null
)
    collate = utf8_unicode_ci;

create table tblcustomiseranswers
(
    AnswerId            int auto_increment
        primary key,
    CustomiserSectionId int                            not null,
    AnswerText          varchar(128)                   not null,
    SourceId            int                            null,
    SourceType          varchar(12) default 'industry' null comment 'industry or firm'
)
    collate = utf8_unicode_ci;

create index idx_customiseranswer_custsectionid
    on tblcustomiseranswers (CustomiserSectionId);

create table tblcustomiserforms
(
    AuditFileNumber  int         not null,
    FormRef          varchar(14) not null,
    CustomiserStatus tinyint(1)  null,
    primary key (AuditFileNumber, FormRef)
)
    collate = utf8_unicode_ci;

create table tblcustomiserlinkage
(
    CustomiserSectionId int          not null,
    TargetType          varchar(16)  not null comment 'Form, ProcSection, ProcRow, CustSection',
    TargetRef           varchar(128) not null,
    TargetValue         varchar(24)  null comment 'Determine if linkage is enabled between customisersectionid and targetref mostly boolean',
    primary key (CustomiserSectionId, TargetType, TargetRef)
)
    collate = utf8_unicode_ci;

create table tblcustomiserlinks
(
    CustomiserSectionId int                  not null comment 'dbcontroller.tblcustomisersections.CustomiserSectionID',
    AnswerId            int                  not null,
    TargetType          varchar(16)          not null comment 'Folder, Form, ProcSection, ProRow',
    TargetRef           int                  not null,
    TargetValue         tinyint(1)           null comment 'usually boolean',
    ShowIcon            tinyint(1)           null comment 'show linkage icon value = 1',
    Linked              tinyint(1) default 1 null comment 'ignore this target ref when Linked = 0, as if they are not linked',
    primary key (CustomiserSectionId, AnswerId, TargetType, TargetRef)
)
    collate = utf8_unicode_ci;

create index idx_customiserlinks_TargetRefTargetType
    on tblcustomiserlinks (TargetRef, TargetType);

create table tblcustomiserquestions
(
    CustomiserSectionId int auto_increment
        primary key,
    AuditFileNumber     int                            null,
    Label               varchar(512)                   null,
    SectionGuidance     text                           null,
    SelectedAnswer      int                            null,
    ParentId            int                            null comment 'self::CustomiserSectionId',
    SectionOrder        int                            null,
    SectionHidden       tinyint(1)                     null comment 'Whether to display this question in the tailoring question modal box',
    SectionType         varchar(32) default 'planning' null comment 'Either planning or completion or discharge',
    ParentAnswerId      int                            null comment 'Parent Answer Id',
    SourceId            int                            null,
    SourceType          varchar(12) default 'industry' null comment 'industry or firm',
    CreatedDate         int                            null comment 'Date question is added',
    CreatedBy           varchar(255)                   null comment 'added by person name',
    LastAnswerUpdated   int                            null comment 'Timestamp when SelectedAnswer is updated'
)
    collate = utf8_unicode_ci;

create index Index_AuditFileNumber
    on tblcustomiserquestions (AuditFileNumber);

create table tblcustomisersections
(
    CustomiserSectionId int auto_increment
        primary key,
    AuditFileNumber     int               null,
    FormRef             varchar(14)       null,
    Label               varchar(128)      null,
    SelectedValue       tinyint(1)        null,
    ParentId            int     default 0 not null,
    SectionOrder        int               null,
    SectionHidden       tinyint(1)        null comment 'Whether to display this question in the tailoring question modal box',
    SectionBehaviour    tinyint default 1 not null comment '1=YES, 0=NO against SelectedValue; if NO, any values in CustomiserLinkage will be reversed'
)
    collate = utf8_unicode_ci;

create index idx_file_number
    on tblcustomisersections (AuditFileNumber);

create table tbldatafieldfiles
(
    datafieldfileId int auto_increment
        primary key,
    AuditFileNumber int                                 not null,
    indexRowId      int                                 not null,
    UploadFileId    int                                 not null,
    fileType        varchar(40)                         null,
    createdAt       timestamp default CURRENT_TIMESTAMP not null,
    updatedAt       timestamp                           null,
    createdByUserId int                                 null,
    updatedByUserId int                                 null
)
    charset = utf8;

create table tblfiledefinedname
(
    fileDefinedNameId int auto_increment
        primary key,
    datafieldFileId   int                                  not null,
    status            text                                 null,
    triggredBy        text                                 null,
    hideTriggerValues tinyint(1) default 0                 not null,
    triggredValue     text                                 null,
    inputDataField    text                                 null,
    outputDataField   text                                 null,
    appliedOn         timestamp                            null,
    createdAt         timestamp  default CURRENT_TIMESTAMP not null,
    updatedAt         timestamp                            null,
    createdByUserId   int                                  null,
    updatedByUserId   int                                  null
)
    charset = utf8;

create table tblfirmlabels
(
    LabelId    int auto_increment
        primary key,
    LabelName  varchar(64) null,
    LabelColor binary(6)   null comment 'Hex representation of color'
)
    collate = utf8_unicode_ci;

create table tblformdata
(
    FormDataID         double                     null,
    AuditFileNumber    double                     null,
    FormRef            varchar(36)                null,
    RowId              double                     not null
        primary key,
    Assertions         varchar(3072)              null,
    Completed          tinyint(1)                 null,
    StaffId            double                     null,
    StaffName          varchar(300)               null,
    DateCompleted      double                     null,
    Reference          varchar(300)               null,
    Regulations        varchar(64)                null comment 'ISA200, CA 18.3, etc',
    Comments           text                       null,
    Comments2          text                       null,
    Comments3          text                       null,
    YesNo              tinyint(1)                 null comment 'N/A: -1 Yes: 1 No: 0',
    DataRowId          int                        null,
    OnlyShowFor        tinyint(1)  default 1      null comment 'If a child of a question row, this determines when this row should display.',
    Procedures         varchar(12) default 'Perm' null comment 'Rows on section filtered by the procedures',
    indexRowIdForExcel int                        null,
    ExcelWorkpaper     int                        null
)
    collate = utf8_unicode_ci;

create index INDEX_AFNUM_FORMREF
    on tblformdata (AuditFileNumber, FormRef);

create index INDX_RowId
    on tblformdata (RowId);

create table tblformdata_lang
(
    RowId     int         not null,
    lang_code varchar(12) not null,
    Comments  text        null,
    Comments2 text        null,
    Comments3 text        null,
    primary key (RowId, lang_code)
)
    collate = utf8_unicode_ci;

create table tblformdatarow
(
    DataRowId           int auto_increment
        primary key,
    DataSectionId       int                  not null,
    RowName             mediumtext           null,
    Description         mediumtext           null,
    Assertion           varchar(64)          null,
    DefaultFormRef      varchar(64)          null,
    Recordable          tinyint(1) default 1 null,
    RowRank             smallint             null,
    Ref1                varchar(50)          null,
    Number1             varchar(50)          null,
    Ref2                varchar(50)          null,
    Number2             varchar(50)          null,
    VersionNumber       varchar(8)           null comment 'version number',
    dbctrlrowid         int                  null comment 'from dbcontroller',
    dbctrlrowtype       varchar(24)          null comment 'tblformcontentrow.RowType',
    ParentId            int                  null comment 'tblformdatarow.DataRowId for subprocedures',
    procedureComponents mediumtext           null,
    Level               tinyint              null
)
    collate = utf8_unicode_ci;

create index IDX_PARENTID
    on tblformdatarow (ParentId);

create index IDX_SECTIONID
    on tblformdatarow (DataSectionId);

create table tblformdatarow_lang
(
    DataRowId   int         not null,
    lang_code   varchar(12) not null,
    RowName     mediumtext  null,
    Description mediumtext  null,
    primary key (DataRowId, lang_code)
)
    collate = utf8_unicode_ci;

create table tblformdatasection
(
    DataSectionId       int auto_increment comment 'Form Data Section'
        primary key,
    AuditFileNumber     int                  null,
    FormRef             varchar(16)          null,
    Title               varchar(255)         null,
    SubTitle            text                 null,
    FormId              int                  null,
    SectionRank         smallint             null,
    VersionNumber       varchar(8)           null,
    dbctrlsectionid     int                  null,
    dbctrlsectiontype   varchar(61)          not null,
    SectionDefaultVal   varchar(12)          null comment 'disabled or enabled',
    SectionComment      mediumtext           null,
    SectionTag          varchar(128)         null comment 'custom tag for audit plan approach table',
    ParentId            int                  null comment 'parent section id',
    Reference           varchar(128)         null comment 'Section FormRef or LSsum FormRef',
    DisplayTitle        tinyint(1) default 1 null comment 'Whether or not to show the section title in frontend rendering',
    sectionSettings     text                 null,
    procedureComponents text                 null,
    ButtonDetail        text                 null
)
    collate = utf8_unicode_ci;

create index INDEX_AFNUM_FORMREF
    on tblformdatasection (AuditFileNumber, FormRef);

create index idx_auditfilenumber
    on tblformdatasection (AuditFileNumber, Title(3));

create index idx_dbctrl_sectionid
    on tblformdatasection (dbctrlsectionid);

create table tblformdatasection_lang
(
    DataSectionId  int          not null,
    lang_code      varchar(12)  not null,
    Title          varchar(255) null,
    SubTitle       text         null,
    SectionComment mediumtext   null,
    primary key (DataSectionId, lang_code)
)
    collate = utf8_unicode_ci;

create table tblhashcoderecord
(
    id          int unsigned auto_increment
        primary key,
    userId      int          not null,
    username    varchar(128) not null,
    hashcode    varchar(500) null,
    hashtype    varchar(255) null,
    activatedAt int          null,
    createdAt   int          null,
    deletedAt   int          null
)
    collate = utf8_unicode_ci;

create index idx_hashcode
    on tblhashcoderecord (hashcode(255));

create table tblimportsdata
(
    ImportsDataId            int auto_increment
        primary key,
    AuditFileNumber          int          null,
    FileAccountCode          varchar(24)  null,
    FileAccountName          varchar(255) null,
    AuditflowAccountSection  varchar(127) null comment 'Income, Expenses, Interest Expense, Income Tax Expense, Current Assets, Non-Current Assets, Current-Liabilities, Non-Current Liabilities, Equity',
    AuditflowAccountName     varchar(255) null,
    LeadSchedule             varchar(8)   null,
    DebitBalance             varchar(64)  null,
    CreditBalance            varchar(64)  null,
    Balance                  varchar(64)  null,
    Ignored                  tinyint(1)   null,
    PYDebitBalance           varchar(64)  null,
    PYCreditBalance          varchar(64)  null,
    PYBalance                varchar(64)  null,
    Units                    varchar(64)  null,
    CurrentYTDBalance        varchar(32)  null,
    CurrentYTDDebitBalance   varchar(32)  null,
    CurrentYTDCreditBalance  varchar(32)  null,
    PriorYTDBalance          varchar(32)  null,
    PriorYTDDebitBalance     varchar(32)  null,
    PriorYTDCreditBalance    varchar(32)  null,
    PriorPeriodBalance       varchar(32)  null,
    PriorPeriodDebitBalance  varchar(32)  null,
    PriorPeriodCreditBalance varchar(32)  null
)
    collate = utf8_unicode_ci;

create table tblinternalfiles
(
    FileId          int unsigned auto_increment comment 'Auto incremented primary key for table'
        primary key,
    FileName        text                                null comment 'File name',
    FilePath        text                                null comment 'Path where file is stored',
    FileType        varchar(128)                        null comment 'Type of file',
    FileMeta        json                                null comment 'Any meta for file goes here',
    CreatedByUserId int                                 not null comment 'Created by user id',
    UpdatedByUserId int                                 null comment 'Deleted by user id',
    RecordStatus    int       default 1                 null comment 'RecordStatus 1 will be active 0 will be inactive 2 will be deleted',
    CreatedAt       timestamp default CURRENT_TIMESTAMP null comment 'Creation Datetime of the record',
    UpdatedAt       timestamp                           null comment 'Updated Datetime of the record'
)
    collate = utf8_unicode_ci;

create table tblkeydocs
(
    id       int auto_increment
        primary key,
    FormRef  varchar(12) default 'NULL' not null comment 'Reference to a form in tblworkingpaperindex',
    position int                        not null comment 'Determines the order that the key completion documents will be displayed in.',
    UserId   int                        null
)
    collate = utf8_unicode_ci;

create table tblleadschedulesummary
(
    LeadScheduleRowId   int auto_increment
        primary key,
    AuditFileNumber     int          null,
    LeadScheduleFormRef varchar(16)  null,
    FormName            varchar(255) null comment 'i.e. CASH AND CASH EQUIVALENTS (if LeadScheduleFormRef == H1)',
    Current             tinyint(1)   null comment 'Current = 1 Non-Current = 0',
    TotalFinal          varchar(32)  null,
    TotalAdjustment     varchar(32)  null,
    TotalInitial        varchar(32)  null,
    TotalInterim        varchar(32)  null comment 'not displayed on LeadSchedule but used for ratio in AC3',
    TotalPreviousYear   varchar(32)  null
)
    collate = utf8_unicode_ci;

create index INDEX_AFNUM
    on tblleadschedulesummary (AuditFileNumber);

create table tblnotification
(
    NotificationId   int unsigned auto_increment comment 'Auto incremented primary key for table'
        primary key,
    NotificationText text                                null comment 'Notification text that will be displayed',
    CreatedByUserId  int                                 not null comment 'Created by user id',
    UpdatedByUserId  int                                 null comment 'Deleted by user id',
    RecordStatus     int       default 1                 null comment 'RecordStatus 1 will be active 0 will be inactive 2 will be deleted',
    CreatedAt        timestamp default CURRENT_TIMESTAMP null comment 'Creation Datetime of the record',
    UpdatedAt        timestamp                           null comment 'Updated Datetime of the record'
)
    collate = utf8_unicode_ci;

create table tblpdfstamppresets
(
    preset_id      int auto_increment
        primary key,
    stamp_text     varchar(255) null,
    username_check tinyint(1)   null,
    date_check     tinyint(1)   null,
    time_check     tinyint(1)   null,
    stamp_color    varchar(255) null,
    user_id        int          null
)
    collate = utf8_unicode_ci;

create table tblpermission
(
    FeatureGroupName varchar(16) null comment 'FK to tblpermissionfeature',
    UserRoleId       int         null comment 'FK to tbluserrole',
    BitwiseAccess    int         null,
    constraint UNIQUE_Feature_RoledId
        unique (FeatureGroupName, UserRoleId)
)
    collate = utf8_unicode_ci;

create table tblpermissionfeature
(
    FeatureId             int auto_increment
        primary key,
    FeatureGroupNameShort varchar(16)          null comment 'STI on FeatureNameShort',
    FeatureName           varchar(64)          null,
    FeatureNameShort      varchar(16)          null comment 'Programmer-friendly version of FeatureName',
    FeatureDesc           varchar(256)         null,
    BitwiseValue          smallint unsigned    null,
    CanOverride           tinyint(1) default 0 not null comment 'Determines whether feature is overridable by a specific resource in the tblpermissionoverride table'
)
    collate = utf8_unicode_ci;

create table tblpermissionsoverride
(
    PermissionOverrideId int auto_increment
        primary key,
    FeatureGroupName     varchar(64)       null comment 'FK to tblpermissionfeature.FeatureGroupNameShort',
    UserId               int               null comment 'FK to tbluser.UserId',
    TableName            varchar(64)       null comment 'Reference to the table this permission is for',
    ColumnName           varchar(64)       not null comment 'Reference to the column this permission is for',
    ColumnValue          int               null comment 'Reference to the value of the column defined in ColumnName',
    BitwiseAccess        smallint unsigned null
)
    collate = utf8_unicode_ci;

create index Index_UserId
    on tblpermissionsoverride (UserId);

create table tblpreauditfile
(
    PreAuditFileNumber int auto_increment
        primary key,
    ClientId           int          null comment 'FK to tblclient',
    AuditPeriodDate    int          null comment 'Unix timestamp for audit period date',
    AuditPeriod        varchar(128) null comment 'Year end, half year, interim, etc',
    CreatedDate        int          null comment 'UNIX timestamp for when preauditfile was first created',
    AuditFileNumber    int          null comment 'FK to the audit file created as a result of this preauditfile',
    TemplateType       varchar(12)  null,
    TemplateId         int          null,
    dbctrltemplatetype varchar(12)  null,
    constraint ClientId
        unique (ClientId, AuditPeriodDate)
)
    collate = utf8_unicode_ci;

create table tblprofile
(
    id               int auto_increment
        primary key,
    UserId           int                  not null comment 'Foreign key to tbluser',
    DisplayName      varchar(255)         null comment 'A friendlier name for the user to display on the site in places where displaying their full name would not be necessary.',
    LandingPage      varchar(1024)        null comment 'The default page the user should see when logging in',
    Avatar           varchar(1024)        null comment 'Absolute file path for the uploaded avatar image',
    Language         varchar(128)         null comment 'Language code per language config file',
    HideDashboardMsg tinyint(1) default 0 null
)
    collate = utf8_unicode_ci;

create table tblrecentfiles
(
    id                int auto_increment
        primary key,
    UserId            int not null,
    AuditFileNumber   int not null,
    LastAccessed      int not null,
    Progress          int null,
    ProgressCompleted int null
)
    collate = utf8_unicode_ci;

create index INDEX_USERID_AFNUM
    on tblrecentfiles (UserId, AuditFileNumber);

create table tblsaasucontact
(
    UserId                      int          not null
        primary key,
    saasu_contactUid            int          null,
    saasu_contactLastUpdatedUid varchar(128) null,
    DateUpdated                 int          null
)
    collate = utf8_unicode_ci;

create table tblsavedfilters
(
    FilterId   int auto_increment
        primary key,
    FilterName varchar(256)         null comment 'User defined name of filter',
    FilterType varchar(64)          null comment 'The type of filter this is (e.g. "workflow_manager", "client_list", "review_points")',
    UserId     int                  null comment 'FK to tbluser - determines the owner of the filter',
    IsDefault  tinyint(1) default 0 not null,
    FilterJSON text                 null comment 'JSON encoded dump of the filter'
)
    collate = utf8_unicode_ci;

create table tblscheduleitem
(
    ScheduleItemId     int auto_increment
        primary key,
    ScheduleItemName   varchar(128) null,
    ScheduleItemDesc   text         null comment 'Intentionally allow long strings so that users can communicate through descriptions until we build comments',
    ScheduleItemStatus varchar(128) null,
    StartDateTime      datetime     null,
    EndDateTime        datetime     null,
    OwnerUserId        int          null,
    TableName          varchar(64)  null,
    ColumnName         varchar(64)  null,
    ColumnValue        varchar(128) null,
    Labels             varchar(32)  null
)
    collate = utf8_unicode_ci;

create table tblscheduleitemusers
(
    ScheduleItemId int null,
    UserId         int null
)
    collate = utf8_unicode_ci;

create table tblsessions
(
    session_id    varchar(40)  not null
        primary key,
    ip_address    varchar(16)  not null,
    user_agent    varchar(50)  null,
    last_activity int unsigned not null,
    user_data     text         null
)
    collate = utf8_unicode_ci;

create table tblsettings
(
    SettingName        varchar(255) not null
        primary key,
    SettingValue       varchar(255) null,
    SettingDescription text         null
)
    collate = utf8_unicode_ci;

create table tblsmsfmembers
(
    MemberId           int auto_increment
        primary key,
    ClientId           int                          not null comment 'FK to tblclient',
    MemberType         varchar(11) default 'member' null comment 'An SMSF member can be a plain member or a trustee',
    Salutation         varchar(128)                 null,
    FirstName          varchar(128)                 null,
    MiddleName         varchar(128)                 null,
    LastName           varchar(128)                 null,
    Gender             enum ('M', 'F')              null,
    AustralianResident tinyint(1)                   null,
    BirthDate          int                          null comment 'UTC Unix timestamp',
    ESPStartDate       int                          null comment 'UTC Unix timestamp',
    FundJoinDate       int                          null comment 'UTC Unix timestamp',
    EffectiveDate      int                          null comment 'UTC Unix timestamp',
    AddressStreet      varchar(255)                 null,
    AddressSuburb      varchar(255)                 null,
    AddressState       varchar(255)                 null,
    AddressPostcode    varchar(12)                  null,
    TransitionType     varchar(255)                 null,
    PensionAccountName varchar(255)                 null,
    PensionProductType varchar(255)                 null,
    PensionStartDate   int                          null comment 'UTC Unix timestamp',
    ClassSuperFundCode varchar(255)                 null,
    SuperMateFundCode  varchar(255)                 null,
    IsChairperson      tinyint(1)  default 0        null comment 'Whether this trustee is the chairperson in a corporate structured fund',
    TFN                varchar(32)                  null
)
    collate = utf8_unicode_ci;

create index INDEX_ClientId
    on tblsmsfmembers (ClientId);

create table tblstatuses
(
    StatusId            int auto_increment
        primary key,
    StatusTitle         varchar(512)              null,
    FullDesc            text                      null,
    StatusOrder         int                       null,
    ParentId            int                       null,
    TriggerNotification tinyint(1) default 0      null comment 'True/False whether to prompt user to send notifications once this step is reached',
    TemplateId          int                       null comment 'FK to templateId from either firm template (tblauditfile) or industry template (dbcontroller.tblformtemplates)',
    TemplateType        enum ('firm', 'industry') null comment 'The template type of the template defined in `TemplateId`',
    AuditFileNumber     int        default 0      null
)
    collate = utf8_unicode_ci;

create index TemplateIdx
    on tblstatuses (TemplateId, TemplateType);

create table tblstatushistory
(
    StatusHistoryId   int auto_increment
        primary key,
    AuditFileNumber   int           null comment 'FK to tblauditfile',
    DateUpdated       int           null comment 'Unix timestamp',
    StaffId           int           null comment 'FK to tbluser for staff that created this update',
    StatusId          int           null comment 'FK to tblstatuses',
    StatusTitleCached varchar(512)  null comment 'Cached title from tblstatuses',
    OptionalMessage   varchar(2048) null comment 'Optional text message input by the user to explain a status change'
)
    collate = utf8_unicode_ci;

create table tbltickmarks
(
    TickmarkId          int auto_increment
        primary key,
    TickmarkSymbol      varchar(8)           null,
    TickmarkDescription varchar(512)         null,
    IsHidden            tinyint(1) default 0 not null,
    IsTemplate          tinyint(1) default 0 null comment 'If this is a template it cannot be modified by the user',
    TickmarkColour      varchar(7)           null comment 'RGB hex for this tickmark''s colour',
    TickmarkTags        varchar(128)         null comment 'Pipe separated list of the the template types (i.e. smsf, pa, audit, etc) this tickmark should be displayed for',
    ParentId            int                  null comment 'Self referential parent ID',
    isSMSF              tinyint(1)           null
)
    collate = utf8_unicode_ci;

create table tbltimesheetitem
(
    TimesheetItemId   int auto_increment
        primary key,
    TimesheetItemName varchar(128)   null,
    TimesheetItemDesc text           null,
    ParentId          int            null,
    StartDateTime     datetime       null,
    EndDateTime       datetime       null,
    NumberOfUnits     int default -1 not null comment 'If -1 it means that the number of units is to be automatically calculated',
    IsBillable        tinyint(1)     null,
    UserId            int            null,
    Labels            varchar(32)    null,
    TableName         varchar(64)    null,
    ColumnName        varchar(64)    null,
    ColumnValue       varchar(128)   null
)
    collate = utf8_unicode_ci;

create table tbluser
(
    UserId               int auto_increment
        primary key,
    Username             varchar(128)         null,
    LastLogin            int                  null,
    UserEmail            varchar(255)         null,
    UserPwd              mediumtext           null,
    UserType             varchar(128)         null,
    UserRoleId           int                  null comment 'FK to tbluserrole',
    CreateAudit          tinyint(1)           null,
    PurchaseVoucher      tinyint(1)           null,
    Activated            int                  null comment 'UNIX Timestamp of when user was last activated',
    AgreeTC              int                  null comment 'The time of the user agree Terms and Conditions',
    ClientId             int                  null comment 'if UserType == ''client'', save ClientId to retrieve Audit Files',
    SendEmail            tinyint(1) default 1 null,
    Signature            mediumtext           null,
    SMEAccess            tinyint(1)           null comment 'SME Access Allowed',
    SMSFAccess           tinyint(1)           null comment 'SMSF Access Allowed',
    Description          varchar(255)         null,
    phone                varchar(48)          null,
    fax                  varchar(48)          null,
    Salesforce_contactId varchar(36)          null comment 'Salesforce contactId',
    SessionIpRestriction tinyint(1) default 1 null comment 'Whether the session is restricted by ip_address for added security'' AFTER `Salesforce_contactId',
    Office365account     tinyint(1)           null,
    constraint Username
        unique (Username)
)
    collate = utf8_unicode_ci;

create table tbluserdetails
(
    UserDetailsId       int auto_increment
        primary key,
    UserId              int                               not null,
    FirstName           varchar(255)                      null,
    LastName            varchar(255)                      null,
    timezone            varchar(32)                       null,
    DateFormatShort     varchar(24) default 'dd-MMM-yyyy' null,
    DateFormatLong      varchar(24) default 'd MMMM yyyy' null,
    CsvColumnSeparator  varchar(2)  default ','           null,
    CsvDecimalSeparator varchar(1)  default '.'           null
)
    collate = utf8_unicode_ci;

create table tblusergroups
(
    GroupCode         varchar(24)  not null
        primary key,
    GroupName         varchar(128) null,
    GroupCreationDate int          null
)
    collate = utf8_unicode_ci;

create table tblusergroupsusers
(
    GroupCode       varchar(24)  not null,
    UserId          int          not null,
    VoucherCode     varchar(128) null,
    AuditFileNumber int          null,
    primary key (GroupCode, UserId)
)
    collate = utf8_unicode_ci;

create table tbluserrole
(
    UserRoleId   int auto_increment
        primary key,
    UserRoleName varchar(64)  null,
    UserRoleDesc varchar(256) null,
    UserType     varchar(64)  null comment 'Reference to old method of specifying user roles on tbluser.UserType',
    Position     int          null comment 'Used for ordering',
    Customizable tinyint(1)   null comment 'Determines whether this role can be changed by a user'
)
    collate = utf8_unicode_ci;

create table tblusertwofa
(
    UserId                       int                         null comment 'Belongs to tblUser',
    UserEmailAddress             varchar(255)                null comment 'User''s 2FA email. If this empty, we will use user''s email from tblUser instead',
    UserMobilePhoneNumber        varchar(20)                 null comment 'User''s mobile phone number. Leading zero.',
    UserMobilePhoneCountryCode   varchar(3)                  null comment 'User''s mobile phone country code - ''au'', ''id'', ''us'' so on',
    UserMobilePhoneCountryNumber varchar(3)                  null comment 'User''s mobile phone country code number - 61, 62, 2, so on',
    UserLanguageOption           varchar(10) default 'en-au' null comment 'User''s language option for 2FA verification - ''en'', ''id'' so on. This will overwrite Nexmo request as well as email template translation. Default is ''en''',
    UserVerificationMethod       varchar(10) default 'email' null
)
    comment 'Contains users Two Factor Authentication settings' collate = utf8_unicode_ci;

create table tblusertwofadevices
(
    UserId                  int         null comment 'Belongs to tblUser',
    UserDeviceToken         varchar(50) null comment 'Generated device token per browser. So users can have multiple tokens for multiple browsers',
    UserDeviceTokenLifetime varchar(50) null
)
    comment 'Contains users device token ID.' collate = utf8_unicode_ci;

create table tblversionhistory
(
    VersionHistoryId   int auto_increment comment 'Id'
        primary key,
    CurrentDbVersion   varchar(12) null comment 'Current Database Version',
    LastDbVersion      varchar(12) null comment 'Before Database Update Version',
    CurrentCodeVersion varchar(12) null comment 'Current Code Version',
    LastCodeVersion    varchar(12) null comment 'Before Code Update Version',
    ActionType         varchar(30) null comment 'Record Action Types',
    ActionDate         datetime    null comment 'Record Datetime of the Action as sql datetime',
    ActionDateNum      int         null comment 'Record Datetime of the Action as number'
)
    comment 'Record Version Changes History' collate = utf8_unicode_ci;

create table tblvoucherorders
(
    OrderNumber          int auto_increment
        primary key,
    OrderDate            int                          null,
    OrderTotal           varchar(24)                  null comment 'Total amount for this voucherorder',
    OrderItem            varchar(255)                 null comment 'Name of the item ordered (i.e. 5 vouchers)',
    OrderByStaffId       int                          null,
    OrderByStaffName     varchar(255)                 null,
    OrderByPaypalAccount varchar(255)                 null comment 'Paypal account the order was placed',
    cc_Last4Digit        int                          null comment 'Last 4 digits of the credit card',
    cc_expiryMonth       int                          null comment 'credit card expiry date month',
    cc_expiryYear        int                          null comment 'credit card expiry date year',
    OrderStatus          enum ('pending', 'complete') null,
    OrderComment         mediumtext                   null,
    OrderReceipt         varchar(255)                 null comment 'IPN txn_id - Receipt number for the payment when successfull - OrderNumber & OrderDate',
    Paypal_payer_id      varchar(24)                  null comment 'payer_id from Paypal',
    Paypal_ipn_track_id  varchar(64)                  null comment 'ipn_track_if from Paypal',
    CurrencyCode         char(3)                      null comment 'AUD, USD, GBP',
    Received             tinyint(1)                   null comment 'Received/Cleared',
    ReceivedByStaffId    int                          null comment 'Received/Cleared',
    ReceivedByStaffName  varchar(255)                 null comment 'Received/Cleared',
    ReceivedByDate       int                          null comment 'Received/Cleared'
)
    collate = utf8_unicode_ci;

create table tblvoucherordersitems
(
    voiId             int auto_increment
        primary key,
    voiCode           varchar(15) null comment 'item code',
    voiName           varchar(64) null comment 'name description of the item',
    voiQuantity       int         null comment 'Item quantity',
    voiPrice          varchar(15) null comment 'Unit price',
    voiTotal          varchar(24) null comment 'voiQuantity x voiPrice',
    voiVoucherOrderId int         null comment 'FK tblvoucherorder'
)
    collate = utf8_unicode_ci;

create table tblvouchers
(
    VoucherCode          varchar(255) not null
        primary key,
    PurchaseDate         int          null,
    PurchaseByStaffId    int          null,
    PurchaseByStaffName  varchar(255) null,
    Activated            tinyint(1)   null,
    ActivatedDate        int          null,
    ActivatedByStaffId   int          null,
    ActivatedByStaffName varchar(255) null,
    AuditFileNumber      int          null comment 'Audit file number in use',
    ClientName           varchar(255) null,
    ExpiryDate           int          null,
    OrderNumber          int          null comment 'Order number from tblVoucherOrders, where this voucher has been purchased in what order number',
    hidden               tinyint(1)   null,
    trial                tinyint(1)   null comment '1 = trial voucher',
    VoucherType          varchar(24)  null comment 'SME, SMSF, SMEcloud, SMSFcloud'
)
    collate = utf8_unicode_ci;


