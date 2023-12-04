# Query Making by Example

## A Step-by-Step Approach

- What do we want to know? How many hours of vacation each person took from Jan 1 to Oct 31, 2023.

## References

- Plex SDE
- Plex view summary screen

## Query Making Process

- Open Plex on test server.
- Create a SPROC in the Plex SDE to use in reviewing Plex views for the report, time_off_review_plex_views.sql.
- Locate a Plex screen(s) that closely resembles the report being created and note it in time_off_review_plex_views.sql as Plex validation screens.
- From the Plex screen(s) view data sources and take note of Plex views you might need.
- If needed use the Plex screens to create some test data to better familiarize yourself with whatever part of the database your are working on.
- Review Plex views you think you need becoming familiar with their data and how they are used in the **[time_off_review_plex_views.sql SPROC](../time_off/Scripts/time_off_review_data_sources.sql)**.
- Describe the **[records](../time_off/Scripts/time_off_records.md)** you want on the report in detail.
- Create the **[final key set](../time_off/Scripts/time_off_final_key_set.sql)** for the report in a CTE view chain in the time_off_final_key_set.sql SPROC. Only include primary keys or keys necessary to join to other Plex views. The fields used to display on the report will be added during the very last step in the process.  This will make for a faster query and help you focus the task at hand and not the final result.
- List a description of the columns needed on each record of the final key set.
- Describe what aggregate values you wish to calculate and display along with each record in the final key set
- Move the final key set CTE view chain into a new Plex SDE SPROC called **[time_off_hours_aggregate.sql](../time_off/Scripts/time_off_hours_aggregate.sql)**.
- Calculate the needed aggregate values in more views appended to the final key set view chain. Again only add the primary keys and any necessary fields that you must in order to calculate the aggregate function(s).
- Once all the aggregate values have been calculated write the final select statement by joining final key set view to each aggregate value view.
- Join the final select statement to each Plex view needed to display the fields desired on the final set.
- Validate a subset of the records against Plex view(s).
