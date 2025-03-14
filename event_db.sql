CREATE TABLE event_table (
    eventID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30),
    description VARCHAR(1000),
    eventDate DATE,
    eventTime TIME,
    location VARCHAR(100),
    society VARCHAR(30),
    colour VARCHAR(30)
);

CREATE TABLE recurring_table (
    recurringID INT PRIMARY KEY,
    eventID INT,
    weekly BOOLEAN,
    biweekly BOOLEAN,
    monthly BOOLEAN,
    FOREIGN KEY (eventID) REFERENCES event_table(eventID)
);
