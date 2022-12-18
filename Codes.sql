--1) Find out which chemicals were used the most in cosmectics and personal care products?

SELECT TOP 10 ChemicalName,COUNT(ChemicalName) AS MostUsedChemicals
FROM ChemicalsinCosmetics
GROUP BY ChemicalName 
ORDER BY MostUsedChemicals DESC

--2) Find out which company used the most reported chemicals in their cosmetics and personal care products?

SELECT TOP 10 CompanyName,COUNT(ChemicalCount) AS NumberOfTimesReported
FROM ChemicalsinCosmetics
GROUP BY CompanyName
ORDER BY NumberOfTimesReported DESC

---3) Which brands had chemicals that were removed and discontinued? Identify the chemicals.

SELECT DISTINCT BrandName,ChemicalName,ChemicalDateRemoved, DiscontinuedDate
FROM ChemicalsinCosmetics
WHERE ChemicalDateRemoved <> ''
 AND DiscontinuedDate <> ''
 ORDER BY BrandName
 
 
 ----4) Identify the brands that had chemicals that where mostly reported in 2018?

 SELECT TOP 10 BrandName,COUNT(ChemicalCount) AS MostlyReported
 FROM ChemicalsinCosmetics
 WHERE InitialDateReported LIKE '%2018%'
 GROUP BY BrandName
 ORDER BY MostlyReported DESC

 ----5) What brand had chemicals discontinued and removed?

 SELECT DISTINCT BrandName,ChemicalDateRemoved,DiscontinuedDate 
FROM ChemicalsinCosmetics
WHERE ChemicalDateRemoved <> ''
 AND DiscontinuedDate <> ''
 ORDER BY BrandName 


----6) Identify the period between the creation of the removed chemicals and when they were actually removed.

SELECT ChemicalName, ChemicalCreatedAt, ChemicalDateRemoved,
  CAST(DATEDIFF(year, ChemicalCreatedAt, ChemicalDateRemoved) as varchar) + ' years ' +
  CAST(DATEDIFF(month, ChemicalCreatedAt, ChemicalDateRemoved) - (DATEDIFF(year, ChemicalCreatedAt, ChemicalDateRemoved)*12) as varchar) + ' months ' +
  CAST(DATEPART(d, ChemicalDateRemoved) - DATEPART(d, ChemicalCreatedAt) as varchar) + ' days' as PeriodDiff
FROM ChemicalsinCosmetics
WHERE ChemicalDateRemoved <> ''
 AND DiscontinuedDate <> '' AND ChemicalDateRemoved > ChemicalCreatedAt

-----7) Can you tell if the discontinued chemicals in bath products were removed?

SELECT PrimaryCategory,ChemicalName,DiscontinuedDate,ChemicalDateRemoved
FROM ChemicalsinCosmetics
WHERE PrimaryCategory = 'Bath Products'
AND DiscontinuedDate <>'' AND ChemicalDateRemoved <>''
 
 ----8) How long were the removed chemicals in baby products used?

 SELECT PrimaryCategory ,ChemicalCreatedAt, ChemicalDateRemoved,
  CAST(DATEDIFF(year, ChemicalCreatedAt, ChemicalDateRemoved) as varchar) + ' years ' +
  CAST(DATEDIFF(month, ChemicalCreatedAt, ChemicalDateRemoved) - (DATEDIFF(year, ChemicalCreatedAt, ChemicalDateRemoved)*12) as varchar) + ' months ' +
CAST(DATEPART(d, ChemicalDateRemoved) - DATEPART(d, ChemicalCreatedAt) as varchar) + ' days' as PeriodDiff
FROM ChemicalsinCosmetics
WHERE PrimaryCategory = 'Baby Products'
AND ChemicalDateRemoved <>''

----9) Identify the relationship between chemicals that were mostly recently reported and discontinued.
    -----   (Does most recently reported chemicals equal discontinuation of such chemicals?)

	SELECT ChemicalName,COUNT(MostRecentDateReported) AS Reported,COUNT(DiscontinuedDate) AS Discontinued
	FROM ChemicalsinCosmetics
	GROUP BY ChemicalName
	ORDER BY 3 DESC

----10) Identify the relationship between CSF and chemicals used in the most manufactured sub categories.
      ---  (Tip: Which chemicals gave a certain type of CSF in sub categories?)

SELECT DISTINCT ChemicalName,CSF,SubCategory
FROM ChemicalsinCosmetics 
WHERE CSF <> ''