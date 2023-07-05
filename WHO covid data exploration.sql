use portfolioproject;

select * from coviddeaths;

select * from coviddeaths where continent is not null order by 2;

select location, date, total_cases, new_cases, total_deaths, population From coviddeaths order by 1;

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathpercentage From coviddeaths where continent is not null order by 1,3;

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathpercentage From coviddeaths where location='ethiopia' and continent is not null order by 3;

Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected From CovidDeaths order by 1;

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected From CovidDeaths Group by Location, Population order by PercentPopulationInfected desc;

select location, max(cast(total_deaths as double)) as totaldeathcount from coviddeaths where continent is not null group by location order by totaldeathcount desc;

select continent, Max(cast(total_deaths as double)) as totaldeathcount from coviddeaths where continent is not null group by continent order by totaldeathcount desc;

select date, sum(new_cases)as total_cases, sum(cast(new_deaths as float))as total_deaths, sum(new_deaths)/sum(new_cases)*100 as deathpercentage from coviddeaths where continent is not null group by date;


select * from coviddeaths join covidvaccinations on coviddeaths.location=covidvaccinations.location and coviddeaths.date=covidvaccinations.date;

select coviddeaths.continent, coviddeaths.location, coviddeaths.date, coviddeaths.population, covidvaccinations.total_vaccinations 
from coviddeaths join covidvaccinations on coviddeaths.location=covidvaccinations.location and coviddeaths. date= covidvaccinations.date where coviddeaths.continent is not null order by 2,4;


with PopvsVac as ( 
select coviddeaths.continent, coviddeaths.location, coviddeaths.date, coviddeaths.population, covidvaccinations.total_vaccinations, sum(cast(covidvaccinations.total_vaccinations as float)) over (partition by coviddeaths.location order by coviddeaths.location,coviddeaths.date)as total_vaccinations_per_location
from coviddeaths join covidvaccinations on coviddeaths.location=covidvaccinations.location and coviddeaths. date= covidvaccinations.date where coviddeaths.continent is not null)
select *,(total_vaccinations_per_location/population)*100 from PopvsVac;

select coviddeaths.continent, coviddeaths.location, coviddeaths.date, coviddeaths.population, covidvaccinations.total_vaccinations, sum(cast(covidvaccinations.total_vaccinations as float)) over (partition by coviddeaths.location order by coviddeaths.location,coviddeaths.date)as total_vaccinations_per_location
from coviddeaths join covidvaccinations on coviddeaths.location=covidvaccinations.location and coviddeaths. date= covidvaccinations.date where coviddeaths.continent is not null order by 3,4;

drop table if exists PercentPopulationVaccinated;

create temporary table PercentPopulationVaccinated
(Continent varchar(255),
location varchar(255),
Date text,
Population numeric,
Total_vaccinations numeric,
total_vaccinations_per_location float);



insert into PercentPopulationVaccinated
select coviddeaths.continent, coviddeaths.location, coviddeaths.date, coviddeaths.population, covidvaccinations.total_vaccinations, sum(cast(covidvaccinations.total_vaccinations as float)) over (partition by coviddeaths.location order by coviddeaths.location,coviddeaths.date)as total_vaccinations_per_location
from coviddeaths join covidvaccinations on coviddeaths.location=covidvaccinations.location and coviddeaths. date= covidvaccinations.date where coviddeaths.continent is not null order by 3,4;

select *,(total_vaccinations_per_location/population)*100 from PercentPopulationVaccinated;


create view PercentPopulationVaccinated as
select coviddeaths.continent, coviddeaths.location, coviddeaths.date, coviddeaths.population, covidvaccinations.total_vaccinations, sum(cast(covidvaccinations.total_vaccinations as float)) over (partition by coviddeaths.location order by coviddeaths.location,coviddeaths.date)as total_vaccinations_per_location
from coviddeaths join covidvaccinations on coviddeaths.location=covidvaccinations.location and coviddeaths. date= covidvaccinations.date where coviddeaths.continent is not null order by 3,4;

select * from PercentPopulationVaccinated order by 2,3;



Select SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(New_Cases)*100 as DeathPercentage
From coviddeaths
where continent is not null 
order by 1,2;

Select location, SUM(new_deaths) as TotalDeathCount
From coviddeaths
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc;

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From coviddeaths
Group by Location, Population
order by PercentPopulationInfected desc;

Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From coviddeaths
Group by Location, Population, date
order by PercentPopulationInfected desc;



