/* Azure friendly */
/* Drop all Foreign Key constraints */
DECLARE
    @name VARCHAR(128) DECLARE @constraint VARCHAR(254) DECLARE @SQL VARCHAR(254)
    SELECT
        @name = (
            SELECT
                TOP 1 TABLE_NAME
            FROM
                INFORMATION_SCHEMA.TABLE_CONSTRAINTS
            WHERE
                constraint_catalog=DB_NAME()
                AND CONSTRAINT_TYPE = 'FOREIGN KEY'
            ORDER BY
                TABLE_NAME
        ) WHILE @name is not null BEGIN
        SELECT
            @constraint = (
                SELECT
                    TOP 1 CONSTRAINT_NAME
                FROM
                    INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                WHERE
                    constraint_catalog=DB_NAME()
                    AND CONSTRAINT_TYPE = 'FOREIGN KEY'
                    AND TABLE_NAME = @name
                ORDER BY
                    CONSTRAINT_NAME
            ) WHILE @constraint IS NOT NULL BEGIN
            SELECT
                @SQL = 'ALTER TABLE [dbo].[' + RTRIM(@name) +'] DROP CONSTRAINT [' + RTRIM(@constraint) +']' EXEC (@SQL) PRINT 'Dropped FK Constraint: ' + @constraint + ' on ' + @name
                SELECT
                    @constraint = (
                        SELECT
                            TOP 1 CONSTRAINT_NAME
                        FROM
                            INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                        WHERE
                            constraint_catalog=DB_NAME()
                            AND CONSTRAINT_TYPE = 'FOREIGN KEY'
                            AND CONSTRAINT_NAME <> @constraint
                            AND TABLE_NAME = @name
                        ORDER BY
                            CONSTRAINT_NAME
                    ) END
                    SELECT
                        @name = (
                            SELECT
                                TOP 1 TABLE_NAME
                            FROM
                                INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                            WHERE
                                constraint_catalog=DB_NAME()
                                AND CONSTRAINT_TYPE = 'FOREIGN KEY'
                            ORDER BY
                                TABLE_NAME
                        ) END GO
 /* Drop all Primary Key constraints */ DECLARE @name VARCHAR(128) DECLARE @constraint VARCHAR(254) DECLARE @SQL VARCHAR(254)
                        SELECT
                            @name = (
                                SELECT
                                    TOP 1 TABLE_NAME
                                FROM
                                    INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                                WHERE
                                    constraint_catalog=DB_NAME()
                                    AND CONSTRAINT_TYPE = 'PRIMARY KEY'
                                ORDER BY
                                    TABLE_NAME
                            ) WHILE @name IS NOT NULL BEGIN
                            SELECT
                                @constraint = (
                                    SELECT
                                        TOP 1 CONSTRAINT_NAME
                                    FROM
                                        INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                                    WHERE
                                        constraint_catalog=DB_NAME()
                                        AND CONSTRAINT_TYPE = 'PRIMARY KEY'
                                        AND TABLE_NAME = @name
                                    ORDER BY
                                        CONSTRAINT_NAME
                                ) WHILE @constraint is not null BEGIN
                                SELECT
                                    @SQL = 'ALTER TABLE [dbo].[' + RTRIM(@name) +'] DROP CONSTRAINT [' + RTRIM(@constraint)+']' EXEC (@SQL) PRINT 'Dropped PK Constraint: ' + @constraint + ' on ' + @name
                                    SELECT
                                        @constraint = (
                                            SELECT
                                                TOP 1 CONSTRAINT_NAME
                                            FROM
                                                INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                                            WHERE
                                                constraint_catalog=DB_NAME()
                                                AND CONSTRAINT_TYPE = 'PRIMARY KEY'
                                                AND CONSTRAINT_NAME <> @constraint
                                                AND TABLE_NAME = @name
                                            ORDER BY
                                                CONSTRAINT_NAME
                                        ) END
                                        SELECT
                                            @name = (
                                                SELECT
                                                    TOP 1 TABLE_NAME
                                                FROM
                                                    INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                                                WHERE
                                                    constraint_catalog=DB_NAME()
                                                    AND CONSTRAINT_TYPE = 'PRIMARY KEY'
                                                ORDER BY
                                                    TABLE_NAME
                                            ) END GO
 /* Drop All Views */ while(exists(
                                                select
                                                    1
                                                from
                                                    INFORMATION_SCHEMA.VIEWS
                                                where
                                                    TABLE_NAME != 'database_firewall_rules'
                                                    AND TABLE_NAME NOT IN (
                                                        select
                                                            name
                                                        from
                                                            sys.external_tables
                                                    )
                                            )) begin declare @sql1 nvarchar(2000)
                                            SELECT
                                                TOP 1 @sql1=('DROP VIEW ' + TABLE_SCHEMA + '.[' + TABLE_NAME + ']')
                                            FROM
                                                INFORMATION_SCHEMA.VIEWS
                                            WHERE
                                                TABLE_NAME != 'database_firewall_rules'
                                                AND TABLE_NAME NOT IN (
                                                    select
                                                        name
                                                    from
                                                        sys.external_tables
                                                ) exec (@sql1) PRINT @sql1 end
 /* Drop all tables */ DECLARE @name VARCHAR(128) DECLARE @SQL VARCHAR(254)
                                                SELECT
                                                    @name = (
                                                        SELECT
                                                            TOP 1 [name]
                                                        FROM
                                                            sysobjects
                                                        WHERE
                                                            [type] = 'U'
                                                            AND category = 0
                                                        ORDER BY
                                                            [name]
                                                    ))