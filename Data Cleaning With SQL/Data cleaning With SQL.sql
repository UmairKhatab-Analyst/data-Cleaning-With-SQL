--FROM DEATH TABLES--


select * from Portfolio..CovidDeaths
order by 3,4;

--select * from Portfolio..CovidVaccinations
--order by 3,4,5

--select data that going to be use

select location, date,total_cases, new_cases, total_deaths, population 
from Portfolio..CovidDeaths
order by 1,2;


--Total Cases Vs Total Death--

select location, date,total_cases, total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from Portfolio..CovidDeaths
where location like '%states%' or location like '%Pak%'
order by 1,2;


--  Population VS Death Case--

select location, date,population ,total_cases,(total_deaths/total_cases)*100 as Affected_Percentage
from Portfolio..CovidDeaths
where location ='pakistan'
order by 1,2;


--Population VS DeathCase--

select location, date,population ,total_deaths,(total_deaths/total_cases)*100 as Death_Percentage
from Portfolio..CovidDeaths
where location ='pakistan'
order by 1,2;

--Country with heights infection rate comparet to population

select location,population ,max(total_cases) as infection,max(total_cases/population)*100 as Percentage_infection
from Portfolio..CovidDeaths
group by location,population
order by Percentage_infection desc ;


-- highst Deaths rate compare to population

select location,population ,max(cast(total_deaths as int)) as Deaths,max(total_deaths/population)*100 as Percentage_Deaths
from Portfolio..CovidDeaths
group by location,population
order by Percentage_Deaths desc ;

--CONTINENT WITH HIGHEST DEATH RATE
select continent,max(cast(total_deaths as int)) as Deaths--,max(total_deaths/population)*100 as Percentage_Deaths
from Portfolio..CovidDeaths
where continent is not null
group by continent
order by Deaths desc ;

----GLOBAL NUMBER 

select date, SUM(total_cases) as TOTALCASEs,SUM(cast(total_deaths as int)) AS TOTALDEATHS,
SUM(cast(total_deaths as int))/sum(total_cases)*100 as total_Percentage_Deaths
from Portfolio..CovidDeaths
where continent is not null
group by date
order by 1,2

--OR TOTAL--

select SUM(total_cases) as TOTALCASEs,SUM(cast(total_deaths as int)) AS TOTALDEATHS,
SUM(cast(total_deaths as int))/sum(total_cases)*100 as total_Percentage_Deaths
from Portfolio..CovidDeaths
where continent is not null
--group by date
order by 1,2


--SUM AS COUNTRY OR LOCATION


select location, SUM(total_cases) as TOTALCASEs,SUM(cast(total_deaths as int)) AS TOTALDEATHS,
SUM(cast(total_deaths as int))/sum(total_cases)*100 as total_Percentage_Deaths
from Portfolio..CovidDeaths
where continent is not null
group by location
order by location

--Second Table (Applyiny Joins)--

select * from Portfolio..CovidVaccinations

select * from Portfolio..CovidDeaths as dea
join Portfolio..CovidVaccinations as vac
on dea.location=vac.location

select top 100 dea.location, dea.date, dea.population, vac.new_vaccinations, (vac.new_vaccinations/dea.population)*100 as VacPercantage
from Portfolio..CovidDeaths as dea
join Portfolio..CovidVaccinations as vac
on dea.location=vac.location
where not vac.new_vaccinations ='null'
order by 1,2


select  distinct top 3 new_vaccinations, location from Portfolio..CovidVaccinations
where not location ='world'
order by new_vaccinations desc
\
select distinct top 10 location, population  from Portfolio..CovidDeaths
where not location='world' and not location='asia'
order by population desc



select  max(new_vaccinations) from Portfolio..CovidVaccinations
where new_vaccinations not in  (select max(new_vaccinations) from Portfolio..CovidVaccinations)
group by new_vaccinations
order by new_vaccinations 


select distinct  location, max(population)  from Portfolio..CovidDeaths
where population not in (select max(population) from Portfolio..CovidDeaths)
group by location , population
order by population desc