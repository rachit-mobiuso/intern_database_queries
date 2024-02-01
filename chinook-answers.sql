-- EXERCISE-1


--Q.1 What is the title of the album with AlbumId 67?
select title from albums where AlbumId = 67;

--Q.2 Find the name and length (in seconds) of all tracks that have length between 50 and 70 seconds.
select Name as trackName,Milliseconds/1000 as lengthInSeconds from tracks where Milliseconds between 50000 and 70000;

--Q.3 List all the albums by artists with the word ‘black’ in their name.
select * from artists where name like '%black%';

--Q.4 Provide a query showing a unique/distinct list of billing countries from the Invoice table
select distinct(BillingCountry) from invoices;

--Q.5 Display the city with highest sum total invoice.
select * from invoices where total=(select max(total) from invoices);

--Q.6 Produce a table that lists each country and the number of customers in that country. (You only need to include countries that have customers) in descending order. (Highest count at the top)
select Country,count(*) from customers group by Country;

--Q.7 Find the top five customers in terms of sales i.e. find the five customers whose total combined invoice amounts are the highest. Give their name, CustomerId and total invoice amount. Use join
select c.CustomerId,c.FirstName || ' ' || c.LastName as customerName,sum(i.Total) as totalSales from customers c
join invoices i on c.CustomerId = i.CustomerId
group by c.CustomerId, CustomerName order by TotalSales desc limit 5;


-- Q.8 Find out state wise count of customerID and list the names of states with count of customerID in decreasing order. Note:- do not include where states is null value.
select State,count(CustomerId) as Counts from Customers where State is not null group by State order by Counts desc;


--Q.9 How many Invoices were there in 2009 and 2011?
select * from invoices where InvoiceDate >= '2009-01-01 00:00:00' and InvoiceDate < '2012-01-01 00:00:00' order by InvoiceDate;

-- Q.10 Provide a query showing only the Employees who are Sales Agents.
select * from employees where title like '%sales%';

-- EXERCISE-2

-- Q.1 Display Most used media types: their names and count in descending order.
select mt.Name as mediaType,count(t.TrackId) as usageCount from media_types mt
join tracks t on mt.MediaTypeId = t.MediaTypeId
group by MediaType order by usageCount desc;


-- Q.2 Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
select c.FirstName || ' ' || c.LastName AS customerFullName,i.InvoiceId,i.InvoiceDate,i.BillingCountry from Customers c 
join Invoices i on c.CustomerId = i.CustomerId where c.Country = 'Brazil';

-- Q.3 Display artist name and total track count of the top 10 rock bands from dataset.
select artists.Name as ArtistName,count(tracks.TrackId) as trackCount from artists 
join albums on artists.ArtistId = albums.ArtistId
join tracks on albums.AlbumId = tracks.AlbumId
join genres on tracks.GenreId = genres.GenreId
where genres.Name = 'Rock' group by artists.ArtistId order by TrackCount desc limit 10;

-- Q.4 Display the Best customer (in case of amount spent). Full name (first name and last name)
select c.FirstName || ' ' || c.LastName as BestCustomer,sum(i.Total) as totalAmountSpent from Customers c 
join Invoices i on c.CustomerId = i.CustomerId
group by c.CustomerId order by TotalAmountSpent desc limit 1;

-- Q.5 Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
select FirstName || ' ' || LastName as fullName , CustomerId , Country from customers where Country != 'USA';

-- Q.6 Provide a query that shows the total number of tracks in each playlist in descending order. The Playlist name should be included on the resultant table.
select playlists.name, count(playlist_track.TrackId) as totalTracks from playlists
join playlist_track on playlists.PlaylistId = playlist_track.TrackId
group by playlists.name order by TotalTracks desc;

-- Q.7 Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.
select t.Name,a.Title as albumName,mt.Name as mediaType,g.Name as genre from tracks t
join albums a on t.AlbumId = a.AlbumId
join media_types mt on t.MediaTypeId = mt.MediaTypeId
join genres g on t.GenreId = g.GenreId;


-- Q.8 Provide a query that shows the top 10 bestselling artists. (In terms of earning).
select artists.Name as artistName,sum(invoice_items.Quantity * invoice_items.UnitPrice) AS totalEarnings from artists
join albums on artists.ArtistId = albums.ArtistId
join tracks on albums.AlbumId = tracks.AlbumId
join invoice_items on tracks.TrackId = invoice_items.TrackId
join invoices on invoice_items.InvoiceId = invoices.InvoiceId
group by artists.ArtistId order by totalEarnings desc limit 10;


-- Q.9 Provide a query that shows the most purchased Media Type.
select mt.Name as mediaTypeName,count(il.TrackId) as PurchaseCount from media_types mt
join tracks t on t.MediaTypeId = mt.MediaTypeId
join invoice_items il on il.TrackId = t.TrackId
group by mt.MediaTypeId, mt.Name order by PurchaseCount desc limit 1;


-- Q.10 Provide a query that shows the purchased tracks of 2013. Display Track name and Units sold.
select t.Name as trackName,count(il.InvoiceLineId) as unitsSold from tracks t
join invoice_items il on t.TrackId = il.TrackId
join invoices i on il.InvoiceId = i.InvoiceId
where strftime('%Y', i.InvoiceDate) = '2013' group by trackName order by unitsSold desc;


