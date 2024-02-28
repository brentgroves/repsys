create view Plex.price_list
as
    with
        all_po
        as
        (
            select pcn, Plexus_Customer_Code, report_date, Part_No, revision, sell_price, gm.PO_No
            from Plex.Cost_Gross_Margin_Daily_View gm
        ),
        --select * from all_po 
        part_aggregate
        as
        (
            select ap.pcn, ap.Plexus_Customer_Code, ap.report_date, ap.Part_No, ap.revision,
                count(distinct Unit_Price) price_count,
                count(*) po_count,
                min(Unit_Price) min_price,
                max(Unit_Price) max_price
            from all_po ap
            group by ap.pcn,ap.Plexus_Customer_Code,ap.report_date,ap.Part_No,ap.revision

        ),
        price_diff
        as
        (
            select *
            --select count(*) 
            from part_aggregate
            where max_price - min_price > .01
        ),
        --select *
        --select count(*) 
        --from price_diff 
        po_price_diff
        as
        (
            select ap.*
            from all_po ap
                inner join price_diff pd
                on ap.pcn = pd.pcn
                    and ap.report_date = pd.report_date
                    and ap.part_no = pd.part_no
                    and ap.revision = pd.revision

        ),
        /*
			select 
			case 
			when pd1.po_no = '' and pd1.unit_price is null then 'no-po/no-price;'
			when pd1.po_no = '' and pd1.unit_price is not null then 'no-po/' + cast(pd1.unit_price as varchar) + ';'
			when pd1.po_no != '' and pd1.unit_price is null then pd1.po_no + '/no-price;'
			else pd1.po_no + '/' + cast(pd1.unit_price as varchar) + ';'
			end as [text()]
			from po_price_diff pd1 
*/
        /*
	select distinct pd2.pcn,pd2.report_date,pd2.part_no,pd2.revision 
	from po_price_diff pd2 	
*/
        /*
	select 
		(
			select 
			case 
			when pd1.po_no = '' then 'no-po,'
			else pd1.po_no + ',' 
			end as [text()]
			from po_price_diff pd1 
			order by pd1.pcn,pd1.report_date,pd1.part_no,pd1.revision 
			for xml path (''), type 
		).value('text()[1]','varchar(max)') [prices]
*/
        price_list
        as
        (
            select main.Plexus_Customer_Code, main.report_date, main.part_no, main.revision,
                left(main.prices,len(main.prices)-1) as prices
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
			).value('text()[1]','varchar(max)') [prices]
                from po_price_diff pd2 
	) [main]
        )
    select *
    from price_list;
