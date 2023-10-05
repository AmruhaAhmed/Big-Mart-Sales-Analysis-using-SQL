-- checking the number of rows in the bigmart table
select count(*) from bigmart;
--100

-- checking the different types of values present in Item_Fat_Content column
select distinct Item_Fat_Content from bigmart;
-- Low Fat
-- Regular
-- low fat
-- LF
-- reg

-- since LF,Low Fat, low fat  are the same , rg and regular are the same hence we are updating the values in the table
update bigmart set Item_Fat_Content='low fat' where Item_Fat_Content='LF' or Item_Fat_Content='Low Fat';

-- since reg and Regular mean the same hence we are updating the values in the table
update bigmart set Item_Fat_Content='regular' where Item_Fat_Content='reg' or Item_Fat_Content='Regular';

-- checking if changes have been implemented or not
select distinct Item_Fat_Content from bigmart;
-- low fat
-- regular

--checking the count of various Item_Type in descending order
select count(*),Item_Type from bigmart group by Item_Type order by count(Item_Type) desc;
-- 21|Snack Foods
-- 13|Fruits and Vegetables
-- 11|Frozen Foods
-- 9|Dairy
-- 8|Canned
-- 7|Household
-- 7|Health and Hygiene
-- 6|Soft Drinks
-- 6|Baking Goods
-- 5|Meat
-- 3|Hard Drinks
-- 2|Breakfast
-- 1|Starchy Foods
-- 1|Breads

-- checking if there are any null values in Outlet_Size attribute or not
select count(*),Outlet_Size from bigmart group by Outlet_Size;
-- 25|
-- 10|High
-- 35|Medium
-- 30|Small

-- as we can observe from the above result, there are 25 NULL values in Outlet_Size. Since Medium size outlet is the most popular type, we replace NULL values with Medium in Outlet_Size
update bigmart set Outlet_Size='Medium' where Outlet_Size is NULL;

-- checking if the updates have been reflected or not
select count(*),Outlet_Size from bigmart group by Outlet_Size;
-- 10|High
-- 60|Medium
-- 30|Small

-- checking if Item_Weight attribute has any NULL values or not
select * from bigmart where Item_Weight is NULL;
-- FDP10||low fat|0.127469857|Snack Foods|107.7622|OUT027|1985|Medium|Tier 3|Supermarket Type3|4022.7636
-- DRI11||low fat|0.034237682|Hard Drinks|113.2834|OUT027|1985|Medium|Tier 3|Supermarket Type3|2303.668
-- FDW12||regular|0.035399923|Baking Goods|144.5444|OUT027|1985|Medium|Tier 3|Supermarket Type3|4064.0432
-- FDC37||low fat|0.057556998|Baking Goods|107.6938|OUT019|1985|Small|Tier 1|Grocery Store|214.3876
-- FDC14||regular|0.072221801|Canned|43.6454|OUT019|1985|Small|Tier 1|Grocery Store|125.8362
-- FDV20||regular|0.059511812|Fruits and Vegetables|128.0678|OUT027|1985|Medium|Tier 3|Supermarket Type3|2797.6916
-- FDX10||regular|0.123111453|Snack Foods|36.9874|OUT027|1985|Medium|Tier 3|Supermarket Type3|388.1614
-- FDB34||low fat|0.026480954|Snack Foods|87.6198|OUT027|1985|Medium|Tier 3|Supermarket Type3|2180.495
-- FDS02||regular|0.255394896|Dairy|196.8794|OUT019|1985|Small|Tier 1|Grocery Store|780.3176
-- FDI26||low fat|0.061082177|Canned|180.0344|OUT019|1985|Small|Tier 1|Grocery Store|892.172
-- FDF09||low fat|0.012090074|Fruits and Vegetables|38.2848|OUT027|1985|Medium|Tier 3|Supermarket Type3|484.7024
-- FDY40||regular|0.15028599|Frozen Foods|51.0692|OUT019|1985|Small|Tier 1|Grocery Store|147.8076
-- FDY45||low fat|0.026015519|Snack Foods|255.8356|OUT027|1985|Medium|Tier 3|Supermarket Type3|2543.356
-- FDN48||low fat|0.113720344|Baking Goods|89.9804|OUT019|1985|Small|Tier 1|Grocery Store|643.1628
-- NCL18||low fat|0.293417759|Household|194.6136|OUT019|1985|Small|Tier 1|Grocery Store|583.2408
-- FDR12||regular|0.031382044|Baking Goods|171.3764|OUT027|1985|Medium|Tier 3|Supermarket Type3|3091.9752
-- FDQ49||regular|0.039057677|Breakfast|155.963|OUT027|1985|Medium|Tier 3|Supermarket Type3|3285.723
-- FDU04||low fat|0.009714595|Frozen Foods|120.0414|OUT019|1985|Small|Tier 1|Grocery Store|487.3656
-- FDD10||regular|0.045797829|Snack Foods|178.5344|OUT027|1985|Medium|Tier 3|Supermarket Type3|2854.9504

