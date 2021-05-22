-- Update Audio Recordings with Roles/Permissions/ etc
Use AudioRecordings
GO

select *
from Language
where LDSCode in (267, 268)
update Language
SET Alpha2 = 'yu',
    Alpha3 = 'zho'
WHERE LDSCode = 267
update Language
SET Alpha2 = 'cm',
    Alpha3 = 'zho'
WHERE LDSCode = 268

UPDATE Role
SET LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 267)
WHERE LanguageId = 999

INSERT INTO Role (LanguageId, Name)
VALUES ((SELECT LanguageId FROM Language WHERE LDSCode = 267), 'Admin')
INSERT INTO Role (LanguageId, Name)
VALUES ((SELECT LanguageId FROM Language WHERE LDSCode = 267), 'Voice Talent')
INSERT INTO Role (LanguageId, Name)
VALUES ((SELECT LanguageId FROM Language WHERE LDSCode = 267), 'Reviewer')
INSERT INTO Role (LanguageId, Name)
VALUES ((SELECT LanguageId FROM Language WHERE LDSCode = 268), 'Admin')
INSERT INTO Role (LanguageId, Name)
VALUES ((SELECT LanguageId FROM Language WHERE LDSCode = 268), 'Voice Talent')
INSERT INTO Role (LanguageId, Name)
VALUES ((SELECT LanguageId FROM Language WHERE LDSCode = 268), 'Reviewer')

insert into RolePermission (RoleId, PermissionId)
VALUES ((SELECT RoleId
         FROM Role
         WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 267) AND Name = 'Admin'), 1)
insert into RolePermission (RoleId, PermissionId)
VALUES ((SELECT RoleId
         FROM Role
         WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 267) AND Name = 'Admin'), 2)
insert into RolePermission (RoleId, PermissionId)
VALUES ((SELECT RoleId
         FROM Role
         WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 267) AND Name = 'Admin'), 3)
insert into RolePermission (RoleId, PermissionId)
VALUES ((SELECT RoleId
         FROM Role
         WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 267) AND Name = 'Admin'), 4)
insert into RolePermission (RoleId, PermissionId)
VALUES ((SELECT RoleId
         FROM Role
         WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 267) AND Name = 'Admin'), 5)
insert into RolePermission (RoleId, PermissionId)
VALUES ((SELECT RoleId
         FROM Role
         WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 267) AND Name = 'Admin'), 6)
insert into RolePermission (RoleId, PermissionId)
VALUES ((SELECT RoleId
         FROM Role
         WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 267) AND Name = 'Admin'), 7)
insert into RolePermission (RoleId, PermissionId)
VALUES ((SELECT RoleId
         FROM Role
         WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 267) AND Name = 'Admin'), 8)
insert into RolePermission (RoleId, PermissionId)
VALUES ((SELECT RoleId
         FROM Role
         WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 267) AND Name = 'Admin'), 9)
insert into RolePermission (RoleId, PermissionId)
VALUES ((SELECT RoleId
         FROM Role
         WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 268) AND Name = 'Admin'), 1)
insert into RolePermission (RoleId, PermissionId)
VALUES ((SELECT RoleId
         FROM Role
         WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 268) AND Name = 'Admin'), 2)
insert into RolePermission (RoleId, PermissionId)
VALUES ((SELECT RoleId
         FROM Role
         WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 268) AND Name = 'Admin'), 3)
insert into RolePermission (RoleId, PermissionId)
VALUES ((SELECT RoleId
         FROM Role
         WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 268) AND Name = 'Admin'), 4)
insert into RolePermission (RoleId, PermissionId)
VALUES ((SELECT RoleId
         FROM Role
         WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 268) AND Name = 'Admin'), 5)
insert into RolePermission (RoleId, PermissionId)
VALUES ((SELECT RoleId
         FROM Role
         WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 268) AND Name = 'Admin'), 6)
insert into RolePermission (RoleId, PermissionId)
VALUES ((SELECT RoleId
         FROM Role
         WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 268) AND Name = 'Admin'), 7)
insert into RolePermission (RoleId, PermissionId)
VALUES ((SELECT RoleId
         FROM Role
         WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 268) AND Name = 'Admin'), 8)
insert into RolePermission (RoleId, PermissionId)
VALUES ((SELECT RoleId
         FROM Role
         WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 268) AND Name = 'Admin'), 9)

insert into RolePermission (RoleId, PermissionId)
VALUES ((SELECT RoleId
         FROM Role
         WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 267) AND Name = 'Voice Talent'), 1)
insert into RolePermission (RoleId, PermissionId)
VALUES ((SELECT RoleId
         FROM Role
         WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 268) AND Name = 'Voice Talent'), 1)

insert into RolePermission (RoleId, PermissionId)
VALUES ((SELECT RoleId
         FROM Role
         WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 267) AND Name = 'Reviewer'), 2)
insert into RolePermission (RoleId, PermissionId)
VALUES ((SELECT RoleId
         FROM Role
         WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 268) AND Name = 'Reviewer'), 2)

INSERT INTO UserRole(UserId, RoleId)
VALUES ((SELECT UserId from [User] WHERE UserName = 'MorrisDR'), (SELECT RoleId
                                                                  FROM Role
                                                                  WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 267)
                                                                    AND Name = 'Admin'))
INSERT INTO UserRole(UserId, RoleId)
VALUES ((SELECT UserId from [User] WHERE UserName = 'MorrisDR'), (SELECT RoleId
                                                                  FROM Role
                                                                  WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 268)
                                                                    AND Name = 'Admin'))
INSERT INTO UserRole(UserId, RoleId)
VALUES ((SELECT UserId from [User] WHERE UserName = 'andrewmhall'), (SELECT RoleId
                                                                     FROM Role
                                                                     WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 267)
                                                                       AND Name = 'Admin'))
INSERT INTO UserRole(UserId, RoleId)
VALUES ((SELECT UserId from [User] WHERE UserName = 'andrewmhall'), (SELECT RoleId
                                                                     FROM Role
                                                                     WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 268)
                                                                       AND Name = 'Admin'))
INSERT INTO UserRole(UserId, RoleId)
VALUES ((SELECT UserId from [User] WHERE UserName = 'jharrys'), (SELECT RoleId
                                                                 FROM Role
                                                                 WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 267)
                                                                   AND Name = 'Admin'))
INSERT INTO UserRole(UserId, RoleId)
VALUES ((SELECT UserId from [User] WHERE UserName = 'jharrys'), (SELECT RoleId
                                                                 FROM Role
                                                                 WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 268)
                                                                   AND Name = 'Admin'))
INSERT INTO UserRole(UserId, RoleId)
VALUES ((SELECT UserId from [User] WHERE UserName = 'whiteri'), (SELECT RoleId
                                                                 FROM Role
                                                                 WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 267)
                                                                   AND Name = 'Admin'))
INSERT INTO UserRole(UserId, RoleId)
VALUES ((SELECT UserId from [User] WHERE UserName = 'whiteri'), (SELECT RoleId
                                                                 FROM Role
                                                                 WHERE LanguageId = (SELECT LanguageId FROM Language WHERE LDSCode = 268)
                                                                   AND Name = 'Admin'))

