
--1. 1)What are the average scores for each capability on both the Gemini Ultra and GPT-4 models?

SELECT * FROM Models
SELECT * FROM Capabilities
SELECT * FROM Benchmarks

---ANS:
SELECT Capabilityname, C.CapabilityID, Round(AVG(ScoreGemini),2) as Gemini_Averagescore, 
round(AVG(ScoreGPT4),2) as GPT4_Averagescore 
FROM Benchmarks as B
join
[dbo].[Capabilities] as C
on
B.CapabilityID = C.CapabilityID
group by Capabilityname, C. CapabilityID

--2)Which benchmarks does Gemini Ultra outperform GPT-4 in terms of scores?

Select Benchmarkname, scoregemini, scoregpt4 
from Benchmarks
Where ScoreGemini > scoregpt4
order by benchmarkname asc

---OR we can use the below syntax-

Select Benchmarkname, scoregemini, scoregpt4 
from Benchmarks
group by Benchmarkname, scoregemini, scoregpt4 
Having ScoreGemini > scoregpt4
order by benchmarkname asc


--3)What are the highest scores achieved by Gemini Ultra and GPT-4 for each benchmark in the Image capability?
Select Benchmarkname, CapabilityName, max(scoregemini) as maximumgemini, max(scoregpt4) from Benchmarks
join
Capabilities
on
Benchmarks.CapabilityID = Capabilities.CapabilityID
where CapabilityName = 'image'
group by benchmarkname, CapabilityName ----highest score in each benchmark including in image capability.

--4)Calculate the percentage improvement of Gemini Ultra over GPT-4 for each benchmark?
select * from Benchmarks
-------------------------------
--ANS:-
select benchmarkname, round((((scoregemini-ScoreGPT4)/ScoreGPT4)*100),2)
as percentage_improvement 
from Benchmarks
Where (scoregemini-ScoreGPT4)/ScoreGPT4*100 > 0
order by percentage_improvement desc



--5)Retrieve the benchmarks where both models scored above the average for their respective models?

select benchmarkname, modelname from Benchmarks
join
Models
on
Benchmarks.ModelID = Models.ModelID
where scoregemini > (select avg(scoregemini) from Benchmarks) and 
ScoreGPT4 > (select avg(scoregpt4)from Benchmarks)


--6)Which benchmarks show that Gemini Ultra is expected to outperform GPT-4 based on the next score?

select B1.BenchmarkName from Benchmarks as B1
join
Benchmarks as B2
on
B2.BenchmarkID = B1.BenchmarkID
where B1.ScoreGemini > B2.ScoreGPT4 
Order by BenchmarkName Asc
------------------------------------
select * from Benchmarks

SELECT BenchmarkName
FROM benchmarks
WHERE ScoreGemini > ScoreGPT4

--7)Classify benchmarks into performance categories based on score ranges?

select * from benchmarks
--------------------------------
select benchmarkname, Modelname,scoregemini,
case
when scoregemini >= 90 then 'Outstanding' 
when scoregemini >= 80 then 'very Good'
when scoregemini >= 70 then 'Good'
when scoregemini >= 60 then 'Average'
when scoregemini < 60 then 'Below Average'
else 'null'
end
as performance_categoryGemini,
scoregpt4,
case
when Scoregpt4 is NULL then 'Not Available'
when scoregpt4 >= 90 then 'Outstanding'
when scoregpt4 >= 80 then 'very Good'
when scoregpt4 >= 70 then 'Good'
when scoregpt4 >= 60 then 'Average'
when scoregpt4 < 60 then 'Below Average'
else 'null'
end as performance_categoryGpt4
from Benchmarks
join
models
on
benchmarks.modelid = models.modelid

--8) Retrieve the rankings for each capability based on Gemini Ultra scores?

select capabilityname, sum(scoregemini) as sum_scoregemini,rank()over(order by sum(scoregemini) desc)
as Capability_Rank
from Benchmarks
join
Capabilities
on
Benchmarks.CapabilityID = Capabilities.CapabilityID
group by capabilityname

--9)Convert the Capability and Benchmark names to uppercase?

select Upper(capabilityname) as Capability_name, Upper(benchmarkname) as Benchmark_name from Benchmarks
join
Capabilities
on
Benchmarks.CapabilityID = Capabilities.CapabilityID

--10) Can you provide the benchmarks along with their descriptions in a concatenated format?

Select Distinct concat(benchmarkname, '-', [Description]) as Benchmark_with_Description from Benchmarks

----the above syntax can be used for removing repitive data

Select concat(benchmarkname, '-', [Description]) as Benchmark_with_Description from Benchmarks

----the above syntax can be used to concatanate columns but not removing repetitive data.

