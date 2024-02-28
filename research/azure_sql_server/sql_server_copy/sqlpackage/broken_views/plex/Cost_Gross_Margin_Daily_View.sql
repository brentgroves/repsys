create view Plex.Cost_Gross_Margin_Daily_View
as
    with
        all_po
        as
        (
            select gm.*
            --select count(*)
            from Plex.Cost_Gross_Margin_View gm
        ),
        --select * from all_po 
        --where valid !=0
        part_aggregate
        as
        (
            select ap.pcn, ap.Plexus_Customer_Code, ap.report_date, ap.Part_No, ap.revision,
                sum(ap.sales_qty) shipped,
                sum(ap.sales_qty*ap.unit_price) total_sales, -- see validation tab of daily_metrics validation spreadsheet.
                sum(ap.sales_qty*ap.unit_price) --total_sales,  -- see validation tab of daily_metrics validation spreadsheet.
	/
	sum(ap.sales_qty) -- shipped,
	sell_price,
                count(distinct Unit_Price) price_count,
                count(*) po_count,
                min(Unit_Price) min_price,
                max(Unit_Price) max_price,
                max(ap.valid) max_valid
            -- most important issue.
            from all_po ap
            group by ap.pcn,ap.Plexus_Customer_Code,ap.report_date,ap.Part_No,ap.revision

        ),
        -- select * from part_aggregate 
        price_diff
        as
        (
            select *
            --select count(*) 
            from part_aggregate
            where max_price - min_price > .01
        ),
        -- select * from price_diff 
        --select count(*) 
        --from price_diff 
        po_price_diff
        as
        (
            select
                ap.*
            from all_po ap
                inner join price_diff pd
                on ap.pcn = pd.pcn
                    and ap.report_date = pd.report_date
                    and ap.part_no = pd.part_no
                    and ap.revision = pd.revision

        ),
        -- select * from po_price_diff 
        price_list
        as
        (
            select main.pcn, main.Plexus_Customer_Code, main.report_date, main.part_no, main.revision,
                left(main.price_list,len(main.price_list)-1) as price_list
            from
                (
	
		select distinct pd2.pcn, pd2.Plexus_Customer_Code, pd2.report_date, pd2.part_no, pd2.revision,
                    (
				select
                        case 
				when pd1.po_no = '' and pd1.unit_price is null then 'no-po/no-price;'
				when pd1.po_no = '' and pd1.unit_price is not null then 'no-po/' + cast(pd1.unit_price as varchar) + ';'
				when pd1.po_no != '' and pd1.unit_price is null then pd1.po_no + '/no-price;'
				else pd1.po_no + '/' + cast(pd1.unit_price as varchar) + ';'
				end as [text()]
                    from po_price_diff pd1
                    where pd1.pcn = pd2.pcn
                        and pd1.report_date = pd2.report_date
                        and pd1.part_no = pd2.part_no
                        and pd1.revision = pd2.revision
                    order by pd1.pcn,pd1.report_date,pd1.part_no,pd1.revision
                    for xml path (''), type 
			).value('text()[1]','varchar(max)') [price_list]
                from po_price_diff pd2 
	) [main]
        )
    -- select * from price_list 
    select pa.pcn, pa.plexus_customer_code, pa.report_date, pa.part_no, pa.revision,
        shipped,
        sell_price,
        total_sales,
        case 
when pl.price_list is null then ''
else pl.price_list 
end price_list,
        pa.max_valid valid
    from part_aggregate pa
        left outer join price_list pl
        on pa.pcn = pl.pcn
            and pa.report_date = pl.report_date
            and pa.part_no = pl.part_no
            and pa.revision = pl.revision;
