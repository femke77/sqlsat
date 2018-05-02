--I am making an assumption that only vendors with tables can be in the raffle contest but opt out is ok 
--maybe this one and vendorEvent should be put into one, event id is occuring in both places... 
CREATE TABLE VendorTable
(
   	EventID int NOT NULL,
	TableNumber smallint NOT NULL,
	RaffleParticipant tinyint NOT NULL
	PRIMARY KEY (EventID, TableNumber)
);

--link vendors, events and tables, if vendortable is null, vendor is only a sponsor 
CREATE TABLE VendorEvent
(
	VendorID int NOT NULL,
	EventID int NOT NULL,  --technically isn't this redundant? 
	VendorTable int NULL,   --fk table number from vendorTable 
	PRIMARY KEY (VendorID, EventID)
);
