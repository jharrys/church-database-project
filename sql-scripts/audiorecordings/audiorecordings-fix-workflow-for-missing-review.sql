-- audio structure for russian bom
WITH TempTable (AudioStructureId, ParentId, Name, AssetId, level) AS (
    SELECT AudioStructureId, ParentId, Name, AssetId, 0 AS level
    FROM AudioStructure
    WHERE AudioStructureId = 763558
    UNION ALL
    SELECT aus.AudioStructureId, aus.ParentId, aus.Name, aus.AssetId, TempTable.level + 1 AS level
    FROM AudioStructure aus
             INNER JOIN TempTable ON TempTable.AudioStructureId = aus.ParentId
)
SELECT ar.AudioRecordingId, TempTable.AudioStructureId, ParentId, Name, AssetId, level
FROM TempTable
         LEFT JOIN AudioRecording ar
                   ON TempTable.AudioStructureId = ar.AudioStructureId
ORDER BY AudioStructureId;

-- audioreviewid's 2 change
WITH TempTable (AudioStructureId, ParentId, Name, AssetId, level) AS (
    SELECT AudioStructureId, ParentId, Name, AssetId, 0 AS level
    FROM AudioStructure
    WHERE AudioStructureId = 763558
    UNION ALL
    SELECT aus.AudioStructureId, aus.ParentId, aus.Name, aus.AssetId, TempTable.level + 1 as level
    FROM AudioStructure aus
             INNER JOIN TempTable ON TempTable.AudioStructureId = aus.ParentId
)
SELECT NewEvent.AudioRecordingId
FROM (
         SELECT Latest.AudioRecordingId
         FROM (
                  SELECT t.AudioRecordingId, MAX(CreatedUtc) as c
                  FROM (
                           SELECT ar.AudioRecordingId, TempTable.AudioStructureId, ParentId, Name, AssetId, level
                           FROM TempTable
                                    INNER JOIN AudioRecording ar ON TempTable.AudioStructureId = ar.AudioStructureId
                       ) AS t
                           INNER JOIN AudioRecordingEvent ev ON t.AudioRecordingId = ev.AudioRecordingId
                  GROUP BY t.AudioRecordingId
              ) AS Latest
                  INNER JOIN AudioRecordingEvent evv
                             ON evv.AudioRecordingId = Latest.AudioRecordingId AND evv.CreatedUtc = Latest.c AND
                                evv.Type = 'Approved' AND evv.AudioReviewNum != 2
     ) AS NewEvent
         INNER JOIN AudioReview rev ON NewEvent.AudioRecordingId = rev.AudioRecordingId AND rev.ReviewerId = 263 AND
                                       rev.Status = 'Pending';

-- audioevents 2 add
WITH TempTable (AudioStructureId, ParentId, Name, AssetId, level) AS (
    SELECT AudioStructureId, ParentId, Name, AssetId, 0 AS level
    FROM AudioStructure
    WHERE AudioStructureId = 763558
    UNION ALL
    SELECT aus.AudioStructureId, aus.ParentId, aus.Name, aus.AssetId, TempTable.level + 1 as level
    FROM AudioStructure aus
             INNER JOIN TempTable ON TempTable.AudioStructureId = aus.ParentId
)
SELECT Latest.AudioRecordingId
FROM (
         SELECT NewEvent.AudioRecordingId, MAX(CreatedUtc) as MaxCreated
         FROM (
                  SELECT ar.AudioRecordingId, TempTable.AudioStructureId, ParentId, Name, AssetId, level
                  FROM TempTable
                           INNER JOIN AudioRecording ar ON TempTable.AudioStructureId = ar.AudioStructureId
              ) AS NewEvent
                  INNER JOIN AudioRecordingEvent ev ON NewEvent.AudioRecordingId = ev.AudioRecordingId
         GROUP BY NewEvent.AudioRecordingId
     ) AS Latest
         INNER JOIN AudioRecordingEvent evv
                    ON evv.AudioRecordingId = Latest.AudioRecordingId AND evv.CreatedUtc = Latest.MaxCreated AND
                       evv.Type = 'Approved' AND evv.AudioReviewNum != 2;

-- insert missing audiorecordingevents by root 762448
WITH TempTable (AudioStructureId, ParentId, Name, AssetId, level) AS (
    SELECT AudioStructureId, ParentId, Name, AssetId, 0 AS level
    FROM AudioStructure
    WHERE AudioStructureId = 763558
    UNION ALL
    SELECT aus.AudioStructureId, aus.ParentId, aus.Name, aus.AssetId, TempTable.level + 1 as level
    FROM AudioStructure aus
             INNER JOIN TempTable ON TempTable.AudioStructureId = aus.ParentId
)
INSERT
INTO AudioRecordingEvent(AudioRecordingId, AudioReviewNum, Type, CreatedUtc, CreatedById)
SELECT evv.AudioRecordingId, 2, 'InReview', '2021-05-03 00:00:00.00', 261
FROM (
         SELECT ev.AudioRecordingId, MAX(CreatedUtc) as MaxCreated
         FROM (
                  SELECT ar.AudioRecordingId, TempTable.AudioStructureId, ParentId, Name, AssetId, level
                  FROM TempTable
                           INNER JOIN AudioRecording ar ON TempTable.AudioStructureId = ar.AudioStructureId
              ) AS NewEvent
                  INNER JOIN AudioRecordingEvent ev ON NewEvent.AudioRecordingId = ev.AudioRecordingId
         GROUP BY ev.AudioRecordingId
     ) AS Latest
         INNER JOIN AudioRecordingEvent evv
                    ON evv.AudioRecordingId = Latest.AudioRecordingId AND evv.CreatedUtc = Latest.MaxCreated AND
                       evv.Type = 'Approved' AND evv.AudioReviewNum != 2;

-- update 2nd reviewer pending 2 approved by root 762448
WITH TempTable (AudioStructureId, ParentId, Name, AssetId, level) AS (
    SELECT AudioStructureId, ParentId, Name, AssetId, 0 AS level
    FROM AudioStructure
    WHERE AudioStructureId = 763558
    UNION ALL
    SELECT aus.AudioStructureId, aus.ParentId, aus.Name, aus.AssetId, TempTable.level + 1 as level
    FROM AudioStructure aus
             INNER JOIN TempTable ON TempTable.AudioStructureId = aus.ParentId
)
UPDATE AudioReview
SET AudioReview.Status='InReview'
FROM (
         SELECT Latest.AudioRecordingId
         FROM (
                  SELECT NewEvent.AudioRecordingId, MAX(CreatedUtc) as MaxCreated
                  FROM (
                           SELECT ar.AudioRecordingId, TempTable.AudioStructureId, ParentId, Name, AssetId, level
                           FROM TempTable
                                    INNER JOIN AudioRecording ar ON TempTable.AudioStructureId = ar.AudioStructureId
                       ) AS NewEvent
                           INNER JOIN AudioRecordingEvent ev ON NewEvent.AudioRecordingId = ev.AudioRecordingId
                  GROUP BY NewEvent.AudioRecordingId
              ) AS Latest
                  INNER JOIN AudioRecordingEvent evv
                             ON evv.AudioRecordingId = Latest.AudioRecordingId AND
                                evv.CreatedUtc = '2021-05-03 00:00:00.00' AND
                                evv.Type = 'InReview' AND evv.AudioReviewNum = 2
     ) as j
         INNER JOIN AudioReview rev ON rev.AudioRecordingId = j.AudioRecordingId AND ReviewerId = 263
WHERE AudioReviewId = rev.AudioReviewId;