-- to fill the NULL values of Item_Weight, we replace null values with average of Item_Weight
select avg(Item_Weight) from bigmart;
-- 13.127037037037

update bigmart set Item_Weight=13.127037037037 where Item_Weight is NULL;

-- checking if changes have been reflected in the table or not
select * from bigmart where Item_Weight is NULL;
-- no rows displayed

--average sales of items with respect to the fat content
select avg(Item_Outlet_Sales),Item_Fat_Content from bigmart group by Item_Fat_Content order by avg(Item_Outlet_Sales) desc; 
-- 2320.43981904762|low fat
-- 1841.38686486487|regular
--low fat items have recorded the highest average amount of sales

--average mrp of items with respect to fat content
select avg(Item_MRP),Item_Fat_Content from bigmart group by Item_Fat_Content order by avg(Item_MRP) desc;
-- 148.74833968254|low fat
-- 122.790059459459|regular
-- low fat content items have a higher average Item_MRP than regular fat content items

--checking the average visibility provided with respect to Item_Fat_Content
select avg(Item_Visibility),Item_Fat_Content from bigmart group by Item_Fat_Content order by avg(Item_Visibility) desc;
-- 0.0714201421891892|regular
-- 0.0622839897301587|low fat
-- regular fat content items are provided with comparitively more visibility

-- outlets from highest to lowest amount of sales
select sum(Item_Outlet_Sales),Outlet_Identifier from bigmart group by Outlet_Identifier order by sum(Item_Outlet_Sales) desc;
-- 34204.8092|OUT046
-- 34133.5686|OUT018
-- 31192.73|OUT045
-- 30182.7114|OUT049
-- 28017.5298|OUT027
-- 19838.1768|OUT017
-- 18635.0762|OUT035
-- 12253.3832|OUT013
-- 3874.2902|OUT019
-- 1986.7472|OUT010

-- OUT046 has the highest amount of sales whereas OUT010 has the lowest amount of sales

--outlet size from highest to lowest  amount of sales
select Outlet_Size,sum(Item_Outlet_Sales) from bigmart group by Outlet_Size order by sum(Item_Outlet_Sales) desc;
-- Medium|145351.4638
-- Small|56714.1756
-- High|12253.3832

-- medium sized outlets have proven to be most profitable sice they have the highest amount of Item_Outlet_Sales

-- checking the item_type from the highest to the lowest average MRP
select avg(Item_MRP),Item_Type from bigmart group by Item_Type order by avg(Item_MRP) desc;
-- 175.56855|Canned
-- 164.7526|Starchy Foods
-- 158.809523809524|Snack Foods
-- 147.408466666667|Dairy
-- 144.9784|Fruits and Vegetables
-- 143.270314285714|Household
-- 141.715636363636|Frozen Foods
-- 128.9652|Meat
-- 123.725257142857|Health and Hygiene
-- 106.1622|Breakfast
-- 104.269633333333|Baking Goods
-- 100.746333333333|Soft Drinks
-- 93.1436|Breads
-- 63.4834666666667|Hard Drinks
-- Canned Food items have the highest average MRP whereas Hard Drinks have the lowest MRP

