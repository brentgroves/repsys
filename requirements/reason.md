# Reason

Why do we need a report system besides the one that comes standard with Plex?

- long running SPROCS time-out so complex queries on large data sets are not possible.
- Queries run against a snap shot of the database which can be several hours old so live reporting is not possible.
- Reports based on data from multiple datasources such as MSC tooling vending machine and Plex.
