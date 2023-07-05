select * from nashvillehousing;
use PortfolioProject_2;


select * from nashvillehousing;

Select saledate,replace(saledate,'/','-') from nashvillehousing;
 

update nashvillehousing set saledate=replace(saledate,'-','/');

select a.parcelID as parcelid1,a.propertyAddress as propertyaddress1,b.parcelID as parcelid2 ,b.propertyAddress as propertyaddress2, ifnull(a.propertyaddress,b.propertyaddress)
from nashvillehousing a,nashvillehousing b where a.uniqueID<>b.uniqueID and a.parcelid=b.parcelid and a.propertyaddress is null;

update nashvillehousing a,nashvillehousing b set a.propertyaddress=ifnull(a.propertyaddress,b.propertyaddress)  where a.uniqueID<>b.uniqueID and a.parcelid=b.parcelid and a.propertyaddress is null;

select substring(propertyaddress,1,locate(',',propertyaddress)-1) as address,
substring(propertyaddress,locate(',',propertyaddress)+1,length(propertyaddress)) as address from nashvillehousing;

alter table nashvillehousing add PropertySplitAddress varchar(255);
update nashvillehousing set PropertySplitAddress=substring(propertyaddress,1,locate(',',propertyaddress)-1);


alter table nashvillehousing add PropertySplitCity varchar(255);
update nashvillehousing set PropertySplitCity=substring(propertyaddress,locate(',',propertyaddress)+1,length(propertyaddress));


select substring(owneraddress,1,locate(',',owneraddress)-1) as address,
substring(owneraddress,locate(',',owneraddress)+1) as address, substring(owneraddress, locate(',',owneraddress, locate(',',owneraddress)+1)+1) as address from nashvillehousing;

alter table nashvillehousing add ownerSplitAddress varchar(255);
update nashvillehousing set ownerSplitAddress=substring(owneraddress,1,locate(',',owneraddress)-1);

alter table nashvillehousing add ownerSplitCity varchar(255);
update nashvillehousing set ownerSplitCity=substring(owneraddress,locate(',',owneraddress)+1,length(owneraddress));

alter table nashvillehousing add ownerSplitState varchar(255);
update nashvillehousing set ownerSplitState=substring(owneraddress, locate(',',owneraddress, locate(',',owneraddress)+1)+1);

select distinct(soldasvacant), count(soldasvacant) from nashvillehousing group by soldasvacant order by 2;

select soldasvacant, case when soldasvacant='Y' then 'Yes' when soldasvacant='N' then 'NO' else soldasvacant end from nashvillehousing;


update nashvillehousing set soldasvacant= case when soldasvacant='Y' then 'Yes' when soldasvacant='N' then 'NO' else soldasvacant end;


with rownumcte as ( 
select * , row_number() over 
(partition by parcelid, propertyaddress, saleprice, saledate, legalreference ) row_num from nashvillehousing order by uniqueid)

select * from rownumcte where row_num >1 order by propertyaddress;

select * from nashvillehousing;

alter table nashvillehousing drop column propertyaddress;
alter table nashvillehousing drop column taxdistrict;

