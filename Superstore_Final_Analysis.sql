USE superstore;
SELECT*FROM superstore;

ALTER TABLE superstore
CHANGE `Sub-category` `Sub_Category` VARCHAR(255);

-- Total Sales in United States

							SELECT
								SUM(Sales) AS Total_sales
							FROM superstore
							GROUP BY country;

-- Total Orders

							SELECT
								COUNT(DISTINCT Order_Id) AS Total_Order
							FROM superstore
							GROUP BY Country;

-- Total Sales by Region

							SELECT 
								State,
								SUM(Sales) AS Total_Sales
							FROM 	
								superstore
							GROUP BY State
							ORDER BY Total_Sales DESC;

-- Total Sales by City,state and Region

							SELECT
								City,
								State,
								Region,
								SUM(Sales) AS Total_Sales
							FROM superstore
							GROUP BY City, State, Region
							ORDER BY Total_Sales DESC
							-- LIMIT 5 (for TOP 5 Cities)
							;

-- Which Segment has the highest sales ?

						SELECT
							Segment,
							SUM(Sales) AS Total_Sales
						FROM superstore
						GROUP BY Segment
						Order BY Total_Sales DESC

-- Which Categoroy has the highest sales ?

					SELECT
						Category,
						Sub_Category,
						SUM(Sales) AS Total_Sales
					FROM superstore
					GROUP BY Category,Sub_Category
					Order BY Total_Sales DESC;

-- Only Category

					SELECT
						Category,
						SUM(Sales) AS Total_Sales
					FROM superstore
					GROUP BY Category
					Order BY Total_Sales DESC;

-- Total Items Sold

					SELECT 
						Category,
						Sub_Category,
						COUNT(Quantity) AS Total_Quantity
					FROM superstore
					GROUP BY Category, Sub_Category
					ORDER BY Total_Quantity DESC;

-- Revenue by Customer

					SELECT 
						Customer_Name,
						SUM(Sales) AS Total_Revenue
						FROM 
						superstore
					GROUP BY Customer_Name
					ORDER BY Total_Revenue DESC
					LIMIT 10;

-- Monthly and Yearly Trends

					SELECT
						YEAR(Order_Date) AS YEARS,
						SUM(Sales) AS Total_Sales
					FROM superstore
					GROUP BY YEARS
					ORDER BY Total_Sales DESC;
                    
						SELECT
							YEAR(Order_Date) AS YEARS,
							MONTH(Order_Date) AS Months,
							SUM(Sales) AS Total_Sales
						FROM superstore
						GROUP BY YEARS,Months
						ORDER BY YEARS,MONTHS;
                        
                        SELECT
							-- YEAR(Order_Date) AS YEARS,
								MONTH(Order_Date) AS Months,
								SUM(Sales) AS Total_Sales
						FROM superstore
						GROUP BY Months
						ORDER BY MONTHS;
                        
-- Profit margin by Category

						SELECT 
							Category,
							SUM(Profit) AS Total_Profit
						FROM superstore
						GROUP BY Category;
                        
SELECT 
	Category,
    ROUND(SUM(Profit)/SUM(Sales) * 100,2 )AS profit_percentage
FROM superstore
GROUP BY Category;


SELECT
	Customer_Name,
    SUM(Quantity) AS Total_Quantity_Ordered
FROM 
	superstore
GROUP BY Customer_name
ORDER BY Total_Quantity_Ordered DESC;

-- Customer Churn analysis

SELECT 
	COUNT(DISTINCT Customer_Name) AS Total_Customer,
    (SELECT
		COUNT(DISTINCT Customer_Name)
	FROM superstore
	WHERE Order_Date > '2017-05-30') AS Customer_left_before_6_Month,
    (COUNT(DISTINCT Customer_Name)-(SELECT COUNT(DISTINCT Customer_Name) FROM superstore WHERE Order_Date > '2017-05-30'))/ COUNT(DISTINCT Customer_Name)* 100  AS churn_rate
FROM 
	superstore;
    
    
    /* RFM segmentation is a customer segmentation technique that groups customers based on 
their Recency (how recently they made a purchase), Frequency (how often they make purchases), and Monetary value (how much they spend) */

SELECT
	DISTINCT Customer_Name,
    YEAR(Order_Date) AS Year_of_Purchase,
    COUNT(Customer_Name) AS No_of_time_Purchase,
    SUM(Sales) AS Total_Revenue_by_Customer
FROM superstore
GROUP BY Customer_Name,Year_of_Purchase
ORDER BY Year_of_Purchase,Total_Revenue_by_Customer DESC;


