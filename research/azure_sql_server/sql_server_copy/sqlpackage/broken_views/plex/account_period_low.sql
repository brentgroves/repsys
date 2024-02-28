-- Plex.account_period_low source

create view Plex.account_period_low
(
    pcn,
    account_key,
    account_no,
    period,
    next_period
)
as
    WITH
        fiscal_period(pcn, year, period)
        as
        (
            select pcn, year(begin_date) year, period
            from Plex.accounting_period
            where pcn = 123681
        ),
        --select * from fiscal_period
        max_fiscal_period(pcn, year, max_fiscal_period)
        as
        (
            SELECT pcn, year, max(period) max_fiscal_period
            FROM fiscal_period
            group by pcn,year
        ),
        anchor_member(pcn, account_key, account_no, period, next_period)
        as
        (
            select
                a.pcn,
                a.account_key,
                a.account_no,
                a.start_period period,
                case 
		    when a.start_period < m.max_fiscal_period then a.start_period+1
		    else ((a.start_period/100 + 1)*100) + 1 
		    end next_period
            --m.max_fiscal_period

            --select count(*) cnt
            --select *
            from Plex.accounting_account a -- low: 398 * 10 = 3,980 /// all: 4,362 X 10 = 43,620
                join Plex.max_fiscal_period m
                on a.pcn=m.pcn
                    and (a.start_period/100) = m.[year]

            where a.pcn = 123681
                --and a.start_period = 0  -- 1,323 accounts do not have any balance snapshot records in Plex 
                and a.low_account =1 -- 661
                and a.start_period != 0
            -- 398
            --	and a.account_no = '10220-000-00000'
            --	and left(a.account_no,1) < '4' 
            --	and account_no = '10000-000-00000'	
        ),
        --select count(*) from anchor_member  -- 398
        --	account_period_low (pcn,account_key,account_no,period,next_period,max_fiscal_period,max_fiscal_next_period)
        --	account_period_low (pcn,account_key,account_no,period,next_period,max_fiscal_period)
        account_period_low (pcn, account_key, account_no, period, next_period)
        AS
        (
            -- Add max_fiscal_next_period to Anchor member
                            select
                    a.pcn,
                    a.account_key,
                    a.account_no,
                    a.period,
                    a.next_period
                --	    a.max_fiscal_period,
                --    m.max_fiscal_period max_fiscal_next_period
                --select count(*) cnt
                --select *
                from anchor_member a
                -- low: 398 * 10 = 3,980 /// all: 4,362 X 10 = 43,620
                --		join max_fiscal_period m 
                --      on a.pcn=m.pcn
                --       and (a.next_period/100) = m.[year]
            UNION ALL
                -- Recursive member that references expression_name.
                select
                    p.pcn,
                    p.account_key,
                    p.account_no,
                    -- create a record for this account with the next period
                    case 
	    when p.period < m.max_fiscal_period then p.period+1
	   -- when p.period%100 < 12 then p.period+1
	    else ((p.period/100 + 1)*100) + 1 
	    end period,
                    case 
	    when p.next_period < n.max_fiscal_period then p.next_period+1
	    else ((p.next_period/100 + 1)*100) + 1 
	    end next_period
                --m.max_fiscal_period,
                --n.max_fiscal_period max_fiscal_next_period
                from account_period_low p
                    join Plex.max_fiscal_period m
                    on p.pcn=m.pcn
                        and (p.period/100) = m.[year]
                    join max_fiscal_period n
                    on p.pcn=n.pcn
                        and (p.next_period/100) = n.[year]
                where p.period < 202111
            -- where p.period < 202110
        )
    --	select count(*) from account_period_low -- low:37,970 
    select *
    from account_period_low --where period =201013;