--checking the item type from the highest to the lowest average  Item_Outlet_Sales
select avg(Item_Outlet_Sales),Item_Type from bigmart group by Item_Type order by avg(Item_Outlet_Sales) desc;
-- 4604.6728|Starchy Foods
-- 2797.0258|Canned
-- 2621.2228952381|Snack Foods
-- 2431.40648571429|Health and Hygiene
-- 2416.5211|Breakfast
-- 2359.5952|Household
-- 2339.88752|Meat
-- 2174.5028|Breads
-- 1949.76969230769|Fruits and Vegetables
-- 1857.80393333333|Baking Goods
-- 1790.39672727273|Frozen Foods
-- 1415.04693333333|Soft Drinks
-- 1328.9368|Dairy
-- 1136.5206|Hard Drinks
-- Starchy Foods are in high demand as average sales are higher than the rest of the types. 
-- Hard Drinks are the lowest in demand since average sales are least among all the types.

--checking the average visibility provided to different item types
select avg(Item_Visibility),Item_Type from bigmart group by Item_Type order by avg(Item_Visibility) desc;
-- 0.113881407444444|Dairy
-- 0.0974682135714286|Household
-- 0.0774423664285714|Snack Foods
-- 0.0729786998181818|Frozen Foods
-- 0.0599486716666667|Baking Goods
-- 0.0591853744285714|Health and Hygiene
-- 0.0551349825|Soft Drinks
-- 0.054073319|Breakfast
-- 0.0480562276923077|Fruits and Vegetables
-- 0.0418506703333333|Hard Drinks
-- 0.038823255875|Canned
-- 0.0312711714|Meat
-- 0.0|Starchy Foods
-- 0.0|Breads
-- Dairy and Household products are given the highest amount of visibility on shelves whereas starchy foods and breads have the lowest amount of visibility on shelves

-- checking which outlet type has the highest to lowest average amount of sales
select avg(Item_Outlet_Sales),Outlet_Type from bigmart group by Outlet_Type order by avg(Item_Outlet_Sales) desc;
-- 3103.05169090909|Supermarket Type2
-- 2547.04816363636|Supermarket Type3
-- 2286.04510625|Supermarket Type1
-- 418.645528571429|Grocery Store

-- Supermarket Type2 have the highest amount of average Item_Outlet_Sales whereas grocery store has the least amount of average_Item_Outlet_Sales

--checking which size of outlet is most profitable in terms of average Item_Outlet_Sales
select avg(Item_Outlet_Sales),Outlet_Size from bigmart group by Outlet_Size order by avg(Item_Outlet_Sales) desc;
-- 2422.52439666667|Medium
-- 1890.47252|Small
-- 1225.33832|High
--Medium sized outlets have highest recorded average Item_Outlet_Sales whereas High (or large) sized outlets have lesser profitability

--checking whether location of an outlet matters in determining profitability of the outlet
select avg(Item_Outlet_Sales),Outlet_Location_Type from bigmart group by Outlet_Location_Type order by avg(Item_Outlet_Sales) desc;
-- 2580.22159259259|Tier 2
-- 2010.29549473684|Tier 3
-- 1950.33745142857|Tier 1

--Tier 2 cities have recorded highest average Item_Outlet_Sales whereas Tier 1 cities have recorded the least average Item_Outlet_Sales

--checking whether the year of establishment has a role to play in Item_Outlet_Sales or not
select avg(Item_Outlet_Sales),Outlet_Establishment_Year from bigmart group by Outlet_Establishment_Year order by avg(Item_Outlet_Sales) desc;
-- 3103.05169090909|2009
-- 2834.02525714286|2007
-- 2599.39416666667|2002
-- 2443.20065714286|1997
-- 2329.384525|2004
-- 2321.74703076923|1999
-- 1678.51684210526|1985
-- 1225.33832|1987
-- 331.124533333333|1998

-- outlets established in 2009 and 2007 have recorded highest average Item_Outlet_Sales whereas the outlets established in 1998 have the least average Item_Outlet_Sales



