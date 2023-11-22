SELECT "APIGUID", "API", "OwnerEmailAddress", "DateExpires", "PermissionCreate", "PermissionGlobalAdmin", "IsDisabled", "IsDeleted"
	FROM "kershner"."API";
	
SELECT "CacheGUID", "CacheKey", "CacheValue", "IsDeleted"
	FROM "kershner"."Cache";
	
SELECT "CacheMetadataGUID", "CacheGUID", "FileMetadataGUID", "OutputFormatGUID", "ExpirationTimestamp"
	FROM "kershner"."CacheMetadata";

SELECT "OutputFormatGuid", "Name", "Description", "FunctionName", "FileExtension", "FileMIMEType"
	FROM "kershner"."DataOutputFormat";
	
SELECT "APIGUID", "FileMetaDataGUID", "Name", "Description", "DateUploaded", "DateModified", "Revision", "IsCurrent", "IsDeleted", "FileGuid", "InputFormatGuid", "FileHash", "FileCacheExpiration"
	FROM "kershner"."FileMetadata";
	
SELECT "fileGuid", "fileContents"
	FROM "kershner"."InputFile";
	
SELECT "InputFormatGuid", "Name", "Description", "FileExtension", "FileMIMEType"
	FROM "kershner"."InputFileFormat";
	
SELECT "AuthorizationGUID", "APIGUID", "FileMetaDataGUID", "PermissionCreate", "PermissionRead", "PermissionUpdate", "PermissionDelete"
	FROM "kershner"."IsAuthorizedTo";

SELECT "SearchGUID", "Name", "Description"
	FROM "kershner"."Search";


SELECT API."OwnerEmailAddress", API."DateExpires", API."PermissionCreate", API."PermissionGlobalAdmin", API."IsDisabled", API."IsDeleted",
CMD.CacheMetadataGUID,CMD.ExpirationTimestamp, CAC."CacheKey", CAC."CacheValue", CAC."IsDeleted", FMD."FileMetaDataGUID", FMD."Name", FMD."Description", FMD."DateUploaded", 
FMD."DateModified", FMD."Revision", FMD."IsCurrent", FMD."IsDeleted", FMD."FileGuid", FMD."InputFormatGuid", FMD."FileHash", FMD."FileCacheExpiration", 
DOF."Name", DOF."Description", DOF."FunctionName", DOF."FileExtension", DOF."FileMIMEType"
	FROM 
	"kershner"."API" AS API,
	"kershner"."CacheMetadata" AS CMD,
	"kershner"."Cache" AS CAC,
	"kershner"."FileMetadata" as FMD,
	"kershner"."DataOutputFormat" as DOF
where 
	CMD.CacheGUID = CAC.CacheGUID AND 
	CMD.FileMetadataGUID = FMD.FileMetaDataGUID AND 
	CMD.OutputFormatGUID = DOF.OutputFormatGuid AND 
	FMD.APIGUID = API.APIGUID;


INSERT INTO "kershner"."API"(
	"APIGUID", "API", "OwnerEmailAddress", "DateExpires", "PermissionCreate", "PermissionGlobalAdmin", "IsDisabled", "IsDeleted")
	VALUES (gen_random_uuid(), gen_random_uuid(), 'joel.kershner@ku.edu','01-01-3000', true, true, false, false);


SELECT "APIGUID", "API", "OwnerEmailAddress", "DateExpires", "PermissionCreate", "PermissionGlobalAdmin", "IsDisabled", "IsDeleted"
	FROM "kershner"."API" where "OwnerEmailAddress"='joel.kershner@ku.edu';

SELECT 
API."OwnerEmailAddress", API."DateExpires", API."PermissionCreate", API."PermissionGlobalAdmin", API."IsDisabled", API."IsDeleted", 
FMD."Name", FMD."Description", FMD."DateUploaded", FMD."DateModified", FMD."Revision", FMD."IsCurrent", FMD."IsDeleted", 
FMD."InputFormatGuid", FMD."FileHash", FMD."FileCacheExpiration", 
IFF."Name", IFF.Description, IFF.FileExtension, IFF.FileMIMEType
	FROM 
	"kershner"."API" AS API,
	"kershner"."FileMetadata" as FMD,
	"kershner"."InputFile" as FG,
	"kershner"."InputFileFormat" as IFF
where 
	FMD.FileGuid=FG.fileGuid AND 
	FMD.InputFormatGuid=IFF.InputFormatGuid AND 
	FMD.APIGUID = API.APIGUID AND
	API.API=?;

UPDATE "kershner"."IsAuthorizedTo"
	SET "APIGUID"=?, "FileMetaDataGUID"=?, "PermissionCreate"=?, "PermissionRead"=?, "PermissionUpdate"=?, "PermissionDelete"=?
	WHERE AuthorizationGUID=?;
	

	
