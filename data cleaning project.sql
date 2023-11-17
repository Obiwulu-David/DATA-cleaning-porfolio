--Data Cleaning Project
Select *
from projectporfolio..housingproject

--clean saledate
select saledate 
from projectporfolio..housingproject

select saledate, convert(date, saledate)
from projectporfolio..housingproject

--update housingproject
--set SaleDate = convert(date, saledate)

alter table projectporfolio..housingproject
add convertedsaledate date

update projectporfolio..housingproject
set convertedsaledate = convert(date, saledate)
--note that the saledate was altered to convertedsaledate after
--the data was cleaned and seperated.
select convertedsaledate
from projectporfolio..housingproject

select *  --propertyaddress
from projectporfolio..housingproject
--where propertyaddress is null
order by ParcelID

--isnull was used to populate columns where property address
--are blank
select H.ParcelID, P.ParcelID, H.PropertyAddress, P.PropertyAddress,
ISNULL(H.propertyaddress, P.PropertyAddress)
from projectporfolio..housingproject H
join projectporfolio..housingproject P
on H.ParcelID = P.ParcelID
and H.[UniqueID ]<> P.[UniqueID ]
where H.PropertyAddress is null

--cleaning of property address

update H
set PropertyAddress =
ISNULL(H.propertyaddress, P.PropertyAddress)
from projectporfolio..housingproject H
join projectporfolio..housingproject P
on H.ParcelID = P.ParcelID
and H.[UniqueID ]<> P.[UniqueID ]
where H.PropertyAddress is null

--Using parsname to saperate PropertyAddress
select propertyaddress
from projectporfolio..housingproject

select
PARSENAME(replace(propertyaddress, ',', '.'), 2)
from projectporfolio..housingproject

alter table projectporfolio..housingproject
add propertyaddressowner nvarchar(500)

update housingproject
set propertyaddressowner = 
PARSENAME(replace(propertyaddress, ',', '.'), 2)

--clean ownersaddress using parsename
select 
PARSENAME(replace(owneraddress, ',', '.'), 3),
PARSENAME(replace(owneraddress, ',', '.'), 2),
PARSENAME(replace(owneraddress, ',', '.'), 1)
from projectporfolio..housingproject

alter table projectporfolio..housingproject
add owneraddressnew nvarchar(500)

update projectporfolio..housingproject
set owneraddressnew = PARSENAME(replace(owneraddress, ',', '.'), 3)

alter table projectporfolio..housingproject
add ownercitynew nvarchar(500)

update projectporfolio..housingproject 
set ownercitynew =
PARSENAME(replace(owneraddress, ',', '.'), 2)

alter table projectporfolio..housingproject
add ownerstatenew nvarchar(500)

update projectporfolio..housingproject 
set ownerstatenew =
PARSENAME(replace(owneraddress, ',', '.'), 1)
 
 --change to Y to YES and N to NO

 select distinct (SoldAsVacant), count (soldasvacant)
 from projectporfolio..housingproject
 group by soldasvacant

select SoldAsVacant,
case when soldasvacant = 'Y'then 'YES'
	 when soldasvacant = 'N' then 'NO'
	 else soldasvacant
	 end
from projectporfolio..housingproject

update projectporfolio..housingproject
set SoldAsVacant =
case when soldasvacant = 'Y'then 'YES'
	 when soldasvacant = 'N' then 'NO'
	 else soldasvacant
	 end

select count (soldasvacant)
from projectporfolio..housingproject
group by soldasvacant

--delete unused column
alter table projectporfolio..housingproject
drop column propertyaddress, saledate, owneraddress

select * 
from projectporfolio..housingproject






