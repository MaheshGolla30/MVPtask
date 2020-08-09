-- Question a,b, and c combined query
SELECT P.Name as PropertyName, OP.PropertyId, PHV.Value, TP.PaymentAmount,TPF.Name as FrequencyType,TP.StartDate,TP.EndDate,
     CAST(CASE 
       WHEN TPF.Name='Weekly' THEN DATEDIFF(week,TP.StartDate,TP.EndDate) * TP.PaymentAmount
       WHEN TPF.Name='Fortnightly' THEN DATEDIFF(week,TP.StartDate,TP.EndDate) * (TP.PaymentAmount/2)
	   WHEN TPF.Name='Monthly' THEN DATEDIFF(month,TP.StartDate,TP.EndDate) * TP.PaymentAmount
     ELSE 0
    END as decimal(15,2)) as TotalPayment,
	CASE 
       WHEN TPF.Name='Weekly' THEN DATEDIFF(week,TP.StartDate,TP.EndDate) * TP.PaymentAmount
       WHEN TPF.Name='Fortnightly' THEN DATEDIFF(week,TP.StartDate,TP.EndDate) * (TP.PaymentAmount/2)
	   WHEN TPF.Name='Monthly' THEN DATEDIFF(month,TP.StartDate,TP.EndDate) * TP.PaymentAmount
     ELSE 0
    END / PHV.Value as Yield
	FROM OwnerProperty OP
    JOIN Property P 
      ON OP.PropertyId=P.Id
    JOIN PropertyHomeValue PHV 
	  ON PHV.PropertyId=P.Id
	JOIN TenantProperty TP
	  ON TP.PropertyId=P.Id
	JOIN TenantPaymentFrequencies TPF
	  ON TPF.Id=TP.PaymentFrequencyId
	where OwnerId=1426  and PHV.IsActive=1 order by PropertyName
-- Question d
SELECT * FROM Job where JobStatusId<>4 and JobStatusId<>5 and JobStatusId<>6 and PropertyId in (5597,5637,5638);
-- Question e 
SELECT P.Name as PropertyName,PE.FirstName,PE.LastName,TPF.Name as FrequencyType
 FROM OwnerProperty OP
 JOIN Property P 
   ON OP.PropertyId=P.Id
  JOIN TenantProperty TP ON OP.PropertyId=TP.PropertyId 
   JOIN Person  PE ON TP.TenantId=PE.Id
   JOIN TenantPaymentFrequencies  TPF ON TP.PaymentFrequencyId=TPF.Id
  WHERE OwnerId=1426
 
