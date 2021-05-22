SET enable_result_cache_for_session TO OFF;
SELECT to_char(date(eventtime), 'MM/DD/YYYY') as date,
       pageurl_full_url                       as "evar 1",
       referrerurl_full_url                   as "evar 2",
       count(*)                               as "event 1",
       count(distinct udo_tealium_session_id) as "event 2",
       count(distinct udo_tealium_visitor_id) as "event 3"
FROM events__all_events
WHERE eventtime >= '2020-12-25'
  AND eventtime < '2020-12-28'
GROUP BY date, pageurl_full_url, referrerurl_full_url
ORDER BY date, "event 1" desc;

SELECT to_char(eventtime, 'MM/DD/YYYY')       as date,
       pageurl_full_url                       as "evar 1",
       referrerurl_full_url                   as "evar 2",
       count(*)                               as "event 1",
       count(distinct udo_tealium_session_id) as "event 2",
       count(distinct udo_tealium_visitor_id) as "event 3"
FROM events__all_events
WHERE eventtime >= '2020-12-01'
  AND eventtime < '2020-12-02'
GROUP BY date, pageurl_full_url, referrerurl_full_url
ORDER BY date, "event 1" desc limit 10;

select eventid
from events__all_events limit 10;

SELECT e.eventid,
       e.eventtime,
       e.pageurl_full_url,
       e.referrerurl_full_url,
       e.udo_tealium_session_id,
       e.udo_tealium_visitor_id
FROM events__all_events e
WHERE eventtime >= '2020-12-27'
  AND eventtime < '2020-12-28';

select max(e.eventtime)
from events__all_events e
